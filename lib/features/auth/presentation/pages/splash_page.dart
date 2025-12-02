import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../data/services/auth_api_service.dart';
import '../../logic/splash_cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(AuthApiService())..checkToken(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            context.go('/success');
          } else if (state is SplashUnauthenticated) {
            context.go('/create-account');
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: Center(
            child: Image.asset(
              AppImages.logo,
              width: 40.w,
              height: 40.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
