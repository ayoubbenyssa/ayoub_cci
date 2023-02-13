import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/services/Fonts.dart';




class ConnectButton extends StatefulWidget {
  ConnectButton(this.show_connect,this.id);
  var show_connect;
  var id;



  @override
  _ConnectButtonState createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton> {

  ParseServer parse_s = new ParseServer();



  connectedorno() async {
    var id = widget.id;
    var response = await parse_s.getparse('connect?where={"receive_req":"$id"}');

  }

  @override
  void initState() {
    super.initState();

    connectedorno();

  }





  @override
  Widget build(BuildContext context) {

    const Color loginGradientStart = Colors.cyan;
    const Color loginGradientEnd = Fonts.col_app;



    Widget lgn = Container(
      width: 146.0,
      height: 42.0,
      margin: new EdgeInsets.only(bottom: 4.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: loginGradientStart,
            offset: Offset(1.0, 2.0),
            blurRadius: 10.0,
          ),
          BoxShadow(
            color: loginGradientEnd,
            offset: Offset(1.0, 2.0),
            blurRadius: 4.0,
          ),
        ],
        gradient: new LinearGradient(
            colors: [loginGradientEnd, loginGradientStart],
            begin: const FractionalOffset(0.1, 0.1),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: loginGradientEnd,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: Text(
              "Se connecter",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.0),
            ),
          ),
          onPressed: () {
            widget.show_connect();
          }),
    );


    return lgn;
  }
}
