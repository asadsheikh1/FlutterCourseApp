import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/providers/courses.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);
  static const routeName = '/playlist';

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late YoutubePlayerController controller;

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final id = ModalRoute.of(context)?.settings.arguments as String;
      final selectedCourse = Provider.of<Courses>(context).findById(id);
      var url = selectedCourse.playlist[0];
      controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      )..addListener(() {
          if (mounted) {
            setState(() {});
          }
        });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<Courses>(context);
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final selectedCourse = courses.findById(id);

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
          playedColor: Theme.of(context).primaryColor,
          handleColor: Theme.of(context).primaryColor,
        ),
      ),
      builder: (context, player) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(selectedCourse.title.toUpperCase()),
        ),
        body: ListView(
          children: [
            player,
            const Divider(),
            ...selectedCourse.playlist
                .map(
                  (video) => MyCard(controller: controller),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final YoutubePlayerController controller;

  String formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          color: Theme.of(context).primaryColorLight,
          child: ListTile(
            leading: Icon(
              Icons.play_arrow,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
            title: Text(
              controller.metadata.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              formatedTime(
                  timeInSecond: controller.metadata.duration.inSeconds),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              controller.metadata.author,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
