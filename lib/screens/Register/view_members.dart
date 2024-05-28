import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../component/Form/search_bar.dart';
import '../../component/appbars/CustomAppBar.dart';
// import 'register_members.dart';

class ViewMembers extends StatefulWidget {
  const ViewMembers({Key? key}) : super(key: key);

  @override
  State<ViewMembers> createState() => _ViewMembersState();
}

class _ViewMembersState extends State<ViewMembers> {
  late Stream<QuerySnapshot>? _membersStream;

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredMessages = [];

  List<Map<String, dynamic>> _messages = [];
  @override
@override
void initState() {
  super.initState();
  _membersStream =
      FirebaseFirestore.instance.collection('members').snapshots();

  // Listen to changes in the Firestore collection and update _messages accordingly
  _membersStream!.listen((QuerySnapshot snapshot) {
    setState(() {
      // _messages = snapshot.docs.map((doc) => doc.data()).toList();
    });
  });
}

void filterMembers(String query) {
  setState(() {
    filteredMessages = _messages.where((message) {
      final String memberName = message['first'].toString().toLowerCase();
      return memberName.contains(query.toLowerCase());
    }).toList();
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'View Members',
      ),
      body: Column(
        children: [
          CustomSearchBar(
            onSearch: filterMembers,
            searchController: _searchController,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _membersStream,
              builder: (context, snapshot) {
                if (_membersStream == null) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No members found.'));
                }

                final members = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member =
                        members[index].data() as Map<String, dynamic>;
                    return ViewData(
                      member: member['first'],
                      last: member['last'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ViewData extends StatelessWidget {
  final String member;
  final String last;

  ViewData({
    required this.member,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0).add(const EdgeInsets.symmetric(horizontal: 6)),
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        child: ListTile(
          title: Text('$member $last'),
          trailing: GestureDetector(
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(builder: ((context) => RegisterMember())));
            },
            child: Container(
              width: 50,
              height: 25,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, borderRadius: BorderRadius.circular(5)),
              child:    Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                       Text('Edit', style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: 14, fontWeight: FontWeight.w700   ),),
                                  ],
                  ),
                ),
              ),
              ),
          ),
        ),
      ),
    );
  }
}
