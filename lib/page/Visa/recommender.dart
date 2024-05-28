import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../component/Form/search_bar.dart';
import '../../component/appbars/CustomAppBar.dart';

class Recommender extends StatefulWidget {
  const Recommender({Key? key}) : super(key: key);

  @override
  State<Recommender> createState() => _RecommenderState();
}

class _RecommenderState extends State<Recommender> {
  late Stream<QuerySnapshot>? _childrenStream;

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredMessages = [];

  List<Map<String, dynamic>> _messages = [];
  @override
  void initState() {
    super.initState();
    _childrenStream =
        FirebaseFirestore.instance.collection('children').snapshots();
  }

  void filterMembers(String query) {
    setState(() {
      filteredMessages = _messages.where((message) {
        final String userId = message['children'].toString().toLowerCase();
        return userId.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Recommendations',
      ),
      body: Column(
        children: [
          // CustomSearchBar(
          //   onSearch: filterMembers,
          //   searchController: _searchController,
          // ),
            Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        height: 35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                            maxLines: 1,
                            minLines: 1,
                            cursorColor: Theme.of(context).colorScheme.tertiary,
                            style: TextStyle(
                              fontFamily: 'Gilmer',
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Search by Child\'s token",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                                fontFamily: "Gilmer",
                                fontWeight: FontWeight.w500,
                              ),
                              focusColor:
                                  Theme.of(context).colorScheme.tertiary,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 2),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 0,
                                ),
                              ),
                              fillColor:
                                  Theme.of(context).colorScheme.secondary,
                              filled: true,
                              prefixIcon: Icon(Icons.search,
                                  color: Theme.of(context).hintColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  width: 2,
                                ),
                              ),
                            )))),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _childrenStream,
              builder: (context, snapshot) {
                if (_childrenStream == null) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No children found.'));
                }

                final children = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    final child =
                        children[index].data() as Map<String, dynamic>;
                    return ViewData(
                      child: child['first_name'],
                      age: child['age'],
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
  final String child;
  final String age;

  ViewData({
    required this.child,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0).add(const EdgeInsets.symmetric(horizontal: 6)),
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        child: ListTile(
          title: Text('$child '),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                 Text('Age: ', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 14, fontWeight: FontWeight.w700   ),),
                Text('$age', style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 14, fontWeight: FontWeight.w700),),
              ],
            ),
            ),
          ),
        ),

    );
  }
}
