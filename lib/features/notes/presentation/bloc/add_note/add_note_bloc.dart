import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_app/features/notes/domain/usecases/get_preview.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/usecases/add_note.dart';
import 'add_note_event.dart';
import 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final AddNote addNote;
  final GetPreview getPreview;

  AddNoteBloc({required this.addNote, required this.getPreview})
    : super(const AddNoteState()) {
    on<GetPreviewEvent>(_onGetPreview);
    on<TitleChanged>(_onTitleChanged);
    on<DescChanged>(_onDescChanged);
    on<UrlChanged>(_onUrlChanged);
    on<ImageUrlChanged>(_onImageUrlChanged);
    on<ProviderNameChanged>(_onProviderChanged);
    on<SubmitAddNote>(_onSubmitAddNote);
  }

  void _onGetPreview(GetPreviewEvent event, Emitter<AddNoteState> emit) async {
    emit(state.copyWith(isLoadingPreview: true));

    final result = await getPreview.execute(event.url);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingPreview: false, previewError: failure.message),
      ),
      (note) => emit(
        state.copyWith(
          imageUrl: note.imageUrl,
          title: note.title,
          desc: note.desc,
          isLoadingPreview: false,
          previewError: '',
        ),
      ),
    );
  }

  void _onTitleChanged(TitleChanged event, Emitter<AddNoteState> emit) {
    emit(
      state.copyWith(title: event.title, showError: false, isSuccess: false),
    );
  }

  void _onDescChanged(DescChanged event, Emitter<AddNoteState> emit) {
    emit(state.copyWith(desc: event.desc, showError: false, isSuccess: false));
  }

  void _onUrlChanged(UrlChanged event, Emitter<AddNoteState> emit) {
    emit(state.copyWith(url: event.url, showError: false, isSuccess: false));
  }

  void _onImageUrlChanged(ImageUrlChanged event, Emitter<AddNoteState> emit) {
    emit(
      state.copyWith(
        imageUrl: event.imageUrl,
        showError: false,
        isSuccess: false,
      ),
    );
  }

  void _onProviderChanged(
    ProviderNameChanged event,
    Emitter<AddNoteState> emit,
  ) {
    emit(
      state.copyWith(
        providerName: event.providerName,
        showError: false,
        isSuccess: false,
      ),
    );
  }

  Future<void> _onSubmitAddNote(
    SubmitAddNote event,
    Emitter<AddNoteState> emit,
  ) async {
    if (!state.isFormValid) {
      emit(
        state.copyWith(
          showError: true,
          errorMessage: 'Lengkapi semua data wajib',
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    final note = Note(
      id: 0, // biasanya backend yang generate
      title: state.title,
      desc: state.desc,
      url: state.url,
      imageUrl: state.imageUrl,
      providerName: state.providerName,
    );

    final result = await addNote.execute(note);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isSubmitting: false,
          showError: true,
          errorMessage: failure.message,
        ),
      ),
      (success) => emit(state.copyWith(isSubmitting: false, isSuccess: true)),
    );
  }
}
