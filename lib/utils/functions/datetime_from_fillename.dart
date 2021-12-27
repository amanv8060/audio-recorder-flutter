import 'dart:io';
import 'package:path/path.dart' as path;

import '../constants.dart';

DateTime getDateTimefromFilename(FileSystemEntity file) {
  String fileName = path.basenameWithoutExtension(file.path);
  String timeinString = fileName.split(Constants.filePrefix)[1];
  int ms = int.parse(timeinString);
  return DateTime.fromMillisecondsSinceEpoch(ms);
}
