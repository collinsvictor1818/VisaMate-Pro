import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../component/appbar.dart';
import '../Account/edit_profile.dart';
import 'src/big_user_card.dart';
import 'src/icon_style.dart';
import 'src/settings_item.dart';
import 'src/settings_group.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Map<String, dynamic>? userData;
  final _prefs = SharedPreferences.getInstance();
  String? userName;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? displayName;
  final bool _isLogin = false;
  // Future _loadUserDataFromPrefs() async {
  //   final prefs = await _prefs;
  //   final String? usernamePrefs = prefs.getString('username');
  //   final String? firstNamePrefs = prefs.getString('first_name');
  //   final String? lastNamePrefs = prefs.getString('last_name');
  //   final String? phoneNumberPrefs = prefs.getString('phone');
  //   final String? emailPrefs = prefs.getString('email');
  //   if (usernamePrefs != null) {
  //     setState(() {
  //       // userData = (
  //       //   String? username = usernamePrefs
  //       // );
  //       userName = '@$usernamePrefs';
  //       firstName = firstNamePrefs;
  //       lastName = lastNamePrefs;
  //       phone = phoneNumberPrefs;
  //       email = emailPrefs;
  //       displayName = '$firstName $lastName';

  //       // String? userName = usernamePrefs;
  //     });
  //   } else {
  //     print('Error loading shared preferences to settings');
  //   }
  // }

  Future<void> _deleteAccountFromFirestore(String uid) async {
    // Replace with your actual Firestore reference logic
    final firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users').doc(uid);
    await userRef.delete(); // Delete user data from Firestore
  }

  Future<void> _deleteAccountFromAuth() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      await user.delete(); // Delete user from Firebase Authentication
    }
  }

  Future<void> _loadUserDataFromPrefs() async {
    final prefs = await _prefs;
    final String? usernamePrefs = prefs.getString('username');
    final String? firstNamePrefs = prefs.getString('first_name');
    final String? lastNamePrefs = prefs.getString('last_name');
    final String? phoneNumberPrefs = prefs.getString('phone');
    final String? emailPrefs = prefs.getString('email');
    if (usernamePrefs != null) {
      setState(() {
        userName = '@$usernamePrefs';
        firstName = firstNamePrefs;
        lastName = lastNamePrefs;
        phone = phoneNumberPrefs;
        email = emailPrefs;
        displayName = '$firstName $lastName';
      });
    } else {
      print('Error loading shared preferences to settings');
    }
  }

  Future<void> _handleAccountDeletion() async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Row(
          children: [
            Icon(Icons.privacy_tip_rounded,
                color: Theme.of(context).colorScheme.onBackground),
            Text(
              ' Confirm Account Deletion',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilmer',
                  fontSize: 18),
            )
          ],
        ),
        content: const Text(
            'Are you sure you want to delete your account? This action is irreversible.'),
        actions: [
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                  padding: EdgeInsets.all(4),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontFamily: 'Gilmer',
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ))),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Delete',
                      style: TextStyle(
                          fontFamily: 'Gilmer',
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onBackground)),
                ),
              )),
        ],
      ),
    );

    if (confirmed == true) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        try {
          await _deleteAccountFromFirestore(uid); // Delete Firestore data
          await _deleteAccountFromAuth(); // Delete user from Firebase Auth
          // await _prefs.clear(); // Clear shared preferences
          Navigator.of(context)
              .popUntil((route) => route.isFirst); // Pop back to login
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account deleted successfully.')),
          );
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting account: ${e.message}')),
          );
        }
      }
    }
  }

  Future<void> _signOut() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();

    // Clear user data from state or shared preferences (optional)
    setState(() {
      userName = null;
      firstName = null;
      lastName = null;
      phone = null;
      email = null;
      displayName = null;
    });
    // await _prefs.clear(); // Clear shared preferences

    Navigator.of(context)
        .popUntil((route) => route.isFirst); // Pop back to login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed out successfully.')),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserDataFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PopScope(
        canPop: true,
        onPopInvoked: (_isLogin) async {
          if (_isLogin = true) {
            final confirmed = await showDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                      icon: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.privacy_tip_rounded,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                          const Spacer(flex: 1)
                        ],
                      ),
                      content: const Text('Are you sure you want to sign out?'),
                      actions: [
                        Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                                padding: EdgeInsets.all(4),
                                child: TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontFamily: 'Gilmer',
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                ))),
                        Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text('Sign Out',
                                    style: TextStyle(
                                        fontFamily: 'Gilmer',
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                              ),
                            )),
                      ],
                    ));
          }
        },
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10).add(EdgeInsets.symmetric(horizontal: 10)),
          child: ListView(
            children: [
              // User card
              BigUserCard(
                // cardColor: Colors.red,
                userName: displayName ?? "Full Name",
                userMoreInfo: Column(
                  children: [
                    Text('$userName | $phone | $email' ?? 'user name'),
                    // Text(userName ?? 'user name'),
                    // Text(phone ?? 'phone number'),
                    // // Text(email??'e-mail'),
                    // Text(email ?? 'e-mail'),
                  ],
                ),
                userProfilePic: AssetImage("assets/visamate_splash.png"),
                cardActionWidget: SettingsItem(
                    icons: Icons.edit,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    iconStyle: IconStyle(
                      withBackground: true,
                      borderRadius: 50,
                      iconsColor: Theme.of(context).colorScheme.background,
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                    title: "Modify",
                    titleStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                    subtitle: "Tap to change your data",
                    subtitleStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                    }),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.pencil_outline,
                    iconStyle: IconStyle(),
                    title: 'Appearance',
                    subtitle: "Make VisaMatePro App yours",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(),
                    title: 'Dark mode',
                    subtitle: "Automatic",
                    trailing: Switch.adaptive(
                      activeColor: Theme.of(context).colorScheme.background,
                      // overlayColor: Colors.transparent,
                      // trackColor: Colors.transperent,
                      focusColor: Theme.of(context).colorScheme.tertiary,
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    title: 'About',
                    subtitle: "Learn more about the App",
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    onTap: _signOut,
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
                  ),
                  SettingsItem(
                    icons: CupertinoIcons.delete_solid,
                    onTap: () => _handleAccountDeletion(),

                    title: "Delete account",
                    // titleStyle: TextStyle(
                    //   color: Theme.of(context).colorScheme.tertiary,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    iconStyle: IconStyle(
                        iconsColor: Colors.red,
                        withBackground: false,
                        backgroundColor: Colors.red.withOpacity(0.05)),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
