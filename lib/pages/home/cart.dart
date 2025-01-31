import 'dart:io';
import 'package:bhi/constant/pallete.dart';
import 'package:bhi/pages/home/checkoutpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> firestoreData = [];
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
    fetchFirestoreData();
  }

  Future<void> fetchFirestoreData() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('BOOKS').get();
      final data = snapshot.docs.map((doc) {
        var bookData = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'title': bookData['title'] ?? 'Unknown Title',
          'author': bookData['author'] ?? 'Unknown Author',
          'ISBN': bookData['ISBN'] ?? 'N/A',
          'category': bookData['category'] ?? 'Uncategorized',
          'quantity': bookData['quantity'] ?? 0,
          'image': bookData['image'] ?? '', // Fetch image from Firestore
        };
      }).toList();

      print(data); // Debug: Print fetched data
      setState(() {
        firestoreData = data;
      });
    } catch (e) {
      print("Error fetching data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching data: $e")),
      );
    }
  }

  Future<void> exportData() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);

      try {
        // Read the CSV file content
        String fileContent = await file.readAsString();
        print("Raw CSV Content:\n$fileContent");

        List<List<dynamic>> csvTable =
            CsvToListConverter().convert(fileContent);
        print("Parsed CSV Table: $csvTable");

        if (csvTable.isNotEmpty) {
          // Ensure the first meaningful row is actually the header
          int headerRowIndex = csvTable.indexWhere((row) =>
              row.isNotEmpty &&
              row.any((cell) => cell.toString().trim().isNotEmpty));

          if (headerRowIndex == -1) {
            print("No valid header row found.");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("CSV format is incorrect.")),
            );
            return;
          }

          List<dynamic> headers = csvTable[headerRowIndex];
          print("Headers: $headers");

          // Process data rows
          for (var i = headerRowIndex + 1; i < csvTable.length; i++) {
            var row = csvTable[i];

            // Ensure row has enough columns
            if (row.length < 3) {
              print("Skipping invalid row: $row");
              continue;
            }

            print("Processing Row: $row");

            await FirebaseFirestore.instance.collection('BOOKS').add({
              'ISBN': row[2].toString(), // Assuming ISBN is in column index 2
              'category': row[8].toString(), // Assuming Genre is in index 8
              'title': row[3].toString(), // Title in index 3
              'author': row[4].toString(), // Author in index 4
              'quantity': int.tryParse(row[10].toString()) ??
                  0, // Convert Pages to quantity
            });
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("File uploaded and added to Firestore!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("CSV file is empty.")),
          );
        }
      } catch (e) {
        print("Error parsing CSV: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading file: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file selected.")),
      );
    }
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: exportData,
                child: const Text('Import CSV'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          firestoreData.isEmpty
              ? const Center(
                  child: Text(
                    'No data available.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(
                        screenWidth * 0.04), // Responsive padding
                    itemCount: firestoreData.length,
                    itemBuilder: (context, index) {
                      final item = firestoreData[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the CheckoutPage when card is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CheckoutPage(cartItems: [item]),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                screenWidth * 0.04), // Responsive padding
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: item['image'] != null &&
                                          item['image'].isNotEmpty
                                      ? Image.network(
                                          item['image'],
                                          fit: BoxFit.cover,
                                          width: screenWidth * 0.15,
                                          height: screenWidth * 0.15,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/home/flowery-book-separator.jpg',
                                              fit: BoxFit.cover,
                                              width: screenWidth * 0.15,
                                              height: screenWidth * 0.15,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          'assets/home/flowery-book-separator.jpg',
                                          fit: BoxFit.cover,
                                          width: screenWidth * 0.15,
                                          height: screenWidth * 0.15,
                                        ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'] ?? "no title",
                                        style: TextStyle(
                                          fontSize: screenWidth *
                                              0.045, // Adaptive font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item['author'] ?? "Author",
                                        style: TextStyle(
                                          fontSize: screenWidth *
                                              0.04, // Adaptive font size
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "ISBN: ${item['ISBN'] ?? 'N/A'}",
                                        style: TextStyle(
                                          fontSize: screenWidth *
                                              0.04, // Adaptive font size
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Quantity: ${item['quantity'] ?? 'N/A'}",
                                        style: TextStyle(
                                          fontSize: screenWidth *
                                              0.04, // Adaptive font size
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
