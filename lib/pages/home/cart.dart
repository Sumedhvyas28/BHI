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
      final data = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
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
        List<List<dynamic>> csvTable =
            CsvToListConverter().convert(fileContent);

        // Convert CSV rows to maps and upload to Firestore
        for (var row in csvTable.skip(1)) {
          // Skip the header row
          await FirebaseFirestore.instance.collection('BOOKS').add({
            'ISBN': row[0].toString(),
            'category': row[1].toString(),
            'quantity': row[2],
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("File uploaded and added to Firestore!")),
        );
      } catch (e) {
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
                child: const Text('Export CSV'),
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
                                  child: Image.asset(
                                    item['image'] ??
                                        '', // Use an empty string as fallback for image
                                    fit: BoxFit.cover,
                                    width: screenWidth *
                                        0.15, // Adjust width based on screen size
                                    height: screenWidth *
                                        0.15, // Adjust height based on screen size
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fallback to an Icon when image is broken or unavailable
                                      return Icon(
                                        Icons
                                            .image, // Icon representing an image (use any icon you prefer)
                                        size: screenWidth *
                                            0.15, // Icon size proportional to the image size
                                        color: Colors
                                            .grey, // Icon color for better visibility
                                      );
                                    },
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
