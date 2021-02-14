import 'package:flutter/material.dart';
import 'package:obsidian/models/transaction.dart';
import 'transactionpage.dart';
import 'function.dart';

class PendingTransaction extends StatefulWidget {
  final List pendingcontracts;

  PendingTransaction({this.pendingcontracts});
  @override
  _PendingTransactionState createState() => _PendingTransactionState();
}

class _PendingTransactionState extends State<PendingTransaction> {
  

  @override
  Widget build(BuildContext context) {
    List pendingcontracts = widget.pendingcontracts;
    
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.blueAccent,
       title: Text("Pending Transactions"), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
                  child: Container(
            child: ListView.builder( 
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: pendingcontracts.length, 
                        
                        itemBuilder: (BuildContext context,int index){
                          print("completed contracts");
                          print(pendingcontracts);
                          print(index);
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  
                                  title: Text('By : ${pendingcontracts[index]['employerEmail']}', 
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Contract ID: ${pendingcontracts[index]['id']}'),
                                        Text('Duration: ${pendingcontracts[index]['duration']} days'),
                                        Text('Hourly Rate: Rs ${pendingcontracts[index]['hourRate']}'),
                                        Text('Leaves Allowed: ${pendingcontracts[index]['leavesAllowed']}'),
                                        Text('Early Bonus: ${pendingcontracts[index]['earlyBonus']}% per day'),
                                        Text('Overdue Charge: ${pendingcontracts[index]['overdueCharge']}% per day'),

                                      ],
                                    ),
                                  ),
                                  ),
                              ),
                              
                              SizedBox(
                                height:5
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
                                            var response = await declineContract(pendingcontracts[index]['id']);
                                            if(response.statusCode == 200){
                                            setState(() {
                                              pendingcontracts.remove(pendingcontracts[index]);
                                            });
                                          }
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(30.0))
                                              )
                                              ),
                                              SizedBox(width: 10),
                                  Center(
                                      child: RaisedButton(
                                          color: Colors.blue,
                                          child: new Text(
                                            "Accept",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            print(pendingcontracts[index]['id']);
                                            var response = await acceptContract(pendingcontracts[index]['id']);
                                            if(response.statusCode == 201){
                                            setState(() {
                                              pendingcontracts.remove(pendingcontracts[index]);
                                            });
                                          }
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(30.0))))
                                ],
                              ),
                              Divider(),
                            ],
                          );
                            



                        }
                          ),
          ),
        ),
      ),
      
    );
  }
}


