class UserInput {
  final String country;
  final String religion;
  final String language;
  final String reason;

  UserInput(this.country, this.religion, this.language, this.reason);
}

class VisaOption {
  final String visa;
  final String country;

  VisaOption(this.visa, this.country);
}

class VisaDetails {
  final List<String> requiredDocuments;
  final String processingTime;
  final String costs;

  VisaDetails(this.requiredDocuments, this.processingTime, this.costs);
}
