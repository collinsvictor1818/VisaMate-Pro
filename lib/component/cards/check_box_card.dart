import "package:flutter/material.dart";

import 'package:intl/intl.dart';

import '../Form/FormText.dart';



// class CheckBoxCard extends StatefulWidget {
//   final String member;
//   final String last;
//   final String condition;
//   final int duration;
//   final TextEditingController? textController;
//   final DateTime startDate;
//   final String status;
//   final DateTime endDate;
//   final bool isSelected; // New property to track selection

//   CheckBoxCard({
//     required this.member,
//     required this.last,
//     required this.condition,
//     this.textController,
//     required this.status,
//     required this.duration,
//     required this.startDate,
//     required this.endDate,
//     required this.isSelected, // Added isSelected parameter
//   });

//   @override
//   _CheckBoxCardState createState() => _CheckBoxCardState();
// }

// class _CheckBoxCardState extends State<CheckBoxCard> {
//   late bool isPresent;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the isPresent state with the isSelected parameter
//     isPresent = widget.isSelected;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dateFormat = DateFormat('MMM d, y');
//     return GestureDetector(
//       onTap: () {
//         // Toggle the selection state when tapped
//         setState(() {
//           isPresent = !isPresent;
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(1.0),
//         child: Card(
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           color: isPresent ?Theme.of(context).colorScheme.tertiary.withOpacity(0.1): Theme.of(context).colorScheme.secondary,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: 
//             // ExpansionTile(
//             //   collapsedBackgroundColor: isPresent ?Theme.of(context).colorScheme.tertiary.withOpacity(0.1): Theme.of(context).colorScheme.secondary,
//             //   iconColor: Colors.white,
//             //   shape: Border(),
//             //   tilePadding: EdgeInsets.zero,
//             //   backgroundColor:  isPresent ?Theme.of(context).colorScheme.tertiary.withOpacity(0.1): Theme.of(context).colorScheme.secondary,
//             //   title:
//                ListTile(
//                 leading: Container(
//                   width: 1,
//                   child: Checkbox(
//                     value: isPresent,
//                     activeColor: Theme.of(context).colorScheme.tertiary,
//                    visualDensity: VisualDensity.compact,
//                         checkColor: Theme.of(context).colorScheme.secondary,
//                     onChanged: (bool? newValue) {
//                       setState(() {
//                         isPresent = newValue ?? false;
//                       });
//                     },
//                   ),
//                 ),
//                 title: Text(
//                   '${widget.member} ${widget.last}',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Gilmer',
//                     fontWeight: FontWeight.w700,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//               // children: !isPresent ? <Widget>[ // Show the expanded content only when isPresent is false
//               //   Padding(
//               //     padding: const EdgeInsets.all(10.0),
//               //     child: Column(
//               //       children: [
//               //         Align(
//               //           alignment: Alignment.centerLeft,
//               //           child: Text(
//               //             'Reason for Absence',
//               //             textAlign: TextAlign.start,
//               //             style: TextStyle(
//               //               fontSize: 14,
//               //               color: Colors.white,
//               //               fontFamily: "Gilmer",
//               //               fontWeight: FontWeight.w700,
//               //             ),
//               //           ),
//               //         ),
//               //         const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
//               //         TextFormField(
//               //           minLines: 3,
//               //           maxLines: 3,
//               //           controller: widget.textController,
//               //           cursorColor: Theme.of(context).colorScheme.tertiary,
//               //           validator: (value) {
//               //             if (value == null || value.isEmpty) {
//               //               return 'Please enter reason';
//               //             }
//               //             return null;
//               //           },
//               //           style: TextStyle(
//               //             fontFamily: 'Gilmer',
//               //             fontSize: 14,
//               //             color: Colors.white,
//               //             fontWeight: FontWeight.w700,
//               //           ),
//               //           decoration: InputDecoration(
//               //             hintText: "Specify Reason",
//               //             hintStyle: TextStyle(
//               //               fontSize: 14,
//               //               color: Colors.grey,
//               //               fontFamily: "Gilmer",
//               //               fontWeight: FontWeight.w700,
//               //             ),
//               //             focusColor: Theme.of(context).colorScheme.tertiary,
//               //             isDense: true,
//               //             enabledBorder: OutlineInputBorder(
//               //               borderRadius: BorderRadius.circular(5),
//               //               borderSide: BorderSide.none,
//               //             ),
//               //             fillColor: Colors.white,
//               //             filled: true,
//               //             focusedBorder: OutlineInputBorder(
//               //               borderRadius: BorderRadius.circular(5),
//               //               borderSide: BorderSide(
//               //                 color: Theme.of(context).colorScheme.tertiary,
//               //                 width: 2,
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //         Padding(padding: EdgeInsets.symmetric(vertical: 7)),
//               //         GestureDetector(
//               //           onTap: () {
//               //             // Save action
//               //           },
//               //           child: Padding(
//               //             padding: const EdgeInsets.all(2.0),
//               //             child: Center(
//               //               child: Padding(
//               //                 padding: const EdgeInsets.only(bottom: 3.0),
//               //                 child: Container(
//               //                   width: 270,
//               //                   height: 30,
//               //                   decoration: BoxDecoration(
//               //                     borderRadius: BorderRadius.circular(5),
//               //                     color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
//               //                   ),
//               //                   child: Padding(
//               //                     padding: const EdgeInsets.all(.0).add(EdgeInsets.symmetric(horizontal: 8)),
//               //                     child: Row(
//               //                       crossAxisAlignment: CrossAxisAlignment.center,
//               //                       mainAxisAlignment: MainAxisAlignment.center,
//               //                       children: [
//               //                         Center(
//               //                           child: Text(
//               //                             'Save',
//               //                             style: TextStyle(
//               //                               color: Theme.of(context).colorScheme.tertiary,
//               //                               fontFamily: 'Gilmer',
//               //                               fontWeight: FontWeight.w700,
//               //                               fontSize: 14,
//               //                             ),
//               //                           ),
//               //                         ),
//               //                       ],
//               //                     ),
//               //                   ),
//               //                 ),
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ] : [], // Show an empty list if isPresent is true
//             ),
//           ),
//         ),
//       // ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CheckBoxCard extends StatefulWidget {
  final String member;
  final String last;
  // final String status;
  // final String condition;
  // final DateTime startDate;
  // final DateTime endDate;
  final bool isSelected;
  final Function(bool, String?) onSelectionChange; // Include onSelectionChange parameter

  CheckBoxCard({
    required this.member,
    required this.last,
    // required this.status,
    // required this.condition,
    // required this.startDate,
    // required this.endDate,
    required this.isSelected,
    required this.onSelectionChange,
  });

  @override
  _CheckBoxCardState createState() => _CheckBoxCardState();
}

