import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/recommendation_logic.dart';
// import 'recommendation_provider.dart';

class RecommendationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final recommendations = Provider.of<RecommendationProvider>(context).recommendations;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Countries'),
      ),
      body: ListView.builder(
        // itemCount: recommendations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              // title: Text(recommendations[index]),
            ),
          );
        },
      ),
    );
  }
}
