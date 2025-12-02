import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/auth_api_service.dart';

class TenantFormState {
  final String tenantName;
  final String firstName;
  final String lastName;
  final bool isTenantNameFormatValid;
  final bool? isTenantAvailable;
  final bool isCheckingTenant;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isSubmitting;
  final String? errorMessage;

  const TenantFormState({
    this.tenantName = '',
    this.firstName = '',
    this.lastName = '',
    this.isTenantNameFormatValid = false,
    this.isTenantAvailable,
    this.isCheckingTenant = false,
    this.isFirstNameValid = false,
    this.isLastNameValid = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  bool get canSubmit {
    return tenantName.isNotEmpty &&
        isTenantNameFormatValid &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        isFirstNameValid &&
        isLastNameValid &&
        !isCheckingTenant &&
        !isSubmitting;
  }

  TenantFormState copyWith({
    String? tenantName,
    String? firstName,
    String? lastName,
    bool? isTenantNameFormatValid,
    bool? isTenantAvailable,
    bool? isCheckingTenant,
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return TenantFormState(
      tenantName: tenantName ?? this.tenantName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isTenantNameFormatValid:
          isTenantNameFormatValid ?? this.isTenantNameFormatValid,
      isTenantAvailable: isTenantAvailable ?? this.isTenantAvailable,
      isCheckingTenant: isCheckingTenant ?? this.isCheckingTenant,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }
}

class TenantFormCubit extends Cubit<TenantFormState> {
  final AuthApiService _apiService;

  TenantFormCubit(this._apiService) : super(const TenantFormState());

  void onTenantNameChanged(String value) {
    final trimmed = value.trim();
    final formatValid = RegExp(r'^[A-Za-z][A-Za-z0-9-]*$').hasMatch(trimmed);
    emit(state.copyWith(
      tenantName: trimmed,
      isTenantNameFormatValid: formatValid,
      isTenantAvailable: null,
      errorMessage: null,
    ));
  }

  void onFirstNameChanged(String value) {
    final trimmed = value.trim();
    final isValid = RegExp(r'^[A-Za-z]+$').hasMatch(trimmed);
    emit(state.copyWith(firstName: trimmed, isFirstNameValid: isValid));
  }

  void onLastNameChanged(String value) {
    final trimmed = value.trim();
    final isValid = RegExp(r'^[A-Za-z]+$').hasMatch(trimmed);
    emit(state.copyWith(lastName: trimmed, isLastNameValid: isValid));
  }

  Future<void> createWorkspace({
    required String email,
    required String password,
    required int editionId,
  }) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final availability =
          await _apiService.checkTenantAvailability(state.tenantName);

      if (!availability.canRegister) {
        emit(state.copyWith(
          isSubmitting: false,
          isTenantAvailable: false,
          errorMessage: 'This workspace name is already taken',
        ));
        return;
      }
      emit(state.copyWith(isTenantAvailable: true));

      await _apiService.registerTenant(
        adminEmailAddress: email,
        adminFirstName: state.firstName,
        adminLastName: state.lastName,
        adminPassword: password,
        tenancyName: state.tenantName,
        editionId: editionId,
      );

      final authResult = await _apiService.authenticate(
        userNameOrEmailAddress: email,
        password: password,
        tenancyName: state.tenantName,
      );

      final token = authResult['accessToken'];
      if (token != null) {
        await _apiService.saveToken(token);
        await _apiService.getCurrentLoginInformations();
      }

      emit(state.copyWith(isSubmitting: false));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to create workspace. Please try again.',
      ));
    }
  }
}
