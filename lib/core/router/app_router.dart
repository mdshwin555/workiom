import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/data/services/auth_api_service.dart';
import '../../features/auth/logic/password_cubit/password_cubit.dart';
import '../../features/auth/logic/tenant_form_cubit/tenant_form_cubit.dart';
import '../../features/auth/presentation/pages/create_account_page.dart';
import '../../features/auth/presentation/pages/enter_password_page.dart';
import '../../features/auth/presentation/pages/enter_company_page.dart';
import '../../features/auth/presentation/pages/success_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),

    GoRoute(
      path: '/create-account',
      builder: (BuildContext context, GoRouterState state) {
        return const CreateAccountPage();
      },
    ),

    GoRoute(
      path: '/enter-password',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) =>
          PasswordCubit( AuthApiService())..loadPasswordRules(),
          child: EnterPasswordPage(),
        );
      },
    ),

    GoRoute(
      path: '/enter-company',
      builder: (BuildContext context, GoRouterState state) {
        final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;

        return BlocProvider<TenantFormCubit>(
          create: (_) => TenantFormCubit( AuthApiService()),
          child: EnterCompanyPage(
            email: extras['email'],
            password: extras['password'],
            editionId: extras['editionId'],
          ),
        );
      },
    ),

    GoRoute(
      path: '/success',
      builder: (BuildContext context, GoRouterState state) {
        return const SuccessPage();
      },
    ),
  ],
);