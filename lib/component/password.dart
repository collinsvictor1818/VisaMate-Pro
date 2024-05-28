import 'package:flutter/material.dart';

class PassWord extends StatefulWidget {
  final String text;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? onClicked;
  final VoidCallback? generatePass;
  final String? label;

  const PassWord({
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
  State<PassWord> createState() => _FormTextState();
}

class _FormTextState extends State<PassWord> {
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
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontFamily: "Gilmer",
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground),
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    focusColor: Theme.of(context).colorScheme.tertiary,
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.key_rounded,
                        size: 20,
                        color: Theme.of(context).colorScheme.tertiary),
                  suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.remove_red_eye_rounded : Icons.remove_red_eye_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      onPressed: _toggle,
                    ),  fillColor: Theme.of(context).colorScheme.secondary,
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
                  validator: (val) =>
                      val!.length < 6 ? 'Password too short.' : null,
                  onSaved: (val) => password = val!,
                  // obscureText: visiblePassword,
                  obscureText: obscureText,
                  obscuringCharacter: "*",
                  controller: widget.controller,
                ),
              ),
              // const Opacity(
              //   opacity: 1,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 10),
              //     child: Row(
              //       children: [
              //         Text(
              //           'Click the ',
              //           style: TextStyle(
              //             fontFamily: 'Gilmer',
              //             fontWeight: FontWeight.w700,
              //             fontSize: 10,
              //             color: AppColor.orange
              //           ),
              //         ),
              //         Icon(Icons.password_rounded, size: 14, color: AppColor.orange),
              //         Text(
              //           ' Icon to generate Password',
              //           style: TextStyle(
              //             fontFamily: 'Gilmer',
              //             fontWeight: FontWeight.w700,
              //             fontSize: 10,
              //             color: AppColor.orange
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
      ],
    );
  }
}
