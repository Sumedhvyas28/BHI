import 'package:flutter/material.dart';

class BottomDrawerPage extends StatelessWidget {
  final Map<String, dynamic> book;

  const BottomDrawerPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.005,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  book['title'],
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'by ${book['author']}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(book['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    5,
                    (starIndex) => Icon(
                      Icons.star,
                      size: screenWidth * 0.06,
                      color: starIndex < book['rating'].round()
                          ? Colors.yellow
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "This is a brief description of the book. Add any additional details you want here to make it informative and engaging.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
