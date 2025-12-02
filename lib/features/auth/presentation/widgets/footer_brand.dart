import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class FooterBrand extends StatelessWidget {
  const FooterBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Stay organized with',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.greyText,
                ),
              ),
              SizedBox(width: 1.5.w),
              Image.asset(
                AppImages.logo,
                width: 22.sp,
                height: 22.sp,
              ),
              SizedBox(width: 1.w),
              Text(
                'workiom',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.workiomBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
