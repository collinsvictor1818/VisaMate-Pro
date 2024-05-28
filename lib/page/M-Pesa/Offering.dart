import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import '../../component/Form/FormText.dart';
import '../../page/Dashboard/M-Pesa.dart';
import 'logic/paybill.dart';
import 'package:visamate/page/M-Pesa/PaymentSuccessful.dart'; // Added import statement for PaymentSuccessful.dart

class Travel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TravelState();
}

class TravelState extends State<Travel> {
  final _formKey = GlobalKey<FormState>();
  String _businessShortCode = "795194";
  late String _passKey;
  late String _amount = "1";
  late String _phoneNumber = "254758214490";
  TextEditingController _amountController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future<void> startTransaction(
      {required double amount, required String phone}) async {
    try {
      // Ensure businessShortCode is not null before proceeding
      if (_businessShortCode == null) {
        throw Exception("Business short code is not set");
      }

      final url = Uri.parse(
          "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest");
      final String consumerKey = "MGSTi2E0vYJ162VnIvCKV6PVxQTaQfP6";
      final String consumerSecret = "cbJSrMvF5q6Z62U1";
      final String passKey =
          "6f7e9867e9d4270fda43b402e5df638b09ff659d2994527f5d1181ad37a51376";

      final String credentials =
          base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
      final responseToken = await http.get(
        Uri.parse(
            "https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"),
        headers: {
          "Authorization": "Basic $credentials",
        },
      );

      final Map<String, dynamic> tokenData = json.decode(responseToken.body);
      final String accessToken = tokenData["access_token"];

      final String timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll("-", "")
          .replaceAll(":", "")
          .split(".")[0];

      final String password =
          base64Encode(utf8.encode("$_businessShortCode$passKey$timestamp"));

      final Map<String, dynamic> requestBody = {
        "BusinessShortCode": _businessShortCode,
        "Password": password,
        "Timestamp": timestamp,
        "TransactionType": "CustomerPayBillOnline",
        "Amount": amount,
        "PartyA": phone,
        "PartyB": _businessShortCode,
        "PhoneNumber": phone,
        "CallBackURL": "https://mydomain.com/TransactionStatus/response",
        "AccountReference": "Travel",
        "TransactionDesc": "Payment of Travel",
      };

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
        body: json.encode(requestBody),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      final String responseCode = responseData["ResponseCode"];

      if (responseCode == "0") {
        final String responseDescription = responseData["ResponseDescription"];
        print(responseDescription);
        // Handle success
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => PaymentSuccessful()),
        // );
      } else {
        final String errorMessage = responseData["errorMessage"];
        print(errorMessage);
        // Handle error (show user-friendly message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $errorMessage"),
          ),
        );
      }
    
    } catch (e) {
      print("Error: $e");
      // Handle any other exceptions during the process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred. Please try again."),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => MPesa())),
            );
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Special Travel",
                style: TextStyle(
                  fontFamily: 'Gilmer',
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                ),
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
                                  Image.asset("assets/MPesaLogo.png", height: 100),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        "Paybill",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontFamily: 'Gilmer',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // Display _businessShortCode only if it's not null
                                      Text(
                                        _businessShortCode != null
                                            ? _businessShortCode
                                            : "",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontFamily: 'Gilmer',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              FormText(text: 'Amount'),
                              TextFormField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Enter Amount",
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
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Validate user input before calling startTransaction
                double amount = double.tryParse(_amountController.text) ?? 0.0;
                if (amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter a valid amount"),
                    ),
                  );
                  return;
                }
                startTransaction(amount: amount, phone: _phoneNumber);
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
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
