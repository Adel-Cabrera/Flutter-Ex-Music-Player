import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/src/helpers/helpers.dart';
import 'package:musicplayer/src/models/audioplayer_model.dart';
import 'package:musicplayer/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import 'package:assets_audio_player/assets_audio_player.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Column(
            children: <Widget>[
              CustomAppBar(),
              ImagenDiscoDuracion(),
              TituloPlay(),
              Expanded(
                child: Lyrics(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            60.0,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xFF33333E),
            Color(0xFF201E28),
          ],
        ),
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return Container(
      child: ListWheelScrollView(
        itemExtent: 42,
        physics: BouncingScrollPhysics(),
        diameterRatio: 1.5,
        children: lyrics
            .map(
              (verso) => Text(
                '$verso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(
                    0.6,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TituloPlay extends StatefulWidget {
  @override
  _TituloPlayState createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  AnimationController playAnimation;

  final assetAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() {
    playAnimation = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    playAnimation.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);

    assetAudioPlayer.open(
      Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
    );

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      margin: EdgeInsets.only(
        top: 40.0,
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Far Away',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white.withOpacity(
                    0.8,
                  ),
                ),
              ),
              Text(
                '-Breaking Benjamin-',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white.withOpacity(
                    0.5,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          FloatingActionButton(
            elevation: 0.0,
            highlightElevation: 0.0,
            backgroundColor: Color(0xFFF8CB51),
            onPressed: () {
              final audioPlayerModel =
                  Provider.of<AudioPlayerModel>(context, listen: false);

              if (this.isPlaying) {
                playAnimation.reverse();
                this.isPlaying = false;
                audioPlayerModel.controller.stop();
              } else {
                playAnimation.forward();
                this.isPlaying = true;
                audioPlayerModel.controller.repeat();
              }
              if (firstTime) {
                open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: playAnimation,
            ),
          ),
        ],
      ),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      margin: EdgeInsets.only(
        top: 100.0,
      ),
      child: Row(
        children: <Widget>[
          ImagenDisco(),
          SizedBox(
            width: 20.0,
          ),
          BarraProgreso(),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
  }
}

class BarraProgreso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(
      color: Colors.white.withOpacity(
        0.4,
      ),
    );

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;

    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '${audioPlayerModel.songTotalDuration}',
            style: estilo,
          ),
          SizedBox(
            height: 10.0,
          ),
          Stack(
            children: <Widget>[
              Container(
                width: 3.0,
                height: 230.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.1,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: 3.0,
                  height: 230.0 * porcentaje,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '${audioPlayerModel.currentSecond}',
            style: estilo,
          ),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Container(
      padding: EdgeInsets.all(
        20.0,
      ),
      width: 250.0,
      height: 250.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          200.0,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xFF484750),
            Color(0xFF1E1C24),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          200.0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SpinPerfect(
              duration: Duration(
                seconds: 10,
              ),
              manualTrigger: true,
              controller: (animationController) =>
                  audioPlayerModel.controller = animationController,
              infinite: true,
              child: Image(
                image: AssetImage(
                  'assets/aurora.jpg',
                ),
              ),
            ),
            Container(
              width: 25.0,
              height: 25.0,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(
                  100.0,
                ),
              ),
            ),
            Container(
              width: 18.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: Color(0xFF1C1C25),
                borderRadius: BorderRadius.circular(
                  100.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
