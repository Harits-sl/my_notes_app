import 'package:dio/dio.dart';
import 'package:my_notes_app/core/error/exceptions.dart';
import 'package:my_notes_app/features/notes/data/models/note_model.dart';

import 'note_remote_datasource.dart';

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final Dio dio;
  final String path = '/notes';

  NoteRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      final response = await dio.get(path);

      final List data = response.data as List;

      return data.map((e) => NoteModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      }
      throw Exception('Failed to get notes: $e');
    }
  }

  // @override
  // Future<NoteModel> getNoteById(String id) async {
  //   try {
  //     final response = await dio.get('${AppConstants.baseUrl}/notes/$id');

  //     return NoteModel.fromJson(response.data);
  //   } catch (e) {
  //     throw Exception('Failed to get note: $e');
  //   }
  // }

  @override
  Future<void> addNote(NoteModel note) async {
    try {
      await dio.post(path, data: note.toJson());
    } catch (e) {
      throw Exception('Failed to create note: $e');
    }
  }

  @override
  Future<NoteModel> getPreview(String url) async {
    try {
      final response = await dio.get('/preview?url=$url');
      return NoteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get preview: $e');
    }
  }

  // @override
  // Future<void> updateNote(NoteModel note) async {
  //   try {
  //     await dio.put(
  //       '${AppConstants.baseUrl}/notes/${note.id}',
  //       data: note.toJson(),
  //     );
  //   } catch (e) {
  //     throw Exception('Failed to update note: $e');
  //   }
  // }

  // @override
  // Future<void> deleteNote(String id) async {
  //   try {
  //     await dio.delete('${AppConstants.baseUrl}/notes/$id');
  //   } catch (e) {
  //     throw Exception('Failed to delete note: $e');
  //   }
  // }
}
