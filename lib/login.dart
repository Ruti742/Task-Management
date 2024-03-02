import 'package:flutter/material.dart';
import 'HomeScreen.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Task Management',style: TextStyle( fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white, ),),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 149, 211, 245), // צבע הרקע
        ),

        child: Padding(
          padding: const EdgeInsets.only(left:300.0, right: 300.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder(), 
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.blue),),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'password', border: OutlineInputBorder(), 
                    focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.blue),),
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    if (username !=''&& password !=''){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(username: username)),
                      );
                      usernameController.clear();
                      passwordController.clear();
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Login Failed'),
                            content: Text('Invalid username or password. Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, 
                  ),
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }