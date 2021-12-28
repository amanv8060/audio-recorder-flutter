import 'package:audiorecorder/services/previous_recording_service.dart';
import 'package:audiorecorder/services/recording_service.dart';
import 'package:audiorecorder/services/timer_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => RecordingService());
  locator.registerLazySingleton(() => PreviousRecordingService());
  locator.registerLazySingleton(() => TimerService());
}
