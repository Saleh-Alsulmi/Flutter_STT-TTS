import 'dart:typed_data' show Uint8List;
import 'package:flutter_ibm_watson/flutter_ibm_watson.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  AudioPlayer audioplayer = new AudioPlayer();

  String TextAsSpeech ="" ;

  String Apikey = "wuFSFy2katGjPFluA_j_XFt1gv-CRe7KCJ4CDo3dTvwk";
  String IbmUrl = "https://api.eu-gb.text-to-speech.watson.cloud.ibm.com/instances/583296de-df7c-4a80-8584-fe98ee9479b0";

  void textToSpeech(String text)async{

    IamOptions option = await IamOptions(iamApiKey: Apikey, url: IbmUrl).build();
    TextToSpeech service = new TextToSpeech(iamOptions: option);
    Uint8List voice = await service.toSpeech(text);
    audioplayer.playBytes(voice);

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(



        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children:[

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

              onChanged: (value) {

                setState(() {
                  TextAsSpeech = value;
                });

      }),
            ),

            ElevatedButton(onPressed:() {

              textToSpeech(TextAsSpeech);
            }, child: Text("Convert"))

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
