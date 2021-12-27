import 'dart:io';

import 'package:audiorecorder/utils/constants.dart';
import 'package:audiorecorder/utils/logging/custom_logger.dart';
import 'package:path_provider/path_provider.dart';

class RecordingService {
  Future<String> getFilePath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    CustomLogger.instance.singleLine(directory.path);

    return directory.path +
        "/" +
        Constants.filePrefix +
        DateTime.now().millisecondsSinceEpoch.toString() +
        ".aac";
  }
}
