import 'dart:math';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../component/alert.dart';
import '../../log_in_page.dart';

class UserRegistrationService {
  // get auth => null;

  // Existing methods
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

  // New method for signup functionality
  Future<void> signUp(
    BuildContext context,
    // Add all the required user data as parameters
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
    String confirmPassword,
    bool acceptTerms,
    // Add any other dependencies like Firebase instances or snackbar helper
    // FirebaseAuth auth,
    // SnackBarHelper
  ) async {
    final snacky = snackBarHelper.SnackBarHelper(context);
    // final snacky = snackBarHelper;

    if (confirmPassword != password) {
      snacky.showSnackBar("Passwords do not match", isError: true);
      return;
    }

    if (!acceptTerms) {
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
      // Generate a password (if needed)
      // ... (Remove this section if you're not generating a password)

      // Add the user's data to the database
      await FirebaseFirestore.instance.collection("users").add({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'username': generateUsername(
            firstName, lastName), // Call username generation method
        'password': password, // Use provided password if not generating
        'terms_accepted': acceptTerms,
      });

      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      // final UserCredential userCredential =
      //     await auth.createUserWithEmailAndPassword(
      //   email: email.trim(),
      //   password: password,
      // );
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      // Send the password to the user's WhatsApp account (if applicable)
      // ... (Implement WhatsApp integration if needed)

      // Navigate to the login screen
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LogInUser()));

      Alert.show(
        context,
        title: 'Username',
        message:
            generateUsername(firstName, lastName), // Display generated username
        isError: true,
      );
    } catch (e) {
      snacky.showSnackBar("An error occurred: $e", isError: true);
      print("An error occurred: $e");
    }
  }

  // Method to generate username (optional)
  String generateUsername(String firstName, String lastName) {
    const String capitalLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String smallLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';

    final random = Random.secure();

    final initials =
        (firstName.isNotEmpty ? firstName.substring(0, 1).toLowerCase() : '') +
            (lastName.isNotEmpty ? lastName.substring(0, 1).toLowerCase() : '');

    final code =
        List.generate(4, (index) => numbers[random.nextInt(numbers.length)])
            .join();

    return '$initials$code';
  }
}
