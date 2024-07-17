import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

defaultTextForm({
  required String? label,
  String? helper,
  double width = double.infinity,
  double contentPaddingWidth = 8,
  double contentPaddingHeight = 8,
  required TextEditingController controller,
  required TextInputType type,
  IconData? sefixicon,
  IconData? prefixIcon,
  bool hidden = false,
  VoidCallback? prassedSufix,
  String? onsubmit,
  bool enablee = true,
  FormFieldValidator<String>? validator,
}) =>
    Container(
      width: width,
      child: TextFormField(
        enabled: enablee,
        validator: validator,
        controller: controller,
        obscureText: hidden,
        keyboardType: type,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: contentPaddingHeight,
                horizontal: contentPaddingWidth),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.circular(AppSize.s8.w),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s8.w),
              // borderSide: BorderSide(color: purplea)
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: ColorManager.primary,
                  )
                : null,
            suffixIcon: sefixicon != null
                ? IconButton(
                    onPressed: prassedSufix,
                    icon: Icon(
                      sefixicon,
                      color: ColorManager.primary,
                    ),
                  )
                : null,
            label: Text(
              label!,
            ),
            labelStyle: getRegularStyle(
                color: ColorManager.darkGrey, fontsize: AppSize.s14.sp),
            helperText: helper,
            helperStyle: getRegularStyle(
                color: ColorManager.lightprimary, fontsize: AppSize.s12.sp)),
        // onFieldSubmitted: onsubmit,
      ),
    );
