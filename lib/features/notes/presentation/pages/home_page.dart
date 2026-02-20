import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_notes_app/core/constants/theme/app_spacing.dart';
import 'package:my_notes_app/core/constants/theme/app_text_style.dart';
import 'package:my_notes_app/features/notes/domain/entities/note.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/notes/note_bloc.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/notes/note_event.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/notes/note_state.dart';
import 'package:my_notes_app/features/notes/presentation/pages/add_note_link_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddNoteLinkPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteInitial) {
            context.read<NoteBloc>().add(GetNotesEvent());
          }
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NoteLoaded) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text("Tidak ada notes, tambahkan notes"),
              );
            }

            return Container(
              margin: const EdgeInsets.only(top: AppMargin.marginDefault),
              child: MasonryGridView.count(
                mainAxisSpacing: AppMargin.marginDefault,
                crossAxisSpacing: AppMargin.marginDefault,
                crossAxisCount: 2,
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];

                  return _NoteCard(note: note);
                },
              ),
            );
          }

          if (state is NoteError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final Note note;

  const _NoteCard({super.key, required this.note});

  // Function to launch a URL
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchURL(note.url),
      child: Container(
        padding: AppPadding.p8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: AppRadius.main,
              child: CachedNetworkImage(
                imageUrl: note.imageUrl,
                placeholder: (_, _) => const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, _, _) => const Icon(Icons.broken_image),
              ),
            ),
            Text(
              note.title,
              style: AppTextStyle.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
