import 'package:dartz/dartz.dart';
import 'package:my_notes_app/core/error/failures.dart';

import '../entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, void>> addNote(Note note);
  Future<Either<Failure, Note>> getPreview(String url);
}
