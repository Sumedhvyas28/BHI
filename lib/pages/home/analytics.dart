import 'package:bhi/constant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OrderAnalyticsPage extends StatefulWidget {
  const OrderAnalyticsPage({super.key});

  @override
  State<OrderAnalyticsPage> createState() => _OrderAnalyticsPageState();
}

class _OrderAnalyticsPageState extends State<OrderAnalyticsPage> {
  final List<Map<String, dynamic>> orders = [
    {
      'Publisher': "Author's Ink",
      'ISBN': '978939...',
      'Title': 'Ballad of A Bullfrog',
      'Author': 'Vibha Divekar',
      'DOP': '2024-10-20',
      'Genre': "Children's Book",
      'Quantity': 3,
    },
    {
      'Publisher': "Author's Ink",
      'ISBN': '978939...',
      'Title': 'Papa 2',
      'Author': 'Jiganshu Sharma',
      'DOP': '2024-10-15',
      'Genre': 'Fiction',
      'Quantity': 2,
    },
    {
      'Publisher': "Author's Ink",
      'ISBN': '978939...',
      'Title': 'Heroic Deceit',
      'Author': 'Salim Hansa',
      'DOP': '2024-10-15',
      'Genre': 'Fiction',
      'Quantity': 5,
    }
  ];

  int get totalOrderQuantity =>
      orders.fold(0, (sum, order) => sum + (order['Quantity'] as int));

  int get totalOrders => orders.length;

  Map<String, List<String>> getOrdersByDate() {
    Map<String, List<String>> dateOrders = {};
    for (var order in orders) {
      dateOrders.putIfAbsent(order['DOP'], () => []).add(order['Title']);
    }
    return dateOrders;
  }

  Map<String, int> getGenreDistribution() {
    Map<String, int> genreMap = {};
    for (var order in orders) {
      genreMap[order['Genre']] =
          (genreMap[order['Genre']] ?? 0) + order['Quantity'] as int;
    }
    return genreMap;
  }

  @override
  Widget build(BuildContext context) {
    final genreData = getGenreDistribution();
    final orderDates = getOrdersByDate();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Analytics",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Metrics (Top Section)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryTile(
                          "Total Order Quantity", totalOrderQuantity),
                      _buildSummaryTile("Number of Orders", totalOrders),

                      // Order Date Section
                      const SizedBox(height: 10),
                      const Text(
                        "Order Dates & Books",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orderDates.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              "${entry.key}: ${entry.value.join(', ')}",
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ),

                      // Genre-Specific Section
                      const SizedBox(height: 10),
                      const Text(
                        "Genre-Specific Books",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      _buildSummaryTile("Unique Genres", genreData.length),

                      // Show list of genres & their quantities
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: genreData.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              "${entry.key}: ${entry.value} books",
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Pie Chart for Genre-Specific Distribution
              const Text(
                "Genre-Specific Distribution",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: genreData.entries
                        .map((e) => PieChartSectionData(
                              title: "${e.key}\n(${e.value})",
                              value: e.value.toDouble(),
                              color: _getGenreColor(e.key),
                              radius: 50,
                            ))
                        .toList(),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Order List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.book,
                                color: Pallete.mainDashColor, size: 40),
                            title: Text(
                              order['Title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                                "Author: ${order['Author']}\nGenre: ${order['Genre']}",
                                style: const TextStyle(fontSize: 14)),
                          ),
                          Text("Ordered Quantity: ${order['Quantity']}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20), // Adds space before bottom elements
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryTile(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value.toString(), style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Color _getGenreColor(String genre) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple
    ];
    return colors[genre.hashCode % colors.length];
  }
}
