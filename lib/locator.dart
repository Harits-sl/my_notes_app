import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_notes_app/core/constants/app_config.dart';
import 'package:my_notes_app/features/notes/domain/usecases/add_note.dart';
import 'package:my_notes_app/features/notes/domain/usecases/get_preview.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/add_note/add_note_bloc.dart';

// BLOC
import 'features/notes/presentation/bloc/notes/note_bloc.dart';

// USECASES
import 'package:my_notes_app/features/notes/domain/usecases/get_notes.dart';

// REPOSITORY
import 'package:my_notes_app/features/notes/data/repositories/note_repository_impl.dart';
import 'package:my_notes_app/features/notes/domain/repositories/note_repository.dart';

// DATASOURCE
import 'package:my_notes_app/features/notes/data/datasources/remote/note_remote_datasource.dart';
import 'package:my_notes_app/features/notes/data/datasources/remote/note_remote_datasource_impl.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // ----------------
  // EXTERNAL
  // ----------------
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    ),
  );

  // --------------------
  // BLOC
  // --------------------
  locator.registerLazySingleton(() => NoteBloc(getNotes: locator()));
  locator.registerLazySingleton(
    () => AddNoteBloc(addNote: locator(), getPreview: locator()),
  );

  // --------------------
  // USECASE
  // --------------------
  locator.registerLazySingleton(() => GetNotes(locator()));
  locator.registerLazySingleton(() => AddNote(locator()));
  locator.registerLazySingleton(() => GetPreview(locator()));

  // --------------------
  // REPOSITORY
  // --------------------
  locator.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(dataRemotesource: locator()),
  );

  // --------------------
  // DATASOURCE
  // --------------------
  locator.registerLazySingleton<NoteRemoteDataSource>(
    () => NoteRemoteDataSourceImpl(dio: locator()),
  );
}
