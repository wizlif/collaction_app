import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/shared_preferences/i_prefs_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'splash_bloc.freezed.dart';

part 'splash_event.dart';

part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IPrefsRepository _prefsRepository;

  SplashBloc(this._prefsRepository) : super(const SplashState.initial());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    yield* event.map(
      checkIfOnboarded: _mapCheckIfOnBoardedToState,
      setOnBoarding: _mapSetOnBoardingToState,
    );
  }

  Stream<SplashState> _mapSetOnBoardingToState(_SetOnBoarding value) async* {
    await _prefsRepository.setOnBoarded(isOnBoarded: value.isOnBoarded);
  }

  Stream<SplashState> _mapCheckIfOnBoardedToState(_CheckIfOnboarded _) async* {
    yield const SplashState.checkingIfOnBoarded();

    final _isOnBoarded = await _prefsRepository.isOnBoarded();

    yield SplashState.onBoardedCheckCompleted(
      isOnboarded: _isOnBoarded.fold(() => false, id),
    );
  }
}
