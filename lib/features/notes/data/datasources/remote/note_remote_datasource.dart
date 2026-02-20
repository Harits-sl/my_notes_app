import 'package:my_notes_app/features/notes/data/models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> getNotes();
  // Future<NoteModel> getNoteById(String id);
  Future<void> addNote(NoteModel note);
  // Future<void> updateNote(NoteModel note);
  // Future<void> deleteNote(String id);
  Future<NoteModel> getPreview(String url);
}
