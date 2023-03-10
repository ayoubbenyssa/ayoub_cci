library geolocator;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'models/geolocation_enums.dart';
part 'models/google_play_services_availability.dart';
part 'models/location_accuracy.dart';
part 'models/location_options.dart';
part 'models/placemark.dart';
part 'models/position.dart';
part 'utils/codec.dart';

/// Provides easy access to the platform specific location services (CLLocationManager on iOS and FusedLocationProviderClient on Android)
class Geolocator {
  factory Geolocator() {
    if (_instance == null) {
      final MethodChannel methodChannel =
      const MethodChannel('flutter.baseflow.com/geolocator/methods');
      final EventChannel eventChannel =
      const EventChannel('flutter.baseflow.com/geolocator/events');
      _instance = new Geolocator.private(methodChannel, eventChannel);
    }
    return _instance;
  }

  @visibleForTesting
  Geolocator.private(this._methodChannel, this._eventChannel);

  static Geolocator _instance;

  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  Stream<Position> _onPositionChanged;

  /// Returns a [Future] containing the current [GeolocationStatus] indicating the availability of location services on the device.
  @Deprecated(
      "This static method will be removed in version 2.0. Please use the `checkGeolocationPermissionStatus` instance method instead.")
  static Future<GeolocationStatus> checkGeolocationStatus(
      [GeolocationPermission locationPermission =
          GeolocationPermission.location]) {
    return Geolocator().checkGeolocationPermissionStatus(
        locationPermission: locationPermission);
  }

  /// Returns a [Future] containing the current [GeolocationStatus] indicating the availability of location services on the device.
  Future<GeolocationStatus> checkGeolocationPermissionStatus(
      {GeolocationPermission locationPermission =
          GeolocationPermission.location}) async {
    PermissionStatus permissionStatus =
    await PermissionHandler.checkPermissionStatus(
        _GeolocationStatusConverter.toPermissionGroup(locationPermission));

    return _GeolocationStatusConverter.fromPermissionStatus(permissionStatus);
  }

  /// Returns the current position taking the supplied [desiredAccuracy] into account.
  ///
  /// When the [desiredAccuracy] is not supplied, it defaults to best.
  Future<Position> getCurrentPosition(
      [LocationAccuracy desiredAccuracy = LocationAccuracy.best]) async {
    PermissionStatus permission = await _getLocationPermission();

    if (permission == PermissionStatus.granted) {
      LocationOptions locationOptions =
      LocationOptions(accuracy: desiredAccuracy, distanceFilter: 0);
      Map<dynamic, dynamic> positionMap = await _methodChannel.invokeMethod(
          'getCurrentPosition', Codec.encodeLocationOptions(locationOptions));

      try {
        return Position._fromMap(positionMap);
      } on ArgumentError {
        return null;
      }
    } else {
      _handleInvalidPermissions(permission);
    }

    return null;
  }

  /// Returns the last known position stored on the users device.
  ///
  /// On Android we look for the location provider matching best with the
  /// supplied [desiredAccuracy]. On iOS this parameter is ignored.
  /// When no position is available, null is returned.
  Future<Position> getLastKnownPosition(
      [LocationAccuracy desiredAccuracy = LocationAccuracy.best]) async {
    PermissionStatus permission = await _getLocationPermission();

    if (permission == PermissionStatus.granted) {
      LocationOptions locationOptions =
      LocationOptions(accuracy: desiredAccuracy, distanceFilter: 0);
      Map<dynamic, dynamic> positionMap = await _methodChannel.invokeMethod(
          'getLastKnownPosition', Codec.encodeLocationOptions(locationOptions));

      try {
        return Position._fromMap(positionMap);
      } on ArgumentError {
        return null;
      }
    } else {
      _handleInvalidPermissions(permission);
    }

    return null;
  }

