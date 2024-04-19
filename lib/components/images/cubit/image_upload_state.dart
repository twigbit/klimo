part of 'image_upload_cubit.dart';

abstract class ImageUploadState extends Equatable {
  const ImageUploadState();

  @override
  List<Object?> get props => [];
}

class ImageUploadInitial extends ImageUploadState {}

class ImageUploadLoading extends ImageUploadState {
  final XFile? file;

  const ImageUploadLoading({this.file});

  @override
  List<Object?> get props => [if (file != null) file];
}

class ImageUploadCompleted extends ImageUploadState {
  final ImageModel? image;

  const ImageUploadCompleted({this.image});

  @override
  List<Object?> get props => [if (image != null) image];
}

class ImageUploadError extends ImageUploadInitial {}
