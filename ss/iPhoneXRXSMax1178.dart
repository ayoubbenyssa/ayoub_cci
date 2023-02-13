import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class iPhoneXRXSMax1178 extends StatelessWidget {
  iPhoneXRXSMax1178({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 59.6, end: 44.4),
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
            Pin(start: 51.0, end: 48.0),
            Pin(size: 213.0, middle: 0.369),
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
            alignment: Alignment(-0.012, -0.467),
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
            alignment: Alignment(0.0, -0.041),
            child: Container(
              width: 116.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: const Color(0xff218bb1),
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.037),
            child: SizedBox(
              width: 72.0,
              height: 15.0,
              child: Text(
                'Enregistre ',
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
          Align(
            alignment: Alignment(-0.021, -0.267),
            child: SizedBox(
              width: 220.0,
              height: 33.0,
              child: Text(
                'Saisissez votre adresse e-mail \nProfessionnel ',
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
            Pin(size: 258.0, middle: 0.5128),
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
          Align(
            alignment: Alignment(0.038, -0.156),
            child: SizedBox(
              width: 283.0,
              height: 29.0,
              child: SvgPicture.string(
                _svg_j4666,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.519, -0.151),
            child: SizedBox(
              width: 40.0,
              height: 15.0,
              child: Text(
                'Email',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 15,
                  color: const Color(0xffa5a5a5),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_j4666 =
    '<svg viewBox="68.1 366.0 282.8 29.0" ><path transform="translate(78.09, 366.0)" d="M 7.050374984741211 0 L 255.7655334472656 0 C 265.1821899414062 0 272.81591796875 6.491870880126953 272.81591796875 14.5 C 272.81591796875 22.50812911987305 265.1821899414062 29 255.7655334472656 29 L 7.050374984741211 29 C -2.366287231445312 29 -10 22.50812911987305 -10 14.5 C -10 6.491870880126953 -2.366287231445312 0 7.050374984741211 0 Z" fill="#f8f8f8" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
