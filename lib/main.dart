import 'package:flutter/material.dart';
import 'music.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _player = AudioPlayer();

  List<Music> myMusicList = [
    Music('Burn it down', 'The cog is dead', 'assets/image/cogisdead.png',
        'assets/music/burn-it-down.mp3'),
    Music('Wolf Totem', 'The HU', 'assets/image/TheHU.jpg',
        'assets/music/wolf-totem.mp3'),
    Music('Resurection By Erection', 'Powerwolf', 'assets/image/powerwolf.jpg',
        'assets/music/powerwolf-resurrection-by-erection.mp3'),
  ];

  String songduration = '';
  int musicIndex = 0;

  Future<void> _init(int musicIndex) async {
    await _player.setAsset(myMusicList[musicIndex].urlSong).then((value) => {
          setState(() {
            songduration = "${value!.inMinutes}:${value.inSeconds % 60}";
          })
        });
  }

  bool selected = true;
  int IconsState = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init(musicIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ynovify"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
          width: double.infinity,
          child: Container(
              child: Column(children: [
            const SizedBox(
              height: 48.0,
            ),
            Center(
                child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                myMusicList[musicIndex].imagePath))))),
            const SizedBox(height: 18),
            Center(
                child: Text(myMusicList[musicIndex].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ))),
            const SizedBox(height: 18),
            Center(
                child: Text(myMusicList[musicIndex].singer,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ))),
            const SizedBox(height: 30),
            Expanded(
                child: Container(
                    child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        iconSize: 45.0,
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            if (musicIndex == 0) {
                              musicIndex = myMusicList.length - 1;
                              _init(musicIndex);
                            } else {
                              musicIndex = musicIndex - 1;
                              _init(musicIndex);
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        iconSize: 45.0,
                        color: Colors.white,
                        icon: Icon(selected ? Icons.play_arrow : Icons.pause),
                        onPressed: () {
                          setState(() {
                            selected = !selected;
                            (selected ? _player.pause() : _player.play());
                          });
                        },
                      ),
                    ),
                    IconButton(
                        iconSize: 45.0,
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            if (musicIndex == myMusicList.length - 1) {
                              musicIndex = 0;
                              _init(musicIndex);
                            } else {
                              musicIndex = musicIndex + 1;
                              _init(musicIndex);
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.skip_next,
                        )),
                  ])
            ]))),
            Center(
                child: Text("durée : $songduration",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ))),
          ]))),
      backgroundColor: Color.fromARGB(255, 1, 26, 73),
    );
  }
}
