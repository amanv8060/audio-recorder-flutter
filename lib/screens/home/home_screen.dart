import 'package:audiorecorder/screens/home/widgets/button_controls.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: const [
          Expanded(
            child: MessageList(),
          ),
          ButtonControls()
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        padding: EdgeInsets.zero,
        itemCount: 0,
        itemBuilder: (_, position) {
          return Container();
        });
  }
}
