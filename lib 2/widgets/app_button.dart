import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/services/Fonts.dart';


class AppButton extends StatelessWidget {
  AppButton(this.text,this.onPressed,{this.show});

  String text;
  var onPressed;
  bool show;


  @override
  Widget build(BuildContext context) {

    //ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);


    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: ScreenUtil().setSp(15),
        fontWeight: FontWeight.w500);

    return new Container(

        padding: new EdgeInsets.only(left: 36.0, right: 36.0),
        child: new Material(
            elevation: 1.0,
            shadowColor: Fonts.col_app_fon,
            borderRadius: new BorderRadius.circular(8.0),
            color: Fonts.col_app_fon,

            /*decoration: new BoxDecoration(
            border: new Border.all(color: const Color(0xffeff2f7), width: 1.5),
            borderRadius: new BorderRadius.circular(6.0)),*/
            child: new MaterialButton(
              // color:  const Color(0xffa3bbf1),
                onPressed: () {
                  onPressed();
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    show
                        ? Container(
                        width: 20,
                        height: 20,

                        // padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        ))
                        : new Image.asset(
                      "images/log.png",
                      width: 25.0,
                      height: 25.0,
                      fit: BoxFit.cover,
                    ),
                    new Container(
                      width: 8.0,
                    ),
                    //  new Container(height: 36.0,color: Colors.white,width: 1.5,),
                    new Container(
                      width: 8.0,
                    ),
                    new Text(text, style: style)
                  ],
                ))));
  }
}
