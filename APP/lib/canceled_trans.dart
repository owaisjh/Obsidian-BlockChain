import 'package:flutter/material.dart';
import 'package:obsidian/models/transaction.dart';
import 'transactionpage.dart';
import 'function.dart';

class CanceledTransaction extends StatefulWidget {
  final List canceledcontracts;

  CanceledTransaction({this.canceledcontracts});
  @override
  _CanceledTransactionState createState() => _CanceledTransactionState();
}

class _CanceledTransactionState extends State<CanceledTransaction> {
  

  @override
  Widget build(BuildContext context) {
    List canceled = widget.canceledcontracts;
    
    return Scaffold(
      
      appBar: AppBar(
       backgroundColor: Colors.blueAccent,
       title: Text('Canceled Transactions'), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
                  child: Container(
            child: ListView.builder( 
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: canceled.length, 
                        
                        itemBuilder: (BuildContext context,int index){
                          print("completed contracts");
                          print(canceled);
                          print(index);
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  
                                  title: Text('By : ${canceled[index]['employerEmail']}', 
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Text('Contract Address: ${canceled[index]['contractAddress']} '),
                                        Text('Duration: ${canceled[index]['duration']} days'),
                                        Text('Hourly Rate: Rs ${canceled[index]['hourRate']}'),
                                        Text('Leaves Allowed: ${canceled[index]['leavesAllowed']}'),
                                        Text('Early Bonus: ${canceled[index]['earlyBonus']}% per day'),
                                        Text('Overdue Charge: ${canceled[index]['overdueCharge']}% per day'),

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


