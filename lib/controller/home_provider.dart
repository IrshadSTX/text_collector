import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:text_collector/model/app_model.dart';
import 'package:text_collector/model/db_functions.dart';

class HomeProvider with ChangeNotifier {
  String recognizedText = '';
  File? selectedImage;
  List<AppModel> data = [];
  Future<void> fetchData() async {
    List<AppModel> fetchedData = await getAllData();
    data = List.from(fetchedData.reversed); // Reversing the list
    setLoading(false);
    notifyListeners();
  }

  Future<List<AppModel>> getAllData() async {
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM text_table');
    final data = result.map((map) => AppModel.fromMap(map)).toList();
    return data;
  }

  void setRecognizedText(String text) {
    recognizedText = text;
    notifyListeners();
  }

  void setSelectedImage(File? imageFile) {
    selectedImage = imageFile;
    notifyListeners();
  }

  Future<void> cropImage(String pickedFile, BuildContext context) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      File croppedImage = File(croppedFile.path);
      setSelectedImage(croppedImage);
      // ignore: use_build_context_synchronously
      textRecoginition(context, croppedImage);
    }
  }

  Future<void> textRecoginition(BuildContext context, File croppedImage) async {
    final InputImage inputImage = InputImage.fromFilePath(selectedImage!.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();

    final recognisedText = await textDetector.processImage(inputImage);
    final finalText = recognisedText.text;
    final currentTime = DateTime.now();
    storeData(finalText, croppedImage, currentTime);
    fetchData();
    textDetector.close();
  }

  Future<void> storeData(
      String finalText, File selectedImage, DateTime currentTime) async {
    final currentTime = DateTime.now();
    final appmodel = AppModel(
      title: finalText,
      imagePath: selectedImage.path,
      date: currentTime,
    );
    await addData(appmodel);
  }

  String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  //shimmer
  bool isLoading = true; // Initialize as true to show loading initially

  // Method to update loading status
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
  //editing screeeen
  // String editedTitle = '';
  // void setEditedTitle(String value) {
  //   editedTitle = value;
  //   notifyListeners();
  // }

  //db functionssssss
  Future<void> deleteData(int index) async {
    await db.rawDelete('DELETE FROM text_table WHERE id = ?', [index]);
    fetchData();
    log('deleted $index ');
    notifyListeners();
  }

  Future<void> clearTable() async {
    await db.delete('text_table');
    notifyListeners();
  }
}
