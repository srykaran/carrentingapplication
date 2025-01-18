import 'package:car_rental_application/Screens/add_car_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_application/Data/Dummy Data.dart';
import 'package:car_rental_application/Screens/Car_details_screen.dart';

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>
{
  void addCar(Map<String , String> newCar)
  {
    setState(
        (){
          availableCars.add(newCar);
        }
    );
  }

  @override
  Widget build(BuildContext context)
  {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Car Renting App'),
     ),
     body: availableCars.isEmpty?
     Center(
       child: Text('No Cars At The Moment!'),
     ) : ListView.builder(
         itemCount: availableCars.length,
         itemBuilder: (context ,index)
         {
           final car = availableCars[index];
           return Card(
             margin: EdgeInsets.all(10),
             child: ListTile(
               leading: car['image'] != null
               ? Image(image: AssetImage("assets/img/${car['image']}"), width:100 ,height: 800)
                   : Icon(Icons.directions_car),
               title: Text(car['name']!),
               subtitle: Text(car['price']!),
               trailing: Icon(Icons.arrow_forward),
               onTap: ()
               {
                 // Navigate to the CarDetailsScreen
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
         }),
       floatingActionButton: FloatingActionButton(onPressed: (){
         Navigator.push(context,
         MaterialPageRoute(builder: (context) => AddCarScreen(onAddCar: addCar,),
         ),
         );
       },
       child: Icon(Icons.add),
       ),
   );
  }
}