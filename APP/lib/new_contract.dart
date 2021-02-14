import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import "models/user.dart";

const url = "https://664cdbe3ce46.ngrok.io/";

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Money Management',
//       theme: ThemeData(primarySwatch: Colors.purple),
//       home: HomePage(),
//     );
//   }
// }

class NewContract extends StatefulWidget {
  final User user;
  NewContract({this.user});

  @override
  _NewContractState createState() => _NewContractState();
}

class _NewContractState extends State<NewContract> {
  TextEditingController usernameCtr = TextEditingController();
  TextEditingController hourRateCtr = TextEditingController();
  TextEditingController durationCtr = TextEditingController();
  TextEditingController leavePenalty = TextEditingController();
  TextEditingController leavesAllowed = TextEditingController();
  TextEditingController earlyBonus = TextEditingController();
  TextEditingController overdueCharge = TextEditingController();
  // TextEditingController username_controller = TextEditingController();

  void sendHandler() async {
    print(usernameCtr.text);
    var response = await http.post(url + 'new_contract', body: {
      'employerUsername': widget.user.name,
      'employerEmail': widget.user.email,
      'employerWalletId': widget.user.walletId,
      'emplyeeUsername': usernameCtr.text,
      'emplyeeEmail': usernameCtr.text,
      'hourRate': hourRateCtr.text,
      'duration': durationCtr.text,
      'leavesAllowed': leavesAllowed.text,
      'leavesPenalty': leavePenalty.text,
      'earlyBonus': earlyBonus.text,
      'overdueCharge': overdueCharge.text
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Fluttertoast.showToast(
        msg: "Offer Sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xff009a9a);
    //Color primaryColor = Color.fromRGBO(255, 82, 48, 1);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor, border: Border.all(color: primaryColor)),
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(
                          width * 0.05, height * 0.03, 0, 0),
                      child: Text(
                        "Fill Details",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(width * 0.05, 0, 0, 0),
                      child: Text(
                        "to make a contract offer to a registered user.",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: 350.0,
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                ),
                // Card(
                //   elevation: 0,
                //   color: Colors.black,
                //   shape: RoundedRectangleBorder(
                //     // side: BorderSide(color: Colors.white70, width: 1),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child:
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.05, height * 0.08, width * 0.05, 0),
                      child: TextFormField(
                        validator: (String value) {
                          return null;
                        },
                        controller: usernameCtr,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.05, height * 0.03, width * 0.05, 0),
                      child: TextFormField(
                        validator: (String value) {
                          return null;
                        },
                        controller: hourRateCtr,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Hourly Rate',
                          labelStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.05, height * 0.03, width * 0.05, 0),
                      child: TextFormField(
                        validator: (String value) {
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: durationCtr,
                        decoration: InputDecoration(
                          labelText: 'Duration',
                          labelStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.05, height * 0.03, width * 0.05, 0),
                      child: TextFormField(
                        validator: (String value) {
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: leavesAllowed,
                        decoration: InputDecoration(
                          labelText: 'Leaves Allowed',
                          labelStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.05, height * 0.03, width * 0.05, 0),
                      child: TextFormField(
                        validator: (String value) {
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: leavePenalty,
                        decoration: InputDecoration(
                          labelText: 'Penalty per extra leave',
                          labelStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.05, height * 0.03, width * 0.05, 0),
                      child: TextFormField(
                        validator: (String value) {
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: earlyBonus,
                        decoration: InputDecoration(
                          labelText: 'Early Completion Bonus per day',
                          labelStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.05, height * 0.03, width * 0.05, 0),
                      child: TextFormField(
                        validator: (String value) {
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: overdueCharge,
                        decoration: InputDecoration(
                          labelText: 'Overdue Charges per day',
                          labelStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, height * 0.03, 0, height * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: width * 0.4,
                            padding: EdgeInsets.fromLTRB(
                                width * 0.05, 0, width * 0.05, 0),
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Discard',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              color: Color(0xff9a0000),
                            ),
                          ),
                          Container(
                              width: width * 0.4,
                              padding: EdgeInsets.fromLTRB(
                                  width * 0.05, 0, width * 0.05, 0),
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                onPressed: () {
                                  sendHandler();
                                },
                                child: Text(
                                  'Send',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                color: Color(0xff009a4d),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 390.0 - 200);
    path.quadraticBezierTo(size.width / 2, 280, size.width, 390.0 - 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
