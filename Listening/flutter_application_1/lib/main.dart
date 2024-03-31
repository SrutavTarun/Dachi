import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecordingPage(),
    );
  }
}

class RecordingPage extends StatefulWidget {
  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  FlutterSoundRecorder _recorder;
  String _audioFilePath;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
  }

  Future<void> _startRecording() async {
    await _recorder.openAudioSession();
    final tempDir = await _recorder.getTempDirectory();
    _audioFilePath = '${tempDir.path}/my_audio.aac';

    await _recorder.startRecorder(toFile: _audioFilePath);
    print('Recording started...');
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    await _recorder.closeAudioSession();
    print('Recording stopped. File saved at: $_audioFilePath');
  }

  @override
  void dispose() {
    _recorder.closeAudioSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Recorder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _startRecording,
              child: Text('Start Recording'),
            ),
            ElevatedButton(
              onPressed: _stopRecording,
              child: Text('Stop Recording'),
            ),
          ],
        ),
      ),
    );
  }
}
