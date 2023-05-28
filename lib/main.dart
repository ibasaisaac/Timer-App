import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:timer/time_up_screen.dart';
// import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Timer app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _initialSeconds = 10;
  int _counterSeconds = 10;
  bool _isRunning = false;
  int hours = 0, minutes = 0, seconds = 0;

  late Timer? _timer;
  //AudioPlayer audioPlayer;

  // AudioPlayer audioPlayer = AudioPlayer();
  // @override
  // void initState() {
  //   super.initState();
  //   audioPlayer = AudioPlayer()..setAsset('assets/audio/timeup.wav');
  // }

  void startTimer() async {
     //final duration = await audioPlayer..setAsset('assets/audio/timeshesh.mp3');
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (_counterSeconds > 0) {
            _isRunning = true;
            // ~/ -> get floor division
            hours = _counterSeconds ~/ 3600;
            minutes = (_counterSeconds % 3600) ~/ 60;
            seconds = _counterSeconds % 60;
            _counterSeconds--;
          }
          if(_counterSeconds<=0) {
            // audioPlayer.play();
            _isRunning = false;
            _timer?.cancel();
            showTimeUpDialog();
            print(223);
             //player.play();
          }
        });
        print(_counterSeconds);
      },
    );

  }

  void pauseTimer() {
    // setState(() {
    //   _isRunning = false;
    // });
    _timer?.cancel();
  }

  void resetTimer() {
    setState(() {
      _isRunning = false;
      _counterSeconds = 10;
    });
    //audioPlayer.stop();
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    //audioPlayer.dispose();
    super.dispose();
  }

  double _calculateProgress() {
    if(_counterSeconds == 0){
      resetTimer();
    }
    //if (_counterSeconds > 0) {
      return (_counterSeconds / _initialSeconds);
    //}
    //else {
    //   return 0.0;
    // }
  }

  void showTimeUpDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Time up'),
        content: Text('The timer has finished'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }

  void _incrementCounter() {
    setState(() {
      _counterSeconds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top:100)),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child:
                  CircularProgressIndicator(
                    strokeWidth: 10,
                    value: _calculateProgress(),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      if (!_isRunning) ...[
                        const Text(
                          '00 : 00 : 00',
                          style:
                          // GoogleFonts.lato(
                          //   textStyle:
                            TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 48,
                            ),
                          // ),
                        ),
                      ] else ...[
                        Text(
                          '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}',
                          style:
                            // GoogleFonts.lato(
                            // textStyle:
                            const TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 48,
                            ),
                          // ),
                        ),
                      ],
                    ],
                  ),
                ),
             ],
            ),
            Spacer(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if(_isRunning)...[
                  IconButton(
                    iconSize: 50,
                    icon: const Icon(Icons.pause_circle),
                    onPressed: () {
                      pauseTimer();
                    },
                  ),
                  // ]else ... [
                  IconButton(
                    iconSize: 50,
                    icon: const Icon(Icons.play_circle),
                    onPressed: () {
                      startTimer();
                      if(_counterSeconds==0) {
                          showDialog(context: context, builder: (context){
                            return const AlertDialog(
                              title: Text(
                                'Time out',
                              ),
                            );
                          });
                        }
                    },
                  ),
                  // ],
                  IconButton(
                    iconSize: 50,
                    icon: const Icon(Icons.stop_circle),
                    onPressed: () {
                      resetTimer();
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (BuildContext context) =>
                      //   TimeUpClass(),
                      //   ),
                      // );
                      // if(_counterSeconds == 0) {
                      //     showDialog(context: context, builder: (context){
                      //       return const AlertDialog(
                      //         title: Text(
                      //           'Time out',
                      //         ),
                      //       );
                      //     });
                      //   }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
