import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';

class LanguageSelectorRow extends StatelessWidget {
  const LanguageSelectorRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.language,
                size: 17.sp,
                color: AppColors.greyText,
              ),
              SizedBox(width: 1.w),
              Text(
                'English',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.greyText,
                ),
              ),
              Icon(
                Icons.arrow_drop_down_sharp,
                size: 20.sp,
                color: AppColors.greyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
