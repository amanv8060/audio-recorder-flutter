import 'package:audiorecorder/services/path_service.dart';
import 'package:audiorecorder/services/previous_recording_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setuplocator() {
  locator.registerLazySingletonAsync(() => PathService().loadPath());
  locator.registerSingleton(() => PreviousRecordingService());
}
