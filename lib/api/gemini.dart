import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Currency extends StatefulWidget {
  const Currency();

  @override
  _CurrencyState createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Future<Map<String, Object?>> findExchangeRate(
    Map<String, Object?> arguments,
  ) async {
    // Simulate fetching the exchange rate from an external API
    // Here, you can implement the logic to fetch the exchange rate based on the provided arguments
    final String currencyDate = arguments['currencyDate'] as String;
    final String currencyFrom = arguments['currencyFrom'] as String;
    final String currencyTo = arguments['currencyTo'] as String;

    // Perform the exchange rate calculation
    // For demonstration purposes, let's just return a hardcoded value
    final double exchangeRate = 0.091;

    // Return the exchange rate as a map
    return {
      'date': currencyDate,
      'base': currencyFrom,
      'rates': {currencyTo: exchangeRate}
    };
  }

  Future<void> fetchCurrency(String to, String amount) async {
    final exchangeRateTool = FunctionDeclaration(
      'findExchangeRate',
      'Returns the exchange rate between currencies on given date.',
      Schema(SchemaType.object, properties: {
        'currencyDate': Schema(SchemaType.string,
            description: 'A date in YYYY-MM-DD format or '
                'the exact value "latest" if a time period is not specified.'),
        'currencyFrom': Schema(SchemaType.string,
            description: 'The currency code of the currency to convert from, '
                'such as "USD".'),
        'currencyTo': Schema(SchemaType.string,
            description: 'The currency code of the currency to convert to, '
                'such as "USD".')
      }, requiredProperties: [
        'currencyDate',
        'currencyFrom'
      ]));

    final generationConfig = GenerationConfig(
      stopSequences: ["red"],
      maxOutputTokens: 200,
      temperature: 2,
      topP: 0.1,
      topK: 16,
    );

    final safetySettings = [
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
    ];

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyBjxxk5kxVVFMc8P2SJwFYlN17M-YL8Dog', // Replace with your actual API key
      generationConfig: generationConfig,
      safetySettings: safetySettings,
      tools: [
        Tool(functionDeclarations: [exchangeRateTool]),
      ],
    );

    final chat = model.startChat();

    final prompt = 'How much is $amount  Kenyan worth in $to?';

    var response = await chat.sendMessage(Content.text(prompt));

    final functionCalls = response.functionCalls.toList();
    if (functionCalls.isNotEmpty) {
      final functionCall = functionCalls.first;

      if (functionCall.name == 'findExchangeRate') {
        final result = await findExchangeRate(functionCall.args);
        response = await chat.sendMessage(Content.functionResponse(functionCall.name, result));
      } else {
        throw UnimplementedError('Function not implemented: ${functionCall.name}');
      }
    }

    if (response.text != null) {
      print(response.text);
    } else {
      print('No text response received.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Conversion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _toController,
                decoration: InputDecoration(labelText: 'Currency To'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the currency code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    fetchCurrency(_toController.text, _amountController.text);
                  }
                },
                child: Text('Convert'),
              ),
            ],
          ),
        ),
      ));
   
  }}