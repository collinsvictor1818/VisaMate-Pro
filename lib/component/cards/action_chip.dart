import 'package:flutter/material.dart';

class ChipCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? shortDescription;
  final VoidCallback? onClicked;

  const ChipCard(
      {this.imageUrl, this.title, this.shortDescription, this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 2.0),
      child: GestureDetector(
          onTap: onClicked,
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:3.0),
                      child: Icon(
                        Icons.info_outlined,
                        size: 14,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    // Gap(),
                    // Spacer(flex: 1),
                    Text(title??'Item')
                  ],
                ),
              ))),
    );
  }
}
