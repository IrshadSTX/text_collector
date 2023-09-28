import 'package:flutter/material.dart';
import 'package:text_collector/model/db_functions.dart';

class EditDialog extends StatefulWidget {
  // final TextEditingController textController;
  final String text;
  const EditDialog({
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
      title: Text('Edit Text'),
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
            // await updateData(textController.toString());
            // Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
