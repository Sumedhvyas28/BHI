import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CheckoutPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Razorpay razorpay = Razorpay();
  double calculateTotal() {
    double total = 0.0;
    for (var item in widget.cartItems) {
      total += (item['price'] ?? 0) * (item['quantity'] ?? 1);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    final totalAmount = calculateTotal();
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: const Text(
                '123 Main Street, Springfield, USA',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return ListTile(
                    leading: ClipRRect(
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
                            color:
                                Colors.grey, // Icon color for better visibility
                          );
                        },
                      ),
                    ),
                    title: Text(
                      item['title'] ?? "NAME",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Qty: ${item['quantity']} ' ?? "NAME",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Text(
                      '\$${((item['price'] ?? 0) * (item['quantity'] ?? 1)).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  var options = {
                    'key': 'rzp_test_GcZZFDPP0jHtC4',
                    'amount': (totalAmount * 100).toInt(),
                    'name': 'Bhi.',
                    'description': 'Books',
                    'prefill': {
                      'contact': '8888888888',
                      'email': 'test@razorpay.com'
                    }
                  };

                  razorpay.open(options);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Order placed successfully!')),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}");
    Fluttertoast.showToast(msg: "Payment Success: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");
    Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    try {
      razorpay.clear();
      print('ffff');
    } catch (e) {
      print(e);
      print('feeee');
    }
  }
}
