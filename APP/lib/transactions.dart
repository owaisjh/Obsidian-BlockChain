import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'models/user.dart';

const url = "https://664cdbe3ce46.ngrok.io/";

class TransactionList extends StatefulWidget {
  final User user;
  TransactionList({this.user});
  @override
  TransactionListState createState() => TransactionListState();
}

class TransactionListState extends State<TransactionList> {
  var arr = [];
  String mywallet;

  @override
  void initState() {
    setList();
  }

  void setList() async {
    mywallet = widget.user.walletId;
    var response2 = await http.post(url + 'transactions', body: {
      'wallet_id': widget.user.walletId,
    });
    print('Response status: ${response2.statusCode}');
    // print('Response body: ${response2.body}');
    var new_arr = jsonDecode(response2.body)[1].reversed.toList();
    // print(new_arr);
    for (int a = 0; a < new_arr.length; a++) {
      var isdebited = true;
      print(a);
      if (new_arr[a]["to_wallet"] == mywallet) {
        isdebited = false;
      }
      var username = new_arr[a]['to_user_name'].split("@")[0];
      var new_item = {
        "debited": isdebited,
        "username": username,
        "amount": new_arr[a]["amount"],
      };
      print(new_item);
      setState(() {
        arr.add(new_item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Color primaryColor = Color(0xff009a9a);
    // Color primaryColor = Color(0xff009a9a);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Color(0xffEBE8DF),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(width * 0.1, height * 0.08, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                "All Transactions: ",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            Container(
              height: height * 0.82,
              child: ListView.builder(
                itemCount: arr.length,
                itemBuilder: (context, position) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.grey[300], blurRadius: 7)
                      ],
                    ),
                    width: width * 0.9,
                    margin: EdgeInsets.fromLTRB(
                        width * 0.05, height * 0.02, width * 0.05, 0),
                    padding: EdgeInsets.fromLTRB(
                        0, height * 0.015, 0, height * 0.015),
                    alignment: Alignment.center,
                    child: ListTile(
                      trailing: Container(
                        padding: EdgeInsets.fromLTRB(
                            0, height * 0.01, width * 0.01, height * 0.01),
                        width: width * 0.3,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: width * 0.1,
                                ),
                                child: Text(
                                  arr[position]["amount"].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              "images/icon.png",
                              height: width * 0.1,
                              width: width * 0.1,
                            )
                          ],
                        ),
                      ),
                      leading: Material(
                        // borderRadius: BorderRadius.circular(100.0),
                        color: arr[position]["debited"]
                            ? Colors.red.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        child: IconButton(
                          alignment: Alignment.center,
                          // padding: EdgeInsets.all(15.0),
                          icon: arr[position]["debited"]
                              ? Icon(Icons.arrow_upward)
                              : Icon(Icons.arrow_downward),
                          color: arr[position]["debited"]
                              ? Colors.red
                              : Colors.green,
                          iconSize: 50.0,
                          onPressed: () {},
                        ),
                      ),
                      title: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                arr[position]["username"],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     "5th Feb",
                            //     style: TextStyle(
                            //       color: Colors.grey,
                            //       fontSize: 17,
                            //       fontWeight: FontWeight.w400,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
