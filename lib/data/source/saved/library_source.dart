import 'package:oz_player/data/dto/library_dto.dart';

abstract interface class LibrarySource {
  Future<List<LibraryDto>> getLibrary(String userId);
}
