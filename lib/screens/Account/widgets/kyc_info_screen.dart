import 'package:flutter/material.dart';

import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/form_text.dart';

class Info extends StatefulWidget {
  final TextEditingController phonenumberController;
  final TextEditingController emailController;

  const Info({
    Key? key,
    required this.phonenumberController,
    required this.emailController,
  }) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FormText(
              text: 'phone Name',
              desc: 'Your phone official name according to your passport',
              controller: widget.phonenumberController,
              prefix: Icons.person,
            ),
            FormText(
              text: 'email Name',
              desc: 'Your third official name according to your passport',
              controller: widget.emailController,
              prefix: Icons.person,
            ),
            SizedBox(
              width: 280,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () => setState(() {
                              if (activeStep > 0) activeStep--;
                            }),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxHeight: 50,
                                minHeight: 50,
                                maxWidth: 125,
                                minWidth: 120),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text('Previous',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            fontSize: 18))),
                              ),
                            ),
                          ),
                        )),
                    GestureDetector(
                      onTap: () => setState(() {
                        final snacky = snackBarHelper.SnackBarHelper(context);

                        String email = widget.emailController.text.trim();
                        String phone = widget.phonenumberController.text.trim();

                        if (email.isEmpty && phone.isEmpty) {
                          snacky.showSnackBar("Fill in all required details",
                              isError: true);
                          return;
                        }
                        if (email.isEmpty && phone.isEmpty) {
                          snacky.showSnackBar("Fill in all required details",
                              isError: true);
                          return;
                        } else if (email.isEmpty) {
                          snacky.showSnackBar("Fill in your email name",
                              isError: true);
                          return;
                        } else if (phone.isEmpty) {
                          snacky.showSnackBar("Fill in your phone name",
                              isError: true);
                          return;
                        } else {
                          activeStep++;
                        }
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 50,
                              minHeight: 50,
                              maxWidth: 125,
                              minWidth: 120),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text('Next',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            fontSize: 18))),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
