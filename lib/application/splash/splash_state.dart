part of 'splash_bloc.dart';

@freezed
class SplashState with _$SplashState {
  /// Not state
  const factory SplashState.initial() = _Initial;

  /// Checking if user was on boarded
  const factory SplashState.checkingIfOnBoarded() = _CheckingIfOnBoarded;

  /// Return onboarded state
  const factory SplashState.onBoardedCheckCompleted({required bool isOnboarded}) = _OnBoardedCheckCompleted;
}

