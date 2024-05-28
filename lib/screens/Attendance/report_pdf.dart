// ignore: file_names
// import 'package:visamate/page/ManageUser/manage_priviledges.dart';
import 'package:flutter/material.dart';
import 'package:visamate/component/appbars/CustomAppBar.dart';
import '../../component/appbars/BottomNav.dart';
import '../../component/listview/ListBuilder.dart';
import '../../utils/responsive/desktop_body.dart';
import '../../utils/responsive/mobile_body.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../../utils/responsive/tablet_body.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../utils/user_controller.dart';


class ReportPDF extends StatefulWidget {
  final List<Map<String, dynamic>> members;
  final String sType;

  const ReportPDF({
    Key? key,
    required this.members,
    required this.sType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<ReportPDF> {
  late pw.Document pdf;

  @override
  void initState() {
    super.initState();
    generatePDF();
  }

 Future<void> generatePDF() async {
  pdf = pw.Document();
final userController = Get.put(UserController());

// Call the getUsername() method to fetch the username
String username = await userController.getUsername();
  // Create a table with borders
  final List<pw.TableRow> tableRows = [
    pw.TableRow(
      children: [
         pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text('Member', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text('Service', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
       
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text('Attendance', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text('Time', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text('Filled By', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
      ],
    ),
  ];

  for (var member in widget.members) {
    tableRows.add(
      pw.TableRow(
        children: [
             pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text('${member['first']} ${member['last']}'),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text(widget.sType),
          ),
       
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text('Present'), // Modify dynamically based on attendance
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text(DateTime.now().toString()), // Current time
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text(username), // Person filling the report
          ),
        ],
      ),
    );
  }

  // Add the table to the PDF document
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Table(
          border: pw.TableBorder.all(),
          children: tableRows,
        );
      },
    ),
  );

  // Set state to trigger rebuild with the PDF content
  setState(() {});
}

  Future<void> printPDF() async {
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Attendance_Report.pdf',
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          title: "Generate Report",
          onClickedHome: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: ((context) => const MobileScaffold)));
          },
          onClickedBack: () {},
        ),
        body: SafeArea(
          child: pdf == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.tertiary,
                )) // Show progress indicator while generating PDF
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: PhysicalModel(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 350,
                              width: 350,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0).add(
                                      EdgeInsets.symmetric(horizontal: 35)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/ConfirmPayment.png'),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontFamily: 'Gilmer',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
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
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => printPDF(),
                        child: Container(
                          height: 50,
                          width: 320,
                          child: PhysicalModel(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                              child: Text(
                                "Generate Report",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontFamily: 'Gilmer',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: ((context) => MPesa())));
                        },
                        child: Container(
                          height: 50,
                          width: 320,
                          child: PhysicalModel(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                              child: Text(
                                "Close",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontFamily: 'Gilmer',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
        ));
  }
}
// import 'package:flutter/material.dart';

// import 'package:printing/printing.dart';
// import 'package:printing/printing.dart';
// import 'package:printing/printing.dart';

