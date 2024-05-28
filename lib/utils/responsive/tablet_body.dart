import 'package:flutter/material.dart';
import 'package:visamate/component/drawer.dart';

import '../../component/cards/my_box.dart';
import '../../component/cards/my_tile.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold();

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: TabletAppbar(context),
      drawer: const IconMenu(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // first 4 boxes in grid
            AspectRatio(
              aspectRatio: 2,
              child: SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 1.0, // Maintain square aspect ratio
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // First instance of MyBox with different properties
                      return const MyBox(
                        title: 'My Tasks',  
                      );
                    } else if (index == 1) {
                      // Second instance of MyBox with different properties
                      return const MyBox(
                        title: 'My Status',
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            // list of previous days
            // Expanded(
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // First instance of MyBox with different properties
                      return const MyTile(
                        title: 'Farm Setup',
                      );
                    } else if (index == 1) {
                      // Second instance of MyBox with different properties
                      return const MyTile(
                        title: 'Consultation Services',
                      );
                    } else if (index == 2) {
                      // Second instance of MyBox with different properties
                      return const MyTile(
                        title: 'Billings & Transactions',
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
            ),
            GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                              children: [
                  Text(
                    'News Feed',
                    style: TextStyle(
                      fontFamily: 'Gilmer',
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onBackground,
                     fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    'More',
                    style: TextStyle(
                      fontFamily: 'Gilmer',
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.tertiary,
                     fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,size: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  )
                              ],
                            ),
                )),
            // Expanded(
            //   child:  Row(
            //     children: [const NewsFeed(hint: 'News\nFeed')],
            //   )
                
                   
                  
            // ),
            //
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AppBar TabletAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TabletScaffold(),
              ));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/visamate_logo_mark.png',
                      width: 28, height: 28),
                ),
              ],
            ),
          ),
        ),
      ],
      centerTitle: true, // Center the title
      title: Container(
        width:
            double.infinity, // Make the TextField take up the available width
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .secondary, // Set the background color of the search bar
          borderRadius:
              BorderRadius.circular(5.0), // Adjust the border radius as needed
        ),
        child: TextFormField(
          maxLines: 1,
          // controller: widget.controller,
          cursorColor: Theme.of(context).colorScheme.tertiary,
          minLines: 1,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter ${widget.text}';
          //   }
          //   return null;
          // },

          style: TextStyle(
            fontFamily: 'Gilmer',
            fontSize: 14,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w300,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,

            disabledBorder: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
              fontFamily: "Gilmer",
              fontWeight: FontWeight.w700,
            ),
            focusColor: Theme.of(context).colorScheme.tertiary,
            // suffixIcon: Icon(widget.suffix, color: Theme.of(context).colorScheme.te),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 2),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 0),
            ),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            prefixIcon: Icon(Icons.search, color: Theme.of(context).hintColor),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
