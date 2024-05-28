import 'package:flutter/material.dart';
import 'package:visamate/component/appbars/CustomAppBar.dart';

class Notifications extends StatelessWidget {
  const Notifications();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar(title: 'Notifications') ,body: const Center(child: Text('No Notifications'),),);
  }
}