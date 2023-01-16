import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../interfazUsuario/diseño_interfaz_app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef void OnError(Exception exception);

const kUrl =
    "https://firebasestorage.googleapis.com/v0/b/alcaldiapp-e9da6.appspot.com/o/mp3%2FHimno.mp3?alt=media&token=f50a139d-c73e-427a-b84f-12bb9f3987d6";

enum PlayerState { stopped, playing, paused }

class Simbolos extends StatefulWidget {
  @override
  _SimbolosState createState() => _SimbolosState();
}

class _SimbolosState extends State<Simbolos> with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  Duration duration;
  Duration position;
  String localFilePath;
  AudioPlayer audioPlayer;
  PlayerState playerState = PlayerState.stopped;
  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

  Future play() async {
    await audioPlayer.play(kUrl);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future _playLocal() async {
    await audioPlayer.play(localFilePath, isLocal: true);
    setState(() => playerState = PlayerState.playing);
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  Widget horizontalLine2() => Padding(
        padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;

    return Container(
      color: Color.fromARGB(255, 190, 234, 245),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            AppBar(
                centerTitle: true,
                title: Text('Nuestros Simbolos',
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Color.fromARGB(255, 255, 255, 255)),
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.1,
                  child: Image.asset('assets/diseño_interfaz/cultu.png'),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.3) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 185, 205, 214),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Text(
                              'HIMNO\nDE CHIMICHAGUA',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: InterfazAppTheme.darkerText,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Material(child: _buildPlayer()),
                                if (localFilePath != null)
                                  IconButton(
                                    onPressed: () => _playLocal(),
                                  ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              horizontalLine(),
                              Text("ESCUDO",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      fontFamily: "Poppins-Medium")),
                              horizontalLine()
                            ],
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 6, bottom: 1),
                                child: Column(
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 2.3,
                                      child: Image.asset(
                                          'assets/diseño_interfaz/escudocalcaldia.png'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        horizontalLine2(),
                                        Text("BANDERA",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.0,
                                                fontFamily: "Poppins-Medium")),
                                        horizontalLine2(),
                                      ],
                                    ),
                                    Expanded(
                                      child: AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity: opacity2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13,
                                              right: 13,
                                              top: 8,
                                              bottom: 8),
                                          child: Column(
                                            children: <Widget>[
                                              AspectRatio(
                                                aspectRatio: 4.6,
                                                child: Image.asset(
                                                    'assets/diseño_interfaz/bandera.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 35,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: InterfazAppTheme.nearlyBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: InterfazAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlayer() => Container(
        color: Color.fromARGB(255, 200, 220, 226),
        padding: EdgeInsets.all(0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                onPressed: isPlaying ? null : () => play(),
                iconSize: 40.0,
                icon: Icon(Icons.play_arrow),
                color: Colors.cyan,
              ),
              IconButton(
                onPressed: isPlaying ? () => pause() : null,
                iconSize: 40.0,
                icon: Icon(Icons.pause),
                color: Colors.cyan,
              ),
              IconButton(
                onPressed: isPlaying || isPaused ? () => stop() : null,
                iconSize: 40.0,
                icon: Icon(Icons.stop),
                color: Colors.cyan,
              ),
            ]),
            if (duration != null)
              Slider(
                  value: position?.inMilliseconds?.toDouble() ?? 0.0,
                  onChanged: (double value) {
                    return audioPlayer.seek((value / 1000).roundToDouble());
                  },
                  min: 0.0,
                  max: duration.inMilliseconds.toDouble()),
          ],
        ),
      );
}
