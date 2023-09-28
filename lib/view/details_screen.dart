import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'package:text_collector/view/widgets/edit_text_widget.dart';

import 'package:text_collector/view/widgets/show_dialogue_widget.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  final String text;
  final File imageUrl;
  final int? id;
  const DetailsScreen(
      {super.key, required this.text, required this.imageUrl, this.id});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.indigo],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(
                  text: text,
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Text copied to clipboard"),
                  ),
                );
              },
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return EditDialog(
                      text: text,
                      id: id,
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit),
              color: Colors.white,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share(text);
              },
              color: Colors.white,
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: TextFormField(
                        // onChanged: (value) {
                        //   data.setEditedTitle(value);
                        // },
                        readOnly: true,
                        initialValue: text,
                        maxLines: null, // Allows unlimited lines
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                            color: Colors.black), // Change text color
                        decoration: InputDecoration.collapsed(hintText: text)),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 20,
                bottom: 40,
                child: Card(
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ShowImageDialog(imageUrl: imageUrl);
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: SizedBox(
                              width: size.width * .5,
                              child: Image.file(imageUrl)),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }
}
