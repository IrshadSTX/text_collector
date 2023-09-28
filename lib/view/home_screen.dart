import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:text_collector/controller/home_provider.dart';
import 'package:text_collector/view/about_screen.dart';

import 'package:text_collector/view/details_screen.dart';
import 'package:text_collector/view/widgets/card_widget.dart';
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
        title: const Text(
          'Text Collector',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutScreen()));
              },
              icon: const Icon(
                Icons.info_outline,
                color: Colors.yellow,
              ))
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.indigo],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<HomeProvider>(builder: (context, value, child) {
          if (value.data.isEmpty) {
            return const Center(
              child: Text('Select Image'),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: .8),
            itemBuilder: (context, index) {
              final item = value.data[index];
              final imageFile = File(item.imagePath);
              return InkWell(
                splashColor: Colors.red,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                            text: item.title,
                            imageUrl: imageFile,
                            id: item.id,
                          )));
                },
                child: CardWidget(size, imageFile, item, value, context),
              );
            },
            itemCount: value.data.length,
          );
        }),
      ),
    );
  }
}
