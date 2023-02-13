import 'package:flutter/material.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCgemBarApp extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56.h);

  MyCgemBarApp(this.text,
      {this.actionswidget, this.leading_widget, this.bottom_widget});

  String text = "";
  Widget actionswidget;
  Widget leading_widget;
  Widget bottom_widget;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      iconTheme: new IconThemeData(
        color: Fonts.col_app_fon,
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      bottom: bottom_widget == null
          ? null
          : bottom_widget,
      title: Text(
        text,
        style: TextStyle(
            color: Fonts.col_app_fon,
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w700),
      ),
     /* leading: leading_widget == null
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              color: Fonts.col_app_fon,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : leading_widget,*/
      actions: [actionswidget],
    );
  }
}
