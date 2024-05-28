import 'package:flutter/material.dart';

import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/form_text.dart';

class Names extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const Names({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
  }) : super(key: key);

  @override
  State<Names> createState() => _NamesState();
}

class _NamesState extends State<Names> {
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
              text: 'First Name',
              desc: 'Your first official name according to your passport',
              controller: widget.firstNameController,
              prefix: Icons.person,
            ),
            FormText(
              text: 'Last Name',
              desc: 'Your third official name according to your passport',
              controller: widget.lastNameController,
              prefix: Icons.person,
            ),SizedBox(
                                            width: 280,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () => setState(() {
                                                            if (activeStep > 0)
                                                              activeStep--;
                                                          }),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: ConstrainedBox(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight: 50,
                                                                  minHeight: 50,
                                                                  maxWidth: 125,
                                                                  minWidth:
                                                                      120),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .tertiary
                                                                    .withOpacity(
                                                                        0.08),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Center(
                                                                  child: Text(
                                                                      'Previous',
                                                                      style: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .tertiary,
                                                                          fontSize:
                                                                              18))),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                  GestureDetector(
                                                    onTap: () => setState(() {
                                                      final snacky =
                                                          snackBarHelper
                                                              .SnackBarHelper(
                                                                  context);

                                                      String last =
                                                          widget.lastNameController
                                                              .text
                                                              .trim();
                                                      String first =
                                                          widget.firstNameController
                                                              .text
                                                              .trim();

                                                      if (last.isEmpty &&
                                                          first.isEmpty) {
                                                        snacky.showSnackBar(
                                                            "Fill in all required details",
                                                            isError: true);
                                                        return;
                                                      }
                                                      if (last.isEmpty &&
                                                          first.isEmpty) {
                                                        snacky.showSnackBar(
                                                            "Fill in all required details",
                                                            isError: true);
                                                        return;
                                                      } else if (last.isEmpty) {
                                                        snacky.showSnackBar(
                                                            "Fill in your last name",
                                                            isError: true);
                                                        return;
                                                      } else if (first
                                                          .isEmpty) {
                                                        snacky.showSnackBar(
                                                            "Fill in your first name",
                                                            isError: true);
                                                        return;
                                                      } else {
                                                        activeStep++;
                                                      }
                                                    }),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: ConstrainedBox(
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxHeight: 50,
                                                                minHeight: 50,
                                                                maxWidth: 125,
                                                                minWidth: 120),
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .tertiary
                                                                    .withOpacity(
                                                                        0.08),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Center(
                                                                  child: Text(
                                                                      'Next',
                                                                      style: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .tertiary,
                                                                          fontSize:
                                                                              18))),
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
