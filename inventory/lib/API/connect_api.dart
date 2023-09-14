// import 'package:flutter/material.dart';
// import 'package:mysql1/mysql1.dart';
//
// Future<int> checkCredentials(int id, String username, String password) async {
//   final settings = ConnectionSettings(
//     host: 'localhost',
//     port: 3306,
//     user: 'root',
//     password: '',
//     db: 'localconnect',
//   );
//
//   final conn = await MySqlConnection.connect(settings);
//
//   var result = await conn.query(
//     'CALL check_credentials(?, ?, ?, @result)',
//     [id, username, password],
//   );
//
//   var selectResult = await conn.query('SELECT @result');
//
//   var row = selectResult.first;
//   var isValid = row['@result'];
//
//   await conn.close();
//
//   return isValid == 1 ? 1 : 0;
// }