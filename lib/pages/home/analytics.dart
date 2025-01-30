import 'package:bhi/constant/pallete.dart';
import 'package:flutter/material.dart';

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
      'Amazon Link': '',
      'Language': 'English',
      'Genre': "Children's Book",
      'Binding': 'Pin',
      'Pages': 20,
      'MRP': 500,
      'Quantity': 3,
      'Description': "Join the Bullfrog as he sings his ballad...",
      'About Author': "A passionate children's book author...",
    },
    {
      'Publisher': "Author's Ink",
      'ISBN': '978939...',
      'Title': 'Papa 2',
      'Author': 'Jiganshu Sharma',
      'DOP': '2024-10-15',
      'Amazon Link': '',
      'Language': 'English',
      'Genre': 'Fiction',
      'Binding': 'Paperback',
      'Pages': 200,
      'MRP': 250,
      'Quantity': 2,
      'Description': "Once again, the demonic murder mystery...",
      'About Author': "Jiganshu Sharma is a bestselling novelist...",
    },
    {
      'Publisher': "Author's Ink",
      'ISBN': '978939...',
      'Title': 'Heroic Deceit',
      'Author': 'Salim Hansa',
      'DOP': '2024-10-15',
      'Amazon Link': '',
      'Language': 'English',
      'Genre': 'Fiction',
      'Binding': 'Paperback',
      'Pages': 194,
      'MRP': 350,
      'Quantity': 5,
      'Description': "Ali, a disillusioned corporate employee...",
      'About Author': "Salim Hansa is an Indian author known for...",
    }
  ];

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
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
                          Text("Publisher: ${order['Publisher']}"),
                          Text("ISBN: ${order['ISBN']}"),
                          Text("Binding: ${order['Binding']}"),
                          Text("Pages: ${order['Pages']}"),
                          Text("MRP: ${order['MRP']}"),
                          Text("Language: ${order['Language']}"),
                          Text("Description: ${order['Description']}"),
                          Text("About Author: ${order['About Author']}"),
                          Text("Ordered Quantity: ${order['Quantity']}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text("Order Analytics",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
