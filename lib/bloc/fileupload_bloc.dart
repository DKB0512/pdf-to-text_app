import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../file_services.dart';

part 'fileupload_event.dart';
part 'fileupload_state.dart';

class FileuploadBloc extends Bloc<FileuploadEvent, FileuploadState> {
  final FileUploadService _fileUploadService;

  FileuploadBloc(this._fileUploadService) : super(FileuploadInitial()) {
    on<FileUpload>((event, emit) async {
      emit(FileuploadLoading());
      final result = await _fileUploadService.getTextData(event.filePath);
      emit(FileuploadResult(result));
    });
  }
}