  /// Fires whenever the location changes outside the bounds of the [desiredAccuracy].
  ///
  /// This event starts all location sensors on the device and will keep them
  /// active until you cancel listening to the stream or when the application
  /// is killed.
  ///
  /// ```
  /// StreamSubscription<Position> positionStream = new Geolocator().GetPostionStream().listen(
  ///   (Position position) => {
  ///     // Handle position changes
  ///   });
  ///
  /// // When no longer needed cancel the subscription
  /// positionStream.cancel();
  /// ```
  ///
  /// You can customize the behaviour of the location updates by supplying an
  /// instance [LocationOptions] class. When you don't supply any specific
  /// options, default values will be used for each setting.
  Future<Stream<Position>> getPositionStream(
      [LocationOptions locationOptions = const LocationOptions()]) async {
    PermissionStatus permission = await _getLocationPermission();

    if (permission == PermissionStatus.granted) {
      if (_onPositionChanged == null) {
        _onPositionChanged = _eventChannel
            .receiveBroadcastStream(
            Codec.encodeLocationOptions(locationOptions))
            .map<Position>((dynamic element) =>
            Position._fromMap(element.cast<String, double>()));
      }

      return _onPositionChanged;
    } else {
      _handleInvalidPermissions(permission);
    }

    return null;
  }

  Future<PermissionStatus> _getLocationPermission() async {
    PermissionStatus permission =
    await PermissionHandler.checkPermissionStatus(PermissionGroup.location);

    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
      await PermissionHandler.requestPermissions(
          [PermissionGroup.location]);

      return permissionStatus[PermissionGroup.location] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permission) {
    if (permission == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permission == PermissionStatus.disabled) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  /// Returns a list of [Placemark] instances found for the supplied address.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied address could not be
  /// resolved into a single [Placemark], multiple [Placemark] instances may be returned.
  ///
  /// Optionally you can specify a locale in which the results are returned.
  /// When not supplied the currently active locale of the device will be used.
  /// The `localeIdentifier` should be formatted using the syntax: [languageCode]_[countryCode] (eg. en_US or nl_NL).
  Future<List<Placemark>> placemarkFromAddress(String address,
      {String localeIdentifier}) async {
    Map<String, String> parameters = <String, String>{"address": address};
    if (localeIdentifier != null) {
      parameters["localeIdentifier"] = localeIdentifier;
    }

    List<dynamic> placemarks =
    await _methodChannel.invokeMethod('placemarkFromAddress', parameters);
    return Placemark._fromMaps(placemarks);
  }

  /// Returns a list of [Placemark] instances found for the supplied coordinates.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied coordinates could not be
  /// resolved into a single [Placemark], multiple [Placemark] instances may be returned.
  ///
  /// Optionally you can specify a locale in which the results are returned.
  /// When not supplied the currently active locale of the device will be used.
  /// The `localeIdentifier` should be formatted using the syntax: [languageCode]_[countryCode] (eg. en_US or nl_NL).
  Future<List<Placemark>> placemarkFromCoordinates(
      double latitude, double longitude,
      {String localeIdentifier}) async {
    Map<String, dynamic> parameters = <String, dynamic>{
      "latitude": latitude,
      "longitude": longitude
    };

    if (localeIdentifier != null) {
      parameters["localeIdentifier"] = localeIdentifier;
    }

    List<dynamic> placemarks = await _methodChannel.invokeMethod(
        'placemarkFromCoordinates', parameters);

    try {
      return Placemark._fromMaps(placemarks);
    } on ArgumentError {
      return null;
    }
  }

  /// Returns the distance between the supplied coordinates in meters.
  Future<double> distanceBetween(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) =>
      _methodChannel.invokeMethod('distanceBetween', <String, double>{
        "startLatitude": startLatitude,
        "startLongitude": startLongitude,
        "endLatitude": endLatitude,
        "endLongitude": endLongitude
      }).then<double>((dynamic result) => result);

  /// Returns the distance between the supplied coordinates in meters.
  ///
  /// This feature is only available on Android devices. On any other platforms
  /// the [checkPlayServicesAvailability] method will always return
  /// [GooglePlayServicesAvailability.notAvailableOnPlatform].
  Future<GooglePlayServicesAvailability>
  checkGooglePlayServicesAvailability() async {
    if (!Platform.isAndroid) {
      return GooglePlayServicesAvailability.notAvailableOnPlatform;
    }

    final dynamic availability =
    await _methodChannel.invokeMethod('checkPlayServicesAvailability');

    return Codec.decodePlayServicesAvailability(availability);
  }
}
