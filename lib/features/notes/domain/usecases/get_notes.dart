import 'package:dartz/dartz.dart';
import 'package:my_notes_app/core/error/failures.dart';

import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotes {
  final NoteRepository repository;

  GetNotes(this.repository);

  Future<Either<Failure, List<Note>>> execute() {
    return repository.getNotes();
  }
}
