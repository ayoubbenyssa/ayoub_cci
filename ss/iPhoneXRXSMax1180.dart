import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class iPhoneXRXSMax1180 extends StatelessWidget {
  iPhoneXRXSMax1180({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 32.0, end: 42.8),
            Pin(size: 290.0, middle: 0.3597),
            child: Stack(
              children: <Widget>[
                Transform.rotate(
                  angle: 0.0698,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(''),
                        fit: BoxFit.fill,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(20.6, 10.5, 8.6, 21.8),
                  ),
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(27.0),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffc9c9c9)),
                      ),
                      margin: EdgeInsets.fromLTRB(0.0, 34.0, 0.2, 0.0),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.028, -1.0),
                  child: SizedBox(
                    width: 78.0,
                    height: 78.0,
                    child: Stack(
                      children: <Widget>[
                        ClipRect(
                          child: BackdropFilter(
                            filter:
                                ui.ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
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
                  Pin(size: 116.0, middle: 0.4838),
                  Pin(size: 35.0, end: 16.0),
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
                Align(
                  alignment: Alignment(-0.002, -0.279),
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
                  Pin(start: 17.5, end: 17.7),
                  Pin(size: 33.0, middle: 0.7194),
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
                  Pin(start: 49.0, end: 37.2),
                  Pin(size: 29.0, middle: 0.5326),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffe6e6e6),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.25, 0.062),
                  child: SizedBox(
                    width: 190.0,
                    height: 15.0,
                    child: Text(
                      'Recherche votre aganisme',
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
                Pinned.fromPins(
                  Pin(size: 12.9, end: 46.7),
                  Pin(size: 7.0, middle: 0.5337),
                  child: SvgPicture.string(
                    _svg_s7kukd,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0x4b6f6f6f),
              border: Border.all(width: 1.0, color: const Color(0x4b707070)),
            ),
            margin: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, -1.0),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 273.2, 0.0, -1.0),
            child: Stack(
              children: <Widget>[
                SizedBox.expand(
                    child: SvgPicture.string(
                  _svg_v0uhp0,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                )),
                Pinned.fromPins(
                  Pin(size: 122.0, middle: 0.2192),
                  Pin(size: 25.0, start: 24.8),
                  child: Text(
                    'Organises',
                    style: TextStyle(
                      fontFamily: 'Louis George Cafe',
                      fontSize: 25,
                      color: const Color(0xff29306d),
                      fontWeight: FontWeight.w700,
                    ),
                    softWrap: false,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 16.1, start: 30.4),
                  Pin(size: 9.5, start: 30.0),
                  child: SvgPicture.string(
                    _svg_thb82a,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 38.0, end: 37.0),
                  Pin(size: 42.0, start: 58.8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xfff8f8f8),
                      borderRadius: BorderRadius.circular(21.0),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 180.0, start: 62.0),
                  Pin(size: 15.0, start: 73.3),
                  child: Text(
                    'Rechercher un Organisme ',
                    style: TextStyle(
                      fontFamily: 'Louis George Cafe',
                      fontSize: 15,
                      color: const Color(0xff999999),
                    ),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 20.0, end: 58.3),
                  Pin(size: 20.5, start: 70.5),
                  child: SvgPicture.string(
                    _svg_b7hzsw,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment(-0.17, -0.373),
                  child: SizedBox(
                    width: 250.0,
                    height: 1.0,
                    child: SvgPicture.string(
                      _svg_ss0edd,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.17, -0.225),
                  child: SizedBox(
                    width: 250.0,
                    height: 1.0,
                    child: SvgPicture.string(
                      _svg_y7gqp,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.17, -0.077),
                  child: SizedBox(
                    width: 250.0,
                    height: 1.0,
                    child: SvgPicture.string(
                      _svg_gkj93,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.17, 0.367),
                  child: SizedBox(
                    width: 250.0,
                    height: 1.0,
                    child: SvgPicture.string(
                      _svg_bfm637,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.17, 0.071),
                  child: SizedBox(
                    width: 250.0,
                    height: 1.0,
                    child: SvgPicture.string(
                      _svg_j1mc5l,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.17, 0.515),
                  child: SizedBox(
                    width: 250.0,
                    height: 1.0,
                    child: SvgPicture.string(
                      _svg_q6eut,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.17, 0.219),
                  child: SizedBox(
                    width: 250.0,
                    height: 1.0,
                    child: SvgPicture.string(
                      _svg_q162tm,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 250.2, middle: 0.4152),
                  Pin(size: 1.0, end: 104.8),
                  child: SvgPicture.string(
                    _svg_vzbxvv,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment(-0.576, -0.272),
                  child: SizedBox(
                    width: 91.0,
                    height: 15.0,
                    child: Text(
                      '2 ARH invest ',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        fontSize: 15,
                        color: const Color(0xffc9c9c9),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.558, -0.423),
                  child: SizedBox(
                    width: 104.0,
                    height: 15.0,
                    child: Text(
                      '10 MENTIONS ',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        fontSize: 15,
                        color: const Color(0xff29306d),
                        fontWeight: FontWeight.w700,
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.61, -0.12),
                  child: SizedBox(
                    width: 63.0,
                    height: 15.0,
                    child: Text(
                      '2 Z decor',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        fontSize: 15,
                        color: const Color(0xffc9c9c9),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.578, 0.334),
                  child: SizedBox(
                    width: 89.0,
                    height: 15.0,
                    child: Text(
                      '2H FASHION',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        fontSize: 15,
                        color: const Color(0xffc9c9c9),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.552, 0.031),
                  child: SizedBox(
                    width: 108.0,
                    height: 15.0,
                    child: Text(
                      '2a ACHIR trans ',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        fontSize: 15,
                        color: const Color(0xffc9c9c9),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.608, 0.486),
                  child: SizedBox(
                    width: 64.0,
                    height: 15.0,
                    child: Text(
                      '2J WASH',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        fontSize: 15,
                        color: const Color(0xffc9c9c9),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.645, 0.183),
                  child: SizedBox(
                    width: 28.0,
                    height: 15.0,
                    child: Text(
                      '2BE',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        fontSize: 15,
                        color: const Color(0xffc9c9c9),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.593, 0.637),
                  child: SizedBox(
                    width: 77.0,
                    height: 15.0,
                    child: Text(
                      '2KM LABFI',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        fontSize: 15,
                        color: const Color(0xffc9c9c9),
                      ),
                      softWrap: false,
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 5.0, start: 31.0),
                  Pin(size: 340.0, middle: 0.6406),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffe4e4e4),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 5.0, start: 31.0),
                  Pin(size: 43.0, middle: 0.3784),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffa5a5a5),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.683, -0.423),
                  child: SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: <Widget>[
                        SizedBox.expand(
                            child: SvgPicture.string(
                          _svg_tnkq4,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )),
                        Center(
                          child: SizedBox(
                            width: 7.0,
                            height: 4.0,
                            child: SvgPicture.string(
                              _svg_dcfplu,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.683, 0.046),
                  child: SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: <Widget>[
                        SizedBox.expand(
                            child: SvgPicture.string(
                          _svg_gxt44,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )),
                        Center(
                          child: SizedBox(
                            width: 7.0,
                            height: 4.0,
                            child: SvgPicture.string(
                              _svg_y5o8e,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.683, -0.27),
                  child: SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: <Widget>[
                        SizedBox.expand(
                            child: SvgPicture.string(
                          _svg_gxt44,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )),
                        Center(
                          child: SizedBox(
                            width: 7.0,
                            height: 4.0,
                            child: SvgPicture.string(
                              _svg_y5o8e,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.683, 0.199),
                  child: SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: <Widget>[
                        SizedBox.expand(
                            child: SvgPicture.string(
                          _svg_gxt44,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )),
                        Center(
                          child: SizedBox(
                            width: 7.0,
                            height: 4.0,
                            child: SvgPicture.string(
                              _svg_y5o8e,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.683, 0.505),
                  child: SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: <Widget>[
                        SizedBox.expand(
                            child: SvgPicture.string(
                          _svg_gxt44,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )),
                        Center(
                          child: SizedBox(
                            width: 7.0,
                            height: 4.0,
                            child: SvgPicture.string(
                              _svg_y5o8e,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.683, -0.117),
                  child: SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: <Widget>[
                        SizedBox.expand(
                            child: SvgPicture.string(
                          _svg_gxt44,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )),
                        Center(
                          child: SizedBox(
                            width: 7.0,
                            height: 4.0,
                            child: SvgPicture.string(
                              _svg_y5o8e,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.683, 0.352),
                  child: SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: <Widget>[
                        SizedBox.expand(
                            child: SvgPicture.string(
                          _svg_gxt44,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        )),
                        Center(
                          child: SizedBox(
                            width: 7.0,
                            height: 4.0,
                            child: SvgPicture.string(
                              _svg_y5o8e,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 21.5, middle: 0.8416),
                  Pin(size: 21.5, end: 102.8),
                  child: Stack(
                    children: <Widget>[
                      SizedBox.expand(
                          child: SvgPicture.string(
                        _svg_gxt44,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      )),
                      Center(
                        child: SizedBox(
                          width: 7.0,
                          height: 4.0,
                          child: SvgPicture.string(
                            _svg_y5o8e,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 116.0, middle: 0.5285),
                  Pin(size: 35.0, end: 33.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff218bb1),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 66.0, middle: 0.5244),
                  Pin(size: 15.0, end: 42.0),
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
                Pinned.fromPins(
                  Pin(start: 54.5, end: 55.5),
                  Pin(size: 33.0, middle: 0.1943),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_s7kukd =
    '<svg viewBox="311.6 369.0 12.9 7.0" ><path transform="translate(377.54, 358.98)" d="M -55.20042037963867 10.41879749298096 L -59.15040969848633 14.36878871917725 C -59.3192253112793 14.53760623931885 -59.59140396118164 14.53760623931885 -59.76021957397461 14.36878871917725 L -63.7102165222168 10.41879749298096 C -64.21495056152344 9.914067268371582 -65.03318786621094 9.914067268371582 -65.53620910644531 10.41879749298096 C -66.04092407226562 10.92352962493896 -66.04092407226562 11.74177837371826 -65.53620910644531 12.24650859832764 L -61.58793258666992 16.19649887084961 C -60.4096565246582 17.37305450439453 -58.50098037719727 17.37305450439453 -57.32442855834961 16.19649887084961 L -53.37443161010742 12.24650859832764 C -52.86970138549805 11.74177837371826 -52.86970138549805 10.92352962493896 -53.37443161010742 10.41879749298096 C -53.87916946411133 9.914067268371582 -54.69741439819336 9.914067268371582 -55.20042037963867 10.41879749298096 Z" fill="#a5a5a5" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_v0uhp0 =
    '<svg viewBox="0.0 273.2 414.0 623.8" ><path transform="translate(0.0, 273.22)" d="M 30 0 L 384 0 C 400.5685424804688 0 414 14.20038795471191 414 31.71745491027832 L 414 623.776611328125 L 0 623.776611328125 L 0 31.71745491027832 C 0 14.20038795471191 13.43145751953125 0 30 0 Z" fill="#ffffff" stroke="#c9c9c9" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_thb82a =
    '<svg viewBox="30.4 303.3 16.1 9.5" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, -157.12, 266.35)" d="M -188.0579986572266 -42.89099884033203 L -191.3509979248047 -46.18399810791016 C -191.6439971923828 -46.47700119018555 -192.1190032958984 -46.47700119018555 -192.4120025634766 -46.18399810791016 C -192.7050018310547 -45.89099884033203 -192.7050018310547 -45.41699981689453 -192.4120025634766 -45.12400054931641 L -189.6920013427734 -42.40399932861328 L -202.8809967041016 -42.40399932861328 C -203.2960052490234 -42.40399932861328 -203.6309967041016 -42.06800079345703 -203.6309967041016 -41.65399932861328 C -203.6309967041016 -41.2400016784668 -203.2960052490234 -40.90399932861328 -202.8809967041016 -40.90399932861328 L -189.6920013427734 -40.90399932861328 L -192.4120025634766 -38.18399810791016 C -192.7050018310547 -37.89099884033203 -192.7050018310547 -37.41699981689453 -192.4120025634766 -37.12400054931641 C -192.1190032958984 -36.83100128173828 -191.6439971923828 -36.83100128173828 -191.3509979248047 -37.12400054931641 L -188.0579986572266 -40.41699981689453 C -187.375 -41.09999847412109 -187.375 -42.20800018310547 -188.0579986572266 -42.89099884033203 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_b7hzsw =
    '<svg viewBox="335.7 343.8 20.0 20.5" ><path transform="translate(525.25, 371.7)" d="M -169.7660064697266 -8.74899959564209 L -174.3220062255859 -13.30500030517578 C -172.9129943847656 -14.85799980163574 -172.0469970703125 -16.91300010681152 -172.0469970703125 -19.17600059509277 C -172.0469970703125 -24.00900077819824 -175.9640045166016 -27.92600059509277 -180.7969970703125 -27.92600059509277 C -185.6289978027344 -27.92600059509277 -189.5469970703125 -24.00900077819824 -189.5469970703125 -19.17600059509277 C -189.5469970703125 -14.3439998626709 -185.6289978027344 -10.42599964141846 -180.7969970703125 -10.42599964141846 C -178.7680053710938 -10.42599964141846 -176.9049987792969 -11.1230001449585 -175.4210052490234 -12.2819995880127 L -170.8269958496094 -7.688000202178955 C -170.5339965820312 -7.394999980926514 -170.0590057373047 -7.394999980926514 -169.7660064697266 -7.688000202178955 C -169.4730072021484 -7.980999946594238 -169.4730072021484 -8.456000328063965 -169.7660064697266 -8.74899959564209 Z M -188.0469970703125 -19.17600059509277 C -188.0469970703125 -23.18000030517578 -184.8009948730469 -26.42600059509277 -180.7969970703125 -26.42600059509277 C -176.7920074462891 -26.42600059509277 -173.5469970703125 -23.18000030517578 -173.5469970703125 -19.17600059509277 C -173.5469970703125 -15.17199993133545 -176.7920074462891 -11.92599964141846 -180.7969970703125 -11.92599964141846 C -184.8009948730469 -11.92599964141846 -188.0469970703125 -15.17199993133545 -188.0469970703125 -19.17600059509277 Z" fill="#999999" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ss0edd =
    '<svg viewBox="68.0 468.5 250.2 1.0" ><path transform="translate(68.0, 468.5)" d="M 0 0 L 250.2351684570312 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_y7gqp =
    '<svg viewBox="68.0 514.6 250.2 1.0" ><path transform="translate(68.0, 514.6)" d="M 0 0 L 250.2351684570312 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_gkj93 =
    '<svg viewBox="68.0 560.7 250.2 1.0" ><path transform="translate(68.0, 560.69)" d="M 0 0 L 250.2351684570312 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bfm637 =
    '<svg viewBox="68.0 699.0 250.2 1.0" ><path transform="translate(68.0, 698.98)" d="M 0 0 L 250.2351684570312 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_j1mc5l =
    '<svg viewBox="68.0 606.8 250.2 1.0" ><path transform="translate(68.0, 606.79)" d="M 0 0 L 250.2351684570312 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_q6eut =
    '<svg viewBox="68.0 745.1 250.2 1.0" ><path transform="translate(68.0, 745.07)" d="M 0 0 L 250.2351684570312 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_q162tm =
    '<svg viewBox="68.0 652.9 250.2 1.0" ><path transform="translate(68.0, 652.88)" d="M 0 0 L 250.2351684570312 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vzbxvv =
    '<svg viewBox="68.0 791.2 250.2 1.0" ><path transform="translate(68.0, 791.17)" d="M 0 0 L 250.2351684570312 0" fill="none" stroke="#e4e4e4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_tnkq4 =
    '<svg viewBox="-72.9 1.0 21.5 21.5" ><path  d="M -57.16500091552734 1.041000008583069 L -67.16500091552734 1.041000008583069 C -70.34100341796875 1.041000008583069 -72.91500091552734 3.615000009536743 -72.91500091552734 6.790999889373779 L -72.91500091552734 16.79100036621094 C -72.91500091552734 19.96599960327148 -70.34100341796875 22.54100036621094 -67.16500091552734 22.54100036621094 L -57.16500091552734 22.54100036621094 C -53.98899841308594 22.54100036621094 -51.41500091552734 19.96599960327148 -51.41500091552734 16.79100036621094 L -51.41500091552734 6.790999889373779 C -51.41500091552734 3.615000009536743 -53.98899841308594 1.041000008583069 -57.16500091552734 1.041000008583069 Z M -57.16500091552734 21.04100036621094 L -67.16500091552734 21.04100036621094 C -69.51200103759766 21.04100036621094 -71.41500091552734 19.13800048828125 -71.41500091552734 16.79100036621094 L -71.41500091552734 6.790999889373779 C -71.41500091552734 4.442999839782715 -69.51200103759766 2.540999889373779 -67.16500091552734 2.540999889373779 L -57.16500091552734 2.540999889373779 C -54.81800079345703 2.540999889373779 -52.91500091552734 4.442999839782715 -52.91500091552734 6.790999889373779 L -52.91500091552734 16.79100036621094 C -52.91500091552734 19.13800048828125 -54.81800079345703 21.04100036621094 -57.16500091552734 21.04100036621094 Z" fill="#29306d" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_dcfplu =
    '<svg viewBox="-65.9 10.0 7.5 4.1" ><path  d="M -59.69499969482422 10.26000022888184 L -61.98799896240234 12.55300045013428 C -62.08599853515625 12.65100002288818 -62.24399948120117 12.65100002288818 -62.34199905395508 12.55300045013428 L -64.63500213623047 10.26000022888184 C -64.92800140380859 9.967000007629395 -65.40299987792969 9.967000007629395 -65.69499969482422 10.26000022888184 C -65.98799896240234 10.55300045013428 -65.98799896240234 11.02799987792969 -65.69499969482422 11.32100009918213 L -63.40299987792969 13.61400032043457 C -62.71900177001953 14.29699993133545 -61.61100006103516 14.29699993133545 -60.92800140380859 13.61400032043457 L -58.6349983215332 11.32100009918213 C -58.34199905395508 11.02799987792969 -58.34199905395508 10.55300045013428 -58.6349983215332 10.26000022888184 C -58.92800140380859 9.967000007629395 -59.40299987792969 9.967000007629395 -59.69499969482422 10.26000022888184 Z" fill="#29306d" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_gxt44 =
    '<svg viewBox="-72.9 1.0 21.5 21.5" ><path  d="M -57.16500091552734 1.041000008583069 L -67.16500091552734 1.041000008583069 C -70.34100341796875 1.041000008583069 -72.91500091552734 3.615000009536743 -72.91500091552734 6.790999889373779 L -72.91500091552734 16.79100036621094 C -72.91500091552734 19.96599960327148 -70.34100341796875 22.54100036621094 -67.16500091552734 22.54100036621094 L -57.16500091552734 22.54100036621094 C -53.98899841308594 22.54100036621094 -51.41500091552734 19.96599960327148 -51.41500091552734 16.79100036621094 L -51.41500091552734 6.790999889373779 C -51.41500091552734 3.615000009536743 -53.98899841308594 1.041000008583069 -57.16500091552734 1.041000008583069 Z M -57.16500091552734 21.04100036621094 L -67.16500091552734 21.04100036621094 C -69.51200103759766 21.04100036621094 -71.41500091552734 19.13800048828125 -71.41500091552734 16.79100036621094 L -71.41500091552734 6.790999889373779 C -71.41500091552734 4.442999839782715 -69.51200103759766 2.540999889373779 -67.16500091552734 2.540999889373779 L -57.16500091552734 2.540999889373779 C -54.81800079345703 2.540999889373779 -52.91500091552734 4.442999839782715 -52.91500091552734 6.790999889373779 L -52.91500091552734 16.79100036621094 C -52.91500091552734 19.13800048828125 -54.81800079345703 21.04100036621094 -57.16500091552734 21.04100036621094 Z" fill="#c9c9c9" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_y5o8e =
    '<svg viewBox="-65.9 10.0 7.5 4.1" ><path  d="M -59.69499969482422 10.26000022888184 L -61.98799896240234 12.55300045013428 C -62.08599853515625 12.65100002288818 -62.24399948120117 12.65100002288818 -62.34199905395508 12.55300045013428 L -64.63500213623047 10.26000022888184 C -64.92800140380859 9.967000007629395 -65.40299987792969 9.967000007629395 -65.69499969482422 10.26000022888184 C -65.98799896240234 10.55300045013428 -65.98799896240234 11.02799987792969 -65.69499969482422 11.32100009918213 L -63.40299987792969 13.61400032043457 C -62.71900177001953 14.29699993133545 -61.61100006103516 14.29699993133545 -60.92800140380859 13.61400032043457 L -58.6349983215332 11.32100009918213 C -58.34199905395508 11.02799987792969 -58.34199905395508 10.55300045013428 -58.6349983215332 10.26000022888184 C -58.92800140380859 9.967000007629395 -59.40299987792969 9.967000007629395 -59.69499969482422 10.26000022888184 Z" fill="#c9c9c9" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
