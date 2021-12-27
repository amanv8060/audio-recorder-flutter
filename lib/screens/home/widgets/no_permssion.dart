import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/logging/custom_logger.dart';
import 'package:audiorecorder/utils/logging/info_toast.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class NoPermission extends StatelessWidget {
  const NoPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //animation for no perms
        const Text("Microphone permission is disabled"),
        TextButton(
          child: const Text("Grant Permission"),
          onPressed: () async {
            var status = await Permission.microphone.request();
            if (status != PermissionStatus.granted) {
              if (status == PermissionStatus.permanentlyDenied) {
                InfoToast("Please give permission from Settings");
                await openAppSettings();
              }
            } else {
              CustomLogger.instance.singleLine("here3");
              Provider.of<RecordingProvider>(context, listen: false).init();
            }
          },
        )
      ],
    );
  }
}
