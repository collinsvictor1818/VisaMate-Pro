import 'package:flutter/material.dart';

import '../../page/Dashboard/M-Pesa.dart';
import '../../page/M-Pesa/PaymentError.dart';
import 'PaymentSuccessful.dart';

class confirmPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => confirmPaymentState();
}

class confirmPaymentState extends State<confirmPayment> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: ((context) => MPesa())));
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Theme.of(context).colorScheme.onBackground),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: PhysicalModel(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    alignment: Alignment.center,
                    height: 350,
                    width: 300,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Image.asset("assets/MPesa.png", height: 100),
                            Center(
                              child: Text(
                                "Confirm Payment",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onBackground,
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35.0)
                                        .add(EdgeInsets.only(top: 15)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Paybill:",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "795194",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Account Name:",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "TITHE",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Amount:",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "1000",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(

                child: Row(
                  
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => paymentSuccessful())));
                        },
                        child: Container(
                          height: 50,
                          width: 140,
                          child: PhysicalModel(
                            color: Theme.of(context).colorScheme.tertiary.withOpacity(.18),
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(flex: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => paymentError())));
                        },
                        child: Container(
                          height: 50,
                          width: 140,
                          child: PhysicalModel(
                            color: Theme.of(context).colorScheme.tertiary.withOpacity(.1),
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
