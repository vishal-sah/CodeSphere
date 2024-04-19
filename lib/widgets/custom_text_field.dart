import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final int maxLines;
  final Function(String) onChanged;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.maxLines = 1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.01),
          child: Text(labelText),
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            errorStyle: const TextStyle(color: Colors.redAccent),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            border: const OutlineInputBorder(),
          ),
          maxLines: maxLines,
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$labelText is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
