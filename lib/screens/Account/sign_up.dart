
import 'package:visamate/screens/Account/widgets/kyc_name_screen.dart';
import 'package:visamate/screens/term_&_conditions.dart';
import 'package:flutter/material.dart';
import '../log_in_page.dart';
import 'package:im_stepper/stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import 'package:firebase_auth/firebase_auth.dart';

import 'logic/sign_up_backend.dart';
import 'widgets/kyc_info_screen.dart';
import 'widgets/kyc_password_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp();

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  int activeStep = 0;
  final _userRegistrationService = UserRegistrationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: 620,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.asset('assets/visamate_logo_mark.png',
                          width: 280, height: 120),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          'Create User Account to Log In',
                          style: TextStyle(
                            fontFamily: 'Gilmer',
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 365,
                      child: Column(
                        children: [
                          // Stepper Widget
                          Expanded(
                            child: IconStepper(
                              icons: [
                                Icon(
                                  Icons.person,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                Icon(Icons.phone,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                Icon(Icons.password,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground)
                              ],
                              scrollingDisabled: true,
                              steppingEnabled: false,
                              enableStepTapping: false,
                              lineLength: 25,
                              stepRadius: 15,
                              stepPadding: 0.0,
                            
                              // numbers: const [1, 2, 3] ,
                              lineColor:
                                  Theme.of(context).colorScheme.tertiary,
                              activeStepColor:
                                  Theme.of(context).colorScheme.tertiary,
                              activeStepBorderColor:
                                  Theme.of(context).colorScheme.tertiary,
                              stepColor: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(.15),
                              activeStep: activeStep,
                              onStepReached: (index) {
                                setState(() {
                                  activeStep = index;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 400,
                            // Stepper Widget
                            child: IndexedStack(
                              index: activeStep,
                              children: [
                                // Name
                                SingleChildScrollView(
                                  controller: _scroll,
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Names(
                                        firstNameController:
                                            _firstNameController,
                                        lastNameController:
                                            _lastNameController,
                                      )
                                    ],
                                  ),
                                ),
                                // Contacts
                                Expanded(
                                  // height: 160,
                                  child: Column(
                                    children: [
                                      Info(
                                        phonenumberController:
                                            _phonenumberController,
                                        emailController: _emailController,
                                      )
                                    ],
                                  ),
                                ),
                                // Password
                                Expanded(
                                  // height: 150,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        Pass(
                                          passController: _passwordController,
                                          passStrengthController:
                                              _passwordStrengthController,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Terms & Conditions
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  // visualDensity: VisualDensity.compact,
                          
                                  activeColor: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(0.08),
                                  checkColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  value: _acceptTerms,
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      width: 2),
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _acceptTerms = newValue ?? false;
                                    });
                                  },
                                ),
                                Text(
                                  'I accept, ',
                                  style: TextStyle(
                                    fontFamily: 'Gilmer',
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    TermsAndConditionsDialog.show(context);
                                  },
                                  child: Text(
                                    'the terms and conditions',
                                    style: TextStyle(
                                      fontFamily: 'Gilmer',
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      decorationThickness: 1.5,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Log in route
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an Account?',
                                    style: TextStyle(
                                      fontFamily: 'Gilmer',
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LogInUser()));
                                    },
                                    child: Text(
                                      ' Log In',
                                      style: TextStyle(
                                        fontFamily: 'Gilmer',
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
