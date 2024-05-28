import 'package:flutter/material.dart';

class FormButton extends StatefulWidget {
  final String? text;
  final VoidCallback? action;
  final bool isLoading;

  const FormButton({
    
    this.text,
    this.action,
    this.isLoading = false,
  });

  @override
  _FormButtonState createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isLoading) {
          widget.action?.call();
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0)
              .add(const EdgeInsets.symmetric(vertical: 7)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 260.0,
              maxWidth: 304.0,
            ),
            child: Stack(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:  Theme.of(context).colorScheme.onTertiary,
                  ),
                  child: Center(
                    child: Text(
                      widget.text ?? '',
                      style: TextStyle(
                        fontFamily: 'Gilmer',
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                if (widget.isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.background,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.background),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
