import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:text_collector/controller/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context).fetchData();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            // processImage(pickedFile.path);
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Text Collector',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final item = value.data[index];
            return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                      height: size.height * .15,
                      child: ListTile(
                        onTap: () async {},
                        leading: CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          // child: Image.network(''),
                        ),
                        title: Text(
                          // '${data.firstName!} ${data.lastName}',
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('sub'),
                      )),
                ));
          },
          itemCount: value.data.length,
        );
      }),
    );
  }
}
