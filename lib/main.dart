import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart'; // TODO
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:window_utils/window_utils.dart';
import 'package:window_utils/window_frame.dart';
// import 'package:http/http.dart' as http;




void main() {
  runApp(MaterialApp(
    title: 'lofimusic',
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    initialRoute: '/',
    routes: {
      '/': (ctx) => HomePage(),
    }
  ));
}


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  int activeIdx;

  //TODO add to preferences
  //<https://github.com/maxence-charriere/lofimusic/blob/master/bin/lofimusic/channel.go#L36>
  List channel = [{
    'title': 'ChilledCow - Study girl',
    'id': '5qap5aO4i9A',
  }, {
    'title': 'ChilledCow - Sleepy girl',
    'id': 'DWcJFNfaw9c',
  }, {
    'title': 'Chillhop Music - Walking raccoon',
    'id': '5yx6BWlEVcY',
  }, {
    'title': 'Chillhop Music - Sleepy raccoon',
    'id': '7NOSDKb0HlU',
  }, {
    'title': 'Tokyo LosT Tracks - サクラチル',
    'id': 'WBfbkPTqUtU',
  }, {
    'title': 'The Jazz Hop Café',
    'id': 'OVPPOwMpSpQ',
  }, {
    'title': 'Homework Radio - Roof girl',
    'id': 'ZYMuB9y549s',
  }, {
    'title': 'Homework Radio - Rainy window',
    'id': 'nMhua5LJRWg',
  }, {
    'title': 'STEEZYASFUCK - Coffee shop radio',
    'id': '-5KAN9_CzSA',
  }, {
    'title': 'the bootleg boy - Smoking girl',
    'id': 'l7TxwBhtTUY',
  }, {
    'title': 'Monstafluff Music - Spaceship girl',
    'id': 'pH3xU1YcjaA',
  }, {
    'title': 'InYourChill - Nerdy girl',
    'id': 'B8tQ8RUbTW8',
  }, {
    'title': 'College Music - Lonely girl',
    'id': 'bM0Iw7PPoU4',
  }, {
    'title': 'KozyPop - 같이해요',
    'id': 'F5v_VqxbQPI',
  }];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        WindowUtils.hideTitleBar();
        WindowUtils.setSize(Size(320, 580));
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // final double w = MediaQuery.of(context).size.width;
    return WindowsFrame(
      active: Platform.isWindows,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: new ListView.builder(
          itemCount: channel == null ? 0 : channel.length,
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
              leading: activeIdx == index ? Icon(Icons.play_arrow) : null,
              title: Text(channel[index]["title"]),
              onTap: () {
                if (activeIdx != index) {
                  play(channel[index]["id"]);
                  setState(() => activeIdx = index);
                } else {
                  audioPlayer.pause();
                  setState(() => activeIdx = null);
                }
              },
            );
          },
        ),
      // floatingActionButton: FloatingActionButton(
        // onPressed: () => audioPlayer.playOrPause(),

        // child: audioPlayer.builderIsPlaying(
            // builder: (context, isPlaying) => Icon(isPlaying ?
                // Icons.pause : Icons.play_arrow),
            // )
      // ),
      )
      )
    );
  }

  Future<void> play(String id) async {
    var yt = YoutubeExplode();
    var vid = VideoId(id);
    var audio = await yt.videos.streamsClient.getHttpLiveStreamUrl(vid);
    // print(audio);

    try {
      await audioPlayer.open(
          Audio.liveStream(audio)
      );
    } catch (t) {
      //stream unreachable
    }
  }
}
