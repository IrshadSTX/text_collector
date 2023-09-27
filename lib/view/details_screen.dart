import 'package:flutter/material.dart';

class TextEditPage extends StatelessWidget {
  final String text;

  const TextEditPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Mode',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      // Implement copy functionality here
                      // You can use Flutter's Clipboard class
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Implement share functionality here
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
          TextFormField(
            initialValue: text,
            maxLines: null, // Allows unlimited lines
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
