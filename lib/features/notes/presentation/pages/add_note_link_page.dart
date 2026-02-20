import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_app/core/constants/theme/app_spacing.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/add_note/add_note_bloc.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/add_note/add_note_event.dart';
import 'package:my_notes_app/features/notes/presentation/pages/add_note_page.dart';

class AddNoteLinkPage extends StatelessWidget {
  const AddNoteLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final urlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Note Link")),
      body: Padding(
        padding: AppPadding.main,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(labelText: 'Url'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.read<AddNoteBloc>().add(
                  GetPreviewEvent(urlController.text),
                );
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const AddNotePage()));
              },
              child: const Text("generate Form"),
            ),
          ],
        ),
      ),
    );
  }
}
