import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.info_outline,
              color: Colors.yellow,
            ),
          ),
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
        child: Consumer<HomeProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return _buildShimmerLoading(size);
            }
            if (value.data.isEmpty) {
              return Center(
                child: Text('No Notes Available'),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) {
                final item = value.data[index];
                final imageFile = File(item.imagePath);
                return InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          text: item.title,
                          imageUrl: imageFile,
                          id: item.id,
                        ),
                      ),
                    );
                  },
                  child: CardWidget(size, imageFile, item, value, context),
                );
              },
              itemCount: value.data.length,
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: .8,
        ),
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              height: size.height * .5,
            ),
          );
        },
        itemCount: 6, // Placeholder items for shimmer effect
      ),
    );
  }
}
