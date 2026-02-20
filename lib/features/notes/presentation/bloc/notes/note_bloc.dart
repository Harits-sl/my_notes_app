import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_app/features/notes/domain/usecases/get_notes.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotes getNotes;

  NoteBloc({required this.getNotes}) : super(NoteInitial()) {
    on<GetNotesEvent>((event, emit) async {
      emit(NoteLoading());

      final notes = await getNotes.execute();
      notes.fold(
        (failure) => emit(NoteError(failure.message)),
        (notes) => emit(NoteLoaded(notes)),
      );
    });
  }
}
