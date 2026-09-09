import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<File> saveTempFile({
  required List<int> bytes,
  required String name,
}) async {
  Directory tempDir = await getTemporaryDirectory();
  var dir = await tempDir.createTemp();

  final file = File(p.join(dir.path, name));
  await file.create();
  await file.writeAsBytes(bytes);

  return file;
}
