import 'package:flutter/material.dart';
import 'package:social_app/Shared/resources/color_manager.dart';

class CustomToast {
  static void showToast(BuildContext context, String message,
      Color Backgroundcolor, Color Textcolor) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: ColorManager.white,
              child: Image.asset(
                'assets/images/splash_logo.png',
                height: height * 0.05,
                width: width * 0.08,
              ),
            ),
            Text(
              message,
              style: TextStyle(color: Textcolor),
              strutStyle: StrutStyle(
                forceStrutHeight: true,
              ),
            ),
          ],
        ),
        duration: Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        width: width * 0.6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Backgroundcolor,
        elevation: 1,
      ),
    );
  }
}
