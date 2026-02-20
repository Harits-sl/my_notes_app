import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:my_notes_app/features/notes/domain/entities/note.dart';

class NoteModel extends Equatable {
  final int id;
  final String title;
  final String desc;
  final String url;
  final String imageUrl;
  final String providerName;

  const NoteModel({
    required this.id,
    required this.url,
    required this.title,
    required this.desc,
    required this.imageUrl,
    required this.providerName,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'desc': desc});
    result.addAll({'url': url});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'providerName': providerName});

    return result;
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      providerName: json['provider_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  Note toEntity() {
    return Note(
      id: id,
      title: title,
      desc: desc,
      url: url,
      imageUrl: imageUrl,
      providerName: providerName,
    );
  }

  factory NoteModel.fromEntity(Note entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      desc: entity.desc,
      url: entity.url,
      imageUrl: entity.imageUrl,
      providerName: entity.providerName,
    );
  }

  @override
  List<Object> get props {
    return [id, title, desc, url, imageUrl, providerName];
  }
}
