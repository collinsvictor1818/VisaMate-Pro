import 'dart:math';
import 'package:validation_pro/validate.dart';
import 'package:visamate/screens/term_&_conditions.dart';
import 'package:visamate/utils/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/alert.dart';
import '../component/custom_button.dart';
import '../component/form_text.dart';
import '../component/password.dart';
import '../component/password_field.dart';
import '../component/phone_field.dart';
import 'log_in_page.dart';
import 'package:im_stepper/stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import 'package:firebase_auth/firebase_auth.dart';

class MobileSignUp extends StatefulWidget {
  const MobileSignUp();

  @override
  State<MobileSignUp> createState() => _MobileSignUpState();
}

class _MobileSignUpState extends State<MobileSignUp> {
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

  Future<bool> doesUsernameExist(String username) async {
    try {
      final users = FirebaseFirestore.instance.collection("users");
      final usernameQuery = users.where("username", isEqualTo: username);
      final usernameSnapshot = await usernameQuery.get();
      return usernameSnapshot.size > 0;
    } catch (e) {
      print("Error checking username existence: $e");
      return false;
    }
  }

  Future<bool> doesPhoneNumberExist(String phone) async {
    try {
      final users = FirebaseFirestore.instance.collection("users");
      final phoneQuery = users.where("phone", isEqualTo: phone);
      final phoneSnapshot = await phoneQuery.get();
      return phoneSnapshot.size > 0;
    } catch (e) {
      print("Error checking phone number existence: $e");
      return false;
    }
  }

  void _signUp() async {
    final snacky = snackBarHelper.SnackBarHelper(context);
    final generatedPassword = generatePassword();

    // final String username = '$_usernameController.text.trim(),$_usernameController.text.trim()';
    final String firstname = _firstNameController.text.trim();
    final String initials =
        firstname.isNotEmpty ? firstname.substring(0, 1).toLowerCase() : '';
    // final String middlename = _middleNameController.text.trim();
    final String lastname = _lastNameController.text.trim();

    final String code = generatedPassword.substring(0, 4);

    final String username = '$initials$lastname$code';
    final String email = _emailController.text.trim();
    final String phone = _phonenumberController.text.trim();
    final String confirmPassword = _passwordStrengthController.text.trim();
    final String password = _passwordController.text.trim();

    if (confirmPassword != password) {
      snacky.showSnackBar("Passwords do not match", isError: true);
      return;
    }

    if (!_acceptTerms) {
      snacky.showSnackBar("Accept the terms and conditions to Log in",
          isError: true);
      return;
    }

    if (await doesPhoneNumberExist(phone)) {
      snacky.showSnackBar("Phone number exists, use a different one",
          isError: true);
      return;
    }

    try {
      // Generate a password

      // Add the user's data to the database
      await FirebaseFirestore.instance.collection("users").add({
        'first_name': firstname,
        // 'middle_name': middlename,
        'last_name': lastname,
        'email': email,
        'phone': phone,
        'username': username,
        'password': password,
        'terms_accepted': _acceptTerms,
      });
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Send the password to the user's WhatsApp account
      await launchUrl(Uri.parse(
          'https://wa.me/0$phone/?text=${Uri.encodeComponent('Your VisaMatePro Account username is: \n\n *$username*\n\nSave it for future logins')}'));

      // Navigate to the login screen
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LogInUser()));

