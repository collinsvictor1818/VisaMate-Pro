import 'dart:io';
import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';

// Replace with your OpenAI API key
const clientApiKey = 'YOUR_OPENAI_API_KEY';

final model = ChatOpenAI(apiKey: clientApiKey);

// final TextEditingController _firstNameController = TextEditingController();
// final TextEditingController _middleNameController = TextEditingController();
// final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _budgetController = TextEditingController();
final TextEditingController _countryController = TextEditingController();
final TextEditingController _reasonController = TextEditingController();
final TextEditingController _currencyController = TextEditingController();
final TextEditingController _durationController = TextEditingController();
final TextEditingController _religionController = TextEditingController();
final TextEditingController _languageController = TextEditingController();
final String country = _countryController.text.trim();
final String religion = _religionController.text.trim();
final String reason = _reasonController.text.trim();
final String duration = _durationController.text.trim();
final String currency = _currencyController.text.trim();
final String language = _languageController.text.trim();
final String budget = _budgetController.text.trim();

final promptTemplate = ChatPromptTemplate.fromTemplate("""
**Langchain Schemas**

**User Input Schema**

{userProfile}

**Output Schema**

{outputSchema}

**Task**

Recommend 10 countries with detailed visa information based on the user's profile {userProfile}.
""");

final combinedPrompt = ChatPromptTemplate.fromTemplate("Recommend 10 countries where a user can be able to apply for a travel visa to provided the country they come from {country}, their prefered religion {religion}, their most prefered language {language}, their purpose of travel {reason}, their budget of expected travel expenses{budget} in the selected currency {currency} ");
// Define the user input schema
const userProfile = ChatFunction(
  name: "get_user_profile",
  description: "Get user preference (country, reason for travel, currency)",
  parameters: {
    "type": "object",
    "properties": {
      "country": {
        "type": "string",
        "description": "A country of citizenship must be standardized",
        "required": true,
      },
      "reason": {
        "type": "string",
        "description": "Purpose/reason for travel",
        "required": true,
      },
      "religion": {
        "type": "string",
        "description": "The user's preferred religion",
        "required": true,
      },
      "language": {
        "type": "string",
        "description": "The user's preferred language",
        "required": true,
      },
      "budget": {
        "type": "string",
        "description": "The user's travel budget",
        "required": true,
      },
      "currency": {
        "type": "string",
        "description": "The currency should be in ISO 4217 format",
        "required": true,
      },
    },
    "required": [
      "country",
      "reason",
      "currency",
      "religion",
      "language",
      "budget",
    ],
  },
);

// Define the output response schema
const visaRecommendation = ChatFunction(
  name: "get_visa_recommendations",
  description: "Get visa recommendations based on user profile",
  parameters: {
    "type": "array",
    "items": {
      "type": "object",
      "properties": {
        "destination": {
          "type": "string",
          "description": "Destination country must be standardized",
        },
        "country_code": {
          "type": "string",
          "description":
              "Country code of the destination country must be standardized in ISO 4217 format",
        },
        "visa_type": {
          "type": "string",
          "description": "Type of visa required according to the reason",
        },
        "visa_cost": {
          "type": "string",
          "description":
              "The cost of the visa in the preferred user currency, if there is no cost then return value 'FREE'",
        },
        "documents": {
          "type": "string",
          "description":
              "A list of all documents required separated by a comma",
        },
        "visa_duration": {
          "type": "string",
          "description": "The number of days allowed for the visa",
        },
        "processing_time": {
          "type": "string",
          "description": "The time it would take for the visa to be processed",
        },
      },
    },
  },
);

// Define the chain of Langchain functions
// //
// final chain = promptTemplate |
//   model.bind(
//     ChatOpenAIOptions(
//       functions: const [userProfile],
//       functionCall: ChatFunctionCall.forced(functionName: userProfile.name),
//     ),
//   ) |
//   JsonOutputFunctionsParser<List<Map<String, String>>>();

// Future<List<Map<String, String>>> getVisaRecommendations(String apiKey) async {
//   final client = OpenAI(apiKey: apiKey);

//   // Execute the Langchain and get user's visa recommendations
//   final result = await chain.run(client);

//   return result;
// }

final chain =  combinedPrompt | model | JsonOutputFunctionsParser();

final res = chain.invoke({
  'country': country,
  'religion': religion,
  'language': language,
  'reason': reason,
  'currency': currency,
  'budget': budget,
  });
// print(res);
