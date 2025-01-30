import 'dart:async';
import 'package:bhi/constant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class LiveOrderStatusPage extends StatefulWidget {
  const LiveOrderStatusPage({Key? key}) : super(key: key);

  @override
  _LiveOrderStatusPageState createState() => _LiveOrderStatusPageState();
}

class _LiveOrderStatusPageState extends State<LiveOrderStatusPage> {
  List<String> orderStatuses = [
    "Order Placed",
    "Packed",
    "Dispatched",
    "In Transit",
    "Out for Delivery",
    "Delivered"
  ];
  int currentStatusIndex = 0;

  @override
  void initState() {
    super.initState();
    _startLiveUpdate();
  }

  void _startLiveUpdate() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentStatusIndex < orderStatuses.length - 1) {
        setState(() {
          currentStatusIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Order Status"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Center(
              child: Text(
                "Track Your Order",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Order Status Steps
            Expanded(
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0.0, // Keeps the line on the left
                  indicatorTheme: IndicatorThemeData(
                    size: 35,
                    color: Colors.grey.shade400,
                  ),
                  connectorTheme: ConnectorThemeData(
                    thickness: 3.0,
                    color: Colors.grey.shade400,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.before,
                  itemCount: orderStatuses.length,
                  contentsBuilder: (context, index) {
                    bool isCompleted = index <= currentStatusIndex;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          orderStatuses[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isCompleted
                                ? Pallete.mainDashColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                  indicatorBuilder: (_, index) {
                    bool isCompleted = index <= currentStatusIndex;
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted
                            ? Pallete.mainDashColor
                            : Colors.grey.shade400,
                      ),
                      child: Icon(
                        isCompleted ? Icons.check : Icons.circle_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    );
                  },
                  connectorBuilder: (_, index, __) {
                    bool isCompleted = index < currentStatusIndex;
                    return SolidLineConnector(
                      color: isCompleted
                          ? Pallete.mainDashColor
                          : Colors.grey.shade400,
                    );
                  },
                ),
              ),
            ),

            // Bottom Note
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  "Thank you!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
