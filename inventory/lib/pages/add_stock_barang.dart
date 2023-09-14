import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:inventory/API/config.dart';

class AddBarangPage extends StatefulWidget {
  final token;
  const AddBarangPage({@required this.token,Key? key}) : super(key: key);

  @override
  _AddBarangPageState createState() => _AddBarangPageState();
}

class _AddBarangPageState extends State<AddBarangPage> {
  late String userId;
  final TextEditingController _addbarangname = TextEditingController();
  final TextEditingController _addbarangquantity = TextEditingController();
  final TextEditingController _addbarangprice = TextEditingController();
  final TextEditingController _addbarangbarcode = TextEditingController();
  List? items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    if (jwtDecodedToken != null) {
      userId = jwtDecodedToken['_id'];
    }
  }

  void addAddBarang() async {
    if (_addbarangname.text.isNotEmpty &&
        _addbarangquantity.text.isNotEmpty &&
        _addbarangprice.text.isNotEmpty &&
        _addbarangbarcode.text.isNotEmpty) {
      var regBody = {
        // "userId": userId,
        "name": _addbarangname.text,
        "quantity": _addbarangquantity.text,
        "price": _addbarangprice.text,
        "barcode": _addbarangbarcode.text
      };
      var response = await http.post(Uri.parse(createAddBarang),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        _addbarangname.clear();
        _addbarangquantity.clear();
        _addbarangprice.clear();
        _addbarangbarcode.clear();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        'Data Barang Berhasil Ditambahkan',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Barang Berhasil Ditambahkan',
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                    const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(8),
                ),
                    child:TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pop(context); // Go back to the previous page
                      },
                      child: const Text(
                        'Selesai',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        print("Something Went Wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text('Tambahkan Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _addbarangname,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Nama Barang',
                filled: true,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _addbarangquantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Barang',
                filled: true,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _addbarangprice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga Barang',
                filled: true,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _addbarangbarcode,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Kode Barang',
                filled: true,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Call the function to add the new barang
                addAddBarang();
              },
              child: const Text('Tambahkan Barang'),
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
