import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_collector/controller/home_provider.dart';
import 'package:text_collector/model/app_model.dart';

// ignore: non_constant_identifier_names
Container CardWidget(Size size, File imageFile, AppModel item,
    HomeProvider value, BuildContext context) {
  return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 1, offset: Offset(1, 1), blurStyle: BlurStyle.solid)
        ],
        borderRadius: BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo,
            Colors.blue,
          ],
        ),
      ),
      height: size.height * .5,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: size.width * .1,
              height: size.height * .08,
              child: Image.file(imageFile),
            ),
            Text(
              item.title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              value.formatTimestamp(item.date!),
              style: const TextStyle(fontSize: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () async {
                      await value.deleteData(item.id!);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 18,
                      color: Colors.red,
                    )),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: item.title,
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Text copied to clipboard"),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 18,
                      color: Colors.white70,
                    )),
              ],
            ),
          ],
        ),
      ));
}
