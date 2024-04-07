import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NoticePageUser extends StatefulWidget {
  @override
  _NoticePageUserState createState() => _NoticePageUserState();
}

class _NoticePageUserState extends State<NoticePageUser> {
  File? _imageFile;
  String? _prediction;

  Future<void> _getImageAndPredict() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _prediction = null; // Reset prediction when new image is selected
      });
    }
  }

  Future<void> _predictImage() async {
    if (_imageFile == null) return;

    final apiUrl =
        "https://076d-2409-408d-284-5603-34ac-48a7-c47b-bae9.ngrok-free.app/predict"; // Replace with your API endpoint
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.files
        .add(await http.MultipartFile.fromPath('image', _imageFile!.path));

    try {
      final streamedResponse = await request.send();
      print(streamedResponse);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("enterred the function");
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _prediction = data['prediction'];
        });
      } else {
        print('Failed to make request');
      }
    } catch (e) {
      print('Error during prediction request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Damage Prediction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Text('No image selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageAndPredict,
              child: Text(
                'Select Image',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictImage,
              child: Text(
                'Predict',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            SizedBox(height: 20),
            _prediction != null
                ? Text(
                    'Prediction: $_prediction',
                    style: TextStyle(fontSize: 18),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
