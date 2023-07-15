import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class menuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<menuPrincipal> {
  final formKey = GlobalKey<FormState>();
  AudioCache cache = AudioCache();
  AudioPlayer? backgroundMusicPlayer;
  bool isMusicPlaying = true;

  @override
  void initState() {
    super.initState();
    // Initialize the background music player
    backgroundMusicPlayer = AudioPlayer();
    playBackgroundMusic();
  }

  @override
  void dispose() {
    // Release resources when the widget is disposed
    backgroundMusicPlayer?.dispose();
    super.dispose();
  }

  void playBackgroundMusic() async {
    // Load the background music file
    await cache.load('audio/backgroundMusic.mp3');
    // Play the background music on a loop
    backgroundMusicPlayer?.setReleaseMode(ReleaseMode.LOOP);
    backgroundMusicPlayer = await cache.loop('audio/backgroundMusic.mp3');
  }

  void toggleMusic() {
    if (backgroundMusicPlayer != null) {
      if (isMusicPlaying) {
        backgroundMusicPlayer?.pause();
      } else {
        backgroundMusicPlayer?.resume();
      }
      setState(() {
        isMusicPlaying = !isMusicPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/images/fondo.jpg'),
            fit: BoxFit.cover,
            height: 1200,
            width: 2400,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 490, left: 0),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.fitHeight,
                height: 300,
                width: 400,
              ),
            ),
          ),
          Positioned(
            top: 40 ,
            left: 9,
            child: IconButton(
              icon: Icon(
                Icons.circle_outlined,
                color: Colors.white,
                size: 50,
              ),
              onPressed: (){
                cache.play("audio/soundSound.mp3");
              },
            ),
          ),
          Positioned(
            top: 48,
            left: 16,
            child: IconButton(
              icon: Icon(
                isMusicPlaying ? Icons.music_note : Icons.music_off,
                color: Colors.white,
                size: 35,
              ),
              onPressed: (){
                cache.play("audio/soundSound.mp3");
                toggleMusic();
              },
            ),
          ),
          
    
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80, left: 0),
              child: Container(
                height: 120,
                width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(0, 158, 158, 158),
                ),
                child: IconButton(
                  icon: Image(
                    image: AssetImage("assets/images/jugar1VS1.png"),
                  ),
                  onPressed: () {
                    cache.play('audio/buttonSound.mp3');
                    mostrarPagina1VS1(context);
                  },
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 300, left: 0),
              child: Container(
                height: 120,
                width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(0, 158, 158, 158),
                ),
                child: IconButton(
                  icon: Image(
                    image: AssetImage("assets/images/jugarCPU.png"),
                  ),
                  onPressed: () {
                    cache.play('audio/buttonSound.mp3');
                    mostrarPaginaCPU(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  mostrarPagina1VS1(BuildContext context) {
    Navigator.of(context).pushNamed("/pagina1vs1");
  }

  mostrarPaginaCPU(BuildContext context) {
    Navigator.of(context).pushNamed("/paginaCPU");
  }
}