// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:http/http.dart' as http;
// import 'package:inventory/API/config.dart';
//
// class Dashboard extends StatefulWidget {
//   final String token;
//   const Dashboard({required this.token, Key? key}) : super(key: key);
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   late String userId;
//   List<dynamic> items = [];
//
//   @override
//   void initState() {
//     super.initState();
//     Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.token);
//     if (jwtDecodedToken != null && jwtDecodedToken.containsKey('_id')) {
//       userId = jwtDecodedToken['_id'].toString();
//       fetchItems();
//     } else {
//       // Handle the case when the JWT token is invalid or doesn't contain the expected field
//       print('Invalid or missing _id field in the JWT token');
//     }
//   }
//
//   Future<void> fetchItems() async {
//     final response = await http.get(Uri.parse(getAddBarangList));
//     print(response.statusCode);
//     print(response.body);
//
//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
//       final responseData = jsonResponse['success'] as List<dynamic>;
//       setState(() {
//         items = responseData;
//       });
//     } else {
//       print('Failed to fetch items');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List View Page'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           final title = item['name'] ?? 'No Name';
//           final quantity = item['quantity'];
//           final price = item['price'];
//           final barcode = item['barcode'];
//
//           final subtitle = 'Quantity: $quantity, Price: $price, Barcode: $barcode';
//
//           return ListTile(
//             title: Text(title),
//             subtitle: Text(subtitle),
//           );
//         },
//       ),
//
//     );
//   }
// }
//
//
