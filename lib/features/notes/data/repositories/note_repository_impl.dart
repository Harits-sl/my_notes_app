import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_notes_app/core/error/dio_error_handler.dart';
import 'package:my_notes_app/core/error/exceptions.dart';
import 'package:my_notes_app/core/error/failures.dart';
import 'package:my_notes_app/features/notes/data/datasources/remote/note_remote_datasource.dart';
import 'package:my_notes_app/features/notes/data/models/note_model.dart';
import 'package:my_notes_app/features/notes/domain/entities/note.dart';
import 'package:my_notes_app/features/notes/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource dataRemotesource;

  NoteRepositoryImpl({required this.dataRemotesource});

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final result = await dataRemotesource.getNotes();
      final notes = result.map((model) => model.toEntity()).toList();
      return Right(notes);
    } on NetworkException {
      return Left(NetworkFailure('Failed to connect to the network'));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<Either<Failure, void>> addNote(Note note) async {
    try {
      final noteModel = NoteModel.fromEntity(note);
      await dataRemotesource.addNote(noteModel);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<Either<Failure, Note>> getPreview(url) async {
    try {
      final result = await dataRemotesource.getPreview(url);
      final note = result.toEntity();
      return Right(note);
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }
}
