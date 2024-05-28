import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:visamate/component/appbars/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../component/Form/FormOptions.dart';
import '../../component/Form/FormText.dart';
import '../../component/Form/TextAction.dart';
import '../../component/cards/check_box_card.dart';
import '../../component/constants/List.dart';
// import 'report_pdf.dart';
import 'package:visamate/component/snacky.dart' as snackBarHelper;
import '../../component/listview/ListBuilder.dart';
import '../../component/slider_view.dart';
import '../../manager/location_manager.dart';
import '../../styles/pallete.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:visamate/component/currency_picker.dart';
import '../../component/country_picker.dart';
import '../../component/custom_calendar.dart';

import 'package:visamate/component/form/CustomButton.dart';
import 'widgets/duration_widget.dart';
import 'widgets/kyc_widget.dart';
import 'widgets/names_widget.dart';
import '../../utils/responsive/mobile_body.dart';
import 'widgets/reason_widget.dart';
import 'widgets/recommendation_list.dart';

class SetupProfile extends StatefulWidget {
  const SetupProfile({Key? key}) : super(key: key);

  @override
  State<SetupProfile> createState() => _SetupProfileState();
}

class _SetupProfileState extends State<SetupProfile> {
  int activeStep = 0;
  List<bool> isSelectedList = [];
  bool isLoading = true;
  double start = 5000.0;
  double end = 10000.0;

  List<QueryDocumentSnapshot> members = [];
  Map<String, bool> SetupProfileMap = {};
  TextEditingController _serviceType = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  final GlobalKey _formKey = GlobalKey();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  // final TextEditingController _birthdayController = TextEditingController();
  // final TextEditingController _branchController = TextEditingController();
  bool isSliderInteracted = false;

