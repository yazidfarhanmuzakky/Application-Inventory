import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/API/config.dart';
import 'package:inventory/pages/home.dart';

class EditDataPage extends StatefulWidget {
  final String itemId;
  final String itemName;
  final int itemQuantity;
  final int itemPrice;
  final int itemBarcode;
  final String token;

  const EditDataPage({
    required this.itemId,
    required this.itemName,
    required this.itemQuantity,
    required this.itemPrice,
    required this.itemBarcode,
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController barcodeController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.itemName);
    quantityController = TextEditingController(text: widget.itemQuantity.toString());
    priceController = TextEditingController(text: widget.itemPrice.toString());
    barcodeController = TextEditingController(text: widget.itemBarcode.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    barcodeController.dispose();
    super.dispose();
  }

  void updateData() async {
    setState(() {
      _isLoading = true;
    });
    final updatedName = nameController.text;
    final updatedQuantity = int.parse(quantityController.text);
    final updatedPrice = int.parse(priceController.text);
    final updatedBarcode = int.parse(barcodeController.text);

    final requestBody = {
      "userId": widget.itemId,
      "name": updatedName,
      "quantity": updatedQuantity,
      "price": updatedPrice,
      "barcode": updatedBarcode,
    };

    final response = await http.post(
      Uri.parse(updateAddBarang),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
      body: jsonEncode(requestBody),
    );

    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // Data updated successfully
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Data Berhasil Disimpan"),
            content: Text("Data barang telah berhasil disimpan."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(token: widget.token)));
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
    } else {
      print("Something Went Wrong");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Edit Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: barcodeController,
              decoration: InputDecoration(labelText: 'Kode'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: updateData,
              child: Text('Save'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
