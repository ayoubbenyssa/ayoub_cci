import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class iPhoneXRXSMax1175 extends StatelessWidget {
  iPhoneXRXSMax1175({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 242.0, start: 50.0),
            Pin(size: 44.0, start: 35.0),
            child: Text(
              'Publier une opportunités \nd’affaires ',
              style: TextStyle(
                fontFamily: 'Louis George Cafe',
                fontSize: 20,
                color: const Color(0xff272c6e),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 16.1, start: 20.4),
            Pin(size: 9.5, start: 36.3),
            child: SvgPicture.string(
              _svg_k77r,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 40.0, end: 30.0),
            Pin(size: 40.0, start: 24.0),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(4.0),
                    border:
                        Border.all(width: 0.5, color: const Color(0xffd6d5d5)),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 4.0, end: 4.0),
                  Pin(size: 26.0, start: 6.0),
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
            Pin(start: 27.0, end: 27.0),
            Pin(size: 760.0, end: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                border: Border.all(width: 0.5, color: const Color(0xffc9c9c9)),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 57.5, end: 57.5),
            Pin(size: 140.0, middle: 0.416),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 57.5, end: 57.5),
            Pin(size: 26.0, middle: 0.6186),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 57.5, end: 57.5),
            Pin(size: 26.0, middle: 0.2393),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, start: 57.5),
            Pin(size: 26.0, middle: 0.5347),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.069),
            child: Container(
              width: 90.0,
              height: 26.0,
              decoration: BoxDecoration(
                color: const Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(13.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, end: 57.5),
            Pin(size: 26.0, middle: 0.5347),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(13.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 57.5, end: 57.5),
            Pin(size: 26.0, middle: 0.6643),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 57.5, end: 57.5),
            Pin(size: 26.0, middle: 0.285),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.553, -0.262),
            child: SizedBox(
              width: 65.0,
              height: 13.0,
              child: Text(
                'Description',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 13,
                  color: const Color(0xffa5a5a5),
                ),
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.585, 0.24),
            child: SizedBox(
              width: 38.0,
              height: 13.0,
              child: Text(
                'Photo ',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 13,
                  color: const Color(0xffa5a5a5),
                ),
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.498, 0.33),
            child: SizedBox(
              width: 103.0,
              height: 13.0,
              child: Text(
                'Budget estimatifs ',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 13,
                  color: const Color(0xffa5a5a5),
                ),
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.61, 0.071),
            child: SizedBox(
              width: 40.0,
              height: 13.0,
              child: Text(
                'Image ',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 13,
                  color: const Color(0xffa5a5a5),
                ),
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.077, 0.071),
            child: SizedBox(
              width: 38.0,
              height: 13.0,
              child: Text(
                'Copier',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 13,
                  color: const Color(0xffa5a5a5),
                ),
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.477, 0.071),
            child: SizedBox(
              width: 30.0,
              height: 13.0,
              child: Text(
                'Past ',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 13,
                  color: const Color(0xffa5a5a5),
                ),
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.595, -0.517),
            child: SizedBox(
              width: 29.0,
              height: 13.0,
              child: Text(
                'Titre ',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 13,
                  color: const Color(0xffa5a5a5),
                ),
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.517, -0.421),
            child: SizedBox(
              width: 91.0,
              height: 13.0,
              child: Text(
                'Valable jusqu’à ',
                style: TextStyle(
                  fontFamily: 'Louis George Cafe',
                  fontSize: 13,
                  color: const Color(0xffa5a5a5),
                ),
                softWrap: false,
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 57.5, end: 57.5),
            Pin(size: 26.0, middle: 0.1872),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff3a7eae)),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 182.0, start: 12.5),
                  Pin(size: 13.0, middle: 0.5498),
                  child: Text(
                    'Appel a manifestation d’intérêt  ',
                    style: TextStyle(
                      fontFamily: 'Louis George Cafe',
                      fontSize: 13,
                      color: const Color(0xff3a7eae),
                    ),
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 57.5, end: 57.5),
            Pin(size: 1.0, middle: 0.3273),
            child: SvgPicture.string(
              _svg_wa4r4c,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment(0.648, -0.618),
            child: SizedBox(
              width: 16.0,
              height: 16.0,
              child: Transform.rotate(
                angle: 3.1416,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 6.0,
                        height: 3.0,
                        child: SvgPicture.string(
                          _svg_lgc5wt,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ),
                    SizedBox.expand(
                        child: SvgPicture.string(
                      _svg_kmpxc8,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    )),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.62, 0.322),
            child: SizedBox(
              width: 11.0,
              height: 11.0,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 5.0,
                      height: 1.0,
                      child: SvgPicture.string(
                        _svg_ljqis0,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  SizedBox.expand(
                      child: SvgPicture.string(
                    _svg_k0m11j,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  )),
                ],
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 116.0, middle: 0.5),
            Pin(size: 35.0, end: 124.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff218bb1),
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 72.0, middle: 0.5),
            Pin(size: 15.0, end: 133.0),
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
          Align(
            alignment: Alignment(0.664, -0.426),
            child: SizedBox(
              width: 16.0,
              height: 17.0,
              child: Stack(
                children: <Widget>[
                  SizedBox.expand(
                      child: SvgPicture.string(
                    _svg_m5x5n,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  )),
                  Align(
                    alignment: Alignment(-0.588, 0.077),
                    child: SizedBox(
                      width: 2.0,
                      height: 1.0,
                      child: SvgPicture.string(
                        _svg_bwsca4,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.077),
                    child: SizedBox(
                      width: 2.0,
                      height: 1.0,
                      child: SvgPicture.string(
                        _svg_y9b614,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.588, 0.077),
                    child: SizedBox(
                      width: 2.0,
                      height: 1.0,
                      child: SvgPicture.string(
                        _svg_lhe7vp,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.588, 0.487),
                    child: SizedBox(
                      width: 2.0,
                      height: 1.0,
                      child: SvgPicture.string(
                        _svg_dd09on,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.487),
                    child: SizedBox(
                      width: 2.0,
                      height: 1.0,
                      child: SvgPicture.string(
                        _svg_g0z97,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.588, 0.487),
                    child: SizedBox(
                      width: 2.0,
                      height: 1.0,
                      child: SvgPicture.string(
                        _svg_s9ueg2,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.138, 0.068),
            child: SizedBox(
              width: 12.0,
              height: 15.0,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 9.0,
                      height: 12.0,
                      child: SvgPicture.string(
                        _svg_m0rnpk,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 8.0,
                      height: 11.0,
                      child: SvgPicture.string(
                        _svg_az0oa2,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 10.0, end: 70.0),
            Pin(size: 12.3, middle: 0.5343),
            child: Stack(
              children: <Widget>[
                SizedBox.expand(
                    child: SvgPicture.string(
                  _svg_sxfztk,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                )),
                Pinned.fromPins(
                  Pin(start: 2.3, end: 2.3),
                  Pin(size: 1.0, middle: 0.5063),
                  child: SvgPicture.string(
                    _svg_krs5uq,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment(-0.333, 0.519),
                  child: SizedBox(
                    width: 3.0,
                    height: 1.0,
                    child: SvgPicture.string(
                      _svg_eo9ld,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(-0.391, 0.069),
            child: SizedBox(
              width: 15.0,
              height: 15.0,
              child: Stack(
                children: <Widget>[
                  SizedBox.expand(
                      child: SvgPicture.string(
                    _svg_vbtjod,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  )),
                  Center(
                    child: SizedBox(
                      width: 5.0,
                      height: 5.0,
                      child: SvgPicture.string(
                        _svg_r0b0fp,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.626, 0.235),
            child: SizedBox(
              width: 15.0,
              height: 15.0,
              child: Stack(
                children: <Widget>[
                  SizedBox.expand(
                      child: SvgPicture.string(
                    _svg_vbtjod,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  )),
                  Center(
                    child: SizedBox(
                      width: 5.0,
                      height: 5.0,
                      child: SvgPicture.string(
                        _svg_r0b0fp,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_k77r =
    '<svg viewBox="20.4 36.3 16.1 9.5" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, -167.12, -0.65)" d="M -188.0579986572266 -42.89099884033203 L -191.3509979248047 -46.18399810791016 C -191.6439971923828 -46.47700119018555 -192.1190032958984 -46.47700119018555 -192.4120025634766 -46.18399810791016 C -192.7050018310547 -45.89099884033203 -192.7050018310547 -45.41699981689453 -192.4120025634766 -45.12400054931641 L -189.6920013427734 -42.40399932861328 L -202.8809967041016 -42.40399932861328 C -203.2960052490234 -42.40399932861328 -203.6309967041016 -42.06800079345703 -203.6309967041016 -41.65399932861328 C -203.6309967041016 -41.2400016784668 -203.2960052490234 -40.90399932861328 -202.8809967041016 -40.90399932861328 L -189.6920013427734 -40.90399932861328 L -192.4120025634766 -38.18399810791016 C -192.7050018310547 -37.89099884033203 -192.7050018310547 -37.41699981689453 -192.4120025634766 -37.12400054931641 C -192.1190032958984 -36.83100128173828 -191.6439971923828 -36.83100128173828 -191.3509979248047 -37.12400054931641 L -188.0579986572266 -40.41699981689453 C -187.375 -41.09999847412109 -187.375 -42.20800018310547 -188.0579986572266 -42.89099884033203 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_lgc5wt =
    '<svg viewBox="170.5 9.4 5.8 3.3" ><path transform="translate(-1.84, -2.23)" d="M 176.2138214111328 12.05612945556641 C 175.7086639404297 11.51229000091553 174.8472900390625 11.51229000091553 174.3421325683594 12.05612945556641 L 172.5040283203125 14.03512001037598 C 172.2989044189453 14.25703525543213 172.3113250732422 14.60304832458496 172.5332336425781 14.80890369415283 C 172.7544097900391 15.01476001739502 173.1011657714844 15.00162029266357 173.3070220947266 14.78043460845947 L 175.1443939208984 12.8014440536499 C 175.2166595458984 12.7233362197876 175.3392944335938 12.7233362197876 175.4115600585938 12.8014440536499 L 177.2489318847656 14.78043460845947 C 177.4547882080078 15.00162029266357 177.8015441894531 15.01476001739502 178.0227203369141 14.80890369415283 C 178.24462890625 14.60304832458496 178.2570495605469 14.25703525543213 178.0519256591797 14.03512001037598 L 176.2138214111328 12.05612945556641 Z" fill="#3a7eae" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_kmpxc8 =
    '<svg viewBox="165.6 3.4 15.7 15.7" ><path transform="translate(0.0, 0.0)" d="M 173.4053344726562 3.378000259399414 C 169.0714263916016 3.378000259399414 165.5579986572266 6.891419410705566 165.5579986572266 11.225341796875 C 165.5579986572266 15.55926513671875 169.0714263916016 19.07268333435059 173.4053344726562 19.07268333435059 C 177.7392578125 19.07268333435059 181.252685546875 15.55926513671875 181.252685546875 11.225341796875 C 181.252685546875 6.891419410705566 177.7392578125 3.378000259399414 173.4053344726562 3.378000259399414 Z M 173.4053344726562 17.97770500183105 C 169.6758575439453 17.97770500183105 166.6529846191406 14.95483589172363 166.6529846191406 11.225341796875 C 166.6529846191406 7.496577739715576 169.6758575439453 4.472977638244629 173.4053344726562 4.472977638244629 C 177.1348419189453 4.472977638244629 180.1576995849609 7.496577739715576 180.1576995849609 11.225341796875 C 180.1576995849609 14.95483589172363 177.1348419189453 17.97770500183105 173.4053344726562 17.97770500183105 Z" fill="#3a7eae" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_wa4r4c =
    '<svg viewBox="57.5 292.9 299.0 1.0" ><path transform="translate(45.69, 292.94)" d="M 11.81103515625 0 L 310.81103515625 0" fill="none" stroke="#f2f2f2" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ljqis0 =
    '<svg viewBox="6.4 9.7 4.6 1.0" ><path transform="translate(117.98, -7.81)" d="M -107.4444351196289 17.55400085449219 L -111.1282958984375 17.55400085449219 C -111.3774185180664 17.55400085449219 -111.5789947509766 17.75618553161621 -111.5789947509766 18.00590896606445 C -111.5789947509766 18.25502777099609 -111.3774185180664 18.45721435546875 -111.1282958984375 18.45721435546875 L -107.4444351196289 18.45721435546875 C -107.1953125 18.45721435546875 -106.9931335449219 18.25502777099609 -106.9931335449219 18.00590896606445 C -106.9931335449219 17.75618553161621 -107.1953125 17.55400085449219 -107.4444351196289 17.55400085449219 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_k0m11j =
    '<svg viewBox="0.0 0.0 10.7 10.7" ><path transform="translate(122.22, -1.36)" d="M -112.0578002929688 3.342990159988403 L -113.5573425292969 1.843451499938965 C -114.2030029296875 1.197181344032288 -115.2506408691406 1.19778299331665 -115.8963088989258 1.84465479850769 L -121.4925079345703 7.449272155761719 C -121.8920593261719 7.849430561065674 -122.1267395019531 8.384980201721191 -122.1508026123047 8.950015068054199 L -122.2218170166016 10.64030742645264 C -122.2543029785156 11.40993309020996 -121.6393280029297 12.05138969421387 -120.8696975708008 12.05138969421387 L -119.2137069702148 12.05138969421387 C -118.6053466796875 12.05138969421387 -118.0228576660156 11.80587768554688 -117.5986328125 11.37021827697754 L -112.0427627563477 5.669923305511475 C -111.4103240966797 5.021246433258057 -111.4169464111328 3.983844757080078 -112.0578002929688 3.342990159988403 Z M -118.2443084716797 10.74019432067871 C -118.4994430541992 11.00135040283203 -118.8484497070312 11.14877700805664 -119.2137069702148 11.14877700805664 L -120.8696975708008 11.14877700805664 C -121.1260375976562 11.14877700805664 -121.3312377929688 10.93455791473389 -121.3204040527344 10.67821598052979 L -121.2493896484375 8.987924575805664 C -121.2349548339844 8.648542404174805 -121.0941467285156 8.327212333679199 -120.8540573120117 8.087118148803711 L -116.8964080810547 4.124050617218018 L -114.3137283325195 6.706723213195801 L -118.2443084716797 10.74019432067871 Z M -112.6884231567383 5.039298534393311 L -113.683708190918 6.06045389175415 L -116.2585601806641 3.485001087188721 L -115.2578582763672 2.482500553131104 C -114.9648132324219 2.188850879669189 -114.4882354736328 2.188850879669189 -114.194580078125 2.482500553131104 L -112.6950454711914 3.982039213180542 C -112.4037933349609 4.273282527923584 -112.4007873535156 4.74444580078125 -112.6884231567383 5.039298534393311 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_m5x5n =
    '<svg viewBox="-20.6 0.5 16.2 17.4" ><path  d="M -8.194324493408203 1.900196552276611 L -8.194324493408203 1.162583708763123 C -8.194324493408203 0.8186407089233398 -8.472793579101562 0.5410000085830688 -8.81590747833252 0.5410000085830688 C -9.159022331237793 0.5410000085830688 -9.437491416931152 0.8186407089233398 -9.437491416931152 1.162583708763123 L -9.437491416931152 1.784167408943176 L -15.65332984924316 1.784167408943176 L -15.65332984924316 1.162583708763123 C -15.65332984924316 0.8186407089233398 -15.93179893493652 0.5410000085830688 -16.2749137878418 0.5410000085830688 C -16.61802673339844 0.5410000085830688 -16.8964958190918 0.8186407089233398 -16.8964958190918 1.162583708763123 L -16.8964958190918 1.900196552276611 C -19.0297737121582 2.3734290599823 -20.62599945068359 4.273818016052246 -20.62599945068359 6.549643039703369 L -20.62599945068359 13.17987155914307 C -20.62599945068359 15.81124210357666 -18.49272346496582 17.94534683227539 -15.86052513122559 17.94534683227539 L -9.230297088623047 17.94534683227539 C -6.59809684753418 17.94534683227539 -4.464821338653564 15.81124210357666 -4.464821338653564 13.17987155914307 L -4.464821338653564 6.549643039703369 C -4.464821338653564 4.273818016052246 -6.06104850769043 2.3734290599823 -8.194324493408203 1.900196552276611 Z M -16.8964958190918 3.199721097946167 L -16.8964958190918 3.648918867111206 C -16.8964958190918 3.992033004760742 -16.61802673339844 4.27050256729126 -16.2749137878418 4.27050256729126 C -15.93179893493652 4.27050256729126 -15.65332984924316 3.992033004760742 -15.65332984924316 3.648918867111206 L -15.65332984924316 3.027334928512573 L -9.437491416931152 3.027334928512573 L -9.437491416931152 3.648918867111206 C -9.437491416931152 3.992033004760742 -9.159022331237793 4.27050256729126 -8.81590747833252 4.27050256729126 C -8.472793579101562 4.27050256729126 -8.194324493408203 3.992033004760742 -8.194324493408203 3.648918867111206 L -8.194324493408203 3.199721097946167 C -6.951985359191895 3.584274053573608 -6.003862857818604 4.625219821929932 -5.770976066589355 5.928059577941895 L -19.32067489624023 5.928059577941895 C -19.08778762817383 4.625219821929932 -18.13966369628906 3.584274053573608 -16.8964958190918 3.199721097946167 Z M -9.230297088623047 16.70217895507812 L -15.86052513122559 16.70217895507812 C -17.80566596984863 16.70217895507812 -19.38283157348633 15.12501430511475 -19.38283157348633 13.17987155914307 L -19.38283157348633 7.17122745513916 L -5.707988739013672 7.17122745513916 L -5.707988739013672 13.17987155914307 C -5.707988739013672 15.12501430511475 -7.285154342651367 16.70217895507812 -9.230297088623047 16.70217895507812 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_bwsca4 =
    '<svg viewBox="-17.7 9.2 2.1 1.2" ><path transform="translate(-0.6, -1.8)" d="M -15.67563819885254 11.04100036621094 L -16.50441551208496 11.04100036621094 C -16.84753036499023 11.04100036621094 -17.12599945068359 11.31864166259766 -17.12599945068359 11.66258430480957 C -17.12599945068359 12.00569820404053 -16.84753036499023 12.2841682434082 -16.50441551208496 12.2841682434082 L -15.67563819885254 12.2841682434082 C -15.33252334594727 12.2841682434082 -15.05405426025391 12.00569820404053 -15.05405426025391 11.66258430480957 C -15.05405426025391 11.31864166259766 -15.33252334594727 11.04100036621094 -15.67563819885254 11.04100036621094 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_y9b614 =
    '<svg viewBox="-13.6 9.2 2.1 1.2" ><path transform="translate(-1.46, -1.8)" d="M -10.67563819885254 11.04100036621094 L -11.50441741943359 11.04100036621094 C -11.84753036499023 11.04100036621094 -12.12600135803223 11.31864166259766 -12.12600135803223 11.66258430480957 C -12.12600135803223 12.00569820404053 -11.84753036499023 12.2841682434082 -11.50441741943359 12.2841682434082 L -10.67563819885254 12.2841682434082 C -10.33252334594727 12.2841682434082 -10.05405426025391 12.00569820404053 -10.05405426025391 11.66258430480957 C -10.05405426025391 11.31864166259766 -10.33252334594727 11.04100036621094 -10.67563819885254 11.04100036621094 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_lhe7vp =
    '<svg viewBox="-9.4 9.2 2.1 1.2" ><path transform="translate(-2.31, -1.8)" d="M -5.675637722015381 11.04100036621094 L -6.504415988922119 11.04100036621094 C -6.847530364990234 11.04100036621094 -7.125999927520752 11.31864166259766 -7.125999927520752 11.66258430480957 C -7.125999927520752 12.00569820404053 -6.847530364990234 12.2841682434082 -6.504415988922119 12.2841682434082 L -5.675637722015381 12.2841682434082 C -5.332523345947266 12.2841682434082 -5.054054260253906 12.00569820404053 -5.054054260253906 11.66258430480957 C -5.054054260253906 11.31864166259766 -5.332523345947266 11.04100036621094 -5.675637722015381 11.04100036621094 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_dd09on =
    '<svg viewBox="-17.7 12.6 2.1 1.2" ><path transform="translate(-0.6, -2.48)" d="M -15.67563819885254 15.04100036621094 L -16.50441551208496 15.04100036621094 C -16.84753036499023 15.04100036621094 -17.12599945068359 15.31864070892334 -17.12599945068359 15.66258430480957 C -17.12599945068359 16.00569915771484 -16.84753036499023 16.2841682434082 -16.50441551208496 16.2841682434082 L -15.67563819885254 16.2841682434082 C -15.33252334594727 16.2841682434082 -15.05405426025391 16.00569915771484 -15.05405426025391 15.66258430480957 C -15.05405426025391 15.31864070892334 -15.33252334594727 15.04100036621094 -15.67563819885254 15.04100036621094 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_g0z97 =
    '<svg viewBox="-13.6 12.6 2.1 1.2" ><path transform="translate(-1.46, -2.48)" d="M -10.67563819885254 15.04100036621094 L -11.50441741943359 15.04100036621094 C -11.84753036499023 15.04100036621094 -12.12600135803223 15.31864070892334 -12.12600135803223 15.66258430480957 C -12.12600135803223 16.00569915771484 -11.84753036499023 16.2841682434082 -11.50441741943359 16.2841682434082 L -10.67563819885254 16.2841682434082 C -10.33252334594727 16.2841682434082 -10.05405426025391 16.00569915771484 -10.05405426025391 15.66258430480957 C -10.05405426025391 15.31864070892334 -10.33252334594727 15.04100036621094 -10.67563819885254 15.04100036621094 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_s9ueg2 =
    '<svg viewBox="-9.4 12.6 2.1 1.2" ><path transform="translate(-2.31, -2.48)" d="M -5.675637722015381 15.04100036621094 L -6.504415988922119 15.04100036621094 C -6.847530364990234 15.04100036621094 -7.125999927520752 15.31864070892334 -7.125999927520752 15.66258430480957 C -7.125999927520752 16.00569915771484 -6.847530364990234 16.2841682434082 -6.504415988922119 16.2841682434082 L -5.675637722015381 16.2841682434082 C -5.332523345947266 16.2841682434082 -5.054054260253906 16.00569915771484 -5.054054260253906 15.66258430480957 C -5.054054260253906 15.31864070892334 -5.332523345947266 15.04100036621094 -5.675637722015381 15.04100036621094 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_m0rnpk =
    '<svg viewBox="-27.3 -47.7 8.6 11.5" ><path  d="M -18.7036018371582 -38.91335296630859 L -18.7036018371582 -44.87328338623047 C -18.7036018371582 -46.41616058349609 -19.95444107055664 -47.66699981689453 -21.49731826782227 -47.66699981689453 L -24.4772834777832 -47.66699981689453 C -26.02015686035156 -47.66699981689453 -27.27099990844727 -46.41616058349609 -27.27099990844727 -44.87328338623047 L -27.27099990844727 -38.91335296630859 C -27.27099990844727 -37.37047576904297 -26.02015686035156 -36.11963653564453 -24.4772834777832 -36.11963653564453 L -21.49731826782227 -36.11963653564453 C -19.95444107055664 -36.11963653564453 -18.7036018371582 -37.37047576904297 -18.7036018371582 -38.91335296630859 Z M -24.4772834777832 -37.23712158203125 C -25.40256118774414 -37.23712158203125 -26.15351104736328 -37.98732757568359 -26.15351104736328 -38.91335296630859 L -26.15351104736328 -44.87328338623047 C -26.15351104736328 -45.79856109619141 -25.40256118774414 -46.54951477050781 -24.4772834777832 -46.54951477050781 L -21.49731826782227 -46.54951477050781 C -20.57129287719727 -46.54951477050781 -19.82108688354492 -45.79856109619141 -19.82108688354492 -44.87328338623047 L -19.82108688354492 -38.91335296630859 C -19.82108688354492 -37.98732757568359 -20.57129287719727 -37.23712158203125 -21.49731826782227 -37.23712158203125 L -24.4772834777832 -37.23712158203125 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_az0oa2 =
    '<svg viewBox="-24.0 -44.4 8.3 11.2" ><path transform="translate(-1.12, -1.12)" d="M -15.99726104736328 -43.19063949584961 C -16.26471138000488 -43.34485244750977 -16.60591697692871 -43.25321578979492 -16.7608757019043 -42.98650741577148 C -16.91508865356445 -42.71905899047852 -16.82419967651367 -42.37785339355469 -16.55674743652344 -42.22289276123047 C -16.05462455749512 -41.93234634399414 -15.7186336517334 -41.39073944091797 -15.7186336517334 -40.77090454101562 L -15.7186336517334 -34.81097412109375 C -15.7186336517334 -33.88495254516602 -16.46883964538574 -33.13474655151367 -17.39486312866211 -33.13474655151367 L -20.37482833862305 -33.13474655151367 C -20.99391555786133 -33.13474655151367 -21.53627014160156 -33.47073745727539 -21.82681465148926 -33.97285842895508 C -21.98102951049805 -34.24031066894531 -22.3229808807373 -34.33119964599609 -22.59043312072754 -34.17698669433594 C -22.85713958740234 -34.02202987670898 -22.94877243041992 -33.68082427978516 -22.79381561279297 -33.41337203979492 C -22.31180572509766 -32.57972717285156 -21.40962028503418 -32.01725769042969 -20.37482833862305 -32.01725769042969 L -17.39486312866211 -32.01725769042969 C -15.85198593139648 -32.01725769042969 -14.60114669799805 -33.26810073852539 -14.60114669799805 -34.81097412109375 L -14.60114669799805 -40.77090454101562 C -14.60114669799805 -41.80569839477539 -15.16361427307129 -42.70788192749023 -15.99726104736328 -43.19063949584961 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_sxfztk =
    '<svg viewBox="-44.8 1.0 10.0 12.3" ><path  d="M -35.1281852722168 4.30787992477417 L -37.37948989868164 1.606542468070984 C -37.67798614501953 1.248003363609314 -38.12058258056641 1.041000008583069 -38.58720397949219 1.041000008583069 L -39.76746368408203 1.041000008583069 L -42.05479431152344 1.041000008583069 C -43.55471038818359 1.041000008583069 -44.77099990844727 2.256716251373291 -44.77099990844727 3.757205009460449 L -44.77099990844727 10.61919784545898 C -44.77099990844727 12.11911392211914 -43.55471038818359 13.3354024887085 -42.05479431152344 13.3354024887085 L -37.48013305664062 13.3354024887085 C -35.97964477539062 13.3354024887085 -34.7639274597168 12.11911392211914 -34.7639274597168 10.61919784545898 L -34.7639274597168 7.188200950622559 L -34.7639274597168 5.314877510070801 C -34.7639274597168 4.946616649627686 -34.8925895690918 4.590365409851074 -35.1281852722168 4.30787992477417 Z M -36.10830688476562 4.471995830535889 L -36.90830230712891 4.471995830535889 C -37.30286407470703 4.471995830535889 -37.62309265136719 4.151769638061523 -37.62309265136719 3.757205009460449 L -37.62309265136719 2.654139757156372 L -36.10830688476562 4.471995830535889 Z M -35.62167739868164 10.61919784545898 C -35.62167739868164 11.64563751220703 -36.45369338989258 12.47765350341797 -37.48013305664062 12.47765350341797 L -42.05479431152344 12.47765350341797 C -43.08123397827148 12.47765350341797 -43.91324996948242 11.64563751220703 -43.91324996948242 10.61919784545898 L -43.91324996948242 3.757205009460449 C -43.91324996948242 2.730765342712402 -43.08123397827148 1.898748993873596 -42.05479431152344 1.898748993873596 L -39.76746368408203 1.898748993873596 L -38.58720397949219 1.898748993873596 C -38.55117797851562 1.898748993873596 -38.51572418212891 1.905039191246033 -38.48084259033203 1.910185694694519 L -38.48084259033203 3.757205009460449 C -38.48084259033203 4.625247001647949 -37.77634429931641 5.329744815826416 -36.90830230712891 5.329744815826416 L -35.62167739868164 5.329744815826416 L -35.62167739868164 7.188200950622559 L -35.62167739868164 10.61919784545898 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_krs5uq =
    '<svg viewBox="-42.5 6.8 5.4 1.0" ><path transform="translate(-1.71, -4.28)" d="M -35.76746368408203 11.04100036621094 L -40.34212493896484 11.04100036621094 C -40.57886505126953 11.04100036621094 -40.77099990844727 11.23256397247314 -40.77099990844727 11.46987438201904 C -40.77099990844727 11.70661354064941 -40.57886505126953 11.89874839782715 -40.34212493896484 11.89874839782715 L -35.76746368408203 11.89874839782715 C -35.5301513671875 11.89874839782715 -35.33858871459961 11.70661354064941 -35.33858871459961 11.46987438201904 C -35.33858871459961 11.23256397247314 -35.5301513671875 11.04100036621094 -35.76746368408203 11.04100036621094 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_eo9ld =
    '<svg viewBox="-42.5 9.6 3.1 1.0" ><path transform="translate(-1.71, -6.42)" d="M -38.05479431152344 16.04100036621094 L -40.34212493896484 16.04100036621094 C -40.57886505126953 16.04100036621094 -40.77099990844727 16.23256301879883 -40.77099990844727 16.46987533569336 C -40.77099990844727 16.70661354064941 -40.57886505126953 16.89874839782715 -40.34212493896484 16.89874839782715 L -38.05479431152344 16.89874839782715 C -37.81748199462891 16.89874839782715 -37.62591934204102 16.70661354064941 -37.62591934204102 16.46987533569336 C -37.62591934204102 16.23256301879883 -37.81748199462891 16.04100036621094 -38.05479431152344 16.04100036621094 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_vbtjod =
    '<svg viewBox="-87.8 -25.9 14.8 14.8" ><path transform="translate(0.0, 0.0)" d="M -76.94375610351562 -25.94699859619141 L -83.81059265136719 -25.94699859619141 C -85.99079895019531 -25.94699859619141 -87.75900268554688 -24.17947769165039 -87.75900268554688 -21.99857711791992 L -87.75900268554688 -15.13175296783447 C -87.75900268554688 -12.95153713226318 -85.99079895019531 -11.18332958221436 -83.81059265136719 -11.18332958221436 L -76.94375610351562 -11.18332958221436 C -74.76286315917969 -11.18332958221436 -72.99533081054688 -12.95153713226318 -72.99533081054688 -15.13175296783447 L -72.99533081054688 -21.99857711791992 C -72.99533081054688 -24.17947769165039 -74.76286315917969 -25.94699859619141 -76.94375610351562 -25.94699859619141 Z M -76.94375610351562 -12.21335315704346 L -83.81059265136719 -12.21335315704346 C -85.42222595214844 -12.21335315704346 -86.72898864746094 -13.52010822296143 -86.72898864746094 -15.13175296783447 L -86.72898864746094 -21.99857711791992 C -86.72898864746094 -23.6102180480957 -85.42222595214844 -24.91697692871094 -83.81059265136719 -24.91697692871094 L -76.94375610351562 -24.91697692871094 C -75.33143615722656 -24.91697692871094 -74.02536010742188 -23.6102180480957 -74.02536010742188 -21.99857711791992 L -74.02536010742188 -15.13175296783447 C -74.02536010742188 -13.52010822296143 -75.33143615722656 -12.21335315704346 -76.94375610351562 -12.21335315704346 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_r0b0fp =
    '<svg viewBox="-83.0 -21.1 5.2 5.2" ><path transform="translate(-2.19, -2.19)" d="M -76.1239013671875 -16.88695526123047 L -77.66893768310547 -16.88695526123047 L -77.66893768310547 -18.43198776245117 C -77.66893768310547 -18.71627807617188 -77.89897918701172 -18.94700241088867 -78.18394470214844 -18.94700241088867 C -78.46823120117188 -18.94700241088867 -78.69895935058594 -18.71627807617188 -78.69895935058594 -18.43198776245117 L -78.69895935058594 -16.88695526123047 L -80.24400329589844 -16.88695526123047 C -80.52827453613281 -16.88695526123047 -80.75900268554688 -16.65623092651367 -80.75900268554688 -16.37194061279297 C -80.75900268554688 -16.08765411376953 -80.52827453613281 -15.85692882537842 -80.24400329589844 -15.85692882537842 L -78.69895935058594 -15.85692882537842 L -78.69895935058594 -14.31189441680908 C -78.69895935058594 -14.02760791778564 -78.46823120117188 -13.79688358306885 -78.18394470214844 -13.79688358306885 C -77.89897918701172 -13.79688358306885 -77.66893768310547 -14.02760791778564 -77.66893768310547 -14.31189441680908 L -77.66893768310547 -15.85692882537842 L -76.1239013671875 -15.85692882537842 C -75.83892059326172 -15.85692882537842 -75.60888671875 -16.08765411376953 -75.60888671875 -16.37194061279297 C -75.60888671875 -16.65623092651367 -75.83892059326172 -16.88695526123047 -76.1239013671875 -16.88695526123047 Z" fill="#2b3f6c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