  DateTime? selectedEndDate;
  DateTime? selectedStartDate;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  TextEditingController _datePicker = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    fetchMemberDataFromFirestore();
    getLocationUpdates();
  }
  Future<void> _getVisaRecommendations() async {
    // Replace with your OpenAI API key
    const clientApiKey =
        'sk-proj-CBO5yMdRYD4CfKbjqX9qT3BlbkFJ7E0vW5SScyC0f00ajQDz';

    final model = ChatOpenAI(apiKey: clientApiKey);
    final combinedPrompt = ChatPromptTemplate.fromTemplate(
        "Recommend 10 countries where a user can be able to apply for a travel visa to provided the country they come from {country}, their preferred religion {religion}, their most preferred language {language}, their purpose of travel {reason}, their budget of expected travel expenses{budget} in the selected currency {currency}");

    const visaRecommendation = ChatFunction(
      name: "get_visa_recommendations",
      description: "Get visa recommendations based on user profile",
      parameters: {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "destination": {
              "type": "string",
              "description": "Destination country must be standardized",
            },
            "country_code": {
              "type": "string",
              "description":
                  "Country code of the destination country must be standardized in ISO 4217 format",
            },
            "visa_type": {
              "type": "string",
              "description": "Type of visa required according to the reason",
            },
            "visa_cost": {
              "type": "string",
              "description":
                  "The cost of the visa in the preferred user currency, if there is no cost then return value 'FREE'",
            },
            "documents": {
              "type": "string",
              "description":
                  "A list of all documents required separated by a comma",
            },
            "visa_duration": {
              "type": "string",
              "description": "The number of days allowed for the visa",
            },
            "processing_time": {
              "type": "string",
              "description":
                  "The time it would take for the visa to be processed",
            },
          },
        },
      },
    );

    final chain = combinedPrompt | model | JsonOutputFunctionsParser();

    final res = await chain.invoke({
      'country': _countryController.text.trim(),
      'religion': _religionController.text.trim(),
      'language': _languageController.text.trim(),
      'reason': _reasonController.text.trim(),
      'currency': _currencyController.text.trim(),
      'budget': _budgetController.text.trim(),
    });

    // Handle the result here
    print(res);
  }

  

  // Function to save information to Firestore
  Future<void> saveToFirestore(
      List<Map<String, dynamic>> members, String sType) async {
    try {
      final CollectionReference membersCollection =
          FirebaseFirestore.instance.collection('members');

      for (var member in members) {
        // Query Firestore to find the document ID of the member
        QuerySnapshot querySnapshot = await membersCollection
            .where('first', isEqualTo: member['first'])
            .where('last', isEqualTo: member['last'])
            .limit(1)
            .get();

        // Check if the member exists
        if (querySnapshot.docs.isNotEmpty) {
          String memberId = querySnapshot.docs.first.id;

          // Update the existing member's SetupProfile information
          await membersCollection.doc(memberId).update({
            'serviceAttended': sType ?? 'Service',
          });

          print(
              'SetupProfile updated for ${member['first']} ${member['last']}');
        } else {
          print(
              'Member ${member['first']} ${member['last']} not found in Firestore.');
        }
      }

      print('Information saved to Firestore successfully!');
    } catch (e) {
      print('Error saving information to Firestore: $e');
    }
  }

  Widget buildDatePicker() {
    return DatePicker(
      text: 'Date',
      controller: _datePicker,
    );
  }

  Future<void> fetchMemberDataFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('members')
          .limit(10)
          .get();

      setState(() {
        members = querySnapshot.docs;
        isSelectedList = List.filled(members.length, true);
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String sType = _serviceType.text.toString();
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: "User Profile",
            onClickedBack: () {
              Navigator.of(context).pop();
            },
            onClickedHome: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => const MobileScaffold()));
            },
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.tertiary))
              : Center(
                  child: SizedBox(
                    width: 400,
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        NumberStepper(
                          lineLength: 25,
                          stepRadius: 15,
                          stepPadding: 0.0,
                          numbers: const [1, 2, 3, 4, 5],
                          lineColor: Theme.of(context).colorScheme.tertiary,
                          activeStepColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeStepBorderColor:
                              Theme.of(context).colorScheme.tertiary,
                          stepColor: Theme.of(context).colorScheme.onBackground,
                          activeStep: activeStep,
                          onStepReached: (index) {
                            setState(() {
                              activeStep = index;
                            });
                          },
                        ),
                        Expanded(
                          // width:400 ,
                          child: IndexedStack(
                            index: activeStep,
                            children: [
                              // Names
                              NameWidget(context),
                              // KYC details
                              KYCWidget(context), // Budget
                              // Reason
                              ReasonWidget(context),
                              // Duration
                              DurationWidget(context),
                              // List of recommendations
                              RecommendationList(context)
                             ],
                          ),
                        )
                      ]),
                    ),
                  ),
                )),
    );
  }

  Widget generateSummary() {
    // Extract present members
    final presentMembers = SetupProfileMap.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    // Extract absent members
    final absentMembers =
        members.where((member) => !presentMembers.contains(member.id)).toList();

    return Column(
      children: [
        Text('Present Members:'),
        presentMembers.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: presentMembers.length,
                itemBuilder: (context, index) => Text(presentMembers[index]),
              )
            : Text('No members present'),
        SizedBox(height: 20),
        Text('Absent Members:'),
        absentMembers.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: absentMembers.length,
                itemBuilder: (context, index) =>
                    Text(absentMembers[index]['first'] ?? ''),
              )
            : Text('All members present'),
      ],
    );
  }

  bool isAnySelectionMade() {
    return isSelectedList.any((selected) => selected);
  }
}

class Summary extends StatelessWidget {
  final String member;
  final String last;
  final bool isSelected;
  final String serviceAttended;

  const Summary({
    Key? key,
    required this.member,
    required this.last,
    required this.isSelected,
    required this.serviceAttended,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Text('$member $last'),
          subtitle: Container(
            width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isSelected
                    ? Theme.of(context).colorScheme.tertiary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.error.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  isSelected ? 'Present' : 'Absent',
                  style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.error),
                ),
              ),
            ),
          ),
          trailing: Text(
            serviceAttended,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700), // Display service attended
            // No need for a Checkbox in this modified version
            // onChanged: onSelectionChange,
          ),
        ));
  }
}

