import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';

enum AuthFieldType {
  text,
  email,
  password,
  workspace,
}

class AuthTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final AuthFieldType fieldType;
  final Widget? prefix;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  final bool obscure;
  final VoidCallback? onToggleObscure;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.fieldType = AuthFieldType.text,
    this.prefix,
    this.controller,
    this.onChanged,
    this.obscure = false,
    this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    final isEmail = fieldType == AuthFieldType.email;
    final isPassword = fieldType == AuthFieldType.password;
    final isWorkspace = fieldType == AuthFieldType.workspace;

    if (isPassword) {
      return _buildBase(
        obscureText: obscure,
        keyboardType: TextInputType.visiblePassword,
        suffix: GestureDetector(
          onTap: onToggleObscure,
          child: Icon(
            obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 18.sp,
            color: AppColors.greyText,
          ),
        ),
      );
    }

    if (isEmail && controller != null) {
      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller!,
        builder: (context, value, _) {
          final hasText = value.text.isNotEmpty;
          return _buildBase(
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            suffix: hasText
                ? GestureDetector(
              onTap: () => controller!.clear(),
              child: Container(
                width: 3.4.h,
                height: 3.4.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.greyText.withOpacity(0.4),
                    width: 1.3,
                  ),
                ),
                child: Icon(
                  Icons.close,
                  size: 14.sp,
                  color: AppColors.greyText,
                ),
              ),
            )
                : null,
          );
        },
      );
    }

    if (isWorkspace) {
      return _buildBase(
        obscureText: false,
        keyboardType: TextInputType.text,
        suffix: Text(
          '.workiom.com',
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.greyText,
          ),
        ),
      );
    }

    return _buildBase(
      obscureText: false,
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildBase({
    required bool obscureText,
    required TextInputType keyboardType,
    Widget? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.8.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.greyText,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              if (prefix != null) ...[
                prefix!,
                SizedBox(width: 2.w),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.greyText,
                    ),
                  ),
                ),
              ),
              if (suffix != null) ...[
                SizedBox(width: 2.w),
                suffix,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
