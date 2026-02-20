import 'package:equatable/equatable.dart';

class AddNoteState extends Equatable {
  final String title;
  final String desc;
  final String url;
  final String imageUrl;
  final String providerName;
  final bool isLoadingPreview;
  final String previewError;
  final bool isSubmitting;
  final bool showError;
  final bool isSuccess;
  final String? errorMessage;

  const AddNoteState({
    this.title = '',
    this.desc = '',
    this.url = '',
    this.imageUrl = '',
    this.providerName = '',
    this.isLoadingPreview = false,
    this.previewError = '',
    this.isSubmitting = false,
    this.showError = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  bool get isFormValid =>
      title.isNotEmpty && desc.isNotEmpty && providerName.isNotEmpty;

  AddNoteState copyWith({
    String? title,
    String? desc,
    String? url,
    String? imageUrl,
    String? providerName,
    bool? isSubmitting,
    bool? isLoadingPreview,
    String? previewError,
    bool? showError,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return AddNoteState(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      providerName: providerName ?? this.providerName,
      isLoadingPreview: isLoadingPreview ?? this.isLoadingPreview,
      previewError: previewError ?? this.previewError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showError: showError ?? this.showError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    title,
    desc,
    url,
    imageUrl,
    providerName,
    isLoadingPreview,
    previewError,
    isSubmitting,
    showError,
    isSuccess,
    errorMessage,
  ];
}
