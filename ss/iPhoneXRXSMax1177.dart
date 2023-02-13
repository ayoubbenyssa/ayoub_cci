import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;

class iPhoneXRXSMax1177 extends StatelessWidget {
  iPhoneXRXSMax1177({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 31.0, end: 37.0),
            Pin(size: 287.4, middle: 0.3813),
            child: Transform.rotate(
              angle: 0.0873,
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
            Pin(start: 47.0, end: 52.0),
            Pin(size: 290.0, middle: 0.4158),
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
            alignment: Alignment(-0.018, -0.467),
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
          Pinned.fromPins(
            Pin(size: 286.0, start: 59.0),
            Pin(size: 128.0, middle: 0.4232),
            child: Text(
              'Afin de vérifier votre appartenance ,\nun email de validation a été envoyé\na votre administrateur de compte.\nSa validation est. nécessaire avant \nque puissiez rejoindre \nla communauté CCIS',
              style: TextStyle(
                fontFamily: 'Louis George Cafe',
                fontSize: 18,
                color: const Color(0xff707070),
              ),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ),
          Align(
            alignment: Alignment(0.416, 0.108),
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
            alignment: Alignment(-0.45, 0.108),
            child: Container(
              width: 116.0,
              height: 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(width: 1.0, color: const Color(0xffc9c9c9)),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.363, 0.108),
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
            alignment: Alignment(-0.368, 0.108),
            child: SizedBox(
              width: 50.0,
              height: 15.0,
              child: Text(
                'Retour ',
                style: TextStyle(
                  fontFamily: 'TT Interphases Pro Trl',
                  fontSize: 15,
                  color: const Color(0xffa5a5a5),
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 285.0, end: 61.5),
            Pin(size: 33.0, middle: 0.6471),
            child: Text(
              'Pour toute information complémentaire \nContact-nous à ',
              style: TextStyle(
                fontFamily: 'Louis George Cafe',
                fontSize: 15,
                color: const Color(0xffa5a5a5),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 258.0, middle: 0.4872),
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
        ],
      ),
    );
  }
}
