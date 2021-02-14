import 'package:flutter/material.dart';
import 'package:obsidian/models/transaction.dart';
import 'transactionpage.dart';
import 'function.dart';

class InProgressTransaction extends StatefulWidget {
  final List inprogresscontracts;

  InProgressTransaction({this.inprogresscontracts});
  @override
  _InProgressTransactionState createState() => _InProgressTransactionState();
}

class _InProgressTransactionState extends State<InProgressTransaction> {
  

  @override
  Widget build(BuildContext context) {
    List inprogresscontracts = widget.inprogresscontracts;
    
    return Scaffold(
      
      appBar: AppBar(
       backgroundColor: Colors.blueAccent,
       title: Text('Completed Transactions'), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
                  child: Container(
            child: ListView.builder( 
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: inprogresscontracts.length, 
                        
                        itemBuilder: (BuildContext context,int index){
                          print("completed contracts");
                          print(inprogresscontracts);
                          print(index);
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  
                                  title: Text('By : ${inprogresscontracts[index]['employerEmail']}', 
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Contract Address: ${inprogresscontracts[index]['contractAddress']}'),
                                        Text('Duration: ${inprogresscontracts[index]['duration']} days'),
                                        Text('Hourly Rate: Rs ${inprogresscontracts[index]['hourRate']}'),
                                        Text('Leaves Allowed: ${inprogresscontracts[index]['leavesAllowed']}'),
                                        Text('Early Bonus: ${inprogresscontracts[index]['earlyBonus']}% per day'),
                                        Text('Overdue Charge: ${inprogresscontracts[index]['overdueCharge']}% per day'),

                                      ],
                                    ),
                                  ),
                                  ),
                              ),
                              
                              SizedBox(
                                height:5
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


