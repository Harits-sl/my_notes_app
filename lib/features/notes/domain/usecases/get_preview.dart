import 'package:dartz/dartz.dart';
import 'package:my_notes_app/core/error/failures.dart';

import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetPreview {
  final NoteRepository repository;

  GetPreview(this.repository);

  Future<Either<Failure, Note>> execute(String url) {
    return repository.getPreview(url);
  }
}
