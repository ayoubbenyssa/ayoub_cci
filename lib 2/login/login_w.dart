import 'package:flutter/material.dart';
import 'package:mycgem/widgets/arc_clipper.dart';
import 'package:mycgem/widgets/widgets.dart';

class LoginBackground extends StatelessWidget {
  var grad;

  final showIcon;
  final image;
  Widget widget;

  LoginBackground(this.grad, {this.showIcon = true, this.image, this.widget});

  Widget topHalf(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return new Flexible(
      flex: 2,
      child: ClipPath(
        clipper: new ArcClipper(),
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.white.withOpacity(0.7), BlendMode.dstATop),
                      image: new AssetImage("images/bc.png")),
                  gradient: new LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    colors: grad,
                  )),
            ),
            widget != null
                ? widget
                : Container(),
            new Padding(
                padding: new EdgeInsets.only(
                  bottom: 200.0,
                  top: 18.0,
                ),
                child: showIcon
                    ? new Center(
                  child: SizedBox(child: Widgets.avatar),
                )
                    : new Container(
                    width: double.infinity,
                    child: image != null
                        ? Container(
                        padding: EdgeInsets.all(18),
                        child: Image.asset("images/logo.png",
                            fit: BoxFit.cover))
                        : new Container()))
          ],
        ),
      ),
    );
  }

  final bottomHalf = new Flexible(
    flex: 3,
    child: new Container(),
  );

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[topHalf(context), bottomHalf],
    );
  }
}
