// import 'package:flip_card/flip_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'CountryMap.dart';

// class Country extends StatelessWidget {
//   static const routeName = '/country';

//   final Map country;

//   Country(this.country);



//   @override
//   Widget build(BuildContext context) {

//     print(this.country);

//     final Map country = ModalRoute.of(context).settings.arguments;
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.cyan,
//         title: Text(this.country['name']),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10),
//         child: GridView(
//           gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           children: <Widget>[
//             FlipCard(
//               direction: FlipDirection.HORIZONTAL, // default
//               front: CountryCard(title: 'Capital'),
//               back: DetailCard(
//                 title: this.country['capital'],
//                 bgcolor: Colors.deepOrange,
//               ),
//             ),
//             FlipCard(
//               direction: FlipDirection.HORIZONTAL, // default
//               front: CountryCard(title: 'Population'),
//               back: DetailCard(
//                 title: this.country['population'].toString(),
//                 bgcolor: Colors.deepPurple,
//               ),
//             ),
//             FlipCard(
//               direction: FlipDirection.HORIZONTAL, // default
//               front: CountryCard(title: 'Flag'),
//               back: Card(
//                 color: Colors.white,
//                 elevation: 10,
//                 child: Center(
//                   child: SvgPicture.network(
//                     this.country['flag'],
//                     width: 200,
//                   ),
//                 ),
//               ),
//             ),
//             FlipCard(
//               direction: FlipDirection.HORIZONTAL, // default
//               front: CountryCard(title: 'Currency'),
//               back: DetailCard(
//                 title: this.country['currencies'][0]['name'],
//                 bgcolor: Colors.blue,
//               ),
//             ),
//             GestureDetector(
//               child: CountryCard(
//                 title: 'Show On Map',
//               ),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         CountryMap(this.country['name'], this.country['latlng']),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CountryCard extends StatelessWidget {
//   final String title;

//   const CountryCard({Key key, this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       child: Center(
//           child: Text(
//         title,
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       )),
//     );
//   }
// }

// class DetailCard extends StatelessWidget {
//   final String title;
//   final MaterialColor bgcolor;

//   DetailCard({this.title, this.bgcolor});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Card(
//       color: bgcolor,
//       elevation: 10,
//       child: Center(
//         child: Text(
//           title,
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       ),
//     );
//   }
// }