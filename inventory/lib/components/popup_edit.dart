// import 'package:flutter/material.dart';
// // import 'package:inventory/components/stock_item.dart';
// import 'package:inventory/pages/stock_barang.dart';
// import 'stock_item.dart';
// import 'edit_stock_item_dialog.dart';
// import 'package:inventory/components/edit_stock_item_dialog.dart';
//
// class EditStockItemDialog extends StatefulWidget {
//   final StockItem stockItem;
//   final Function(StockItem) updateStockItem;
//
//   const EditStockItemDialog({
//     required this.stockItem,
//     required this.updateStockItem,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _EditStockItemDialogState createState() => _EditStockItemDialogState();
// }
//
// class _EditStockItemDialogState extends State<EditStockItemDialog> {
//   late TextEditingController nameController;
//   late TextEditingController quantityController;
//   late TextEditingController priceController;
//
//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.stockItem.name);
//     quantityController = TextEditingController(
//         text: widget.stockItem.quantity?.toString() ?? '');
//     priceController = TextEditingController(
//         text: widget.stockItem.price?.toString() ?? '');
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     quantityController.dispose();
//     priceController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Edit Stock Item'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: nameController,
//             decoration: InputDecoration(labelText: 'Name'),
//           ),
//           TextField(
//             controller: quantityController,
//             decoration: InputDecoration(labelText: 'Quantity'),
//             keyboardType: TextInputType.number,
//           ),
//           TextField(
//             controller: priceController,
//             decoration: InputDecoration(labelText: 'Price'),
//             keyboardType: TextInputType.number,
//           ),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             final newName = nameController.text;
//             final newQuantity = int.tryParse(quantityController.text) ?? 0;
//             final newPrice = double.tryParse(priceController.text) ?? 0.0;
//
//             // Call the updateStockItem method from the parent widget
//             widget.updateStockItem(
//               StockItem(
//                 name: newName,
//                 quantity: newQuantity,
//                 price: newPrice,
//               ),
//             );
//
//             Navigator.pop(context); // Close the dialog
//           },
//           child: Text('Save'),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context); // Close the dialog
//           },
//           child: Text('Cancel'),
//         ),
//       ],
//     );
//   }
// }
//
// StockItemupdate(String newName, int newQuantity, double newPrice) {
//   return StockItem(
//     name: newName,
//     quantity: newQuantity,
//     price: newPrice,
//   );
// }
//
// typedef UpdateStockItem = void Function(StockItem oldItem, StockItem newItem);