import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visamate/common/models/country.dart';
import 'package:visamate/common/models/country_list.dart';
import 'package:visamate/common/models/visa.dart';

import '../../component/list/ListHeader.dart';
import '../../component/list/ListRow.dart';
import '../../utils/constants.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: kSidebarMargin + kTabWidth + 5),
        child: SingleChildScrollView(
          child: Column(
            children: _buildDataRows(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDataRows(BuildContext context) {
    List<Widget> widgetList = [];

    widgetList.add(Text(
      "Press country to view more",
      textAlign: TextAlign.center,
      style: kListInfoTextStyle,
    ));

    widgetList.add(
      ListHeader(leftTitle: "Country Name", rightTitle: "Status"),
    );

    // Get current country code with null check
    final currentCountryCode = Provider.of<Country>(context)?.getCountryCode;

    // Check if currentCountryCode and destinationList are not null
    if (currentCountryCode != null &&
        Provider.of<VisaData>(context, listen: false).getData(currentCountryCode).isNotEmpty) {
      final destinationList = Provider.of<VisaData>(context, listen: false).getData(currentCountryCode);

      destinationList.forEach((element) {
        // Get country with null check
        final Country? country = Provider.of<CountryList>(context, listen: false).getCountryByCode(element.code!);

        // Add ListRow only if country is not null
        if (country != null) {
          widgetList.add(ListRow(countryName: country.getCountryName!, destination: element));
        }
      });
    } else {
      // Handle case where data is not available (optional)
      widgetList.add(Text("No data available"));
    }

    return widgetList;
  }
}
