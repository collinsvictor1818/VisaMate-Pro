import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visamate/screens/log_in_page.dart';
import 'package:visamate/screens/sign_up.dart';
import 'package:visamate/utils/responsive/mobile_body.dart';
import 'package:visamate/utils/responsive/members_view.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_social_button/flutter_social_button.dart';
import '../component/custom_button.dart';
import 'package:location/location.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen();

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

Location location = new Location();
// LocationData _locationData;
Position? _currentPosition;

final _geolocator = GeolocatorPlatform.instance;
final _prefs = SharedPreferences.getInstance();
LocationData _locationData = LocationData.fromMap({});
bool _serviceEnabled = false;

class _ChoiceScreenState extends State<ChoiceScreen> {
  Future<void> _loadLocationFromPrefs() async {
    final prefs = await _prefs;
    final double? latitude = prefs.getDouble('latitude');
    final double? longitude = prefs.getDouble('longitude');
    if (latitude != null && longitude != null) {
      setState(() {
        _currentPosition = Position(
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      });
    } else {
      // If no location is loaded, set a default position
      setState(() {
        _currentPosition = Position(
          latitude: 0.0,
          longitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        print("Current Position set: $_currentPosition");
      });
    }
  }

  @override
  void initState() {
    // _checkLocationPermission();
    _loadLocationFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Passport.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.background.withOpacity(0),
                    Theme.of(context).colorScheme.background
                  ],
                  begin: Alignment.topCenter,
                  stops: [0.0, 1])),
          child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 10.0,
                right: 10.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0)
                          .add(const EdgeInsets.symmetric(vertical: 5)),
                      child: Image.asset('assets/visamate_logo_mark.png',
                          width: 150, height: 100),
                    ),
                    // Text('Welcome to Visa Mate Pro'),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Center(
                    //     child: SizedBox(
                    //       width: 400,
                    //       child: Text(
                    //         'Welcome back, Log in to continue',
                    //         style: TextStyle(
                    //           fontFamily: 'Gilmer',
                    //           fontSize: 15,
                    //           color: Theme.of(context).colorScheme.onBackground,
                    //           fontWeight: FontWeight.w800,
                    //         ),
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Column(
                      children: [
                        SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              //  FormButton(
                              //   text: 'Log In',
                              //   action:() {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInUser()));
                              //   },
                              // ),
                              // FormButton(
                              //   text: 'Proceed as a guest',
                              //   action:() {
                              //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => MembersView()));
                              //   },
                              // ),
                              Text('Welcome to VisaMate Pro'),

                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LogInUser()));
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0)
                                        .add(const EdgeInsets.symmetric(
                                            vertical: 7)),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiary,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Log In',
                                                style: TextStyle(
                                                  fontFamily: 'Gilmer',
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MobileScaffold()));
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0)
                                        .add(const EdgeInsets.symmetric(
                                            vertical: 7)),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary
                                                  .withOpacity(0.1),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                  fontFamily: 'Gilmer',
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // FormButton(
                              //   text: 'Log In',
                              //   action: (){
                              //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInUser()));
                              //   },
                              // ),
                              // Spacer(flex: 1),
                              Gap(10),
                              Row(children: [
                                Divider(color: Theme.of(context).hintColor),
                                Text('Sign in using',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor)),
                                Divider(color: Theme.of(context).hintColor)
                              ]),

                              Row(children: [
                                FlutterSocialButton(
                                  onTap: () {},
                                  buttonType: ButtonType
                                      .facebook, // Button type for different type buttons
                                ),
                                FlutterSocialButton(
                                  onTap: () {},
                                  buttonType: ButtonType
                                      .facebook, // Button type for different type buttons
                                ),
                              ])
                            ],
                          ),
                        )
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Center(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           'Don\'t have an Account?',
                    //           style: TextStyle(
                    //             fontFamily: 'Gilmer',
                    //             fontSize: 15,
                    //             color: Theme.of(context).colorScheme.onBackground,
                    //             fontWeight: FontWeight.w800,
                    //           ),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             // Navigator.push(
                    //             //   context,
                    //             //   MaterialPageRoute(
                    //             //     builder: (context) => const MobileSignUp(),
                    //             //   ),
                    //             // );
                    //           },
                    //           child: Text(
                    //             ' Sign up as a guest',
                    //             style: TextStyle(
                    //               fontFamily: 'Gilmer',
                    //               fontSize: 15,
                    //               color: Theme.of(context).colorScheme.tertiary,
                    //               fontWeight: FontWeight.w800,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const Spacer(flex: 1),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Navigator.of(context).push(
                    //     //   MaterialPageRoute(
                    //     //     builder: (context) => const ForgotPassword(),
                    //     //   ),
                    //     // );
                    //   },
                    //   child: Text(
                    //     'Forgot Password?',
                    //     style: TextStyle(
                    //       fontFamily: 'Gilmer',
                    //       fontSize: 15,
                    //       color: Theme.of(context).colorScheme.tertiary,
                    //       fontWeight: FontWeight.w800,
                    //     ),
                    //   ),
                    // ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class ChoiceScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:    Stack(children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             image: DecorationImage(
//               fit: BoxFit.e,
//               image: AssetImage(
//                 'assets/Passport.jpg',
//                 height
//               ),
//             ),
//           ),
//           height: 350.0,
//         ),
//         Container(
//           height: 350.0,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               gradient: LinearGradient(
//                   begin: FractionalOffset.topCenter,
//                   end: FractionalOffset.bottomCenter,
//                   colors: [
//                     Colors.grey.withOpacity(0.0),
//                     Colors.black,
//                   ],
//                   stops: [
//                     0.0,
//                     1.0
//                   ])),
//         )
//       ]),  
//     );
//   }
// }
