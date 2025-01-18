import 'package:car_rental_application/Screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_application/Screens/signup_screen.dart';

class LoginScreen extends StatelessWidget
{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: AutofillHints.email,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: AutofillHints.password,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              if(emailController.text.isNotEmpty &&
              passwordController.text.isNotEmpty){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen())
                );
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please Enter Valid Credential')),
                );
              }
            },
                child: Text('Login')),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupScreen(),),
                    );
                    },
                  child: Text('SignUp',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}