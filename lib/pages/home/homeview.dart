import 'dart:ui';

import 'package:bhi/constant/pallete.dart';
import 'package:bhi/model/book.dart';
import 'package:bhi/pages/home/bottom_drawer.dart';
import 'package:bhi/pages/home/cart.dart';
import 'package:bhi/pages/home/description.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  bool _isDrawerOpen = false;

  void _showBottomDrawer(BuildContext context, Map<String, dynamic> book) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    List<Map<String, dynamic>> cartItems = [];
    void _addToCart(Map<String, dynamic> book) {
      setState(() {
        cartItems.add(book);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${book['title']} added to cart!')),
      );
    }

    void _navigateToCart() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(cartItems: cartItems),
        ),
      );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Text(
                      book['title'] ?? 'Unknown Title',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book['author'] ?? 'Unknown Author',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        image: book['image'] != null
                            ? DecorationImage(
                                image: AssetImage(book['image']),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: List.generate(
                        5,
                        (starIndex) => Icon(
                          Icons.star,
                          color: starIndex < (book['rating'] ?? 0).round()
                              ? Colors.yellow
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Genre",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book['genre'] ?? 'No description available.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Publication Year",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book['publicationYear'],
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book['mainDescription'] ?? 'No description available.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.mainFontColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                        ),
                        onPressed: () {
                          _addToCart(book);
                          _navigateToCart();
                        },
                        label: const Text(
                          'ADD TO CART',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Existing content here...
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Pallete.mainDashColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.04),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Upcoming",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.05,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 126, 162, 175),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Text(
                                            "Learn more",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenWidth * 0.04,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: index == 0
                                      ? Image.asset(
                                          "assets/home/making.jpg", // Photo for first page

                                          fit: BoxFit.fitWidth,
                                        )
                                      : index == 1
                                          ? Image.asset(
                                              "assets/home/evie.jpg", // Photo for first page
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/home/5 types of we.jpg", // Photo for first page
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

// Page Indicator
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotHeight: screenWidth * 0.015,
                        dotWidth: screenWidth * 0.015,
                        activeDotColor: Pallete.mainDashColor,
                        dotColor: Colors.grey.shade400,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Section Title
                  Text(
                    "Best Seller",
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Horizontal List of Books
                  SizedBox(
                    height: screenHeight * 0.35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return GestureDetector(
                          onTap: () => _showBottomDrawer(context, book),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02),
                            child: Column(
                              children: [
                                Container(
                                  width: screenWidth * 0.25,
                                  height: screenHeight * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(book['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  (book['title']?.split(' ').first ??
                                      'Unknown Title'),
                                  maxLines: 1, // Ensures it shows only one line
                                  overflow: TextOverflow
                                      .ellipsis, // Adds "..." if the text overflows
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.035,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  book['author'],
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    5,
                                    (starIndex) => Icon(
                                      Icons.star,
                                      size: screenWidth * 0.04,
                                      color: starIndex < book['rating']
                                          ? Colors.yellow
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Trending Section
                  Text(
                    "Trending",
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Card(
                    // color: Colors.white54,
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        width: double.infinity,
                        // Adjust height to be more flexible
                        height: screenHeight * 0.35,
                        child: Row(
                          children: [
                            // Image container with some padding for better spacing
                            Container(
                              color: Colors.white24,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/home/alech.jpg', // Updated image asset
                                  width: screenWidth *
                                      0.31, // Flexible image width
                                  height: screenHeight *
                                      0.3, // Flexible image height
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: screenWidth *
                                    0.05), // Spacing between image and text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title with adaptive font size
                                  Text(
                                    'The Alchemist',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenWidth > 600
                                          ? 22
                                          : 18, // Responsive font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  // Author and format text with adaptive font size
                                  Text(
                                    'Paulo Coelho',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: screenWidth > 600 ? 16 : 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  // Rating text with adaptive font size
                                  Text(
                                    '4.6 out of 5 stars    45,602 ratings',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: screenWidth > 600 ? 16 : 14,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  // Description text with ellipsis for overflow
                                  Text(
                                    'Paulo Coelhos enchanting novel has inspired a devoted following...',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenWidth > 600 ? 16 : 14,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  // Read More button with better padding and border radius
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: Pallete.mainDashColor,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                    ),
                                    onPressed: () {
                                      // Navigate to the Description Page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DescriptionPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Read More',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (_isDrawerOpen)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
        ],
      ),
    );
  }
}
