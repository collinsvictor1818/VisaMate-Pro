// import 'package:flutter/material.dart';
// // import 'package:langchain/langchain.dart';
// // import 'package:langchain_openai/langchain_openai.dart';
// // import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// // class RecommendationLogic {
// //   final TextEditingController? countryCtr;
// //   final TextEditingController? religionCtr;
// //   final TextEditingController? currencyCtr;
// //   final TextEditingController? budgetCtr;
// //   final TextEditingController? purposeCtr;
// //   final TextEditingController? languageCtr;

// //   const RecommendationLogic(
// //       {this.countryCtr,
// //       this.religionCtr,
// //       this.currencyCtr,
// //       this.purposeCtr,
// //       this.budgetCtr,
// //       this.languageCtr});

// //   Future<void> _getVisaRecommendations() async {
// //     // Replace with your OpenAI API key
// //     const clientApiKey =
// //         'sk-proj-CBO5yMdRYD4CfKbjqX9qT3BlbkFJ7E0vW5SScyC0f00ajQDz';

// //     final model = ChatOpenAI(apiKey: clientApiKey);
// //     final combinedPrompt = ChatPromptTemplate.fromTemplate(
// //         "Recommend 10 countries where a user can be able to apply for a travel visa to provided the country they come from {country}, their preferred religion {religion}, their most preferred language {language}, their purpose of travel {purpose}, their budget of expected travel expenses{budget} in the selected currency {currency}");

// //     const visaRecommendation = ChatFunction(
// //       name: "get_visa_recommendations",
// //       description: "Get visa recommendations based on user profile",
// //       parameters: {
// //         "type": "array",
// //         "items": {
// //           "type": "object",
// //           "properties": {
// //             "destination": {
// //               "type": "string",
// //               "description": "Destination country must be standardized",
// //             },
// //             "country_code": {
// //               "type": "string",
// //               "description":
// //                   "Country code of the destination country must be standardized in ISO 4217 format",
// //             },
// //             "visa_type": {
// //               "type": "string",
// //               "description": "Type of visa required according to the purpose",
// //             },
// //             "visa_cost": {
// //               "type": "string",
// //               "description":
// //                   "The cost of the visa in the preferred user currency, if there is no cost then return value 'FREE'",
// //             },
// //             "documents": {
// //               "type": "string",
// //               "description":
// //                   "A list of all documents required separated by a comma",
// //             },
// //             "visa_duration": {
// //               "type": "string",
// //               "description": "The number of days allowed for the visa",
// //             },
// //             "processing_time": {
// //               "type": "string",
// //               "description":
// //                   "The time it would take for the visa to be processed",
// //             },
// //           },
// //         },
// //       },
// //     );

// //     final chain = combinedPrompt | model | JsonOutputFunctionsParser();

// //     final res = await chain.invoke({
// //       'country': countryCtr.toString().trim(),
// //       'religion': religionCtr.toString().trim(),
// //       'language': languageCtr.toString().trim(),
// //       'purpose': purposeCtr.toString().trim(),
// //       'currency': currencyCtr.toString().trim(),
// //   'budget': budgetCtr.toString().trim(),
// //     });

// //     // Handle the result here
// //     print(res);
// //   }

// // class RecommendationProvider with ChangeNotifier {
// //   List<String> _recommendations = [];

// //   List<String> get recommendations => _recommendations;

// // // Define the travelVisaTool function declaration
// // final travelVisaTool = FunctionDeclaration(
// //   'recommendTravelVisas',
// //   'Recommends travel visas based on the user\'s inputs.',
// //   Schema(SchemaType.object, properties: {
// 'nationality': Schema(SchemaType.string, description: 'The country of nationality of the user.'),
// 'religion': Schema(SchemaType.string, description: 'The religion of the user.'),
// 'language': Schema(SchemaType.string, description: 'The preferred language of the user.'),
// 'purpose': Schema(SchemaType.string, description: 'The purpose of travel (e.g., tourism, business, study).'),
// 'budget': Schema(SchemaType.number, description: 'The budget for travel in USD.'),
//   }, requiredProperties: [
// //     'nationality',
// //     'religion',
// //     'language',
// //     'purpose',
// //     'budget',
// //   ]),
// // );

