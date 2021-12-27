import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathService {
  late Directory directory;
  Future<PathService> loadPath() async {
    directory = await getApplicationDocumentsDirectory();

    return this;
  }
}
