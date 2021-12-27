import 'dart:io';
import 'package:audiorecorder/services/path_service.dart';
import 'package:audiorecorder/utils/constants.dart';
import 'package:audiorecorder/utils/get_it/locator.dart';
import 'package:path/path.dart' as path;

class PreviousRecordingService {
  Future<List<FileSystemEntity>> getRecordings() async {
    List<FileSystemEntity> temp = locator<PathService>().directory.listSync();
    // not considering file that don't start with my prefix
    temp.removeWhere((element) =>
        !path.basename(element.path).contains(Constants.filePrefix));

    //comparing  basename and sorting , beacause these have common prefix and
    //extension , and unique identifier is name which will always increase
    temp.sort((a, b) => path.basename(b.path).compareTo(path.basename(a.path)));
    return temp;
  }
}
