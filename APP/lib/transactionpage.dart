import 'package:flutter/material.dart';
import 'package:obsidian/completed_trans.dart';
import 'package:obsidian/models/transaction.dart';
import 'package:obsidian/mycontracts.dart';
import 'package:obsidian/pending_contracts.dart';
import 'canceled_trans.dart';
import 'function.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:obsidian/models/user.dart';

import 'inprogress_trans.dart';

class TransactionPage extends StatefulWidget {
  final Transaction transaction;
  final User user;

  TransactionPage({this.transaction, this.user});
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List ongoingcontracts = [];
  List completedcontracts = [];
  List pendingcontracts = [];
  List canceledcontracts = [];
  List mycontracts = [];

  void getcontracts() async {
    print("func called");
    ongoingcontracts = await getOngoingContracts(widget.user.email);
    completedcontracts = await getCompletedContracts(widget.user.email);
    pendingcontracts = await getPendingContracts(widget.user.email);
    canceledcontracts = await getCanceledContracts(widget.user.email);
    mycontracts = await getMyContracts(widget.user.email);
    print("func done");

    setState(() {});
  }

  @override
  void initState() {
    getcontracts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final transaction = widget.transaction;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Transactions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Color(0xFF152238),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  childAspectRatio: 0.75,
                  crossAxisCount: 3,
                  //crossAxisSpacing: 40.0,
                  //mainAxisSpacing: 60.0,
                  shrinkWrap: true,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyContracts(
                                mycontracts: mycontracts,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            padding: EdgeInsets.all(8),
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFD92C60),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    mycontracts.length.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "MY CONTRACTS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  )
                                ])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PendingTransaction(
                                  pendingcontracts: pendingcontracts,
                                ),
                              )).then((value) => getcontracts());
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF2CB7D9),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    pendingcontracts.length.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "PENDING",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InProgressTransaction(
                                  inprogresscontracts: ongoingcontracts,
                                ),
                              ));
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF2CD9A5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    ongoingcontracts.length.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "IN PROGRESS",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ])),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompletedTransaction(
                                completedcontracts: completedcontracts,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            padding: EdgeInsets.all(8),
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    completedcontracts.length.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "COMPLETED",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ])),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CanceledTransaction(
                                canceledcontracts: canceledcontracts,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            padding: EdgeInsets.all(8),
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    canceledcontracts.length.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "OBJECTION OR FAILURE",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ])),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
                  child: Text("New Transactions",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: pendingcontracts.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("listview");
                      print(pendingcontracts);
                      print(index);
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              title: Text(
                                  'By : ${pendingcontracts[index]['employerEmail']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        'Duration: ${pendingcontracts[index]['duration']} days'),
                                    Text(
                                        'Hourly Rate: Rs ${pendingcontracts[index]['hourRate']}'),
                                    Text(
                                        'Leaves Allowed: ${pendingcontracts[index]['leavesAllowed']}'),
                                    Text(
                                        'Early Bonus: ${pendingcontracts[index]['earlyBonus']}% per day'),
                                    Text(
                                        'Overdue Charge: ${pendingcontracts[index]['overdueCharge']}% per day'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Center(
                                  child: RaisedButton(
                                      color: Colors.white,
                                      child: new Text(
                                        "Decline",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () async {
                                        var response = await declineContract(
                                            pendingcontracts[index]['id']);
                                        if (response.statusCode == 200) {
                                          setState(() {
                                            pendingcontracts.remove(
                                                pendingcontracts[index]);
                                          });
                                        }
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(
                                                  30.0)))),
                              SizedBox(width: 30),
                              Center(
                                  child: RaisedButton(
                                      color: Colors.blue,
                                      child: new Text(
                                        "Accept",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        print(pendingcontracts[index]['id']);
                                        var response = await acceptContract(
                                            pendingcontracts[index]['id']);
                                        if (response.statusCode == 201) {
                                          setState(() {
                                            pendingcontracts.remove(
                                                pendingcontracts[index]);
                                          });
                                        }
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0))))
                            ],
                          ),
                          SizedBox(height: 5),
                          Divider(),
                        ],
                      );
                    }),
              ],
            )),
      ),
    ));
  }
}
