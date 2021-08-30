import 'crowdaction.dart';

abstract class ICrowdActionRepository {
  Future<List<CrowdAction>> getCrowdActions({int amount = 0});
}