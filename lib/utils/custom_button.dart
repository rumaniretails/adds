import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final String label;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await onPressed();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label executed successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow, // Button background color
          foregroundColor: Colors.black, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
          elevation: 5, // Shadow effect
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
