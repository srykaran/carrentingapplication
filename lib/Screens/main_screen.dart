import 'package:car_rental_application/Screens/add_car_screen.dart';
import 'package:car_rental_application/Data/Dummy Data.dart';
import 'package:car_rental_application/Screens/Car_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_application/Screens/login_screen.dart';
import 'package:car_rental_application/Screens/approval_request_screen.dart';
import 'package:car_rental_application/Screens/my_bookings_screen.dart';
import 'package:car_rental_application/Screens/rented_car_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail; // Email passed from LoginScreen

  HomeScreen({required this.userEmail}); // Constructor to accept email

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void addCar(Map<String, String> newCar) {
    setState(() {
      availableCars.add(newCar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Renting App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/img/profile_placeholder.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome,', // Static text
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    widget.userEmail, // Display the user's email dynamically
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text('Rented Cars'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RentedCarsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.approval),
              title: Text('Approval Requests'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ApprovalRequestsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.book_online),
              title: Text('My Bookings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyBookingsScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: availableCars.isEmpty
          ? Center(
        child: Text('No Cars At The Moment!'),
      )
          : ListView.builder(
        itemCount: availableCars.length,
        itemBuilder: (context, index) {
          final car = availableCars[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: car['image'] != null
                  ? Image(
                image: AssetImage("assets/img/${car['image']}"),
                width: 100,
                height: 800,
              )
                  : Icon(Icons.directions_car),
              title: Text(car['name']!),
              subtitle: Text(car['price']!),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailsScreen(
                      carName: car['name']!,
                      carPrice: car['price']!,
                      carImage: car['image'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCarScreen(
                onAddCar: addCar,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

