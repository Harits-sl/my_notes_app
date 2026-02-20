import 'package:equatable/equatable.dart';

abstract class AddNoteEvent extends Equatable {
  const AddNoteEvent();

  @override
  List<Object?> get props => [];
}

class GetPreviewEvent extends AddNoteEvent {
  final String url;

  const GetPreviewEvent(this.url);

  @override
  List<Object?> get props => [url];
}

class TitleChanged extends AddNoteEvent {
  final String title;

  const TitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class DescChanged extends AddNoteEvent {
  final String desc;

  const DescChanged(this.desc);

  @override
  List<Object?> get props => [desc];
}

class UrlChanged extends AddNoteEvent {
  final String url;

  const UrlChanged(this.url);

  @override
  List<Object?> get props => [url];
}

class ImageUrlChanged extends AddNoteEvent {
  final String imageUrl;

  const ImageUrlChanged(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class ProviderNameChanged extends AddNoteEvent {
  final String providerName;

  const ProviderNameChanged(this.providerName);

  @override
  List<Object?> get props => [providerName];
}

class SubmitAddNote extends AddNoteEvent {
  const SubmitAddNote();
}
