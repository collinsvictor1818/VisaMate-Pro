import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visamate/component/snacky.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/custom_button.dart';
import '../component/form_text.dart';
import '../component/password.dart';
import '../logic/provider/provider.dart';
import '../utils/responsive/mobile_body.dart';
import '../utils/user_controller.dart';
import 'forgot_password.dart';
import 'sign_up.dart';

class LogInUser extends ConsumerStatefulWidget {
  const LogInUser({Key? key});

  @override
  ConsumerState<LogInUser> createState() => _LogInUserState();
}

class _LogInUserState extends ConsumerState<LogInUser> {
  // final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final UserController userController = Get.find(); // Access the UserController
  final _identifierController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool _isLoggingIn = false;
  final _usernameRegex = RegExp(
      r'^[a-zA-Z0-9_]{6,}$'); // Allow alphanumeric characters and underscores, minimum 6 characters
  final _prefs = SharedPreferences.getInstance();

  bool _rememberPass = false;
void login() async {
  final String identifier = _identifierController.text.trim();
  final String password = _passwordController.text.trim();
  SnackBarHelper snacky = SnackBarHelper(context);

  if (password.isEmpty || identifier.isEmpty) {
    snacky.showSnackBar("Please Enter Both Username/Email and Password", isError: true);
    return;
  }

  try {
    final usersQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: identifier)
        .get();

    if (usersQuery.docs.isNotEmpty) {
      // Username exists, check password
      final userData = usersQuery.docs.first.data() as Map<String, dynamic>;
      final String fetchedPassword = userData['password'];
      if (fetchedPassword == password) {
        // Password matched, proceed with login
        final fetchUsername = userData['last_name']?.split(' ')[0] ?? '';
        final fetchPhone = userData['phone'] ?? '';

        // Update the UserController with user data
        userController.updateUserData(fetchUsername, fetchPhone);
        userController.fetchUserDataFromFirestore();

        // Successfully logged in, navigate to the dashboard
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MobileScaffold(username: fetchUsername)),
        );
        snacky.showSnackBar("Log In Successful", isError: false);
        _identifierController.clear();
        _passwordController.clear();
      } else {
        // Password does not match
        snacky.showSnackBar("Invalid Password", isError: true);
      }
    } else {
      // No matching username found, check email
      final emailQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: identifier)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        // Email exists, check password
        final userData = emailQuery.docs.first.data() as Map<String, dynamic>;
        final String fetchedPassword = userData['password'];
        if (fetchedPassword == password) {
          // Password matched, proceed with login
          final fetchUsername = userData['last_name']?.split(' ')[0] ?? '';
          final fetchPhone = userData['phone'] ?? '';

          // Update the UserController with user data
          userController.updateUserData(fetchUsername, fetchPhone);
          userController.fetchUserDataFromFirestore();

          // Successfully logged in, navigate to the dashboard
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MobileScaffold(username: fetchUsername)),
          );
          snacky.showSnackBar("Log In Successful", isError: false);
          _identifierController.clear();
          _passwordController.clear();
        } else {
          // Password does not match
          snacky.showSnackBar("Invalid Password", isError: true);
        }
      } else {
        // No matching user found with the provided credentials
        snacky.showSnackBar("Invalid Login Details", isError: true);
      }
    }
  } on FirebaseException catch (e) {
    snacky.showSnackBar("Firebase error: ${e.message}", isError: true);
  } catch (e) {
    // General error handling
    snacky.showSnackBar("An unexpected error occurred: ${e.toString()}", isError: true);
  }
}

//   final TextEditingController _identifierController = TextEditingController();
// final _passwordController = TextEditingController();
// final _formKey = GlobalKey<FormState>();
// final UserController userController = Get.find(); // Access the UserController
// final _auth = FirebaseAuth.instance;
// final _firestore = FirebaseFirestore.instance;
// bool _isLoggingIn = false;
// final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{6,}$'); // Allow alphanumeric characters and underscores, minimum 6 characters
// final _prefs = await SharedPreferences.getInstance(); // Get prefs instance

// Future<void> _saveUserInfoToPrefs(Map<String, dynamic> userData) async {
//   // Avoid saving password in SharedPreferences for security reasons
//   userData.remove('password'); // Remove password before saving

