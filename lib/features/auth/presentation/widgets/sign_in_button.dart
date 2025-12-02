import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final String? imagePath;
  final bool showTrailingIcon;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SignInButton({
    super.key,
    required this.text,
    this.imagePath,
    this.showTrailingIcon = false,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = imagePath == null;
    final bool isEnabled = onPressed != null && !isLoading;

    final Color backgroundColor;
    if (!isPrimary) {
      backgroundColor = AppColors.secondaryButtonBackground;
    } else {
      backgroundColor = (onPressed != null && !isLoading)
          ? AppColors.primaryBlue
          : AppColors.disabledButtonGrey;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 15.sp,
                    height: 15.sp,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                  SizedBox(width: 3.w),
                ],
                if (imagePath != null) ...[
                  Image.asset(
                    imagePath!,
                    width: 17.sp,
                    height: 17.sp,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ] else
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            if (showTrailingIcon && !isLoading)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: Container(
                    width: 7.w,
                    height: 2.2.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightBackground.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Icon(
                      Icons.keyboard_return_rounded,
                      size: 17.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}