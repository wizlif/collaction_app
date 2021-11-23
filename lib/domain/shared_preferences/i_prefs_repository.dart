import 'package:dartz/dartz.dart';

abstract class IPrefsRepository {
  /// On Boarding
  Future<Option<bool>> isOnBoarded();

  Future<Option<Unit>> setOnBoarded({required bool isOnBoarded});

}
