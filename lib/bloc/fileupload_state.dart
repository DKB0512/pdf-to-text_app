part of 'fileupload_bloc.dart';

@immutable
abstract class FileuploadState extends Equatable {}

class FileuploadInitial extends FileuploadState {
  @override
  List<Object?> get props => [];
}

class FileuploadLoading extends FileuploadState {
  @override
  List<Object?> get props => [];
}

class FileuploadResult extends FileuploadState {
  final String textResult;

  FileuploadResult(this.textResult);

  @override
  List<Object?> get props => [textResult];
}
