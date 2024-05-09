// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:tflite_v2/tflite_v2.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
//
//
// class ImageSelector extends StatefulWidget {
//   @override
//   _ImageSelectorState createState() => _ImageSelectorState();
// }
//
// class _ImageSelectorState extends State<ImageSelector> {
//   File? _image;
//   String? _result;
//
//   Future<void> _selectImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//       _classifyImage(pickedImage.path);
//     }
//   }
//
//   Future<void> _classifyImage(String imagePath) async {
//     print("Attempting to load model...");
//     final res = await Tflite.loadModel(
//       labels: "assets/labels.txt",
//       model: "assets/model.tflite",
//     );
//
//     if (res != 'success') {
//       print("Failed to load model: $res");
//       setState(() {
//         _result = 'Failed to load model';
//       });
//       return;
//     }
//
//     print("Model loaded successfully");
//
//     print("Running model on image...");
//     final output = await Tflite.runModelOnImage(path: imagePath);
//     print("Model execution completed");
//
//     setState(() {
//       _result = output.toString();
//     });
//
//     Tflite.close();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Diabetic Retinopathy Detection'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _image == null
//                 ? Text('No image selected.')
//                 : Image.file(_image!, width: 300, height: 200, fit: BoxFit.cover),
//             ElevatedButton(
//               onPressed: _selectImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             _result == null ? Container() : Text('Result: $_result'),
//           ],
//         ),
//       ),
//     );
//   }
// }
