import 'package:oz_player/domain/entitiy/library_entity.dart';

abstract interface class LibraryRepository {
  Future<List<LibraryEntity>> getLibrary(String userId);
}
