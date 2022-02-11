part of 'fileupload_bloc.dart';

@immutable
abstract class FileuploadEvent extends Equatable {}

class FileUpload extends FileuploadEvent {
  final String filePath;

  FileUpload(this.filePath);

  @override
  List<Object?> get props => [filePath];
}
