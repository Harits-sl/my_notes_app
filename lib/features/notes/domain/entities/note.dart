import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int id;
  final String title;
  final String desc;
  final String url;
  final String imageUrl;
  final String providerName;

  const Note({
    required this.id,
    required this.url,
    required this.title,
    required this.desc,
    required this.imageUrl,
    required this.providerName,
  });

  @override
  List<Object> get props {
    return [id, title, desc, url, imageUrl, providerName];
  }
}
