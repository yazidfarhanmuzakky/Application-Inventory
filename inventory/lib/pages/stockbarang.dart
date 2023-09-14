// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:http/http.dart' as http;
// import 'package:inventory/API/config.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class stockbarang extends StatefulWidget {
//   final token;
//   const stockbarang({@required this.token, Key? key}) : super(key: key);
//
//   @override
//   State<stockbarang> createState() => _stockbarangState();
// }
//
// class _stockbarangState extends State<stockbarang> {
//   late String userId;
//   TextEditingController _addbarangName = TextEditingController();
//   TextEditingController _addbarangquantity = TextEditingController();
//   TextEditingController _addbarangprice = TextEditingController();
//   TextEditingController _addbarangbarcode = TextEditingController();
//   List? items;
//
//   @override
//   void initState() {
//     super.initState();
//     Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
//     userId = jwtDecodedToken['_id'];
//     getAddBarangsList(userId);
//   }
//
//   void getAddBarangsList(userId) async {
//     var regBody = {
//       "userId": userId,
//     };
//
//     var response = await http.post(
//       Uri.parse(getAddBarangList),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(regBody),
//     );
//
//     var jsonResponse = jsonDecode(response.body);
//     items = jsonResponse['success'];
//
//     setState(() {});
//   }
//
//   void deleteItem(id) async {
//     var regBody = {
//       "id": id,
//     };
//
//     var response = await http.post(
//       Uri.parse(deleteAddBarang),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(regBody),
//     );
//
//     var jsonResponse = jsonDecode(response.body);
//     if (jsonResponse['status']) {
//       getAddBarangsList(userId);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start, // Add this line
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               top: 60.0,
//               left: 30.0,
//               right: 30.0,
//               bottom: 30.0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10.0),
//                 Text(
//                   'ToDo with NodeJS + Mongodb',
//                   style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   '5 Task',
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               child: items == null
//                   ? null
//                   : ListView.builder(
//                 itemCount: items!.length,
//                 itemBuilder: (context, int index) {
//                   return Slidable(
//                     key: const ValueKey(0),
//                     endActionPane: ActionPane(
//                       motion: const ScrollMotion(),
//                       dismissible: DismissiblePane(onDismissed: () {}),
//                       children: [
//                         SlidableAction(
//                           backgroundColor: Color(0xFFFE4A49),
//                           foregroundColor: Colors.white,
//                           icon: Icons.delete,
//                           label: 'Delete',
//                           onPressed: (BuildContext context) {
//                             print('${items![index]['_id']}');
//                             deleteItem('${items![index]['_id']}');
//                           },
//                         ),
//                       ],
//                     ),
//                     child: Card(
//                       child: ListTile(
//                         leading: Icon(Icons.task),
//                         title: Text('${items![index]['name']}'),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Quantity: ${items![index]['quantity']}'),
//                             Text('Price: ${items![index]['price']}'),
//                             Text('Barcode: ${items![index]['barcode']}'),
//                           ],
//                         ),
//                         trailing: Icon(Icons.arrow_back),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
