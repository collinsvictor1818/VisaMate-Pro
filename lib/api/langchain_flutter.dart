// import 'package:flutter/material.dart';
// import 'package:langchain/langchain.dart';
// import 'package:langchain_openai/langchain_openai.dart';

// // Replace with your OpenAI API key
// const apiKey = 'YOUR_OPENAI_API_KEY';

// Future<List<Map<String, String>>> getUserVisaRecommendations(
//   String country,
//   String reason,
//   String currency,
// ) async {

//   final client = OpenAI(apiKey: apiKey);


//   // Define the user input schema
//   const userInputSchema = ChatFunction(
//     name: "get_user_profile",
//     description: "Get user preference (country, reason for travel, currency)",
//     parameters: {
//       "type": "object",
//       "properties": {
//         "country": {
//           "type": "string",
//           "description": "A country of citizenship must be standardized",
//           "required": true,
//         },
//         "reason": {
//           "type": "string",
//           "description": "Purpose/reason for travel",
//           "required": true,
//         },
//         "currency": {
//           "type": "string",
//           "description": "The currency should be in ISO 4217 format",
//           "required": true,
//         },
//       },
//       "required": [
//         "country",
//         "reason",
//         "currency",
//       ],
//     },
//   );

//   // Define the output response schema
//   const outputSchema = ChatFunction(
//     name: "get_visa_recommendations",
//     description: "Get visa recommendations based on user profile",
//     parameters: {
//       "type": "array",
//       "items": {
//         "type": "object",
//         "properties": {
//           "destination": {
//             "type": "string",
//             "description": "Destination country must be standardized",
//           },
//           "country_code": {
//             "type": "string",
//             "description":
//                 "Country code of the estination country must be standardized in ISO 4217 format",
//           },
//           "visa_type": {
//             "type": "string",
//             "description": "type of visa required according to the reason",
//           },
//           "visa_cost": {
//             "type": "string",
//             "description":
//                 "the cost of the visa in the prefered user currency, if there is no cost then return value 'FREE'",
//           },
//           "documents": {
//             "type": "string",
//             "description": "A list of all documents required separated by a comma",
//           },
//           "visa_duration": {
//             "type": "string",
//             "description": "the number of days allowed for the visa",
//           },
//           "processing_time": {
//             "type": "string",
//             "description": "the time it would take for the visa to be processed",
//           },
//         },
//       },
//     },
//   );

//   // Structure the user input as a Langchain object
//   final userInput = {
//     "country": country,
//     "reason": reason,
//     "currency": currency,
//   };

//   // Create the prompt combining user input and schema information
//   final prompt = """
//     **Langchain Schemas**

//     **Input Schema**

//     ${userInputSchema.toJson()}

//     **Output Schema**

//     ${outputSchema.toJson()}

//     **User Input**

//     ${userInput.toJson()}

//     **Task**

//     Recommend 10 countries with detailed visa information based on the user's profile.
//   """;

//   // Call OpenAI with the prompt
//   final response = await client.complete(prompt: prompt);

//   // Parse the OpenAI response
//   final parsedResponse = response.choices.first.text.trim();

//   try {
//     // Assuming the response is valid JSON, parse it into a list of maps
//     final recommendations = jsonDecode(parsedResponse) as List<dynamic>;
//     return recommendations.cast<Map<String, String>>();
//   } catch (error) {
//     print("Error parsing OpenAI response: $error");
//     throw Exception("Error getting visa recommendations");
//   }
// }