class _CheckBoxCardState extends State<CheckBoxCard> {
  late TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: widget.isSelected
            ? Theme.of(context).colorScheme.tertiary.withOpacity(0.1)
            : Theme.of(context).colorScheme.secondary,
            child: Column(
        children: [
          ListTile(
            title: Text('${widget.member} ${widget.last}'),
            // subtitle: Text('Status: ${widget.status}'),
            trailing: Checkbox(
              activeColor: Theme.of(context).colorScheme.tertiary,
              value: widget.isSelected,
              onChanged: (value) {
                widget.onSelectionChange(value ?? false, _reasonController.text);
              },
            ),
          ),
          if (!widget.isSelected) // Show reason field only if not selected
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:    Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Reason for Absence',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: "Gilmer",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                      TextFormField(
                        minLines: 3,
                        maxLines: 3,
                        // controller: widget.textController,
                        cursorColor:Theme.of(context).colorScheme.background,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter reason';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontFamily: 'Gilmer',
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          hintText: "Specify Reason",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: "Gilmer",
                            fontWeight: FontWeight.w700,
                          ),
                          focusColor: Theme.of(context).colorScheme.tertiary,
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Theme.of(context).colorScheme.background,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 7)),
                      GestureDetector(
                        onTap: () {
                          // Save action
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 3.0),
                              child: Container(
                                width: 270,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(.0).add(EdgeInsets.symmetric(horizontal: 8)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.tertiary,
                                            fontFamily: 'Gilmer',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
        ],
      ),
    );
  }
}
