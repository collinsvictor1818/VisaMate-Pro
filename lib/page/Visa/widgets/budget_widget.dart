import 'package:flutter/material.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../../component/Form/FormOptions.dart';
import '../../../component/constants/List.dart';
import '../../../component/custom_calendar.dart';
import '../../../component/form_text.dart';
import '../../../component/listview/ListBuilder.dart';

class ReasonWidget extends StatefulWidget {
  const ReasonWidget(BuildContext? context);

  @override
  State<ReasonWidget> createState() => _ReasonWidgetState();
}

class _ReasonWidgetState extends State<ReasonWidget> {
  
  DateTime? selectedEndDate;
  DateTime? selectedStartDate;
  void onStartDateSelected(DateTime startDate, DateTime endDate) {
    setState(() {
      selectedStartDate = startDate;
    });
  }

  void onEndDateSelected(DateTime startDate, DateTime endDate) {
    setState(() {
      selectedEndDate = endDate;
    });
  }


  @override
  Widget build(BuildContext context) {
    return _budgetWidget(context);
  }
Widget _budgetWidget(context) {
  int activeStep = 0;
    double start = 5000.0;
  double end = 10000.0;

  final TextEditingController _currencyController= TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  return Expanded(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          FormDropDown(
            text: "Currency",
            list: religions,
            desc: "Choose your prefered currency of trade",
            controller: _currencyController,
          ),
          // const PriceRangeSlider(desc: 'Budget cost', text: 'Budget'),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    // widget.text!,
                    'Budget',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilmer',
                        fontSize:
                            18)), // Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    // widget.desc??
                    'Specify your budget',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilmer',
                        fontSize: 12),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 3)),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.secondary),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RangeSlider(
                        divisions: 10,
                        activeColor: Theme.of(context).colorScheme.tertiary,
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).colorScheme.tertiary),

                        inactiveColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.5),
                        // overlayColor: Theme.of(context).colorScheme.tertiary,
                        values: RangeValues(start, end),
                        labels: RangeLabels(start.toString(), end.toString()),
                        onChanged: (value) {
                          {
                            start = value.start;
                            end = value.end;
                          };
                        },
                        min: 10.0,
                        max: 1000000.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0)
                            .add(const EdgeInsets.only(bottom: 10)),
                        child: Text(
                          "Start: " +
                              start.toInt().toStringAsFixed(0) +
                              "\nEnd: " +
                              end.toInt().toStringAsFixed(0),
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const CurrencyPicker(
          //   text: 'Budget',
          //   desc: 'Specify your Budget',
          // ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () => {
                        // if (activeStep > 2)
                        activeStep--
                      },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxHeight: 50,
                          minHeight: 50,
                          maxWidth: 144,
                          minWidth: 100),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('Previous',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 18))),
                        ),
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  // if (activeStep < 4) activeStep++;
                  final String budget = _budgetController.toString();
                  final String currency = _currencyController.toString();
                  // final String language = _languageController.toString();
                  final snacky = snackBarHelper.SnackBarHelper(context);
                  if (budget.isEmpty &&
                      // country.isEmpty &&
                      currency.isEmpty) {
                    snacky.showSnackBar("Fill in all details", isError: true);

                    return;
                  } else if (currency.isEmpty) {
                    snacky.showSnackBar("Fill in your prefered currency",
                        isError: true);
                    return;
                    // } else if (language.isEmpty) {
                    //   snacky.showSnackBar(
                    //       "Fill in your language preference",
                    //       isError: true);
                    //   return;
                  } else if (budget.isEmpty) {
                    snacky.showSnackBar("Fill in your budget details",
                        isError: true);
                    return;
                  } else if (activeStep < 4) {
                    activeStep++;
                  } else {
                    return;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxHeight: 50,
                        minHeight: 50,
                        maxWidth: 144,
                        minWidth: 100),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('Next',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 18))),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}