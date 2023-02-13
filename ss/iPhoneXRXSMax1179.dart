import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class iPhoneXRXSMax1179 extends StatelessWidget {
  iPhoneXRXSMax1179({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 52.6, end: 51.4),
            Pin(size: 257.7, middle: 0.358),
            child: Transform.rotate(
              angle: 0.0698,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 32.0, end: 43.0),
            Pin(size: 256.0, middle: 0.3938),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(27.0),
                    border:
                        Border.all(width: 0.5, color: const Color(0xffc9c9c9)),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.054, -0.467),
            child: SizedBox(
              width: 78.0,
              height: 78.0,
              child: Stack(
                children: <Widget>[
                  ClipRect(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0x11ffffff),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                              width: 0.5, color: const Color(0xffc9c9c9)),
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(start: 7.0, end: 8.0),
                    Pin(size: 53.0, start: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(''),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.06, 0.062),
            child: SizedBox(
              width: 116.0,
              height: 35.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff187fb2),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.1),
                    child: SizedBox(
                      width: 66.0,
                      height: 15.0,
                      child: Text(
                        'Confirmer',
                        style: TextStyle(
                          fontFamily: 'TT Interphases Pro Trl',
                          fontSize: 15,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                        softWrap: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.046, -0.28),
            child: SizedBox(
              width: 176.0,
              height: 15.0,
              child: Text(
                'Choisir votre organisme ',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 15,
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 49.5, end: 60.5),
            Pin(size: 33.0, middle: 0.4668),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 15,
                  color: const Color(0xff707070),
                ),
                children: [
                  TextSpan(
                    text:
                        'Si vous n’avez pas trouvé votre organisme\nSur la liste, ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'cliquez ici pour l’ajouter',
                    style: TextStyle(
                      color: const Color(0xff34b7f9),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '  ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 258.0, middle: 0.4679),
            Pin(size: 35.5, end: 68.7),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 51.0, end: 60.0),
            Pin(size: 29.0, middle: 0.4118),
            child: SvgPicture.string(
              _svg_yafhm,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment(-0.462, -0.174),
            child: SizedBox(
              width: 180.0,
              height: 15.0,
              child: Text(
                'Recherche votre aganisme',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 15,
                  color: const Color(0xffa5a5a5),
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.624, -0.17),
            child: SizedBox(
              width: 13.0,
              height: 7.0,
              child: SvgPicture.string(
                _svg_oqrlfm,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_yafhm =
    '<svg viewBox="51.0 357.0 303.0 29.0" ><path transform="translate(81.0, 357.0)" d="M -15.5 0 L 258.5 0 C 266.5081176757812 0 273 6.491870880126953 273 14.5 C 273 22.50812911987305 266.5081176757812 29 258.5 29 L -15.5 29 C -23.50812911987305 29 -30 22.50812911987305 -30 14.5 C -30 6.491870880126953 -23.50812911987305 0 -15.5 0 Z" fill="#f8f8f8" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_oqrlfm =
    '<svg viewBox="325.6 369.0 12.9 7.0" ><path transform="translate(391.54, 358.98)" d="M -55.20042037963867 10.41879749298096 L -59.15040969848633 14.36878871917725 C -59.3192253112793 14.53760623931885 -59.59140396118164 14.53760623931885 -59.76021957397461 14.36878871917725 L -63.7102165222168 10.41879749298096 C -64.21495056152344 9.914067268371582 -65.03318786621094 9.914067268371582 -65.53620910644531 10.41879749298096 C -66.04092407226562 10.92352962493896 -66.04092407226562 11.74177837371826 -65.53620910644531 12.24650859832764 L -61.58793258666992 16.19649887084961 C -60.4096565246582 17.37305450439453 -58.50098037719727 17.37305450439453 -57.32442855834961 16.19649887084961 L -53.37443161010742 12.24650859832764 C -52.86970138549805 11.74177837371826 -52.86970138549805 10.92352962493896 -53.37443161010742 10.41879749298096 C -53.87916946411133 9.914067268371582 -54.69741439819336 9.914067268371582 -55.20042037963867 10.41879749298096 Z" fill="#a5a5a5" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
