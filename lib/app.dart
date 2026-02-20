import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_app/core/constants/theme/app_colors.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/add_note/add_note_bloc.dart';
import 'features/notes/presentation/bloc/notes/note_bloc.dart';
import 'features/notes/presentation/pages/home_page.dart';
import 'locator.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(create: (context) => di.locator<NoteBloc>()),
        BlocProvider<AddNoteBloc>(
          create: (context) => di.locator<AddNoteBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.softCream,
          primaryColor: AppColors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
