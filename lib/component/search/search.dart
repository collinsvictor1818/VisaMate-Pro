import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:visamate/common/models/country.dart';
import 'package:visamate/common/models/country_list.dart';

import 'search_result_tile.dart';

class Search extends SearchDelegate<Country> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, Provider.of<Country>(context, listen: false).getCountry);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = Provider.of<CountryList>(context, listen: false)
        .getCountryList!
        .where((p) =>
            p.getCountryName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(suggestionList[index]);
        },
        child: SearchResultTile(country: suggestionList[index]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = Provider.of<CountryList>(context, listen: false)
        .getCountryList!
        .where((p) =>
            p.getCountryName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(suggestionList[index]);
        },
        child: SearchResultTile(country: suggestionList[index]),
      ),
    );
  }
}
