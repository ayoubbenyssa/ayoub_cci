import 'package:flutter/material.dart';
import 'package:mycgem/services/Fonts.dart';

class EasyCard extends StatelessWidget {
  final Color prefixBadge;
  final Color suffixBadge;
  final IconData icon;
  final IconData suffixIcon;
  final Color iconColor;
  final Color suffixIconColor;
  final String title;
  final int perc;
  final String description;
  final Function onTap;
  final Color backgroundColor;
  final Color titleColor;
  final Color descriptionColor;
  final String txt;

  const EasyCard(
      {Key key,
        this.prefixBadge,
        this.suffixBadge,
        this.perc,
        this.icon,
        this.iconColor,
        this.title,
        this.description,
        this.suffixIcon,
        this.suffixIconColor,
        this.onTap,
        this.backgroundColor,
        this.descriptionColor,
        this.titleColor,
        this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(children: <Widget>[
        InkWell(
          onTap: this.onTap,
          child: Card(
            color: (this.backgroundColor != null)
                ? Fonts.col_app_green
                : Colors.white,
            margin: const EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                (this.prefixBadge != null)
                    ? Container(
                  width: 10.0,
                  height: 60.0,
                  color: this.prefixBadge,
                )
                    : Container(),
                (this.icon != null)
                    ? Container(
                  margin: const EdgeInsets.all(5.0),
                  width: 50.0,
                  height: 50.0,
                  child: Icon(
                    this.icon,
                    color: (this.iconColor != null)
                        ? this.iconColor
                        : Colors.black,
                  ),
                )
                    : Container(
                  margin: const EdgeInsets.only(left: 20.0),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        (this.title != null)
                            ? Container(
                          child: Text(
                            this.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: (this.titleColor != null)
                                    ? this.titleColor
                                    : Colors.black),
                          ),
                        )
                            : Container(),
                        (this.description != null)
                            ? Container(
                          child: Text(
                            this.description+" Votes",
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 14.0,
                                color: (this.descriptionColor != null)
                                    ? this.descriptionColor
                                    : Colors.black87),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Text(
                  this.txt.toString() == "NaN"
                      ? ""
                      : this.txt.toString().split(".")[0] + '%      ',
                  style: TextStyle(
                      color: Fonts.col_gr, fontWeight: FontWeight.w800,fontSize: 16),
                ),
                (this.suffixIcon != null)
                    ? Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child:  CircleAvatar(
                      radius: 16,
                      backgroundColor: suffixIconColor.withOpacity(0.1),
                      child:  Icon(this.suffixIcon,
                          color: (this.suffixIconColor != null)
                              ? this.suffixIconColor
                              : Colors.black)),
                )
                    : Container(),
                (this.suffixBadge != null)
                    ? Container(
                  width: 10.0,
                  height: 60.0,
                  color: this.suffixBadge,
                )
                    : Container(),
              ],
            ),
          ),
        ),
        Positioned(
          top: 4.0,
          left: 12.0,
          child: Container(
            height: 60.0,
            color: Fonts.col_gr.withOpacity(0.15),
            width: txt.toString() == "NaN"
                ? 0.0
                : MediaQuery.of(context).size.width * double.parse(txt) / 100,
          ),
        )
      ]),
      onTap: () {
        this.onTap();
      },
    );
  }
}
