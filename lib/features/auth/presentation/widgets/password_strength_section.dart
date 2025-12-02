import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';

class PasswordStrengthSection extends StatelessWidget {
  final double strength;
  final bool hasMinLength;
  final bool hasUppercase;

  const PasswordStrengthSection({
    super.key,
    required this.strength,
    required this.hasMinLength,
    required this.hasUppercase,
  });

  @override
  Widget build(BuildContext context) {
    final barValue = strength.clamp(0.0, 1.0);

    final bool allGood = hasMinLength && hasUppercase;

    final Color barColor =
    allGood ? AppColors.passwordGreen : AppColors.passwordYellow;

    final String statusText =
    allGood ? 'Strong password' : 'Not enough strong';

    final IconData statusIcon =
    allGood ? Icons.check : Icons.warning_amber_rounded;

    final Color statusIconColor =
    allGood ? AppColors.passwordGreen : AppColors.passwordYellow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.5.h),
        SizedBox(
          height: 0.6.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: barValue,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
              backgroundColor: Colors.grey[300],
            ),
          ),
        ),
        SizedBox(height: 1.5.h),
        Row(
          children: [
            SizedBox(width: 1.w),
            Icon(
              statusIcon,
              size: 19.sp,
              color: statusIconColor,
            ),
            SizedBox(width: 2.w),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        _buildRuleRow(
          passed: hasMinLength,
          text: 'Passwords must have at least 7 characters',
        ),
        SizedBox(height: 1.h),
        _buildRuleRow(
          passed: hasUppercase,
          text: 'Passwords must have at least one uppercase ("A"-"Z").',
        ),
      ],
    );
  }

  Widget _buildRuleRow({
    required bool passed,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 1.w),
        Icon(
          passed ? Icons.check : Icons.close,
          size: 19.sp,
          color: passed ? AppColors.passwordGreen : Colors.red,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyText,
            ),
          ),
        ),
      ],
    );
  }
}
