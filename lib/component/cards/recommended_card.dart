import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:visamate/common/models/country.dart';
import 'package:visamate/common/models/country_list.dart';
import 'package:visamate/common/models/navigation.dart';

class RecommendationCard extends StatelessWidget {
  final String code;
  final String visa;

  const RecommendationCard({
    Key? key,
    required this.code,
    required this.visa,
  }) : super(key: key);

  final height = 20.0;
  @override
  Widget build(BuildContext context) {
    Country country =
        Provider.of<CountryList>(context, listen: false).getCountryByCode(code);

    return GestureDetector(
      onTap: () {
        Provider.of<NavigationState>(context, listen: false)
            .setSearchNavigation(destinationCountry: country);
        debugPrint(country.getCountryName);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        // height: 150,
        width: 100,
        decoration: const BoxDecoration(
          // color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFlag(context),
            _buildCountryName(country.getCountryName!),
          ],
        ),
      ),
    );
  }

  Widget _buildFlag(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SvgPicture.asset(
        "assets/flags/${code.toLowerCase()}.svg",
        width: 100,
        height: 100,
        fit: BoxFit.contain,
        color: Theme.of(context).colorScheme.tertiary.withOpacity(.05),
        colorBlendMode: BlendMode.modulate,
      ),
    );
  }

  Widget _buildCountryName(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // _buildVisaResult(double height, String visa) {
  //   return SizedBox(
  //     height: height,
  //     child: FittedBox(
  //       fit: BoxFit.fitHeight,
  //       child: Text(
  //         visa,
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
