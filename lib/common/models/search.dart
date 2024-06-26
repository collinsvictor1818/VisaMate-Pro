import 'package:visamate/common/models/country.dart';
import 'package:flutter/material.dart';

class Search extends ChangeNotifier {
  static Country? _passportCountry;
  static Country? _destinationCountry;

  Country? get passportCountry => _passportCountry;
  Country? get destinationCountry => _destinationCountry;

  bool hasNull() {
    if (_passportCountry == null || _destinationCountry == null) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return "passportCountry:$_passportCountry destinationCountry:$_destinationCountry";
  }

  void setPassportCountry(Country? country) {
    _passportCountry = country;
    notifyListeners();
  }

  void setDestinationCountry(Country? country) {
    _destinationCountry = country;
    notifyListeners();
  }
}
