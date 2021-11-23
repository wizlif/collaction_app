part of 'splash_bloc.dart';


@freezed
class SplashEvent with _$SplashEvent {
  /// Check if the user was onboarded
  const factory SplashEvent.checkIfOnboarded() = _CheckIfOnboarded;

  /// Set the user's onboarding status
  const factory SplashEvent.setOnBoarding({required bool isOnBoarded}) = _SetOnBoarding;
}
