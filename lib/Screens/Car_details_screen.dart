import 'package:flutter/material.dart';
import 'package:car_rental_application/Data/Dummy Data.dart';

class CarDetailsScreen extends StatelessWidget
{
 final String carName;
 final String carPrice;
 final String? carImage;

 CarDetailsScreen({
   required this.carName,
   required this.carPrice,
   required this.carImage,
 });
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carName),
      ),
      body:
        Padding(padding: EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Center(
          child: carImage != null ?Image.asset("assets/img/${carImage}",height: 200, fit :BoxFit.cover)
          :Icon(Icons.directions_car, size: 200,),
        ),
          SizedBox(height: 20,),
          Text(
            'Car Name: $carName',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Text(
            'Price: $carPrice',
            style: TextStyle(fontSize: 18),
          ),
          Spacer(),
          Center(
            child: ElevatedButton(onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booking $carName')),
              );
            }, child: Text('Book Now!')),
          ),
        ],
      ),
    )
    );
  }
}