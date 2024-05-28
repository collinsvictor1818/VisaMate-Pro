import 'package:flutter/material.dart';

class RecommendedScreen extends StatelessWidget {
     final List<Map<String, String>> recommendations;

    const RecommendedScreen({required this.recommendations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            for (var recommendation in recommendations)
              buildRecommendationCard(recommendation),
          ],
        ),
      ),
    );
  }

  Widget buildRecommendationCard(Map<String, String> recommendation) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended Country: ${recommendation['destination']}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Visa Cost: ${recommendation['visa_cost']}'),
            const SizedBox(height: 4.0),
            Text('Processing Time: ${recommendation['processing_time']}'),
            const SizedBox(height: 4.0),
            Text('Required Documents: ${recommendation['documents']}'),
          ],
        ),
      ),
    );
  }
}
