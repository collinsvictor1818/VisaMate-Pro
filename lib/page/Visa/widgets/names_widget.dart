import 'package:flutter/material.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/form_text.dart';

class NameWidget extends StatefulWidget {
  const NameWidget(BuildContext? context);

  @override
  State<NameWidget> createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  @override
  Widget build(BuildContext context) {
    return _nameWidget(context);
  }

Widget _nameWidget(BuildContext context) {
  int activeStep = 0;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        FormText(
          text: 'First Name',
          desc: 'Your first official name according to your passport',
          controller: _firstNameController,
        ),
        FormText(
          text: 'Middle Name',
          desc: 'Your second official name according to your passport',
          controller: _middleNameController,
        ),
        FormText(
          text: 'Last Name',
          controller: _lastNameController,
          desc: 'Your third official name according to your passport',
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (activeStep > 0) {
                  setState(() {
                    activeStep--;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0).add(const EdgeInsets.symmetric(horizontal: 4)),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 50,
                    minHeight: 50,
                    maxWidth: 144,
                    minWidth: 100,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Previous',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final String last = _lastNameController.text;
                final String first = _firstNameController.text;
                final String middle = _middleNameController.text;
                final snacky = snackBarHelper.SnackBarHelper(context);

                if (last.isEmpty && first.isEmpty && middle.isEmpty) {
                  snacky.showSnackBar("Fill in all details", isError: true);
                  return;
                } else if (first.isEmpty) {
                  snacky.showSnackBar("Fill in your first name", isError: true);
                  return;
                } else if (middle.isEmpty) {
                  snacky.showSnackBar("Fill in your middle name", isError: true);
                  return;
                } else if (last.isEmpty) {
                  snacky.showSnackBar("Fill in your last name", isError: true);
                  return;
                } else if (activeStep < 2) {
                  setState(() {
                    activeStep++;
                  });
                } else {
                  return;
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 50,
                    minHeight: 50,
                    maxWidth: 144,
                    minWidth: 100,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}