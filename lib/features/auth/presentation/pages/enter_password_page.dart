import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/auth_top_bar.dart';
import '../widgets/header_section.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_strength_section.dart';
import '../widgets/footer_brand.dart';
import '../widgets/sign_in_button.dart';
import '../../logic/password_cubit/password_cubit.dart';

class EnterPasswordPage extends StatelessWidget {
  EnterPasswordPage({super.key})
      : emailController = TextEditingController(),
        passwordController = TextEditingController();

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTopBar(
                onBackTap: () => context.pop(),
              ),
              HeaderSection(
                title: 'Enter a strong password',
                subtitle: "Let's start an amazing journey! 👋",
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<PasswordCubit, PasswordState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthTextField(
                            label: 'Your work email',
                            hintText: 'Enter your email',
                            fieldType: AuthFieldType.email,
                            controller: emailController,
                            prefix: const Icon(Icons.email_outlined),
                            onChanged: context
                                .read<PasswordCubit>()
                                .onEmailChanged,
                          ),
                          SizedBox(height: 3.h),
                          AuthTextField(
                            label: 'Your password',
                            hintText: 'Enter your password',
                            fieldType: AuthFieldType.password,
                            controller: passwordController,
                            prefix: const Icon(Icons.lock_outline),
                            obscure: state.isPasswordObscured,
                            onToggleObscure: context
                                .read<PasswordCubit>()
                                .togglePasswordVisibility,
                            onChanged: context
                                .read<PasswordCubit>()
                                .onPasswordChanged,
                          ),
                          PasswordStrengthSection(
                            strength: state.strength,
                            hasMinLength: state.hasMinLength,
                            hasUppercase: state.hasUppercase,
                          ),
                          SizedBox(height: 4.h),
                          SignInButton(
                            text: 'Confirm password',
                            showTrailingIcon: true,
                            onPressed: state.canSubmit
                                ? () {
                              context.push(
                                '/enter-company',
                                extra: {
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                  'editionId': state.editionId,
                                },
                              );
                            }
                                : null,
                          ),

                          SizedBox(height: 3.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const FooterBrand(),
            ],
          ),
        ),
      ),
    );
  }
}