import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../component/appbar.dart';
import 'view_members.dart';

class MemberDetailsScreen extends StatelessWidget {
  final DocumentReference memberRef;

  const MemberDetailsScreen({Key? key, required this.memberRef})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Member Details",
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: memberRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Member not found.'));
          }

          // Access member data from snapshot
          final memberData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8)),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'First Name:',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18),
                            ),
                            const Spacer(flex: 1),
                            Text(
                              '${memberData['first']}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Last Name:',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18),
                            ),
                            const Spacer(flex: 1),
                            Text(
                              '${memberData['last']}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Phone:',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18),
                            ),
                            const Spacer(flex: 1),
                            Text(
                              '${memberData['phone']}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Cell:',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18),
                            ),
                            const Spacer(flex: 1),
                            Text(
                              '${memberData['cell']}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Church:',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18),
                            ),
                            const Spacer(flex: 1),
                            Text(
                              '${memberData['group']}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Zone:',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18),
                            ),
                            const Spacer(flex: 1),
                            Text(
                              '${memberData['zone']}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: 260.0,
                                  maxWidth: 304.0,
                                  minHeight: 50,
                                  maxHeight: 50),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewMembers()));
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary
                                          // : Theme.of(context).buttonTheme.,
                                          ),
                                      child: Center(
                                        child: Text(
                                          'View members',
                                          style: TextStyle(
                                            fontFamily: 'Gilmer',
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
