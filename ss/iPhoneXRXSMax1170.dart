import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class iPhoneXRXSMax1170 extends StatelessWidget {
  iPhoneXRXSMax1170({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 78.0, start: 51.5),
            Pin(size: 78.0, middle: 0.2475),
            child: Stack(
              children: <Widget>[
                ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                    child: Container(
                      decoration: BoxDecoration(
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
          Pinned.fromPins(
            Pin(size: 158.0, start: 51.5),
            Pin(size: 34.0, middle: 0.3565),
            child: Text(
              'Welcome ',
              style: TextStyle(
                fontFamily: 'Louis George Cafe',
                fontSize: 34,
                color: const Color(0xff218bb1),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 172.0, start: 50.5),
            Pin(size: 21.0, middle: 0.3924),
            child: Text(
              'Sign in to continue',
              style: TextStyle(
                fontFamily: 'Louis George Cafe',
                fontSize: 21,
                color: const Color(0xff999999),
              ),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 46.0, start: 51.5),
            Pin(size: 15.0, middle: 0.4575),
            child: Text(
              'Sign in',
              style: TextStyle(
                fontFamily: 'Louis George Cafe',
                fontSize: 15,
                color: const Color(0xffc9c9c9),
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 127.0, start: 51.5),
            Pin(size: 15.0, middle: 0.5098),
            child: Text(
              'Create an account ',
              style: TextStyle(
                fontFamily: 'Louis George Cafe',
                fontSize: 15,
                color: const Color(0xffc9c9c9),
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 309.1, start: 40.0),
            Pin(size: 4.7, middle: 0.4725),
            child: SvgPicture.string(
              _svg_nix9,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 309.1, start: 40.0),
            Pin(size: 4.7, middle: 0.5242),
            child: SvgPicture.string(
              _svg_cj4oee,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 116.0, start: 53.0),
            Pin(size: 35.0, middle: 0.6295),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff218bb1),
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.508, 0.253),
            child: SizedBox(
              width: 48.0,
              height: 15.0,
              child: Text(
                'Entrée ',
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
          Pinned.fromPins(
            Pin(size: 198.0, start: 52.5),
            Pin(size: 18.0, middle: 0.5538),
            child: Text(
              'or use your email registration',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 16,
                color: const Color(0xff999999),
                fontWeight: FontWeight.w300,
              ),
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_nix9 =
    '<svg viewBox="40.0 421.1 309.1 4.7" ><path transform="matrix(-0.965926, 0.0, 0.0, 1.0, 349.05, 421.13)" d="M 319.987060546875 4.683837890625 L 0.000244140625 4.683837890625 L 0.000244140625 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_cj4oee =
    '<svg viewBox="40.0 467.2 309.1 4.7" ><path transform="matrix(-0.965926, 0.0, 0.0, 1.0, 349.05, 467.22)" d="M 319.987060546875 4.683837890625 L 0.000244140625 4.683837890625 L 0.000244140625 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
