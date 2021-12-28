import 'dart:io';
import 'package:path/path.dart' as path;

import '../constants.dart';

///Returns the datetime from a file named in format [Constants.filePrefix]*.extension
DateTime getDateTimefromFilename(FileSystemEntity file) {
  String fileName = path.basenameWithoutExtension(file.path);
  String timeinString = fileName.split(Constants.filePrefix)[1];
  int ms = int.parse(timeinString);
  return DateTime.fromMillisecondsSinceEpoch(ms);
}
