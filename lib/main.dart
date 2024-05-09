import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageUploadScreen(),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final picker = ImagePicker();
  File? _image;
  String _result = '';

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      return;
    }

    final url = 'http://192.168.1.6:5000/predict';
    final imageBytes = await _image!.readAsBytes();
    final response = await http.post(
      Uri.parse(url),
      body: imageBytes,
      headers: {
        'Content-Type': 'application/octet-stream', // Adjust content type based on your server requirements
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _result = jsonResponse['predicted_label'];
      });
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Image.file(
              _image!,
              height: 200,
            )
                : Text('No image selected.'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload and Predict'),
            ),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
