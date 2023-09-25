import 'dart:io';

import 'package:flutter/material.dart';
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
}
