import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/annonces/details_annonce.dart';
import 'package:mycgem/cards/details_parc.dart';
import 'package:mycgem/cards/like_widget.dart';
import 'package:mycgem/cards/likes.dart';
import 'package:mycgem/cards/participatebutton.dart';
import 'package:mycgem/cards/prom_details.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/commentsfunctions.dart';
import 'package:mycgem/services/like_wall_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/widgets/pdf_widget.dart';

class CardFooter extends StatefulWidget {
  CardFooter(this.an, this.user, this.deletepost, this.context, this.list,
      this.analytics, this.lat, this.lng, this.onLocaleChange,
      {this.ratefunc});

  var an;
  var deletepost;
  var context;
  User user;
  var list;
  var analytics;
  double lat;
  double lng;
  var onLocaleChange;
  var ratefunc;

  @override
  _CardFooterState createState() => new _CardFooterState();
}

class _CardFooterState extends State<CardFooter> {
  String _value1 = 'addfav';
  CommentFunctions commentFunctions = new CommentFunctions();

  //likes
  LikeFunctions likeFunctions = new LikeFunctions();

  var likestext = "Likes";

  var load = true;

  bool wait = false;

  /* toggletar() async {
    /* _heartAnimationController.forward().whenComplete(() {
      _heartAnimationController.reverse();
    });*/
    setState(() {
      wait = true;
    });
    var res =
        await likeFunctions.like(widget.an.objectId, context, widget.user.id);
    if (res == "nointernet") {
    } else if (res == "error") {
    } else {
      try {
        setState(() {
          widget.an.isLiked = res["isLiked"];
          widget.an.likesCount = res["numberLikes"];
          wait= false;
        });
      } catch (e) {}
    }
  }*/
  func_update_comment(num) {
    setState(() {
      widget.an.numbercommenttext =
          (int.parse(widget.an.numbercommenttext) + num).toString();
    });
  }

  func_update_likes(i) {
    setState(() {
      widget.an.likes_post = (int.parse(widget.an.likes_post) + i).toString();
    });
  }


  @override
  initState() {
    super.initState();
    /* isliked();
    getnumbers();
    getNumbeComments();*/
  }

  func() {
    setState(() {
      widget.an.numbercommenttext =
          (int.parse(widget.an.numbercommenttext) + 1).toString();
    });
  }

  getnumbers() async {
    var count = await likeFunctions.likes(widget.an.objectId);
    try {
      setState(() {
        print("-----------------------------------");
        print(count);
        widget.an.likesCount = count;
        likestext = "  j'aime";
        if (widget.an.likesCount.toString() == "1") likestext = "  j'aime";
      });
    } catch (e) {}
  }

  getNumbeComments() {
    commentFunctions.numberComments(widget.an.objectId).then((count) {
      try {
        setState(() {
          widget.an.numbercommenttext = count.toString() /*+" Comments"*/;
        });
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget numbercomments = widget.an.numbercommenttext.toString() == "0"
        ? Container()
        : new Text(
            widget.an.numbercommenttext.toString() +
                (widget.an.numbercommenttext.toString() == "1"
                    ? " Commentaire"
                    : " Commentaires"),
            style: new TextStyle(
                fontWeight: FontWeight.w600,
                color: Fonts.col_ap_fonn,
                fontSize: 13.0.sp),
          );

    Widget textlike = widget.an.likes_post.toString() != "null" &&
            widget.an.likes_post.toString() != "0"
        ? new Text(
            widget.an.likes_post.toString() == "null"
                ? "0"
                : widget.an.likes_post.toString() + " J'aime",
            style: new TextStyle(
                color: Colors.blue[300],
                fontSize: 13.0.sp,
                fontWeight: FontWeight.w600))
        : Container();

    Widget decodertoggletar = new Container(
        child: widget.an.isLiked
            ? new Image.asset("images/hand.png", width: 18.0.w, height: 18.0.w)
            : new Image.asset("images/handn.png",
                width: 18.0.w, height: 18.0.w));

    Widget iconlike = decodertoggletar;

    goto() {}

    return new Container(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Column(children: [

          Container(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: textlike,
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute<Null>(
                          builder: (BuildContext context) => new LikeList(
                              widget.lat,
                              widget.lng,
                              widget.user,
                              widget.onLocaleChange,
                              widget.an.objectId)));

                  //  rt.gotocomment(context, widget.news, widget.news.author["objectId"],false,false);
                },
              ),
              Expanded(
                child: Container(),
              ),
              /* new InkWell(
                child: numbercomments,
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute<Null>(
                          builder: (BuildContext context) => new Comments(
                              widget.an,
                              "",
                              true,
                              widget.user,
                              func_update_comment,
                              widget.onLocaleChange)));

                  //  rt.gotocomment(context, widget.news, widget.news.author["objectId"],false,false);
                },
              ),
              Container(
                width: 12,
              ),*/
            ],
          ),
          Container(
            height: 6.h,
          ),
          new Container(
              color: /*const Color(0xffedd9ac)*/ Colors.white,
              child: new Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  margin: new EdgeInsets.only(
                      left: 4.0, right: 4.0, bottom: 6.0, top: 0.0),
                  child: Center(
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        FavoriteButton(
                          widget.an,
                          widget.user,
                          false,
                          func_update_likes,
                        ),
                        /* new InkWell(
                      onTap: () => toggletar(),
                    */
                        new Container(
                          width: 8.0.w,
                        ),
                        //  textlike,

                        /* new InkWell(
                          child: Row(children: [
                            new Image.asset("images/cht.png",
                                color: Fonts.col_ap_fonn,
                                width: 17.0.w,
                                height: 17.0.w),
                            new Container(
                              width: 8.0.w,
                            ),
                            Text("Commenter",
                                style: new TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Fonts.col_ap_fonn,
                                    fontSize: 13.0.sp)),
                          ]),
                          onTap: () async {
                            Navigator.push(
                                context,
                                new MaterialPageRoute<Null>(
                                    builder: (BuildContext context) =>
                                        new Comments(
                                            widget.an,
                                            "",
                                            true,
                                            widget.user,
                                            func_update_comment,
                                            widget.onLocaleChange)));

                            //  rt.gotocomment(context, widget.news, widget.news.author["objectId"],false,false);
                          },
                        ),*/

                        /*new InkWell(
                          child: Row(
                            children: [
                              new Image.asset("images/share1.png",
                                  color: Fonts.col_app_fonn,
                                  width: 18.0,
                                  height: 18.0),
                              Text("  Partager",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Fonts.col_app_fonn,
                                      fontSize: 14.5)),
                            ],
                          ),
                          onTap: () async {
                            Navigator.push(
                                context,
                                new MaterialPageRoute<Null>(
                                    builder: (BuildContext context) =>
                                        new Comments(widget.an, "", true,
                                            widget.user, func)));

                            //  rt.gotocomment(context, widget.news, widget.news.author["objectId"],false,false);
                          },
                        ),*/

                        new Container(
                          width: 8.0.w,
                        ),

                        /* widget.an.type == "event"
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          child: InkWell(
                              onTap: () {
                                rate();
                              },
                              child: new Image.asset(
                                "images/medal.png",
                                color: Colors.black,
                                width: 18.0,
                                height: 18.0,
                              )))
                      : Container(),*/

                        /**
                                widget.an.type == "event"
                                ? widget.an.docUrl == null || widget.an.docUrl == ""
                                ? Container()
                                : CircleAvatar(
                                backgroundColor: Colors.white,
                                // backgroundColor: Colors.amber[400],
                                child: InkWell(
                                onTap: () {
                                /* Navigator.push(context,
                                new MaterialPageRoute<String>(
                                builder:
                                (BuildContext context) {
                                return new Scaffold(
                                appBar: AppBar(
                                title: new Text(
                                widget.an.name,
                                ),
                                ),
                                body: SimplePdfViewerWidget(
                                completeCallback:
                                (bool result) {
                                print(
                                "completeCallback,result:${result}");
                                },
                                initialUrl: widget.an.docUrl,
                                ),
                                );
                                }));*/
                                },
                                child: new Image.asset(
                                "images/pdf.png",
                                color: Colors.black,
                                width: 18.0,
                                height: 18.0,
                                )))
                                : Container(),
                             */

                        /*

                    Navigator.push(context, new MaterialPageRoute<String>(
                  builder: (BuildContext context) {
                return new  Scaffold(
                  appBar: AppBar(
                    title: const Text('Plugin example app'),
                  ),
                  body: SimplePdfViewerWidget(
                    completeCallback: (bool result){
                      print("completeCallback,result:${result}");
                    },
                    initialUrl: "https://www.orimi.com/pdf-test.pdf",
                  ),
                );
              }));
                   */

                        /* widget.an.author.toString() == "null"
                      ? Container()
                      : widget.user.auth_id == widget.an.author.auth_id
                          ? Container()
                          : new InkWell(
                              child: new Image.asset("images/cht.png",
                                  color: Colors.green[600],
                                  width: 26.0,
                                  height: 26.0),
                              onTap: () async {
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return new ChatScreen(
                                      widget.user.auth_id,
                                      widget.an.author.auth_id,
                                      goto,
                                      false,
                                      null,
                                      widget.analytics,
                                      widget.onLocaleChange,
                                      user: widget.user);
                                }));

                                //  rt.gotocomment(context, widget.news, widget.news.author["objectId"],false,false);
                              },
                            ),*/
                        Container(
                          width: 8.w,
                        ),
                        ((widget.an.author?.id == widget.user.id) ||
                                (widget.user.entreprise?.objectId ==
                                        widget.an.partner?.objectId &&
                                    widget.user.rl == true))
                            ? new InkWell(
                                child: new Image.asset(
                                    "images/icons/delete.png",
                                    color: Fonts.col_ap_fonn,
                                    width: 22.0,
                                    height: 22.0),
                                onTap: () async {
                                  await showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            new AlertDialog(
                                          title: const Text(''),
                                          content: const Text(
                                              'Voulez vous supprimer ce post ?'),
                                          actions: <Widget>[
                                            new FlatButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  widget.deletepost();

                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop('dialog');
                                                }),
                                            new FlatButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop('dialog');
                                              },
                                            ),
                                          ],
                                        ),
                                      ) ??
                                      false;

                                  //  rt.gotocomment(context, widget.news, widget.news.author["objectId"],false,false);
                                },
                              )
                            : Container(),
                        new Expanded(
                            child: new Container(
                          width: 2.0.w,
                        )),

                        widget.an.docUrl.toString() != "null" &&
                                widget.an.docUrl.toString() != ""
                            ? InkWell(
                                //   iconSize: 42,
                                child: CircleAvatar(
                                    radius: 18,
                                    // backgroundColor: Colors.orange[500],
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Image.asset(
                                          "images/pdf.png",
                                          color: Colors.white,
                                          width: 36,
                                          height: 36,
                                          fit: BoxFit.fill,
                                        ))),
                                onTap: () {
                                  Navigator.push(context,
                                      new MaterialPageRoute<String>(
                                          builder: (BuildContext context) {
                                    return PdfWiget(
                                      widget.an.docUrl,
                                      0,
                                      title: widget.an.name,
                                    );
                                  }));
                                  /*Navigator.push(context,
                                      new MaterialPageRoute<String>(
                                          builder: (BuildContext context) {
                                    return new Scaffold(
                                      appBar: AppBar(
                                        title: new Text(
                                          widget.an.name,
                                        ),
                                      ),
                                      body: SimplePdfViewerWidget(
                                        completeCallback: (bool result) {
                                          print(
                                              "completeCallback,result:${result}");
                                        },
                                        initialUrl: widget.an.docUrl,
                                      ),
                                    );
                                  }));*/
                                  /*Navigator.push(context,
                                      new MaterialPageRoute<String>(
                                          builder: (BuildContext context) {
                                    return new WebviewScaffold(
                                      url: widget.an.docUrl,
                                      withZoom: true, // zoom
                                      hidden: true,
                                      appBar: new AppBar(
                                        title: new Text(widget.an.name),
                                      ),
                                    );
                                  }));*/
                                },
                              )
                            : Container(),
                        Container(
                          width: 12,
                        ),
                        widget.an.type != "sondage" &&
                                widget.an.type != "opportunite" &&
                                widget.an.type != "video" &&
                                widget.an.type != "prod_service"
                            ? new RaisedButton(
                                color: Colors.grey[100],
                                elevation: 0,
                                padding: EdgeInsets.all(0),
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.all(
                                  Radius.circular(6.0),
                                )),
                                // padding: EdgeInsets.all(0),
                                onPressed: () {
                                  if (widget.an.type == "Annonces" ||
                                      widget.an.type == "Objets perdus" ||
                                      widget.an.type == "Général" ||
                                      widget.an.type == "Général") {
                                    Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return new DetailsAnnonce(
                                          widget.an,
                                          widget.user,
                                          widget.list,
                                          null,
                                          widget.analytics,
                                          widget.onLocaleChange);
                                    }));
                                  } else if (widget.an.type == "news" ||
                                      widget.an.type == "event") {
                                    Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return new DetailsParc(
                                          widget.an,
                                          widget.user,
                                          widget.an.type,
                                          widget.list,
                                          null,
                                          widget.analytics,
                                          widget.onLocaleChange,
                                          widget.lat,
                                          widget.lng);
                                    }));
                                  } else if (widget.an.type == "promotion") {
                                    Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return new Promo_details(
                                          widget.an,
                                          widget.user,
                                          widget.lat,
                                          widget.lng,
                                          widget.onLocaleChange);
                                    }));
                                  } else {
                                    Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return new DetailsParc(
                                          widget.an,
                                          widget.user,
                                          widget.an.type,
                                          widget.list,
                                          null,
                                          widget.analytics,
                                          widget.onLocaleChange,
                                          widget.lat,
                                          widget.lng);
                                    }));
                                  }
                                },
                                child: Container(
                                    padding: EdgeInsets.only(left: 2, right: 2),
                                    child: Text(
                                      LinkomTexts.of(context).details(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0.sp,
                                        color: Fonts.col_app_green,
                                      ),
                                    )))
                            : Container(),
                        Container(
                          width: 0,
                        )
                        /*  widget.an.type != "sondage" && widget.an.type != "opportunite"
                      ? new RaisedButton(
                          color: Colors.grey[100],
                          elevation: 1,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                            Radius.circular(6.0),
                          )),
                          // padding: EdgeInsets.all(0),
                          onPressed: () {
                            if (widget.an.type == "Annonces" ||
                                widget.an.type == "Objets perdus" ||
                                widget.an.type == "Général" ||
                                widget.an.type == "Général") {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new DetailsAnnonce(
                                    widget.an,
                                    widget.user,
                                    widget.list,
                                    null,
                                    widget.analytics,
                                    widget.onLocaleChange);
                              }));
                            } else if (widget.an.type == "news" ||
                                widget.an.type == "event") {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new DetailsParc(
                                    widget.an,
                                    widget.user,
                                    widget.an.type,
                                    widget.list,
                                    null,
                                    widget.analytics,
                                    widget.onLocaleChange,
                                    widget.lat,
                                    widget.lng);
                              }));
                            } else if (widget.an.type == "promotion") {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new Promo_details(
                                    widget.an,
                                    widget.user,
                                    widget.lat,
                                    widget.lng,
                                    widget.onLocaleChange);
                              }));
                            } else if (widget.an.type == "boutique") {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductPage(
                                              widget.an,
                                              widget.user,
                                              widget.lat,
                                              widget.lng,
                                              widget.onLocaleChange)));
                            } else {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new DetailsParc(
                                    widget.an,
                                    widget.user,
                                    widget.an.type,
                                    widget.list,
                                    null,
                                    widget.analytics,
                                    widget.onLocaleChange,
                                    widget.lat,
                                    widget.lng);
                              }));
                            }
                          },
                          child: Container(
                              child: Text(
                            LinkomTexts.of(context).details(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(30),
                              color: Fonts.col_app_green,
                            ),
                          )))
                      : Container(),*/
                        ,
                      ])))),
        ])); //2E9E51
  }
}
