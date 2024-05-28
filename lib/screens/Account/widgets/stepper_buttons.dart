import 'package:flutter/material.dart';

import '../../../component/form_text.dart';

class StepperButton extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const StepperButton({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
                                    // height: 200,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FormText(
              text: 'First Name',
              desc: 'Your first official name according to your passport',
              controller: firstNameController,
              prefix: Icons.person,
            ),
            FormText(
              text: 'Last Name',
              desc: 'Your third official name according to your passport',
              controller: lastNameController,
              prefix: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
