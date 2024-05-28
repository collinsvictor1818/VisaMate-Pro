import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Recommendation',
      initialRoute: '/',
      routes: {
        '/': (context) => InputForm(),
        '/results': (context) => ResultsScreen(),
      },
    );
  }
}

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  String? selectedReligion; // Nullable String
  int budgetMin = 200;
  int budgetMax = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Recommendation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedReligion,
              hint: Text('Select Religion'),
              onChanged: (String? value) { // Nullable String
                setState(() {
                  selectedReligion = value;
                });
              },
              items: <String>['Christians', 'Muslims', 'Buddhists', 'Hindus']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Budget Min: $budgetMin'),
                Slider(
                  value: budgetMin.toDouble(),
                  min: 0,
                  max: 500,
                  divisions: 500,
                  onChanged: (double value) {
                    setState(() {
                      budgetMin = value.toInt();
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Budget Max: $budgetMax'),
                Slider(
                  value: budgetMax.toDouble(),
                  min: 0,
                  max: 500,
                  divisions: 500,
                  onChanged: (double value) {
                    setState(() {
                      budgetMax = value.toInt();
                    });
                  },
                ),
              ],
            ),
            ElevatedButton( // Replace RaisedButton with ElevatedButton
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/results',
                  arguments: {
                    'religion': selectedReligion,
                    'budgetMin': budgetMin,
                    'budgetMax': budgetMax,
                  },
                );
              },
              child: Text('Recommend Countries'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?; // Nullable Map
    if (args == null) return Scaffold(body: Center(child: Text('No data received.'))); // Handle null case

    // Use backend code here to filter and recommend countries
    // You can replace this placeholder with the actual recommendation logic
    List<String> recommendedCountries = ['Country 1', 'Country 2', 'Country 3'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Countries'),
      ),
      body: ListView.builder(
        itemCount: recommendedCountries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recommendedCountries[index]),
          );
        },
      ),
    );
  }
}
