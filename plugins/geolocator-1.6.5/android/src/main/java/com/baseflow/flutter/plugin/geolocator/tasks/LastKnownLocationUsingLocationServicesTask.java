package com.baseflow.flutter.plugin.geolocator.tasks;

import android.location.Location;
import androidx.annotation.NonNull;

import com.baseflow.flutter.plugin.geolocator.data.LocationMapper;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;

import java.util.Map;

class LastKnownLocationUsingLocationServicesTask extends LocationUsingLocationServicesTask {
    private final FusedLocationProviderClient mFusedLocationProviderClient;

    LastKnownLocationUsingLocationServicesTask(TaskContext taskContext) {
        super(taskContext);

        mFusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(taskContext.getAndroidContext());
    }

    @Override
    public void startTask() {
        mFusedLocationProviderClient.getLastLocation()
                .addOnSuccessListener(new OnSuccessListener<Location>() {
                    @Override
                    public void onSuccess(Location location) {
                        Map<String, Double> locationMap = location != null
                                ? LocationMapper.toHashMap(location)
                                : null;

                        getTaskContext().getResult().success(locationMap);

                        stopTask();
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        getTaskContext().getResult().error(
                                e.getMessage(),
                                e.getLocalizedMessage(),
                                null);

                        stopTask();
                    }
                });
    }
}
