import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';

FileUploadBloc fileUploadBlocFromJson(String str) =>
    FileUploadBloc.fromJson(json.decode(str));

String fileUploadBlocToJson(FileUploadBloc data) => json.encode(data.toJson());

class FileUploadBloc {
  FileUploadBloc({
    required this.file,
    required this.success,
  });

  String file;
  int success;

  factory FileUploadBloc.fromJson(Map<String, dynamic> json) => FileUploadBloc(
        file: json["file"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "success": success,
      };
}

class FileUploadService {
  Future<String> getTextData(String path) async {
    String url = "http://api.rest7.com/v1/pdf_to_text.php?file=";
    // ignore: prefer_typing_uninitialized_variables
    var fileuploadBloc;
    final httpDio = dio.Dio();
    final formData = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(
        path,
        filename: basename(path),
      )
    });
    try {
      final dio.Response response = await httpDio.post(
        url,
        data: formData,
      );
      if (response.statusCode == 200) {
        final fileuploadBloc = fileUploadBlocFromJson(response.data);
        final responseData = await get(Uri.parse(fileuploadBloc.file));
        return responseData.body;
      }
    } on dio.DioError catch (e) {
      if (e.response != null) {}
    }
    return fileuploadBloc;
  }
}