// // // Function to fetch recommendations
// // Future<Map<String, Object?>> recommendTravelVisas(
// //   Map<String, Object?> arguments,
// // ) async {
// //   // Implement your recommendation logic here
// //   return {
// //     'recommendations': [
// //       'Country1',
// //       'Country2',
// //       'Country3',
// //       'Country4',
// //       'Country5',
// //       'Country6',
// //       'Country7',
// //       'Country8',
// //       'Country9',
// //       'Country10',
// //     ],
// //   };
// // }
// //   Future<void> fetchRecommendations(String nationality, String religion, String language, String purpose, double budget) async {
// // final model = GenerativeModel(
// //   model: 'gemini-1.0-pro',
// //   apiKey: 'your-api-key',
// //   tools: [
// //     Tool(functionDeclarations: [travelVisaTool]),
// //   ],
// // );

// //     final chat = model.startChat();
// //     final prompt = 'Recommend travel visas based on the following inputs: '
// //         'Country of nationality: $nationality, Religion: $religion, '
// //         'Preferred Language: $language, Purpose of travel: $purpose, '
// //         'Budget: $budget USD.';

// //     var response = await chat.sendMessage(Content.text(prompt));

// //     final functionCalls = response.functionCalls.toList();
// //     if (functionCalls.isNotEmpty) {
// //       final functionCall = functionCalls.first;
// //       final result = await (() async {
// //         switch (functionCall.name) {
// //           case 'recommendTravelVisas':
// //             return await recommendTravelVisas(functionCall.args);
// //           default:
// //             throw UnimplementedError('Function not implemented: ${functionCall.name}');
// //         }
// //       })();

// //       response = await chat.sendMessage(Content.functionResponse(functionCall.name, result));

// //       if (response.text != null) {
// //         _recommendations = (result['recommendations'] as List).cast<String>();
// //         notifyListeners();
// //       }
// //     }
// //   }
// // }

// class RecommendationLogic {
//   // Future<Map<String, Object?>> travelVisaTool(
//   //   Map<String, Object?> arguments,
//   // ) async =>
//   //     // This hypothetical API returns a JSON such as:
//   //     // {"base":"USD","date":"2024-04-17","rates":{"SEK": 10.99}}
//   //     {
//   //       // 'nationality': arguments['nationality'],
//   //       // 'religion': arguments['religion'],
//   //       // 'language': arguments['language'],
//   //       // 'purpose': arguments['purpose'],
//   //       // 'budget': arguments['budget'],
//   //       'country_name': arguments['countryName'],
//   //       'country_code': arguments['countryCode'],
//   //       'language': arguments['officialLanguage'],
//   //       'currency': arguments['officialCurrency'],
//   //       'visa_type': arguments['visaType'],
//   //       'visa_duration': arguments['budget'],
//   //       'processing_time': arguments['processingTime'],
//   //       // 'currency': <String, Object?>{arguments['currency'] as String: 10.99}
//   //     };

//  Future<void> fetchRecommendations(
//     String nationality, String religion, String language, String purpose, double budget, String currency) async {

//   // Ensure you define the travelVisaTool correctly and make it a function.
//   final travelVisaTool = FunctionDeclaration(
//     'recommendTravelVisas',
//     'Recommends travel visas based on the user\'s inputs.',
//     Schema(SchemaType.object, properties: {
//       'nationality': Schema(SchemaType.string, description: 'The country of nationality of the user,'),
//       'religion': Schema(SchemaType.string, description: 'The religion of the user.'),
//       'language': Schema(SchemaType.string, description: 'The preferred language of the user.'),
//       'purpose': Schema(SchemaType.string, description: 'The purpose of travel (e.g., tourism, business, study).'),
//       'budget': Schema(SchemaType.number, description: 'The budget for travel in USD.'),
//     }, requiredProperties: [
// 'nationality',
// 'religion',
// 'language',
// 'purpose',
// 'budget',
//     ]),
//   );

//   print('Fetching recommendations for:');
//   print('Nationality: $nationality');
//   print('Religion: $religion');
//   print('Language: $language');
//   print('Purpose: $purpose');
//   print('Budget: $budget');
//   print('Currency: $currency');

//   final model = GenerativeModel(
//     model: 'gemini-1.0-pro',
//     apiKey: 'AIzaSyBjxxk5kxVVFMc8P2SJwFYlN17M-YL8Dog',
//     tools: [
//       Tool(functionDeclarations: [travelVisaTool]),
//     ],
//   );

//   final chat = model.startChat();

//   final prompt =
//       'Recommend 10 countries where a user can apply for a travel visa considering their country of origin: $nationality, preferred religion: $religion, preferred language: $language, purpose of travel: $purpose, and a travel budget of $budget $currency.';

//   // Send the message to the generative model.
//   var response = await chat.sendMessage(Content.text(prompt));

//   final functionCalls = response.functionCalls.toList();
//   // When the model responds with a function call, invoke the function.
//   if (functionCalls.isNotEmpty) {
//     final functionCall = functionCalls.first;

