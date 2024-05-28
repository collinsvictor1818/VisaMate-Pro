import 'package:flutter/material.dart';
import 'recommendation_screen.dart';
import '../../logic/recommendation_logic.dart';

class UserProfile extends StatefulWidget {
  final RecommendationLogic recommendationLogic;

  UserProfile({required this.recommendationLogic});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nationalityController.dispose();
    _religionController.dispose();
    _languageController.dispose();
    _reasonController.dispose();
    _currencyController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nationalityController,
                decoration: InputDecoration(labelText: 'Country of Citizenship'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country of citizenship';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _religionController,
                decoration: InputDecoration(labelText: 'Religion'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your religion';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _languageController,
                decoration: InputDecoration(labelText: 'Preferred Language'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your preferred language';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: 'Purpose of Travel'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your purpose of travel';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _currencyController,
                decoration: InputDecoration(labelText: 'Currency'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your preferred currency';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _budgetController,
                decoration: InputDecoration(labelText: 'Budget (in USD)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your budget';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.recommendationLogic.fetchRecommendations(
                      _nationalityController.text,
                      _religionController.text,
                      _languageController.text,
                      _reasonController.text,
                      double.parse(_budgetController.text),
                      _currencyController.text,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RecommendationsScreen(),
                    ));
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
