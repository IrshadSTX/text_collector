import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:text_collector/controller/home_provider.dart';
import 'package:text_collector/view/widgets/floating_speed_dial.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        provider.fetchData();
      },
    );
    log('hi');
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: const FloatingSpeedDialWidget(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Text Collector',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<HomeProvider>(builder: (context, value, child) {
          if (value.data.isEmpty) {
            return Center(
              child: Text('Select Image'),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemBuilder: (context, index) {
              final item = value.data[index];
              final imageFile = File(item.imagePath);
              return InkWell(
                splashColor: Colors.amber,
                onTap: () {},
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                      height: size.height * .5,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: size.width * .1,
                              height: size.height * .08,
                              child: Image.file(imageFile),
                            ),
                            Text(
                              item.title.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await value.deleteData(item.id!);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 16,
                                    )),
                                Text(
                                  value.formatTimestamp(item.date!),
                                  style: const TextStyle(fontSize: 10),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                        text: item.title,
                                      ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Text copied to clipboard"),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.copy,
                                      size: 16,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
            itemCount: value.data.length,
          );
        }),
      ),
    );
  }
}
