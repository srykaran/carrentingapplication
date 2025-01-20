import 'package:flutter/material.dart';

class RentedCarsScreen extends StatefulWidget {
  @override
  _RentedCarsScreenState createState() => _RentedCarsScreenState();
}

class _RentedCarsScreenState extends State<RentedCarsScreen> {
  // Dummy data for rented cars
  List<Map<String, String>> rentedCars = [
    {
      'carName': 'Ford Mustang',
      'rentedFrom': '2025-01-10',
      'rentedTo': '2025-01-20',
      'price': '\$70/day',
      'status': 'Ongoing',
    },
    {
      'carName': 'BMW X5',
      'rentedFrom': '2025-01-05',
      'rentedTo': '2025-01-10',
      'price': '\$150/day',
      'status': 'Completed',
    },
    {
      'carName': 'Audi Q7',
      'rentedFrom': '2025-01-15',
      'rentedTo': '2025-01-20',
      'price': '\$200/day',
      'status': 'Cancelled',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rented Cars'),
      ),
      body: rentedCars.isEmpty
          ? Center(
        child: Text('You have no rented cars at the moment.'),
      )
          : ListView.builder(
        itemCount: rentedCars.length,
        itemBuilder: (context, index) {
          final car = rentedCars[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.directions_car,
                size: 40,
                color: car['status'] == 'Ongoing'
                    ? Colors.green
                    : car['status'] == 'Completed'
                    ? Colors.blue
                    : Colors.red,
              ),
              title: Text(car['carName']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rented From: ${car['rentedFrom']}'),
                  Text('Rented To: ${car['rentedTo']}'),
                  Text('Price: ${car['price']}'),
                  Text('Status: ${car['status']}'),
                ],
              ),
              trailing: car['status'] == 'Ongoing'
                  ? ElevatedButton(
                onPressed: () {
                  // Optionally, logic to extend the rental or return car
                  setState(() {
                    car['status'] = 'Completed';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Rental Completed'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Mark as Completed'),
              )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
