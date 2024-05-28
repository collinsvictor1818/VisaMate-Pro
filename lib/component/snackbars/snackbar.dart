import 'package:flutter/material.dart';

class ScrollableSnackbar extends StatelessWidget {
  final String message;

  const ScrollableSnackbar({ required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context, String message) {
   ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    content: Text('Snackbar message'),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        right: 20,
        left: 20),
  ));
  }
}
