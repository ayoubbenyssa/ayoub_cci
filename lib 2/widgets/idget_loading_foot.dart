import 'package:flutter/material.dart';
import 'package:mycgem/widgets/loading_foot.dart';



class MyLoadingPage extends StatefulWidget {
  MyLoadingPage(this._isPaused,{Key key, this.title}) : super(key: key);

  bool _isPaused = true;



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyLoadingPage>
    with SingleTickerProviderStateMixin {

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    if(widget._isPaused == true)

      {
        _run();
      }
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _pause() {
    setState(() {
      widget._isPaused = true;
      animationController.stop();
    });
  }

  void _run() {
    setState(() {
      widget._isPaused = false;
      animationController.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 150,
              child: Stickman(animationController: animationController),
            ),
            /*Icon( widget._isPaused ? Icons.directions_walk : Icons.directions_run,
                color: Colors.purple.withAlpha(127)),*/
          ],
        ),
      );
  }
}