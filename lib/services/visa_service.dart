import 'package:http/http.dart' as http;
import 'package:visamate/api/visa_api.dart';

import '../models/visa_model.dart';

class VisaService {
  final VisaAPI api = VisaAPI();

  Future<Recommendation> getRecommendation(UserInput userInput) async {
    final visaOptions = await api.getVisaOptions(userInput.toJson());
    final filteredVisas = filterVisas(visaOptions, userInput);
    final recommendation = recommendVisa(filteredVisas);
    final details = await api.getVisaDetails(recommendation.visa, recommendation.country);
    return Recommendation(recommendation.visa, recommendation.country, VisaDetails(details["required_documents"], details["processing_time"], details["costs"]));
  }

  List<VisaOption> filterVisas(Map<String, dynamic> visaOptions, UserInput userInput) {
    // Implement filtering logic based on user religion and language preferences
    // This is a placeholder for the actual filtering logic
    final filtered = visaOptions["options"]
        .map((option) => VisaOption(option["visa"], option["country"]))
        .toList();
    return filtered;
  }

  VisaOption recommendVisa(List<VisaOption> filteredVisas) {
    // Implement logic to choose the most suitable visa based on travel reason
    // This is a placeholder for the actual recommendation logic
    return filteredVisas[0]; // Choose the first option for now
  }
}

class Recommendation {
  final String visa;
  final String country;
  final VisaDetails details;

  Recommendation(this.visa, this.country, this.details);
}

class UserInput {
  final String field1;
  final int field2;

  UserInput(this.field1, this.field2);

  Map<String, dynamic> toJson() {
    return {
      'field1': field1,
      'field2': field2,
    };
  }
}
