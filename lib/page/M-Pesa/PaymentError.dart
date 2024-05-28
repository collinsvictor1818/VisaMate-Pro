import 'package:flutter/material.dart';
import 'package:visamate/page/Dashboard/M-Pesa.dart';
import '../../../styles/pallete.dart';

class paymentError extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => paymentErrorState();
}

class paymentErrorState extends State<paymentError> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => MPesa())));
        },icon: Icon(Icons.arrow_back_ios_rounded), color: AppColor.accentDark),
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
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 500,
                    width: 350,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),

                        child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/PaymentError.png'),
                            Text(
                              "Payment Failed",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontFamily: 'Gilmer',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => MPesa())));

              },
              child: Container(
                height: 50,
                width: 320,
                child: PhysicalModel(
                  color:Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(15),
                  child: Center(
                    child: Text(
                      "Close",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontFamily: 'Gilmer',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
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
