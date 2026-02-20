import 'package:dio/dio.dart';
import 'package:my_notes_app/core/error/exceptions.dart';

class DioErrorHandler {
  static NetworkException handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException('Koneksi ke server timeout. Coba lagi.');
      case DioExceptionType.sendTimeout:
        return NetworkException('Gagal mengirim data. Periksa koneksi.');
      case DioExceptionType.receiveTimeout:
        return NetworkException('Server terlalu lama merespons.');
      case DioExceptionType.badResponse:
        return NetworkException(
          e.response?.data['message'] ?? 'Terjadi kesalahan pada server',
        );
      case DioExceptionType.connectionError:
        return NetworkException('Tidak ada koneksi internet');
      default:
        return NetworkException('Terjadi kesalahan tidak diketahui');
    }
  }
}