//   final prefs = await _prefs;
//   await prefs.setString('username', userData["username"]);
//   await prefs.setString('firstname', userData["first_name"]);
//   await prefs.setString('lastname', userData["last_name"]);
// }

  void _saveUserInfoToPrefs(Map<String, dynamic>? userData) async {
    if (userData != null) {
      // Remove password before saving
      userData.remove('password');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', userData["username"]);
      // ... store other user data (if needed)
    } else {
      // Handle the case where userData is null (optional)
    }
  }

  Future<void> _loginUser() async {
    setState(() {
      _isLoggingIn = true;
    });

    try {
      final identifier = _identifierController.text.trim();
      final password = _passwordController.text.trim();

      // Validate input fields
      if (password.isEmpty || identifier.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enter both identifier and password.')),
        );
        return;
      }

      // Determine login method based on identifier format
      if (_isValidEmail(identifier)) {
        // Email login
        await _auth.signInWithEmailAndPassword(
            email: identifier, password: password);
      } else if (_usernameRegex.hasMatch(identifier)) {
        // Username login
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: await _getUsernameEmail(
              identifier), // Fetch email associated with username
          password: password,
        );
        // Update user data if necessary (optional)
      } else {
        // Phone number login (not implemented yet)
        // TODO: Implement phone number login with Firebase Phone Auth
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Phone number login is not yet implemented.')),
        );
        return;
      }

      // User login successful, check if user data exists
      final user = await _auth.currentUser!;
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (docSnapshot.exists) {
        // User data exists, proceed with fetching data
        final userData = await _fetchUserData(user.uid);
        // userData.remove('password'); // Remove password before saving

        // Update user controller with user data (replace with your user management logic)
        // userController.updateUserData(userData['last_name']?.split(' ')[0] ?? '', userData['phone'] ?? '');
        // userController.fetchUserDataFromFirestore();

        _saveUserInfoToPrefs(userData); // Save user data to SharedPreferences

        // Navigate to the dashboard
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                MobileScaffold(username: userData?['username'] ?? ''),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        _identifierController.clear();
        _passwordController.clear();
      } else {
        // Handle user not found scenario
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('User data not found. Please contact support.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
          message = 'Invalid username or password.';
          break;
        case 'invalid-email':
          message = 'Invalid email format.';
          break;
        default:
          message = 'Login error: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

// ... other helper methods (_isValidEmail, _fetchUserData, _getUsernameEmail)

  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  Future<Map<String, dynamic>?> _fetchUserData(String uid) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!docSnapshot.exists) {
        return null; // Return null if user data not found
      }

      return docSnapshot.data() as Map<String, dynamic>;
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      // ... existing error handling
    }
  }

  Future<String> _getUsernameEmail(String username) async {
    try {
      final usersQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (usersQuery.docs.isEmpty) {
        throw Exception(
            'Username not found'); // Handle username not found error
      }

      final userData = usersQuery.docs.first.data() as Map<String, dynamic>;
      return userData['email'] ??
          ''; // Return email or empty string if not found
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      // Handle other exceptions (e.g., network errors)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error fetching username email: ${e.toString()}')),
      );
      rethrow; // Re-throw the exception for proper handling
    }
  }

  Future<String> _getPhoneEmail(String phonenumber) async {
    try {
      final usersQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phonenumber', isEqualTo: phonenumber)
          .get();

      if (usersQuery.docs.isEmpty) {
        throw Exception(
            'Phonenumber not found'); // Handle username not found error
      }

      final userData = usersQuery.docs.first.data() as Map<String, dynamic>;
      return userData['email'] ??
          ''; // Return email or empty string if not found
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      // Handle other exceptions (e.g., network errors)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error fetching username email: ${e.toString()}')),
      );
      rethrow; // Re-throw the exception for proper handling
    }
  }

// initState(){
//   Map<String, dynamic>? _userData;
//   // setState(){
//   //   _saveUserInfoToPrefs(_userData!);
//   // }
//   _saveUserInfoToPrefs(_userData!);
//   super.initState();
// }
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: 620,
            child:
             Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Image.asset('assets/visamate_logo_mark.png',
                        width: 200, height: 120),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Welcome back, Log in to continue',
                        style: TextStyle(
                          fontFamily: 'Gilmer',
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Material(
                    color: Theme.of(context).colorScheme.background,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          FormText(
                            prefix: Icons.account_circle_rounded,
                            // title: 'Username or PhoneNumber',
                            text: 'Username or E-Mail',
                            controller: _identifierController,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Enter Username';
                              }
                              return null;
                            },
                          ),
                          PassWord(
                            title: 'Enter Password',
                            text: 'Enter Password',
                            controller: _passwordController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FormButton(
                      text: 'Log In',
                      // action: login,
                      action: () async {
                        await ref
                            .read(loginStateProvider.notifier)
                            .logIn(_rememberMe);
                        login;
                      }),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 2),
                          checkColor: Theme.of(context).colorScheme.tertiary,
                          activeColor: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.08),
                          value: _rememberMe,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _rememberMe = newValue ?? false;
                            });
                          },
                        ),
                        Text(
                          'Save Password',
                          style: TextStyle(
                            fontFamily: 'Gilmer',
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an Account?',
                            style: TextStyle(
                              fontFamily: 'Gilmer',
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MobileSignUp(),
                                ),
                              );
                            },
                            child: Text(
                              ' Sign Up',
                              style: TextStyle(
                                fontFamily: 'Gilmer',
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'Gilmer',
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ),

    );
  }
}
