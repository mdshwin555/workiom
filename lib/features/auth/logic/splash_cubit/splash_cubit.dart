import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/auth_api_service.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthApiService _authService;

  SplashCubit(this._authService) : super(SplashInitial());

  Future<void> checkToken() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final token = await _authService.getToken();

      if (token != null) {
        await _authService.getCurrentLoginInformations();
        emit(SplashAuthenticated());
      } else {
        emit(SplashUnauthenticated());
      }
    } catch (e) {
      emit(SplashUnauthenticated());
    }
  }
}