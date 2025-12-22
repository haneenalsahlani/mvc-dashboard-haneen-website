import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';

Future<FormData> addFileToFormData(List<PlatformFile> files) async {
  FormData formData = FormData();

  // Fix: Use Future.wait to properly handle async operations
  await Future.wait(
    files.map((file) async {
      formData.files.add(
        MapEntry(
          uploadFilesFieldName,
          await MultipartFile.fromFile(file.path!),
        ),
      );
    }),
  );

  return formData;
}
