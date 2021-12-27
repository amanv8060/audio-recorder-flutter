import 'dart:io';
import 'package:audiorecorder/utils/constants.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PreviousRecordingService {
  Future<List<FileSystemEntity>> getRecordings() async {
    Directory directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> temp = directory.listSync();
    // not considering file that don't start with my prefix
    temp.removeWhere((element) =>
        !path.basename(element.path).contains(Constants.filePrefix));

    //comparing  basename and sorting , beacause these have common prefix and
    //extension , and unique identifier is name which will always increase
    temp.sort((a, b) => path.basename(b.path).compareTo(path.basename(a.path)));
    return temp;
  }
}
