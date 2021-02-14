import 'package:flutter/material.dart';
import 'package:obsidian/models/transaction.dart';
import 'transactionpage.dart';
import 'function.dart';

class MyContracts extends StatefulWidget {
  final List mycontracts;

  MyContracts({this.mycontracts});
  @override
  _MyContractsState createState() => _MyContractsState();
}

class _MyContractsState extends State<MyContracts> {
  int hoursWorked = 0;
  int noOfLeaves = 0;
  @override
  Widget build(BuildContext context) {
    List mycontracts = widget.mycontracts;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('My Contracts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mycontracts.length,
                itemBuilder: (BuildContext context, int index) {
                  Color tilecolour = Colors.green.withOpacity(0.5);
                  if (mycontracts[index]['status'] == 'Pending') {
                    tilecolour = Colors.blue.withOpacity(0.5);
                  }
                  if (mycontracts[index]['status'] == 'In Process') {
                    tilecolour = Colors.yellow.withOpacity(0.5);
                  }
                  if (mycontracts[index]['status'] == 'Rejected') {
                    tilecolour = Colors.red.withOpacity(0.5);
                  }
                  print("completed contracts");
                  print(mycontracts);
                  print(index);
                  return Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: tilecolour,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(
                              'By : ${mycontracts[index]['employerEmail']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                mycontracts[index]['contractAddress'] == null
                                    ? Container()
                                    : Text(
                                        'Contract Address: ${mycontracts[index]['contractAddress']}'),
                                Text(
                                    'Duration: ${mycontracts[index]['duration']} days'),
                                Text(
                                    'Hourly Rate: Rs ${mycontracts[index]['hourRate']}'),
                                Text(
                                    'Leaves Allowed: ${mycontracts[index]['leavesAllowed']}'),
                                Text(
                                    'Early Bonus: ${mycontracts[index]['earlyBonus']}% per day'),
                                Text(
                                    'Overdue Charge: ${mycontracts[index]['overdueCharge']}% per day'),
                                Text('Status: ${mycontracts[index]['status']}'),
                                SizedBox(height: 20),
                                mycontracts[index]['status'] == 'In Process'
                                    ? Center(
                                        child: RaisedButton(
                                            color: Colors.white,
                                            child: new Text(
                                              "Complete",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () async {
                                              //   // var response = await completeContract(mycontracts[index]['id']);
                                              //   // if(response.statusCode == 200){
                                              //   // setState(() {

                                              //   // });
                                              // }
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    child: AlertDialog(
                                                      title: Text(
                                                          'Please Fill In these '),
                                                      content: Form(
                                                          autovalidate: true,
                                                          child: Column(
                                                            children: <Widget>[
                                                              TextFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Enter hours worked",
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  //prefixIcon: Icon(Icons.email)
                                                                ),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                onChanged:
                                                                    (value) {
                                                                  hoursWorked =
                                                                      int.parse(
                                                                          value);
                                                                },
                                                              ),
                                                              TextFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      "Enter no of Leaves taken",
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  //prefixIcon: Icon(Icons.email)
                                                                ),
                                                                onChanged:
                                                                    (value) {
                                                                  noOfLeaves =
                                                                      int.parse(
                                                                          value);
                                                                },
                                                              ),
                                                            ],
                                                          )),
                                                      actions: [
                                                        FlatButton(
                                                          textColor:
                                                              Colors.black,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('CANCEL'),
                                                        ),
                                                        FlatButton(
                                                          textColor:
                                                              Colors.black,
                                                          onPressed: () async {
                                                            //print(mycontracts[index]['id']);
                                                            var response =
                                                                await completeContract(
                                                                    mycontracts[
                                                                            index]
                                                                        ['id'],
                                                                    hoursWorked,
                                                                    noOfLeaves);
                                                            //Navigator.pop(context);
                                                            print("hello");
                                                            print(response
                                                                .statusCode);
                                                            if (response
                                                                    .statusCode ==
                                                                200) {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {});
                                                            }
                                                          },
                                                          child:
                                                              Text('COMPLETE'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0))))
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
