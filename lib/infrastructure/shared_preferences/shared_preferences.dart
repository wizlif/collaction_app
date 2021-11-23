import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/shared_preferences/i_prefs_repository.dart';

@LazySingleton(as: IPrefsRepository)
class Preferences implements IPrefsRepository {
  late SharedPreferences _preferences;

  final _readyCompleter = Completer();

  Future get ready => _readyCompleter.future;

  Preferences() {
    _init().then((_) {
      _readyCompleter.complete();
    });
  }

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// On Boarding
  static const _isOnBoardedKey = "IS_ON_BOARDED_KEY";

  @override
  Future<Option<bool>> isOnBoarded() async {
    await ready;
    final isOnBoarded = _preferences.getBool(_isOnBoardedKey);
    return optionOf(isOnBoarded);
  }

  @override
  Future<Option<Unit>> setOnBoarded({required bool isOnBoarded}) async {
    await ready;
    await _preferences.setBool(_isOnBoardedKey, isOnBoarded);
    return some(unit);
  }
}
