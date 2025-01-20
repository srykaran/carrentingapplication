import 'package:flutter/material.dart';

class MyBookingsScreen extends StatefulWidget {
  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  // Dummy data for bookings
  List<Map<String, String>> myBookings = [
    {
      'carName': 'Toyota Camry',
      'date': '2025-01-15',
      'price': '\$50/day',
      'status': 'Confirmed',
    },
    {
      'carName': 'Tesla Model 3',
      'date': '2025-01-17',
      'price': '\$120/day',
      'status': 'Pending',
    },
    {
      'carName': 'Honda Accord',
      'date': '2025-01-20',
      'price': '\$60/day',
      'status': 'Cancelled',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: myBookings.isEmpty
          ? Center(
        child: Text('You have no bookings at the moment.'),
      )
          : ListView.builder(
        itemCount: myBookings.length,
        itemBuilder: (context, index) {
          final booking = myBookings[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.car_rental,
                size: 40,
                color: booking['status'] == 'Confirmed'
                    ? Colors.green
                    : booking['status'] == 'Pending'
                    ? Colors.orange
                    : Colors.red,
              ),
              title: Text(booking['carName']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${booking['date']}'),
                  Text('Price: ${booking['price']}'),
                  Text('Status: ${booking['status']}'),
                ],
              ),
              trailing: booking['status'] == 'Pending'
                  ? ElevatedButton(
                onPressed: () {
                  // Cancel booking logic (if needed)
                  setState(() {
                    booking['status'] = 'Cancelled';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booking Cancelled'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Cancel'),
              )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
