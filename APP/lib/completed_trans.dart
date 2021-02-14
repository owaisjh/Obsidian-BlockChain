import 'package:flutter/material.dart';
import 'package:obsidian/models/transaction.dart';
import 'transactionpage.dart';
import 'function.dart';

class CompletedTransaction extends StatefulWidget {
  final List completedcontracts;

  CompletedTransaction({this.completedcontracts});
  @override
  _CompletedTransactionState createState() => _CompletedTransactionState();
}

class _CompletedTransactionState extends State<CompletedTransaction> {
  

  @override
  Widget build(BuildContext context) {
    List completedcontracts = widget.completedcontracts;
    
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
                        itemCount: completedcontracts.length, 
                        
                        itemBuilder: (BuildContext context,int index){
                          print("completed contracts");
                          print(completedcontracts);
                          print(index);
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  
                                  title: Text('By : ${completedcontracts[index]['employerEmail']}', 
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Contract Address: ${completedcontracts[index]['contractAddress']}'),
                                        Text('Duration: ${completedcontracts[index]['duration']} days'),
                                        Text('Hourly Rate: Rs ${completedcontracts[index]['hourRate']}'),
                                        Text('Leaves Allowed: ${completedcontracts[index]['leavesAllowed']}'),
                                        Text('Early Bonus: ${completedcontracts[index]['earlyBonus']}% per day'),
                                        Text('Overdue Charge: ${completedcontracts[index]['overdueCharge']}% per day'),

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


