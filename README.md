# Flutter Audio Recorder 

A Simple audio recorder written in FLutter .

Basic Features
1. Audio recording - long press for quick record, and press/hold and  swipe up  to record longer audios.

2. Recorded audios to be shown in chat bubble, that can be played there itself by clicking the play button.

3. Multiple audio chat bubbles can be added if audio is recorded multiple times.

4. Delete previously recorded audios



## Run it 

- Download apk from releases 

or you can buiild it

1. Clone repo `git clone https://github.com/amanv8060/audio-recorder-flutter`
2. cd audio-recorder-flutter
3. run `flutter pub get`
4. run `flutter run`


### Proeject Structure

📦lib
 ┣ 📂providers
 ┃ ┣ 📜player_provider.dart
 ┃ ┣ 📜previous_recording_providers.dart
 ┃ ┗ 📜recording_provider.dart
 ┣ 📂screens
 ┃ ┗ 📂home
 ┃ ┃ ┣ 📂widgets
 ┃ ┃ ┃ ┣ 📜audio_card.dart
 ┃ ┃ ┃ ┣ 📜audio_list.dart
 ┃ ┃ ┃ ┣ 📜button_controls.dart
 ┃ ┃ ┃ ┣ 📜custom_app_bar.dart
 ┃ ┃ ┃ ┣ 📜delete_button.dart
 ┃ ┃ ┃ ┣ 📜lock_button.dart
 ┃ ┃ ┃ ┣ 📜no_permission.dart
 ┃ ┃ ┃ ┣ 📜pause_button.dart
 ┃ ┃ ┃ ┣ 📜record_button.dart
 ┃ ┃ ┃ ┗ 📜timer_widget.dart
 ┃ ┃ ┗ 📜home_screen.dart
 ┣ 📂services
 ┃ ┣ 📜previous_recording_service.dart
 ┃ ┣ 📜recording_service.dart
 ┃ ┗ 📜timer_service.dart
 ┣ 📂utils
 ┃ ┣ 📂functions
 ┃ ┃ ┣ 📜datetime_from_filename.dart
 ┃ ┃ ┗ 📜format_number.dart
 ┃ ┣ 📂get_it
 ┃ ┃ ┗ 📜locator.dart
 ┃ ┣ 📂logging
 ┃ ┃ ┣ 📜custom_logger.dart
 ┃ ┃ ┗ 📜info_toast.dart
 ┃ ┣ 📂theme
 ┃ ┃ ┗ 📜app_theme.dart
 ┃ ┣ 📂ui
 ┃ ┃ ┗ 📜size_config.dart
 ┃ ┗ 📜constants.dart
 ┣ 📜generated_plugin_registrant.dart
 ┗ 📜main.dart

## Packages that it depends upon and their primary use cases
- fluttertoast: `Show informative toast`
- get_it: `Create singletons`
- intl: `Formatting Date`
- path: `Utilities for working on path`
- path_provider: `Accessing applications path`
- permission_handler: `Managing Permission`
- provider:`Mangaing State`
- record:`Recording audio`
- just_audio: `Playing audio`
- logger: `For logging`
- lottie:`Showinfg lottie animation`
- focused_menu:`Focusing a tile and showing a context menu`


This codebase contains boilerplate code from packages examples.
