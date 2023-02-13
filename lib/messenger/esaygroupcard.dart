import 'package:flutter/material.dart';

class EasyBadgeCard1 extends StatelessWidget {
  final Function onTap;
  final Color leftBadge;
  final Color prefixIconColor;
  final Color suffixIconColor;
  final String title;
  final String description;
  final String prefixIcon;
  final String suffixIcon;
  final Color backgroundColor;
  final Color titleColor;
  final Color descriptionColor;
  final Color rightBadge;

  const EasyBadgeCard1(
      {Key key,
        this.onTap,
        this.title,
        this.description,
        this.leftBadge,
        this.prefixIcon,
        this.suffixIcon,
        this.suffixIconColor,
        this.prefixIconColor,
        this.backgroundColor,
        this.descriptionColor,
        this.titleColor,
        this.rightBadge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: this.onTap,
        child: Card(
          color: (this.backgroundColor != null)
              ? this.backgroundColor
              : Colors.white,
          margin: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              (this.leftBadge != null)
                  ? Container(
                width: (this.backgroundColor != null) ? 80.0 : 100.0,
                height: 60.0,
                color: this.leftBadge,
                alignment: Alignment.topRight,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: (this.prefixIcon != null)
                          ? Image.asset(
                        this.prefixIcon,
                        height: 50.0,
                        color: this.prefixIconColor,
                      )
                          : Container(),
                    ),


                  ],
                ),
              )
                  : Container(),
              (this.backgroundColor != null && leftBadge != null)
                  ? Container(

              )
                  : Container(),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      (this.title != null)
                          ? Container(
                        child: Text(
                          this.title,
                          style: TextStyle(
                              color: (this.titleColor != null)
                                  ? this.titleColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      )
                          : Container(),
                      (this.description != null)
                          ? Container(
                        child: Text(
                          this.description,
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 10.0,
                              color: (this.descriptionColor != null)
                                  ? this.descriptionColor
                                  : Colors.grey),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}