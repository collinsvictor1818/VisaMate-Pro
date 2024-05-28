import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PasswordField extends StatefulWidget {
  final String text;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? onClicked;
  final VoidCallback? generatePass;
  final String? label;

  const PasswordField({
    required this.text,
    this.hint,
    this.controller,
    this.generatePass,
    this.prefix,
    this.suffix,
    this.onClicked,
    this.label,
    required String title,
  });

  @override
  State<PasswordField> createState() => _FormTextState();
}

class _FormTextState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    bool obscureText = true;

    late String password;
  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }


    void _dispose() {
      widget.controller?.dispose();
      super.dispose();
    }

    final Color eye;
    bool visiblePassword = false;

    return Column(
      children: [
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     widget.text,
        //     textAlign: TextAlign.start,
        //     textDirection: TextDirection.ltr,
        //     style: TextStyle(
        //       fontSize: 14,
        //       color:Theme.of(context).colorScheme.secondary,
        //       fontFamily: "Gilmer",
        //       fontWeight: FontWeight.w700,
        //     ),
        //   ),
        // ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 0)),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: FancyPasswordField(
                  obscuringCharacter: '*',
                  obscureText: obscureText,
                  strengthIndicatorBuilder: (strength) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: StepProgressIndicator(
                        totalSteps: 8,
                        currentStep: getStep(strength),
                        selectedColor: getColor(strength)!,
                        unselectedColor:
                            Theme.of(context).colorScheme.secondary!,
                      ),
                    );
                  },
                  validationRuleBuilder: (rules, value) {return const Padding(padding: EdgeInsets.zero,);},
//                     return Wrap(
//                       // runSpacing: 8,
//                       spacing: 4,
                      // children: rules.map(
                      //   (rule) {
                      //     final ruleValidated = rule.validate(value);
//                           return Chip(
//                               side: BorderSide(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onBackground),
// // color: Theme.of(context).colorScheme.onBackground,
// // shape: const OutlinedBorder(side: BorderSide.none)
//                               label: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   if (ruleValidated) ...[
//                                     const Icon(
//                                       Icons.check,
//                                       color: Color(0xFF00FF62),
//                                     ),
//                                     const SizedBox(width: 8),
//                                   ],
//                                   Text(
//                                     rule.name,
//                                     style: TextStyle(
//                                         fontFamily: "Gilmer",
//                                         fontWeight: FontWeight.w700,
//                                         color: ruleValidated
//                                             ? const Color(0xFF00FF62)
//                                             : Color.fromARGB(255, 255, 38, 38)),
//                                   ),
//                                 ],
//                               ),
//                               backgroundColor: ruleValidated
//                                   ? const Color(0xFF00FF62).withOpacity(0.05)
//                                   : Color.fromARGB(255, 255, 0, 0)
//                                       .withOpacity(0.01));
//                         },
//                       ).toList(),
                    // );
                    // return Row(

                    //   children: [
                    //     Padding(
                    //         padding: EdgeInsets.all(5),
                    //         child: Text(
                    //           'Accuracy',
                    //           style: TextStyle(
                    //               color: Theme.of(context)
                    //                   .colorScheme
                    //                   .onBackground,
                    //               fontWeight: FontWeight.w700),
                    //         )),
                    //     Padding(
                    //         padding: EdgeInsets.all(5),
                    //         child: Text(
                    //           '${}',
                    //           style: TextStyle(
                    //               color: Theme.of(context)
                    //                   .colorScheme
                    //                   .onBackground,
                    //               fontWeight: FontWeight.w700),
                    //         ))
                    //   ],

                  // },
                  validationRules: {
                    DigitValidationRule(),
                    UppercaseValidationRule(),
                    LowercaseValidationRule(),
                    SpecialCharacterValidationRule(),
                    MinCharactersValidationRule(6),
                    MaxCharactersValidationRule(12),
                  },
                  decoration: InputDecoration(
                    focusColor: Theme.of(context).colorScheme.tertiary,
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.key_rounded,
                        size: 18,
                        color: Theme.of(context).colorScheme.tertiary),
                                   suffixIcon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.remove_red_eye_rounded : Icons.remove_red_eye_outlined,
                      size: 20,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    onPressed: _toggle, // Call _toggle function here
                                    ),
                     fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2,
                      ),
                    ),
                    hintText: widget.text ?? "Password",
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontFamily: "Gilmer",
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).hintColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 0),
                    ),
                  ),
                  showPasswordIcon: Icon(Icons.password,
                      color: Theme.of(context).colorScheme.tertiary),
                         validator: (val) =>
                      val!.length < 6 ? 'Password too short.' : null,
                  onSaved: (val) => password = val!,
               controller: widget.controller,
                ),
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
      ],
    );
  }

  int getStep(double strength) {
    if (strength == 0) {
      return 0;
    } else if (strength < .1) {
      return 1;
    } else if (strength < .2) {
      return 2;
    } else if (strength < .3) {
      return 3;
    } else if (strength < .4) {
      return 4;
    } else if (strength < .5) {
      return 5;
    } else if (strength < .6) {
      return 6;
    } else if (strength < .7) {
      return 7;
    }
    return 8;
  }

  Color? getColor(double strength) {
    if (strength == 0) {
      return Theme.of(context).colorScheme.secondary;
    } else if (strength < .1) {
      return Colors.red;
    } else if (strength < .2) {
      return Colors.red;
    } else if (strength < .3) {
      return Colors.yellow;
    } else if (strength < .4) {
      return Theme.of(context).colorScheme.tertiary;
    } else if (strength < .5) {
      return Theme.of(context).colorScheme.tertiary;
    } else if (strength < .6) {
      return Color(0xFF00FF62);
    } else if (strength < .7) {
      return Color(0xFF00FF62);
    }
    return Color(0xFF00FF62);
  }
}
