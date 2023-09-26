import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:text_collector/model/app_model.dart';
import 'package:text_collector/model/db_functions.dart';

class HomeProvider with ChangeNotifier {
  String recognizedText = '';
  File? selectedImage;
  List<AppModel> data = [];
  Future<void> fetchData() async {
    data = await getAllData();
    notifyListeners();
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
    }
  }
}
