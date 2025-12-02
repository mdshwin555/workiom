import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';

class AuthTopBar extends StatelessWidget {
  const AuthTopBar({
    super.key,
    this.title,
    this.onBackTap,
  });

  final String? title;
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 5.2.h,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20.sp,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              if (title != null) ...[
                SizedBox(width: 1.w),
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}