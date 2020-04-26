import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicplayer/src/helpers/helpers.dart';
import 'package:musicplayer/src/widgets/custom_appbar.dart';

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

class TituloPlay extends StatelessWidget {
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
            onPressed: () {},
            child: Icon(
              Icons.play_arrow,
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
            width: 40.0,
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
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Text(
            '00:00',
            style: estilo,
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
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            '00:00',
            style: estilo,
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Image(
              image: AssetImage(
                'assets/aurora.jpg',
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
