import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:inventory/API/config.dart';
import 'package:inventory/pages/editbarangpage.dart';

class Stock_barang extends StatefulWidget {
  final String token;
  const Stock_barang({required this.token, Key? key}) : super(key: key);

  @override
  State<Stock_barang> createState() => _Stock_barangState();
}

class _Stock_barangState extends State<Stock_barang> {
  late String userId;
  List<dynamic> items = [];
  List<dynamic> filteredItems = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.token);
    if (jwtDecodedToken != null && jwtDecodedToken.containsKey('_id')) {
      userId = jwtDecodedToken['_id'].toString();
      fetchItems();
    } else {
      print('Invalid or missing _id field in the JWT token');
    }
  }

  void deleteItem(String id) async {
    var regBody = {
      "id": id
    };
    var response = await http.post(
      Uri.parse(deleteAddBarang),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Barang Berhasil Dihapus"),
            content: Text("Barang telah berhasil dihapus."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  fetchItems();
                },
                child: Text("OK"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> fetchItems() async {
    setState(() {
      _isRefreshing = true;
    });

    final response = await http.get(Uri.parse(getAddBarangList));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final responseData = jsonResponse['success'] as List<dynamic>;
      setState(() {
        items = responseData;
        filteredItems = items; // Initialize filteredItems with all items
      });
    } else {
      print('Failed to fetch items');
    }

    setState(() {
      _isRefreshing = false;
    });
  }

  void showItemDialog(dynamic item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final title = item['name'] ?? 'No Name';
        final quantity = item['quantity'];
        final price = item['price'];
        final barcode = item['barcode'];

        final quantityFormatted = NumberFormat.decimalPattern().format(quantity);
        final priceFormatted = NumberFormat.decimalPattern().format(price);
        final subtitle = 'Jumlah: $quantityFormatted. Harga: $priceFormatted. Kode: $barcode.';

        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle edit action
                      Navigator.pop(context); // Close the dialog
                      navigateToEditPage(item);
                    },
                    child: Text('Edit'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle delete action
                      deleteItem(item['_id']);
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('Delete'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // Handle close action
                Navigator.pop(context); // Close the dialog
              },
              icon: Icon(Icons.close),
            ),
          ],
        );
      },
    );
  }


  void navigateToEditPage(dynamic item) {
    final itemId = item['_id'];
    final itemName = item['name'] ?? '';
    final itemQuantity = item['quantity'] ?? 0;
    final itemPrice = item['price'] ?? 0;
    final itemBarcode = item['barcode'] ?? 0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDataPage(
          itemId: itemId,
          itemName: itemName,
          itemQuantity: itemQuantity,
          itemPrice: itemPrice,
          itemBarcode: itemBarcode,
          token: widget.token,
        ),
      ),
    );
  }

  void filterItems(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredItems = items; // If the keyword is empty, show all items
      } else {
        filteredItems = items.where((item) {
          final title = item['name'] ?? '';
          return title.toLowerCase().contains(keyword.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: TextField(
          controller: _searchController,
          onChanged: filterItems,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isRefreshing
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          final title = item['name'] ?? 'No Name';
          final quantity = item['quantity'];
          final price = item['price'];
          final barcode = item['barcode'];

          final quantityFormatted = NumberFormat.decimalPattern().format(quantity);
          final priceFormatted = NumberFormat.decimalPattern().format(price);
          final subtitle = 'Jumlah: $quantityFormatted. Harga: $priceFormatted. Kode: $barcode.';

          return Card(
            elevation: 2, // Adjust the elevation as needed
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust the margins as needed
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              onTap: () {
                showItemDialog(item);
              },
            ),
          );
        },
      ),
    );
  }
}
