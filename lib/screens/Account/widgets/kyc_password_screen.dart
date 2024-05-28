import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/form/CustomButton.dart';
import '../../../component/form_text.dart';
import '../logic/sign_up_backend.dart';

class Pass extends StatefulWidget {
  final TextEditingController passController;
  final TextEditingController passStrengthController;

  const Pass({
    Key? key,
    required this.passController,
    required this.passStrengthController,
  }) : super(key: key);

  @override
  State<Pass> createState() => _PassState();
}

class _PassState extends State<Pass> {
 int activeStep = 0;
  
      final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordStrengthController =
      TextEditingController();
      
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController _scroll = ScrollController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  bool _acceptTerms = false;

  final _userRegistrationService = UserRegistrationService();

  void _handleSignUpButton() async {
    
    final snacky = snackBarHelper.SnackBarHelper(context);
  // Get user data from your form fields
  final firstName = _firstNameController.text.trim();
  final lastName = _lastNameController.text.trim();
  final email = _emailController.text.trim();
  final phone = _phonenumberController.text.trim();
  final password = _passwordController.text.trim();
  final confirmPassword = _passwordStrengthController.text.trim();
  final acceptTerms = _acceptTerms; // Assuming this is a checkbox

  // Validate data (optional)
  // You can add checks for empty fields, email format, etc.

  await _userRegistrationService.signUp(context, 
      firstName, 
      lastName, 
      email, 
      phone, 
      password, 
      confirmPassword, 
      acceptTerms,
      // Pass required dependencies
      // auth: _auth, // Assuming you have an FirebaseAuth instance
      // snackBarHelper: snackBarHelper, // Assuming you have a SnackBarHelper instance
  );
}
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FormText(
              text: 'pass Name',
              desc: 'Your pass official name according to your passport',
              controller: widget.passController,
              prefix: Icons.person,
            ),
            FormText(
              text: 'passStrength Name',
              desc: 'Your third official name according to your passport',
              controller: widget.passStrengthController,
              prefix: Icons.person,
            ),  FormButton(
                                          text: 'Create Account',
                                          // action: _signUp,
                                          action: () => setState(() {
                                            // if (activeStep < 2)
                                            final snacky =
                                                snackBarHelper.SnackBarHelper(
                                                    context);

                                            String pass =
                                                widget.passController.text.trim();
                                            String confirm =
                                                widget.passStrengthController.text
                                                    .trim();

                                            if (pass.isEmpty &&
                                                confirm.isEmpty) {
                                              snacky.showSnackBar(
                                                  "Fill in all required details",
                                                  isError: true);
                                              return;
                                            }
                                            if (pass != confirm) {
                                              snacky.showSnackBar(
                                                  "Passwords don't match",
                                                  isError: true);
                                              return;
                                            } else {
                                              // activeStep++;
                                              _handleSignUpButton();
                                              // _signUp();
                                            }
                                          }),
                                        ),
                                                                            
          ],
        ),
      ),
    );
  }
}