//     if (functionCall.name == 'travelVisaTool') {
//       // Simulate the function call as you don't have the actual implementation
//       final result = await simulateTravelVisaTool(functionCall.args);

//       // Send the response to the model so that it can use the result to generate
//       // text for the user.
//       response = await chat.sendMessage(Content.functionResponse(functionCall.name, result));
//     } else {
//       throw UnimplementedError('Function not implemented: ${functionCall.name}');
//     }
//   }

//   // When the model responds with non-null text content, print it.
//   if (response.text != null) {
//     print(response.text);
//   }
// }

// // Simulate the travelVisaTool function call as you don't have the actual implementation
// Future<dynamic> simulateTravelVisaTool(dynamic args) async {
//   // Simulate the response you expect from the travelVisaTool function
//   return {
//     'recommendedCountries': ['Country1', 'Country2', 'Country3']
//   };
// }
// }
// import 'package:gemini/gemini.dart';
// import 'package:google_generative_ai/google_generative_ai.dart'; // Replace with the actual package name if different
// class RecommendationLogic{
// // Define your function to simulate the travel visa recommendation
// // import 'package:gemini/gemini.dart'; // Replace with the actual package name if different

// // Define your function to simulate the travel visa recommendation
// // import 'package:gemini/gemini.dart'; // Replace with the actual package name if different

// // Define your function to simulate the travel visa recommendation
// Future<Map<String, dynamic>> recommendTravelVisas(Map<String, dynamic> args) async {
//   // Simulate the response from the travel visa recommendation API
//   return {
//     'country_name': args['countryName'],
//     'country_code': args['countryCode'],
//     'language': args['officialLanguage'],
//     'currency': args['officialCurrency'],
//     'visa_type': args['visaType'],
//     'visa_duration': args['visaDuration'],
//     'processing_time': args['processingTime'],
//   };
// }

// // Define the function declaration
// final travelVisaTool = FunctionDeclaration(
//   'recommendTravelVisas',
//   'Recommends countries for a user to apply for a travel visa based on various criteria.',
//   Schema(SchemaType.object, properties: {
//     'countryName': Schema(SchemaType.string, description: 'The name of the country.'),
//     'countryCode': Schema(SchemaType.string, description: 'The country code.'),
//     'officialLanguage': Schema(SchemaType.string, description: 'The official language of the country.'),
//     'officialCurrency': Schema(SchemaType.string, description: 'The official currency of the country.'),
//     'visaType': Schema(SchemaType.string, description: 'The type of visa available.'),
//     'visaDuration': Schema(SchemaType.string, description: 'The duration of the visa.'),
//     'processingTime': Schema(SchemaType.string, description: 'The processing time for the visa.'),
//   }, requiredProperties: [
//     'countryName', 'countryCode', 'officialLanguage', 'officialCurrency', 'visaType', 'visaDuration', 'processingTime'
//   ])
// );

// // Main function to fetch recommendations
// Future<void> fetchRecommendations(
//   String nationality,
//   String religion,
//   String language,
//   String purpose,
//   double budget,
//   String currency
// ) async {
//   print('Fetching recommendations for:');
//   print('Nationality: $nationality');
//   print('Religion: $religion');
//   print('Language: $language');
//   print('Purpose: $purpose');
//   print('Budget: $budget');
//   print('Currency: $currency');

//   final model = GenerativeModel(
//     model: 'gemini-1.0-pro', // Use a model that supports function calling
//     apiKey: 'AIzaSyBjxxk5kxVVFMc8P2SJwFYlN17M-YL8Dog', // Replace with your actual API key
//     tools: [
//       Tool(functionDeclarations: [travelVisaTool]),
//     ],
//   );

//   final chat = model.startChat();

//   final prompt = '''
//   I need recommendations for 10 countries where a user can apply for a travel visa considering their country of origin: $nationality, preferred religion: $religion, preferred language: $language, purpose of travel: $purpose, and a travel budget of $budget $currency.
//   Please use the recommendTravelVisas function to provide the recommendations.
//   ''';

//   // Send the message to the generative model.
//   var response = await chat.sendMessage(Content.text(prompt));

//   final functionCalls = response.functionCalls.toList();
//   // When the model responds with a function call, invoke the function.
//   if (functionCalls.isNotEmpty) {
//     final functionCall = functionCalls.first;

//     if (functionCall.name == 'recommendTravelVisas') {
//       // Call the recommendTravelVisas function
//       final result = await recommendTravelVisas(functionCall.args);

