import 'package:dartz/dartz.dart';
import 'package:my_notes_app/core/error/failures.dart';

import '../entities/note.dart';
import '../repositories/note_repository.dart';

class AddNote {
  final NoteRepository repository;

  AddNote(this.repository);

  Future<Either<Failure, void>> execute(Note note) {
    return repository.addNote(note);
  }
}
