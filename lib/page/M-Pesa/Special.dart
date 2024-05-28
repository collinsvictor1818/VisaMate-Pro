import 'package:visamate/page/M-Pesa/PaymentSuccessful.dart';
import 'package:flutter/material.dart';

import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import '../../component/Form/FormText.dart';
import '../../page/Dashboard/M-Pesa.dart';
import 'logic/paybill.dart';

class SpecialTravel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SpecialTravelState();
}

class SpecialTravelState extends State<SpecialTravel> {
  final _formKey = GlobalKey<FormState>();
  String _businessShortCode = "795194";
  late String _passKey;
  late String _amount;
  late String _phoneNumber;

    Future<dynamic> startTransaction({required double amount, required String phone}) async{

    dynamic transactionInitialisation;
//Wrap it with a try-catch
    try {
//Run it
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: '174379',//use your store number if the transaction type is CustomerBuyGoodsOnline
          transactionType: TransactionType.CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
          amount: amount,
          partyA: phone,
          partyB: '174379',
          callBackURL: Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
          accountReference: 'Payment',
          phoneNumber: phone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: 'demo',
          passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');


      //HashMap result = transactionInitialisation as HashMap<String, dynamic>;
      print('RESULT'+transactionInitialisation.toString());
    } catch (e) {
//you can implement your exception handling here.
//Network un-reachability is a sure exception.

      /*
  Other 'throws':
  1. Amount being less than 1.0
  2. Consumer Secret/Key not set
  3. Phone number is less than 9 characters
  4. Phone number not in international format(should start with 254 for KE)
   */
      print(e.toString());
    }
  }

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
            color: Theme.of(context).colorScheme.tertiary),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /**/ Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Special Travel",
                style: TextStyle(
                    fontFamily: 'Gilmer',
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 35,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: PhysicalModel(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 240,
                      width: 300,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/MPesaLogo.png",
                                      height: 100),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        "Paybill",
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onBackground,
                                          fontFamily: 'Gilmer',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "795194",
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onBackground,
                                          fontFamily: 'Gilmer',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              FormText(
                                text: 'Amount'
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              // onTap: () {
              //   if (_formKey.currentState!.validate()) {
              //     _formKey.currentState?.save();
              //     makePayBillPayment(
              //         _businessShortCode, _passKey, _amount, _phoneNumber);
              //   }
              // },
              onTap: (){
                 startTransaction(amount: 1.0, phone: '254758214490');

              },
                // onTap: (() {
                //     Navigator.of(context).push(MaterialPageRoute(builder: ((context) => paymentSuccessful())));
                //   }),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => paymentSuccessful())));
                  }),child: Container(
                    height: 50,
                    width: 300,
                    child: PhysicalModel(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                        child: Text(
                          "Pay",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontFamily: 'Gilmer',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "GOD BLESS YOU AS YOU GIVE",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: 'Gilmer',
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
