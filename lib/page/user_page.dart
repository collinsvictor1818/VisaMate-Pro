import 'package:flutter/material.dart';
import '../../../styles/pallete.dart';
class UserPage extends StatelessWidget {
  final String name;
  final String urlImage;

  const UserPage({
    required Key key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(name),
          centerTitle: true,
        ),
        body: Image.network(
          urlImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
}
