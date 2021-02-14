import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'function.dart';
import 'package:toast/toast.dart';
//import 'checker.dart';
//import 'loading.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String name = '';
  String password = '';
  String confirmPassword = '';
  String aadharNumber;
  String contactNo;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(
                  padding: const EdgeInsets.only(top:80,bottom:50, left: 50),
                  child: Text('Register here.',
                  style: 
                     TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.0,
                        color: Colors.black,
                        ),
                  ),
                ),
                 Container(
                        padding: const EdgeInsets.all(40.0),
                        child:  Form(
                          autovalidate: true,
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                               TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Enter email", 
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.email)
                                    ),
                                keyboardType: TextInputType.emailAddress,
                                
                                onChanged: (value){
                                  email = value;
                                },
                                validator: (String value) {
                                    return value.contains('@') ? null : 'Enter a valid email';
                                },
                                
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Enter your name", 
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.person_outline)
                                    ),
                                keyboardType: TextInputType.text,                                
                                onChanged: (value){
                                  name = value.trimRight();
                                  //print(username);
                                },
                                
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Enter Password",
                                  prefixIcon: Icon(Icons.lock_outline)
                                ),
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                onChanged: (value){
                                  password = value;
                                },
                                validator: (value){
                                  return (value.length < 6) ? 'Enter a longer password' : null; 
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  prefixIcon: Icon(Icons.lock_outline)
                                ),
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                onChanged: (value){
                                  confirmPassword = value;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Enter Aadhar Number", 
                                    fillColor: Colors.white,
                                    hintText: "Aadhar Number",
                                    prefixIcon: Icon(Icons.person_pin)
                                    ),

                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  aadharNumber = value.trimRight();
                                  //print(age);
                                  
                                },
                                 validator: (value){
                                  return (value.length != 12) ? 'Enter a valid aadhar number' : null; 
                                },
                                
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Enter contact number", 
                                    fillColor: Colors.white,
                                    hintText: 'Contact Number',
                                    prefixIcon: Icon(Icons.phone, color: Colors.grey),
                                    
                                    ),

                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  contactNo = value.trimRight();
                                  
                                },
                                validator: (value){
                                  return value.length == 10 ? null : 'Enter a valid phone number';
                                },
                                
                              ),

                               
                              
                              Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                              ),
                             MaterialButton(
                                height: 50.0,
                                minWidth: 150.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  
                                ),
                                color: Colors.black,
                                splashColor: Colors.black,
                                textColor: Colors.white,
                                child:  Text('Create User'),
                                onPressed: () async {
                                  if (name == '' || password == '' || confirmPassword ==''){
                                  
                                  showToast("These fields cannot be empty");
                                  }
                                  
                                  else if( password!='' && confirmPassword!='' && password == confirmPassword ) {
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Loading(),),);
                                    var response = await createUser(email: email, name: name, password: password, aadharNumber: aadharNumber, contactNo: contactNo);
                                    print(response.body);
                                    if (response.statusCode == 201) {
                                      showToast("User Created successfully", duration: Toast.LENGTH_LONG);
                                    Navigator.pop(context);
                                    }
                                  //   if (response.statusCode == 400){
                                      
                                  // }
                                }
                                //   else {
                                //     Fluttertoast.showToast(
                                //       msg: "Passwords do not match",
                                //       toastLength: Toast.LENGTH_LONG,
                                //       gravity: ToastGravity.CENTER,
                                //       textColor: Colors.black,
                                //       backgroundColor: Colors.grey,
                                //       fontSize: 16.0                                
                                //    );
                                //   }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:80),
                                child: FlatButton(
                                    child: Text(
                                    'Already have an account? Sign In.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                     )
          ]
          ),
        ),
        
      ),
    );
    
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}