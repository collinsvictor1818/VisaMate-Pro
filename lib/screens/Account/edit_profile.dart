import 'package:flutter/material.dart';

import '../../component/appbar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).colorScheme.background,appBar: const CustomAppBar(title: 'Edit Profile'), body: SafeArea(child: Container(),));
  }
}