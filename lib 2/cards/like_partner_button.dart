import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/likepartnerservice.dart';
/*s
class LikePartnerButton extends StatefulWidget {
  LikePartnerButton(this.partner, this.user,this.bl);

  var partner;
  User user;
  bool bl;



  @override
  _FavoriteButtonState createState() => new _FavoriteButtonState();
}

class _FavoriteButtonState extends State<LikePartnerButton>
    with TickerProviderStateMixin {

  Animation<double> _heartAnimation;
  AnimationController _heartAnimationController;
  Color _heartColor = Colors.grey[400];
  bool favorite = false;
  int fav_id;
  static const int _kHeartAnimationDuration = 100;
  //LikePartnertService favservice = new LikePartnertService();
  LikePartnertService likeFunctions = new LikePartnertService();
  bool show = false;


  _configureAnimation() {
    Animation<double> _initAnimation({@required double from,
      @required double to,
      @required Curve curve,
      @required AnimationController controller}) {
      final CurvedAnimation animation = new CurvedAnimation(
        parent: controller,
        curve: curve,
      );
      return new Tween<double>(begin: from, end: to).animate(animation);
    }

    _heartAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kHeartAnimationDuration),
      vsync: this,
    );

    _heartAnimation = _initAnimation(
        from: 1.0,
        to: 1.8,
        curve: Curves.easeOut,
        controller: _heartAnimationController);
  }


  isliked() async {
    var res = await likeFunctions.isliked(
        widget.user.id, widget.partner.objectId);
    try {
      setState(() {
        widget.partner.liked = res;
      });
    } catch (e) {
      e.toString();
    }
  }


  toggletar() async {
    setState(() {
      show = true;
    });
    var res = await likeFunctions.like(widget.user.id, widget.partner.objectId);
    if (res == false) return;
    try {


      setState(() {
        show = false;
        widget.partner.liked = res["isLiked"];
        widget.partner.numberlikes = res["numberlikes"];
      });

      if(widget.partner.liked)
      {
       /* Scaffold
            .of(context)
            .showSnackBar(new SnackBar(content: new Text("Votre requette sera transmise à notre partenaire!")));*/
      }
      else{

      }

    } catch (e) {
      e.toString();
    }

    //  return {"numberlikes": numberlikes + 1, "isLiked": true};
  }


  @override
  void initState() {
    super.initState();
    _configureAnimation();
    isliked();


    //verify_fav();
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  String id;

  toggle() async {
    Scaffold.of(context).
    showSnackBar(new SnackBar(content: new Text("Suppriméé")));
  }


 Color loginGradientStart =  Colors.pink[200];
 Color loginGradientEnd = const  Color(0xffF40D30);



  Color loginGradientStart1 = Colors.green[200];
  Color loginGradientEnd1 =Colors.green[700];


  @override
  Widget build(BuildContext context) {


    final Widget child = widget.bl == true ?new Container(

        padding: new EdgeInsets.only(left: 52.0, right: 52.0),
        child: new Material(
          elevation: 1.0,
          shadowColor: Fonts.col_app_fon,
          borderRadius: new BorderRadius.circular(8.0),
          color:widget.partner.liked == false
              ? Fonts.col_app_fon:Fonts.col_grey,

          /*decoration: new BoxDecoration(
            border: new Border.all(color: const Color(0xffeff2f7), width: 1.5),
            borderRadius: new BorderRadius.circular(6.0)),*/
          child: MaterialButton(
              highlightColor: Colors.transparent,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  show
                      ? new Container(width:20.0,
                      height: 20.0,
                      child: new CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Fonts.col_gr),
                        strokeWidth: 3.0,))
                      : new Container(),
                  new Container(width: 4.0),
                  Text(
                    widget.partner.liked == true
                        ? LinkomTexts.of(context).annuler()
                        : LinkomTexts.of(context).sui(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.0),

                  ),
                ],),
              onPressed: () {
                toggletar();
              }
          ),
        )
      /*new Container(
          child: new ScaleTransition(
              scale: _heartAnimation,
              child: new Text(
                widget.offer.liked == true
                    ? "Acheté": "J'achète",
                style: new TextStyle(
                    color: widget.offer.liked == true
                        ? Colors.green
                        : const Color(0xffff374e),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              )

            /*new Icon(
                Icons.favorite,
                color: widget.offer.liked == true ? const Color(0xffff374e):Colors.grey[400],
                size: 24.0,
              )*/))*/


    ):new InkWell(
      //padding: new EdgeInsets.all(1.0),
      child:    Container(
        height: 44.0,
        width: MediaQuery.of(context).size.width*0.42,

        child: MaterialButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(
                  Radius.circular(4.0),
                )),
            color:  widget.partner.liked == true
                ? Colors.grey:Fonts.col_gr,
            highlightColor: Colors.transparent,
            splashColor: loginGradientEnd,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            show
                ? new Container(width:20.0,
                height: 20.0,
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink[100]),
                  strokeWidth: 3.0,))
                : new Container(),
            new Container(width: 4.0),
            Text(
              widget.partner.liked == true
                  ? "Suivi": LinkomTexts.of(context).sui(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.0),

            ),
          ],),
          onPressed: () {
            toggletar();
          }
      ),
    )
    /*new Container(
          child: new ScaleTransition(
              scale: _heartAnimation,
              child: new Text(
                widget.offer.liked == true
                    ? "Acheté": "J'achète",
                style: new TextStyle(
                    color: widget.offer.liked == true
                        ? Colors.green
                        : const Color(0xffff374e),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              )

            /*new Icon(
                Icons.favorite,
                color: widget.offer.liked == true ? const Color(0xffff374e):Colors.grey[400],
                size: 24.0,
              )*/))*/


    );

    return
      child;
  }
}
*/