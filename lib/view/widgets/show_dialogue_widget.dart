import 'dart:io';

import 'package:flutter/material.dart';

class ShowImageDialog extends StatelessWidget {
  final File imageUrl;

  const ShowImageDialog({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(); // Close the dialog on tap
        },
        child: Hero(
          tag: 'imageHero',
          child: Image.file(imageUrl),
        ),
      ),
    );
  }
}
