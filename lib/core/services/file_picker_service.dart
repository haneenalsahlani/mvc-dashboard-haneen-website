import 'package:file_picker/file_picker.dart';

Future<List<PlatformFile>> pickSingleFile() async {
  final result = await FilePicker.platform.pickFiles();
  if (result == null) {
    return [];
  } else {
    return result.files;
  }
}

Future<List<PlatformFile>> pickSingleSvg() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['svg'],
  );
  if (result == null) {
    return [];
  } else {
    return result.files;
  }
}

Future<List<PlatformFile>> pickMultiFile() async {
  final result = await FilePicker.platform.pickFiles(allowMultiple: true);
  if (result == null) {
    return [];
  } else {
    return result.files;
  }
}
