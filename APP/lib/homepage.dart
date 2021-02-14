import 'package:flutter/material.dart';
import 'package:obsidian/completed_trans.dart';
import 'package:obsidian/dashboard.dart';
import 'package:obsidian/models/transaction.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import 'package:obsidian/transactionpage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'completed_trans.dart';
import 'previous_trans.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
// import 'package:obsidian/models/user.dart';
import 'models/user.dart';
import 'function.dart';
import 'crypto_exchange.dart';
import 'buy_crypto.dart';
import 'new_contract.dart';
import 'transactions.dart';

const url = "https://664cdbe3ce46.ngrok.io/";

class HomePage extends StatefulWidget {
  final User user;

  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  TextEditingController obsValueCtr = TextEditingController();
  TextEditingController usernameCtr = TextEditingController();
  var obsidianBalance = 10000;

  @override
  void initState() {
    updateVal();
    super.initState();
  }

  void updateVal() async {
    var response2 = await http.post(url + 'get_bal', body: {
      'wallet_id': widget.user.walletId,
    });
    print('Response status: ${response2.statusCode}');
    print('Response body: ${response2.body}');
    setState(() {
      obsidianBalance = int.parse(response2.body);
    });
  }

  void _doSomething() async {
    var response2 = await http.post(url + 'check_user', body: {
      'email': usernameCtr.text,
    });
    // print('Response status: ${response2.statusCode}');
    // print('Response body: ${response2.body}');
    if (response2.statusCode / 10 == 20) {
      var response3 = await http.post(url + 'get_bal', body: {
        'wallet_id': widget.user.walletId,
      });
      print('Response status: ${response3.statusCode}');
      print('Response body: ${response3.body}');

      if (int.parse(response3.body) >= int.parse(obsValueCtr.text)) {
        var response = await http.post(url + 'transfer', body: {
          // 'employerUsername': 'malharmarathe26@gmail.com',
          'wallet_id': widget.user.walletId,
          'transfereeEmail': usernameCtr.text,
          'amount': obsValueCtr.text
        });

        _btnController.success();

        Fluttertoast.showToast(
            msg: "Payment Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.of(context).pop();

        // print('Response status: ${response.statusCode}');
        // print('Response body: ${response.body}');
      } else {
        _btnController.error();

        // Timer(Duration(milliseconds: 500), () {
        _btnController.reset();
        // });
        Fluttertoast.showToast(
            msg: "Insufficient Balance",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      _btnController.error();

      // Timer(Duration(milliseconds: 500), () {
      _btnController.reset();
      // });
      Fluttertoast.showToast(
          msg: "User Not Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    updateVal();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    Color primaryColor = Colors.black;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    //Color primaryColor = Color.fromRGBO(255, 82, 48, 1);

    //List transaction = ['Transaction 1', 'Transaction 2', 'Transaction 3'];

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height: 350.0,
                  decoration: BoxDecoration(color: primaryColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            'Hello, ${widget.user.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          '${obsidianBalance.toString()} Obsidian',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    // Material(
                    //   elevation: 1.0,
                    //   borderRadius: BorderRadius.circular(100.0),
                    //   color: Colors.blue[300],
                    //   child: MaterialButton(
                    //     onPressed: () {},
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: 10.0, horizontal: 30.0),
                    //     child: Text(
                    //       'INVOICE',
                    //       style: TextStyle(fontSize: 16.0, color: Colors.white),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 120.0, right: 25.0, left: 25.0, bottom: 20),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                  width: double.infinity,
                  height: 370.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 15.0)
                      ]),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.purple.withOpacity(0.1),
                                  child: IconButton(
                                    padding: EdgeInsets.all(15.0),
                                    icon: Icon(Icons.send),
                                    color: Colors.purple,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        expand: false,
                                        builder: (context) => Container(
                                          // decoration: BoxDecoration(
                                          //   color: Colors.red,
                                          // ),

                                          padding: EdgeInsets.fromLTRB(
                                            width * 0.02,
                                            height * 0.01,
                                            width * 0.02,
                                            MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.45 +
                                              MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 20, 0, 10),
                                                child: TextFormField(
                                                  controller: usernameCtr,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        "Recepient username",
                                                    fillColor: Colors.white,
                                                    hintText: 'Sam',
                                                    prefixIcon: Icon(
                                                        Icons.account_circle,
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 40, 0, 10),
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: obsValueCtr,
                                                  style: TextStyle(
                                                    fontSize: 80,
                                                    color: Colors.grey,
                                                  ),
                                                  cursorColor: Colors.grey,
                                                  decoration: InputDecoration(
                                                    // labelText:
                                                    //     "Recepient username",
                                                    fillColor: Colors.white,
                                                    hintText: '0',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(),
                                                    hintStyle:
                                                        TextStyle(fontSize: 80),

                                                    border: InputBorder.none,
                                                    // prefixIcon: Icon(
                                                    //     Icons.account_circle,
                                                    //     color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                              RoundedLoadingButton(
                                                child: Text('Send',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                controller: _btnController,
                                                onPressed: _doSomething,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('Send',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.blue.withOpacity(0.1),
                                  child: IconButton(
                                    padding: EdgeInsets.all(15.0),
                                    icon: Icon(Icons.credit_card),
                                    color: Colors.blue,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  NewContract(user: user)));
                                    },
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('New\nContract',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.orange.withOpacity(0.1),
                                  child: IconButton(
                                    padding: EdgeInsets.all(15.0),
                                    icon: Icon(Icons.receipt),
                                    color: Colors.orange,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TransactionList(user: user)));
                                    },
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('All\nTransactions',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.pink.withOpacity(0.1),
                                  child: IconButton(
                                    padding: EdgeInsets.all(15.0),
                                    icon: Icon(Icons.monetization_on),
                                    color: Colors.pink,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  BuyObsi(user: user)))
                                          .then((value) => updateVal());
                                    },
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('Buy\nObsidian',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.purpleAccent.withOpacity(0.1),
                                  child: IconButton(
                                    padding: EdgeInsets.all(15.0),
                                    icon: Icon(Icons.business_center),
                                    color: Colors.purpleAccent,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionPage(user: user),
                                        ),
                                      ).then((value) => updateVal());
                                    },
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('My\nTransactions',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.deepPurple.withOpacity(0.1),
                                  child: IconButton(
                                    padding: EdgeInsets.all(15.0),
                                    icon: Icon(Icons.attach_money),
                                    color: Colors.deepPurple,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ChartApp()));
                                    },
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text('Currency\nrates',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      ),
                      // SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
            child: Text(
              'Ongoing Transactions',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
          FutureBuilder(
              future: getOngoingContracts(user.email),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print('future1');
                //print(snapshot.data);
                if (snapshot.data == null) {
                  return Center(child: Text('Ruko jara, sabar karo'));
                } else {
                  //return Center(child: Text(snapshot.data[1]['emplyeeEmail']));
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: UpcomingCard(
                            index: index,
                            title:
                                "By : ${snapshot.data[index]['employerEmail']}",

                            value:
                                "Contract ID : ${snapshot.data[index]['id']}",
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => PendingPage(pendingcontract: pending,),),);
                            // },
                          ),
                        );
                      });
                }
              })
        ]),
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

class UpcomingCard extends StatelessWidget {
  final String title;
  final String value;
  final int index;
  final Function onTap;
  // final Color color;

  UpcomingCard({this.title, this.value, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = index % 2 == 0 ? Colors.blue : Colors.orange;
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(5),
          width: 120.0,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 30.0),
                    Text('$value',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                IconButton(
                    icon: Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    onPressed: null)
              ],
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