      Alert.show(
        context,
        title: 'Username',
        message: username,
        isError: true,
      );
    } catch (e) {
      snacky.showSnackBar("An error occurred: $e", isError: true);
      print("An error occurred: $e");
    }
  }

  String generatePassword() {
    const String capitalLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String smallLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String specialCharacters = '!@#\$%^&*()_-+=<>?';
    const String numbers = '0123456789';

    const String passwordString =
        '$capitalLetters$smallLetters$specialCharacters$numbers';

    final random = Random.secure();

    final capitalLetter = capitalLetters[random.nextInt(capitalLetters.length)];
    final smallLetter = smallLetters[random.nextInt(smallLetters.length)];
    final specialCharacter =
        specialCharacters[random.nextInt(specialCharacters.length)];
    final numbersList = List.generate(7, (index) {
      final randomIndex = random.nextInt(numbers.length);
      return numbers[randomIndex];
    });
    numbersList.shuffle(random);

    final passwordComponents = <String>[
      capitalLetter,
      smallLetter,
      specialCharacter,
      ...numbersList
    ];
    passwordComponents.shuffle(random);

    final password = passwordComponents.join();

    return password;
  }

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
                          IconStepper(
                            icons: [
                              Icon(
                                Icons.person,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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
                            lineColor: Theme.of(context).colorScheme.tertiary,
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
                                      FormText(
                                        text: 'First Name',
                                        desc:
                                            'Your first official name according to your passport',
                                        controller: _firstNameController,
                                        prefix: Icons.person,
                                      ),
                                      FormText(
                                        text: 'Last Name',
                                        controller: _lastNameController,
                                        prefix: Icons.person,
                                        desc:
                                            'Your third official name according to your passport',
                                      ),
                                      SizedBox(
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
                                                      _lastNameController
                                                          .text
                                                          .trim();
                                                  String first =
                                                      _firstNameController
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
                                // Contacts
                                Expanded(
                                  // height: 160,
                                  child: Column(
                                    children: [
                                      FormText(
                                        text: 'E-Mail Address',
                                        desc: 'Your Email Address',
                                        controller: _emailController,
                                        prefix: Icons.email,
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              !Validate.isEmail(value)) {
                                            return "Enter a valid email address";
                                          }
                                          return null;
                                        },
                                      ),
                                      PhoneField(
                                        prefix: Icons.phone_iphone_rounded,
                                        title: 'Enter PhoneNumber',
                                        text: 'Enter PhoneNumber',
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please Enter PhoneNumber';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        controller: _phonenumberController,
                                      ),
                                      SizedBox(
                                        width: 280,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                  onTap: () => setState(() {
                                                        if (activeStep > 0)
                                                          activeStep--;
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
                                                                  'Previous',
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .tertiary,
                                                                      fontSize:
                                                                          18))),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                              GestureDetector(
                                                // onTap: () {
                                                //   if (isAnySelectionMade()) {
                                                //     setState(() {
                                                //       if (activeStep < 2) activeStep++;
                                                //     });
                                                //   } else {
                                                //     ScaffoldMessenger.of(context)
                                                //         .showSnackBar(const SnackBar(
                                                //       content: Text(
                                                //           'Please select at least one member.'),
                                                //     ));
                                                //   }
                                                // },
                                                onTap: () => setState(() {
                                                  // if (activeStep < 2)
                                                  final snacky = snackBarHelper
                                                      .SnackBarHelper(context);

                                                  String phone =
                                                      _phonenumberController
                                                          .text
                                                          .trim();
                                                  String email =
                                                      _emailController.text
                                                          .trim();

                                                  if (phone.isEmpty &&
                                                      email.isEmpty) {
                                                    snacky.showSnackBar(
                                                        "Fill in all required details",
                                                        isError: true);
                                                    return;
                                                  } else {
                                                    activeStep++;
                                                  }
                                                }),

                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
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
                                                                      color: Theme.of(
                                                                              context)
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
                                // Password
                                Expanded(
                                  // height: 150,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        PasswordField(
                                          title: 'Create a Password',
                                          text: 'Enter Password',
                                          controller:
                                              _passwordStrengthController,
                                        ),
                                        PassWord(
                                          text: 'Confirm Password',
                                          controller: _passwordController,
                                          prefix: Icons.key_rounded,
                                          title: '',
                                        ),
                                        FormButton(
                                          text: 'Create Account',
                                          // action: _signUp,
                                          action: () => setState(() {
                                            // if (activeStep < 2)
                                            final snacky =
                                                snackBarHelper.SnackBarHelper(
                                                    context);

                                            String pass =
                                                _passwordController.text.trim();
                                            String confirm =
                                                _passwordStrengthController.text
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
                                              _signUp();
                                            }
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Terms & Conditions
                          Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
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
