import 'package:flutter/material.dart';

// --- Data Models for clean code ---

// Enum to represent the status of an order
enum StatusType {
  pickupPending, pickupFailed, pickupRescheduled,
  deliveryFailed, delivered, deliveryPending, deliveryRescheduled
}

// Class to hold status information (text and colors)
class OrderStatus {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  OrderStatus({required this.text, required this.backgroundColor, required this.textColor});

  // Factory method to get status properties from the enum
  factory OrderStatus.fromType(StatusType type) {
    switch (type) {
      case StatusType.delivered:
        return OrderStatus(text: 'Delivered', backgroundColor: Colors.green.shade100, textColor: Colors.green.shade800);
      case StatusType.pickupFailed:
        return OrderStatus(text: 'Pickup Failed', backgroundColor: Colors.red.shade100, textColor: Colors.red.shade800);
      case StatusType.deliveryFailed:
        return OrderStatus(text: 'Delivery Failed', backgroundColor: Colors.red.shade100, textColor: Colors.red.shade800);
      case StatusType.pickupPending:
        return OrderStatus(text: 'Pickup Pending', backgroundColor: Colors.red.shade100, textColor: Colors.red.shade800);
      case StatusType.deliveryPending:
        return OrderStatus(text: 'Delivery Pending', backgroundColor: Colors.red.shade100, textColor: Colors.red.shade800);
      case StatusType.pickupRescheduled:
        return OrderStatus(text: 'Pickup Rescheduled', backgroundColor: Colors.blue.shade100, textColor: Colors.blue.shade800);
      case StatusType.deliveryRescheduled:
        return OrderStatus(text: 'Delivery Rescheduled', backgroundColor: Colors.blue.shade100, textColor: Colors.blue.shade800);
      default:
        return OrderStatus(text: 'Unknown', backgroundColor: Colors.grey.shade200, textColor: Colors.grey.shade800);
    }
  }
}

// Represents a single order
class Order {
  final String id;
  final StatusType statusType;

  Order({required this.id, required this.statusType});
}

// Enum for the top filter tabs
enum OrderTab { newTab, pending }

// --- Main Screen Widget ---

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrderTab _selectedTab = OrderTab.pending;

  // Sample data to populate the list
  final List<Order> _orders = [
    Order(id: '#11250', statusType: StatusType.pickupPending),
    Order(id: '#11251', statusType: StatusType.pickupFailed),
    Order(id: '#11252', statusType: StatusType.pickupRescheduled),
    Order(id: '#11251', statusType: StatusType.deliveryFailed),
    Order(id: '#11253', statusType: StatusType.delivered),
    Order(id: '#11250', statusType: StatusType.deliveryPending),
    Order(id: '#11252', statusType: StatusType.deliveryRescheduled),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterBar(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Tap to Expand', style: TextStyle(color: Colors.grey)),
            ),
            _buildOrderList(),
          ],
        ),
      ),
      //bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_bag_outlined, size: 28),
        SizedBox(width: 8),
        Text('Orders', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            _buildTabButton('New', OrderTab.newTab),
            _buildTabButton('Pending', OrderTab.pending),
            const Spacer(),
            _buildDatePicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, OrderTab tab) {
    bool isActive = _selectedTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = tab),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFFFC107) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? Colors.black87 : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Text('24/08/2025', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
          const SizedBox(width: 4),
          Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          return _buildOrderCard(_orders[index]);
        },
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    final status = OrderStatus.fromType(order.statusType);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Order No.', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: status.backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(status.text, style: TextStyle(color: status.textColor, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Icon(Icons.keyboard_arrow_down, color: Colors.red, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 5, blurRadius: 15)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
            label: const Text('Orders'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: const Color(0xFFFFD149),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, color: Colors.black87),
            label: const Text('Account', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal)),
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
          ),
        ],
      ),
    );
  }
}