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
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 260.0,
              maxWidth: 304.0,
              minHeight: 50,
              maxHeight: 50
            ),
            child: Stack(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.onTertiary
                        // : Theme.of(context).buttonTheme.,
                  ),
                  child: Center(
                    child: Text(
                      widget.text ?? '',
                      style: TextStyle(
                        fontFamily: 'Gilmer',
                        fontSize: 18,
                        color:  Theme.of(context).colorScheme.background
,                        fontWeight: FontWeight.w800,
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
