import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

defaultbutton({
  required String text,
  bool fillbackground = false,
  Color? backgroundcoloor,
  IconData? icone,
  VoidCallback? onpress,
  GlobalObjectKey? key,
  double width = 100,
}) =>
    Container(
      width: width,
      height: AppSize.s55.w,
      child: TextButton(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text,
                key: key,
                style: getMediumStyle(
                    fontsize: AppSize.s16.sp, color: ColorManager.white),
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(AppPadding.p14.w),
          ),
          // backgroundColor: fillbackground
          //     ? MaterialStateProperty.all<Color>(backgroundcoloor!)
          //     : MaterialStateProperty.all<Color>(ColorManager.white),
          // foregroundColor:
          //     MaterialStateProperty.all<Color>(ColorManager.primary),
          // overlayColor: MaterialStateProperty.all(
          //     fillbackground ? Colors.white54 : ColorManager.lightprimary),
          // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(AppSize.s10.w),
          //     side: BorderSide(color: ColorManager.primary),
          //   ),
          // ),
        ),
        onPressed: onpress,
      ),
    );
