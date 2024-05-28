import 'package:flutter/material.dart';

class PriceRangeSlider extends StatefulWidget {
  final String? desc;
  final String? text;
  final ValueChanged<int>? onChanged; // Add callback function parameter
  const PriceRangeSlider({this.desc, this.text, this.onChanged});

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

double start = 1000.0;
double end = 100000.0;

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  double distValue = 50.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.text!,
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
              widget.desc ?? '',
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
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  inactiveColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  // overlayColor: Theme.of(context).colorScheme.tertiary,
                  values: RangeValues(start, end),
                  labels: RangeLabels(start.toString(), end.toString()),
                  onChanged: (value) {
                    setState(() {
                      start = value.start;
                      end = value.end;
                      if (widget.onChanged != null) {
                        // widget.onChanged!(_sliderLevel);
                      }
                    });
                  },
                  min: 10.0,
                  max: 80.0,
                ),
                Text(
                  "Start: " +
                      start.toStringAsFixed(2) +
                      "\nEnd: " +
                      end.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
