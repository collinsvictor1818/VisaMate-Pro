import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // User input variables
  String origin = "";
  String language = "";
  String reasonForTravel = "";
  String religion = ""; // User input
  String budget = ""; // User input
  String visaDifficulty = "";

  // Text editing controllers for user input fields
  final originController = TextEditingController();
  final languageController = TextEditingController();
  final reasonForTravelController = TextEditingController();
  final religionController = TextEditingController();
  final budgetController = TextEditingController();
  final visaDifficultyController = TextEditingController();

  // Placeholder response message
  String responseMessage = "";

  @override
  void dispose() {
    // Clean up controllers to avoid memory leaks
    originController.dispose();
    languageController.dispose();
    reasonForTravelController.dispose();
    religionController.dispose();
    budgetController.dispose();
    visaDifficultyController.dispose();
    super.dispose();
  }

  // Function to handle user input and generate recommendations
  void generateRecommendations() async {
    setState(() {
      origin = originController.text;
      language = languageController.text;
      reasonForTravel = reasonForTravelController.text;
      religion = religionController.text;
      budget = budgetController.text;
      visaDifficulty = visaDifficultyController.text;
      responseMessage = ""; // Clear previous message
    });

    // Simulate model response (replace with actual API call)
    String responseText = """
      Country: Neverland
      Official Language: Elvish
      CPI INDEX: 120
      Dominant Religion: Nature worship
      Visa Difficulty: Easy
    """;

    // Handle potential lack of information
    if (responseText.split("\n").length < 5) {
      setState(() {
        responseMessage = "The model couldn't provide enough information.";
      });
      return;
    }

    // Extract and format the output
    List<String> outputs = responseText.split("\n");
    String country = outputs[0];
    String officialLanguage = outputs[1];
    String cpiIndex = outputs[2];
    String dominantReligion = outputs[3];
    String visaRequirement = outputs[4];

    setState(() {
      responseMessage = """
        Country: $country
        Official Language: $officialLanguage
        CPI INDEX: $cpiIndex
        Dominant Religion: $dominantReligion
        Visa Difficulty: $visaRequirement
      """;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Travel Recommendation'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: originController,
                decoration: InputDecoration(labelText: "Origin"),
              ),
              TextField(
                controller: languageController,
                decoration: InputDecoration(labelText: "Language"),
              ),
              TextField(
                controller: reasonForTravelController,
                decoration: InputDecoration(labelText: "Reason for Travel"),
              ),
              TextField(
                controller: religionController,
                decoration: InputDecoration(labelText: "Preferred Religion"),
              ),
              TextField(
                controller: budgetController,
                decoration: InputDecoration(labelText: "Budget"),
              ),
              TextField(
                controller: visaDifficultyController,
                decoration: InputDecoration(labelText: "Visa Difficulty"),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: generateRecommendations,
                child: Text('Generate Recommendations'),
              ),
              SizedBox(height: 20.0),
              Text(responseMessage, style: TextStyle(fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }
}
