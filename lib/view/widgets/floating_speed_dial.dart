import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:text_collector/controller/home_provider.dart';
import 'package:text_collector/view/splash_screen.dart';

class FloatingSpeedDialWidget extends StatelessWidget {
  const FloatingSpeedDialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return SpeedDial(
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.refresh),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          label: 'Reset',
          onPressed: () {
            if (provider.data.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.blueGrey,
                  content: Text(
                    'No data for reset.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
              return;
            }
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Reset Text Collector',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          'Text Collectors will no longer active',
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Decline'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async {
                        await provider.clearTable();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SplashScreen()));
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.image),
          foregroundColor: Colors.white,
          backgroundColor: Colors.cyan,
          label: 'Select Image',
          onPressed: () async {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              provider.cropImage(pickedFile.path, context);
            }
          },
        ),
      ],
      closedForegroundColor: Colors.black,
      openForegroundColor: Colors.white,
      closedBackgroundColor: Colors.white,
      openBackgroundColor: Colors.black,
      child: const Icon(Icons.menu),
    );
  }
}
