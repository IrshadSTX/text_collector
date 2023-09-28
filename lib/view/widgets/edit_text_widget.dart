import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_collector/controller/home_provider.dart';
import 'package:text_collector/model/db_functions.dart';
import 'package:text_collector/view/details_screen.dart';
import 'package:text_collector/view/home_screen.dart';

class EditDialog extends StatefulWidget {
  // final TextEditingController textController;
  final String text;
  final int? id;
  const EditDialog({
    this.id,
    super.key,
    required this.text,
  });

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Text'),
      content: TextField(
        controller: textController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await updateData(textController.text, widget.id!);

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
            // Close the dialog
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
