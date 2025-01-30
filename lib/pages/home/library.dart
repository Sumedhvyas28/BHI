import 'package:bhi/pages/home/cart.dart';
import 'package:bhi/pages/home/checkoutpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All'; // Default category filter

  // Cart state
  List<Map<String, dynamic>> cartItems = [];

  // List to store books from Firestore
  List<Map<String, dynamic>> bookList = [];

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Fetch books when the page loads
  }

  Future<void> fetchBooks() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('BOOKS').get();

      List<Map<String, dynamic>> books = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;

        return {
          'id': doc.id,
          'title': data['title'] ?? 'Unknown Title',
          'author': data['author'] ?? 'Unknown Author',
          'category': data['category'] ?? 'Uncategorized',
          'image': data['image'] ?? '', // Default empty string if image is null
        };
      }).toList();

      setState(() {
        bookList = books;
      });
    } catch (e) {
      print("Error fetching books: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // List of unique categories with "All" as the default option
    final List<String> categories = [
      'All',
      ...bookList.map((item) => item['category'] as String).toSet().toList(),
    ];

    // Filtered list based on the search query and selected category
    final filteredItems = bookList.where((item) {
      final title = item['title'].toString().toLowerCase();
      final author = item['author'].toString().toLowerCase();
      final category = item['category'].toString();
      final matchesSearch =
          title.contains(_searchQuery) || author.contains(_searchQuery);
      final matchesCategory =
          _selectedCategory == 'All' || category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Library",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [
          // Cart icon
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // Navigate to the cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: screenWidth * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search bar
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.trim().toLowerCase();
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Search by title or author...',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.045,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      filled: true,
                      fillColor: Colors.black54,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              icon: const Icon(Icons.arrow_drop_down),
              underline: Container(), // Removes the underline
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: filteredItems.isEmpty
                  ? const Center(child: Text("No books available"))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 40,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigate to the CartPage with the selected book
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  cartItems: [
                                    filteredItems[index]
                                  ], // Pass the selected book
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: screenHeight * 0.25,
                                      maxWidth: screenWidth,
                                    ),
                                    child: filteredItems[index]['image'] !=
                                                null &&
                                            filteredItems[index]['image']
                                                .isNotEmpty
                                        ? Image.network(
                                            filteredItems[index]['image'],
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/home/flowery-book-separator.jpg',
                                                  fit: BoxFit.cover);
                                            },
                                          )
                                        : Image.asset(
                                            'assets/home/flowery-book-separator.jpg',
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                filteredItems[index]['title'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                filteredItems[index]['author'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
