import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:text_collector/controller/home_provider.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            provider.cropImage(pickedFile.path, context);
          }
        },
        child: const Icon(Icons.add),
      ),
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
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      await value.deleteData(index);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 18,
                                    )),
                                Text('1'),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.copy,
                                      size: 18,
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
