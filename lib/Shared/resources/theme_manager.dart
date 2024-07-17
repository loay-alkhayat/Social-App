import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/resources/styles_manager.dart';
import 'package:social_app/Shared/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationLightTheme() {
  return ThemeData(
    //main Colors
    primaryColor: ColorManager.primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorManager.white,
    primaryColorLight: ColorManager.white,
    primaryColorDark: ColorManager.black, disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightprimary,
    //Divider Theme
    dividerTheme: DividerThemeData(
        color: ColorManager.grey2,
        thickness: AppSize.s0_5,
        space: AppSize.s4,
        indent: AppSize.s20.w,
        endIndent: AppSize.s20.w),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          elevation: MaterialStatePropertyAll(20),
          side: MaterialStatePropertyAll(BorderSide()),
          foregroundColor: MaterialStatePropertyAll(ColorManager.primary),
          backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
          overlayColor: MaterialStatePropertyAll(ColorManager.lightGrey),
          iconColor: MaterialStatePropertyAll(ColorManager.white)),
    ),
    //TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(AppSize.s10.w),
        //     side: BorderSide(color: ColorManager.primary),
        //   ),
        // ),
        overlayColor: MaterialStatePropertyAll(ColorManager.darkprimary),
        backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
        textStyle: MaterialStatePropertyAll(
          getSemiBoldStyle(fontsize: AppSize.s16.sp, color: ColorManager.white),
        ),
      ),
    ),
    //Icon Theme
    iconTheme: IconThemeData(
      color: ColorManager.black,
    ),
    //Card Theme
    cardTheme: CardTheme(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: ColorManager.white,
        elevation: AppSize.s4),

//AppBar Theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      color: ColorManager.primary,
      iconTheme: IconThemeData(color: ColorManager.white),
      actionsIconTheme: IconThemeData(color: ColorManager.white),
      elevation: AppSize.s4,
      centerTitle: false,
      titleSpacing: AppSize.s8,
      shadowColor: ColorManager.lightprimary,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontsize: FontSize.s22,
      ),
    ),

    //OutLinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      side:
          MaterialStatePropertyAll(BorderSide(color: ColorManager.lightGrey!)),
      overlayColor: MaterialStatePropertyAll(ColorManager.lightGrey),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10.w),
        ),
      ),
    )),

//bottomBAr
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.grey1,
      backgroundColor: ColorManager.white,
      elevation: AppSize.s20,
    ),
//buttonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.s12),
          ),
        ),
        textStyle:
            getRegularStyle(color: ColorManager.white, fontsize: FontSize.s17),
      ),
    ),

// text theme
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontsize: FontSize.s16,
      ),
      bodyMedium: getSemiBoldStyle(
        color: ColorManager.black,
        fontsize: FontSize.s16,
      ),
      titleMedium: getRegularStyle(
        color: ColorManager.black,
        fontsize: FontSize.s16,
      ),
      bodyLarge: getSemiBoldStyle(
        color: ColorManager.black,
        fontsize: FontSize.s18,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey1,
      ),
      titleSmall: getRegularStyle(
        color: ColorManager.grey,
      ),
      displayLarge: getLightStyle(
        color: ColorManager.white,
        fontsize: FontSize.s22,
      ),
    ),
  );
}

ThemeData getApplicationDarkTheme() {
  return ThemeData(
    //main Colors
    primaryColor: ColorManager.primary,
    brightness: Brightness.light,
    disabledColor: ColorManager.grey1,
    primaryColorLight: ColorManager.black,
    primaryColorDark: ColorManager.white,
    splashColor: ColorManager.lightGrey,
    scaffoldBackgroundColor: ColorManager.grey1,

    //ICon Theme
    iconTheme: IconThemeData(
      color: ColorManager.white,
    ),
    //textButton
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(AppSize.s10.w),
        //     side: BorderSide(color: ColorManager.primary),
        //   ),
        // ),
        overlayColor: MaterialStatePropertyAll(ColorManager.darkprimary),
        // backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
        textStyle: MaterialStatePropertyAll(
          getSemiBoldStyle(fontsize: AppSize.s16.sp, color: ColorManager.white),
        ),
      ),
    ),
    //Card Theme
    cardTheme: CardTheme(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: ColorManager.grey2,
        elevation: AppSize.s8),

    //Divider Theme
    dividerTheme: DividerThemeData(
        color: ColorManager.white,
        thickness: AppSize.s0_5,
        space: AppSize.s4,
        indent: AppSize.s20.w,
        endIndent: AppSize.s20.w),

//AppBar Theme
    appBarTheme: AppBarTheme(
      titleSpacing: AppSize.s8,
      iconTheme: IconThemeData(color: ColorManager.white),
      actionsIconTheme: IconThemeData(color: ColorManager.white),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      color: ColorManager.darkprimary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.darkprimary,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontsize: FontSize.s20,
      ),
    ),

//bottomBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.darkprimary,
      unselectedItemColor: ColorManager.white,
      backgroundColor: ColorManager.grey2,
      elevation: AppSize.s12,
    ),
    //OutLinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      side: MaterialStatePropertyAll(BorderSide(color: ColorManager.darkGrey)),
      overlayColor: MaterialStatePropertyAll(ColorManager.lightGrey),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10.w),
        ),
      ),
    )),
// text theme
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.white,
      ),
      bodyLarge: getSemiBoldStyle(
        color: ColorManager.white,
        fontsize: FontSize.s18,
      ),
      bodyMedium: getSemiBoldStyle(
        color: ColorManager.white,
        fontsize: FontSize.s16,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.lightGrey!,
      ),
      titleSmall: getRegularStyle(
        color: ColorManager.white,
      ),
      titleMedium: getRegularStyle(
        color: ColorManager.white,
        fontsize: FontSize.s16,
      ),
      titleLarge: getRegularStyle(
        color: ColorManager.white,
        fontsize: FontSize.s18.sp,
      ),
      displayLarge: getLightStyle(
        color: ColorManager.white,
        fontsize: FontSize.s22,
      ),
    ),
  );
}
