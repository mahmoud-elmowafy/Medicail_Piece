import 'dart:async';
import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audio_waveforms/audio_waveforms.dart'; // Import the package
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medical_piece/core/widgets/PrimaryButton.dart';
import 'package:medical_piece/features/user/home/presentation/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? recordedFilePath;
  final RecorderController recorderController = RecorderController();
  bool isRecorded = false;
  bool _isRecording = false;
  bool _isLoading = false;
  String _result = "";
  double recordingTime = 0; // Track the recording time

  @override
  void initState() {
    super.initState();
    recorderController.checkPermission();
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  // Method to start or stop recording
  Future<void> _toggleRecording() async {
    if (recorderController.hasPermission) {
      if (recorderController.isRecording) {
        // Stop recording
        recordedFilePath = await recorderController.stop();
        setState(() {
          isRecorded = true;
          _isRecording = false;
        });
      } else {
        setState(() {
          _isRecording = true;
          recordingTime = 0; // Reset recording time when starting
        });
        // Start recording
        recorderController.record(
          androidEncoder: AndroidEncoder.opus,
          androidOutputFormat: AndroidOutputFormat.ogg,
        );
        // Start a timer to monitor recording time
        _startRecordingTimer();
      }
    } else {
      print('Microphone permission denied.');
    }
  }

  // Start a timer to update recording time
  void _startRecordingTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isRecording) {
        setState(() {
          recordingTime++;
        });
        if (recordingTime >= 81) {
          _toggleRecording(); // Automatically stop after 81 seconds
        }
      }
    });
  }

  // Method to send audio to the API
  Future<void> _sendAudioToAPI() async {
    if (recordedFilePath == null) return;

    // If the recorded file is less than 22 seconds, show an error
    if (recordingTime < 21) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Recording must be at least 21 seconds long'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() {
      _result = "";
      _isLoading = true;
    });

    final String url =
        'https://resflask-crbhdqakgtaaa9bh.uaenorth-01.azurewebsites.net/predict';
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..files
          .add(await http.MultipartFile.fromPath('audio', recordedFilePath!));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        final result = json.decode(responseBody.body);
        setState(() {
          _result = result['result']; // Assuming the API returns a "result" key
          _isLoading = false;
        });
      } else {
        print(response.statusCode);
        print(recordedFilePath);
        setState(() {
          _result = 'Error: Failed to upload audio';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the color for the outer ring based on recording time
    Color ringColor = Colors.blue; // Default color
    if (_isRecording||isRecorded) {
      if (recordingTime < 22) {
        ringColor = Colors.red;
      } else if (recordingTime >= 22 ) {
        ringColor = Colors.green;
      }
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Medical Piece"),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Tap To Record',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 30),
              // Circle button with a dynamic color ring
              GestureDetector(
                onTap: _toggleRecording,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer ring indicating time
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ringColor,
                          width: 10,
                        ),
                      ),
                    ),
                    // Inner button (circle)
                    Container(
                      width: 230,
                      height: 230,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isRecording ? Colors.red : Colors.blue,
                      ),
                      child: Icon(
                        _isRecording ? Icons.stop : Icons.mic,
                        color: Colors.white,
                        size: 75,
                      ),
                    ),
                    // Display recording time text
                    Positioned(
                      bottom: 50,
                      child: Text(
                        _isRecording
                            ? "${recordingTime}s"
                            : isRecorded
                                ? "${recordingTime}s"
                                : "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // Audio waveform visualization
              if (_isRecording)
                AudioWaveforms(
                  recorderController: recorderController,
                  size: Size(300, 50),
                ),
              SizedBox(height: 15),
              // Send Button
              if (isRecorded)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: _isLoading == false
                      ? PrimaryButton(
                          onPressed: _sendAudioToAPI,
                          text: "Send Record To Check",
                        )
                      : LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color(0xFF1A1A3F),
                          rightDotColor: const Color(0xFFEA3799),
                          size: 30,
                        ),
                ),
              SizedBox(height: 20),
              // Show result from API if available
              if (_result.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _result,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