//       // Send the response to the model so that it can use the result to generate text for the user.
//       response = await chat.sendMessage(Content.functionResponse(functionCall.name, result));
//     } else {
//       throw UnimplementedError('Function not implemented: ${functionCall.name}');
//     }
//   }

//   // When the model responds with non-null text content, print it.
// if (response.text != null) {
//   print(response.text);
// } else {
//   print('No text response received.');
// }
// }

// }
import 'package:google_generative_ai/google_generative_ai.dart';

class RecommendationLogic {
  Future<void> fetchRecommendations(String nationality, String religion,
      String language, String purpose, double budget, String currency) async {
    print('Fetching recommendations for:');
    print('Nationality: $nationality');
    print('Religion: $religion');
    print('Language: $language');
    print('Purpose: $purpose');
    print('Budget: $budget');
    print('Currency: $currency');
    final travelVisaTool = FunctionDeclaration(
        'recommendTravelVisas',
        'Recommends countries for a user to apply for a travel visa based on various criteria.',
        Schema(SchemaType.object, properties: {
          'countryName': Schema(SchemaType.string,
              description: 'The name of the country.'),
          'countryCode':
              Schema(SchemaType.string, description: 'The country code.'),
          'officialLanguage': Schema(SchemaType.string,
              description: 'The official language of the country.'),
          'officialCurrency': Schema(SchemaType.string,
              description: 'The official currency of the country.'),
          'visaType': Schema(SchemaType.string,
              description: 'The type of visa available.'),
          'visaDuration': Schema(SchemaType.string,
              description: 'The duration of the visa.'),
          'processingTime': Schema(SchemaType.string,
              description: 'The processing time for the visa.'),
          'nationality': Schema(SchemaType.string,
              description: 'The country of nationality of the user.'),
          'religion': Schema(SchemaType.string,
              description: 'The religion of the user.'),
          'language': Schema(SchemaType.string,
              description: 'The preferred language of the user.'),
          'purpose': Schema(SchemaType.string,
              description:
                  'The purpose of travel (e.g., tourism, business, study).'),
          'budget': Schema(SchemaType.number,
              description: 'The budget for travel in USD.'),
        }, requiredProperties: [
          'countryName',
          'countryCode',
          'officialLanguage',
          'officialCurrency',
          'visaType',
          'visaDuration',
          'processingTime',
          // 'nationality',
          // 'religion',
          // 'language',
          // 'purpose',
          // 'budget',
        ]));

    final generationConfig = GenerationConfig(
      stopSequences: ["red"],
      maxOutputTokens: 200,
      temperature: 0.0,
      topP: 0.1,
      topK: 16,
    );

    final safetySettings = [
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
    ];
    final model = GenerativeModel(
      model: 'gemini-1.5-flash', // Use a model that supports function calling
      apiKey:
          'AIzaSyBjxxk5kxVVFMc8P2SJwFYlN17M-YL8Dog', // Replace with your actual API key
      generationConfig: generationConfig,
      safetySettings: safetySettings,
      tools: [
        Tool(functionDeclarations: [travelVisaTool]),
      ],
    );

    final chat = model.startChat();

    final prompt = '''
  I need recommendations for 10 countries where a user can apply for a travel visa considering their country of origin: $nationality, preferred religion: $religion, preferred language: $language, purpose of travel: $purpose, and a travel budget of $budget $currency.
  Please use the recommendTravelVisas function to provide the recommendations.
  ''';

    // Send the message to the generative model.
    var response = await chat.sendMessage(Content.text(prompt));
    Future<Map<String, dynamic>> recommendTravelVisas(
        Map<String, dynamic> args) async {
      // Simulate the response from the travel visa recommendation API
      return {
        'country_name': args['countryName'],
        'country_code': args['countryCode'],
        'language': args['officialLanguage'],
        'currency': args['officialCurrency'],
        'visa_type': args['visaType'],
        'visa_duration': args['visaDuration'],
        'processing_time': args['processingTime'],
      };
    }

    final functionCalls = response.functionCalls.toList();
    // When the model responds with a function call, invoke the function.
    if (functionCalls.isNotEmpty) {
      final functionCall = functionCalls.first;

      if (functionCall.name == 'recommendTravelVisas') {
        // Call the recommendTravelVisas function
        final result = await recommendTravelVisas(functionCall.args);

        // Send the response to the model so that it can use the result to generate text for the user.
        response = await chat
            .sendMessage(Content.functionResponse(functionCall.name, result));
      } else {
        throw UnimplementedError(
            'Function not implemented: ${functionCall.name}');
      }
    }

    // When the model responds with non-null text content, print it.
    if (response.text != null) {
      print(response.text);
    } else {
      print('No text response received.');
    }
  }
}
