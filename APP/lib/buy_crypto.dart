import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'models/user.dart';

const url = "https://664cdbe3ce46.ngrok.io/";

class BuyObsi extends StatefulWidget {
  final User user;
  BuyObsi({this.user});
  @override
  BuyObsiState createState() => BuyObsiState();
}

class BuyObsiState extends State<BuyObsi> {
  TextEditingController moneyCtr = TextEditingController();
  TextEditingController obsValCtr = TextEditingController();

  var rupeeVal = 0;
  var walletRupees = 20000;

  void onAdd() {
    setState(() {
      walletRupees += int.parse(moneyCtr.text);
    });
  }

  void updateval() {
    setState(() {
      rupeeVal = int.parse(obsValCtr.text) * 2;
    });
  }

  void buyobs() async {
    // if (int(obsValCtr.text) == '0') {
    //   print("didnt come here");
    //   return;
    // }
    print("came here");
    var response2 = await http.post(url + 'buy',
        body: {'wallet_id': widget.user.walletId, 'amount': obsValCtr.text});
    print('Response status: ${response2.statusCode}');
    print('Response body: ${response2.body}');

    var response3 = await http.post(url + 'get_bal', body: {
      'wallet_id': widget.user.walletId,
    });
    print('Response status: ${response3.statusCode}');
    print('Response body: ${response3.body}');

    Fluttertoast.showToast(
        msg: (int.parse(obsValCtr.text) * 2).toString() + " obsidian added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    setState(() {
      walletRupees -= int.parse(obsValCtr.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xff009a9a);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(width * 0.1, height * 0.08, 0, 0),
              child: Text(
                "Balance",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(width * 0.1, height * 0.01, 0, 0),
              child: Text(
                "₹ " + walletRupees.toString(),
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  width * 0.04, height * 0.05, width * 0.04, height * 0.01),
              child: Card(
                child: Container(
                  // height: height * 0.15,
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.04, height * 0.01, 0, 0),
                        width: double.infinity,
                        child: Text(
                          "Conversion Rate",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.15,
                            child: Image.asset(
                              "images/icon.png",
                              height: width * 0.15,
                              width: width * 0.15,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.325,
                            child: Text(
                              "1 Obsidian",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.325,
                            child: Text(
                              "₹ 0.5",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  // side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  width * 0.04, height * 0.05, width * 0.04, height * 0.01),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green[300],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.02),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                          width * 0.04, height * 0.01, 0, height * 0.02),
                      child: Text(
                        "Add Rupees To Wallet",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: width * 0.4,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: moneyCtr,
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.grey,
                            ),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              // labelText:
                              //     "Recepient username",
                              fillColor: Colors.white,
                              hintText: '100',
                              contentPadding: EdgeInsets.symmetric(),
                              hintStyle: TextStyle(fontSize: 35),

                              border: InputBorder.none,
                              // prefixIcon: Icon(
                              //     Icons.account_circle,
                              //     color: Colors.blue),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.45,
                          alignment: Alignment.centerRight,
                          child: ButtonTheme(
                            minWidth: width * 0.3,
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              onPressed: () {
                                onAdd();
                              },
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              color: Colors.green,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(width * 0.04, height * 0.05, 0, 0),
              child: Text("Purchase Price",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  width * 0.04, height * 0.02, width * 0.04, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: width * 0.42,
                    height: height * 0.1,
                    margin:
                        EdgeInsets.fromLTRB(width * 0.01, 0, width * 0.01, 0),
                    padding: EdgeInsets.fromLTRB(width * 0.01, height * 0.01,
                        width * 0.01, height * 0.01),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          // height: height * 0.2,
                          padding: EdgeInsets.only(left: width * 0.02),
                          child: Text(
                            "₹",
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                        ),
                        Container(
                          width: width * 0.2,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: obsValCtr,
                            onChanged: (value) => {updateval()},
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            ),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              // labelText:
                              //     "Recepient username",
                              fillColor: Colors.white,
                              hintText: '0',
                              // contentPadding: EdgeInsets.symmetric(),
                              hintStyle:
                                  TextStyle(fontSize: 23, color: Colors.white),

                              border: InputBorder.none,
                              // prefixIcon: Icon(
                              //     Icons.account_circle,
                              //     color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // constraints: BoxConstraints(
                    //   minHeight: height * 0.025,
                    // ),
                    height: height * 0.1,
                    width: width * 0.42,
                    margin:
                        EdgeInsets.fromLTRB(width * 0.01, 0, width * 0.01, 0),
                    padding: EdgeInsets.fromLTRB(width * 0.01, height * 0.01,
                        width * 0.01, height * 0.01),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          // height: height * 0.2,
                          child: Image.asset(
                            "images/icon.png",
                            height: width * 0.1,
                            width: width * 0.1,
                          ),
                        ),
                        Container(
                          child: Text(
                            rupeeVal.toString(),
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, height * 0.05, 0, height * 0.05),
              alignment: Alignment.center,
              child: ButtonTheme(
                minWidth: width * 0.9,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  onPressed: () {
                    buyobs();
                  },
                  child: Text(
                    'BUY',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.amber,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
