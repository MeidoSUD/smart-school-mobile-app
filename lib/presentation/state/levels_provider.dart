


import 'package:geniuses_school/data/models/level_model.dart';
import 'package:geniuses_school/data/repositories/level_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final levelRepositoryProvider = Provider((ref) => LevelRepository());

class LevelsNotifier extends AsyncNotifier<List<LevelModel>> {

  @override
  Future<List<LevelModel>> build() async {
     
     final repo = ref.read(levelRepositoryProvider);
      return await repo.getLevels();
  
}

}

final levelsProvider =
    AsyncNotifierProvider<LevelsNotifier, List<LevelModel>>(() {
  return LevelsNotifier();
});