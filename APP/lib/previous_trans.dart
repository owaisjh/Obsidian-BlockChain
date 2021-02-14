import 'package:flutter/material.dart';
import 'package:obsidian/models/transaction.dart';
import 'transactionpage.dart';


class PreviousTransaction extends StatefulWidget {
  @override
  _PreviousTransactionState createState() => _PreviousTransactionState();
}

class _PreviousTransactionState extends State<PreviousTransaction> {
  

  @override
  Widget build(BuildContext context) {
    List<Transaction> f = [];
  f.add(Transaction(
      id: 1,
      description : "Transaction 1",
      value: 250,
    ));

    f.add(Transaction(
      id: 2,
      description : "Transaction 2",
      value: 550,
    ));

    f.add(Transaction(
      id: 3,
      description : "Transaction 3",
      value: 100,
    ));
    return Scaffold(
      body: ListView.builder( 
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: f.length, 
              itemBuilder: (BuildContext context,int index){ 
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UpcomingCard(
          index: index,
          title: f[index].description,
          value: f[index].value,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage(transaction: f[index],),),);
          },
        ),
      );
        }
        )
      
    );
  }
}


class UpcomingCard extends StatelessWidget {
  final String title;
  final double value;
  final int index;
  final Function onTap;
  // final Color color;

  UpcomingCard({this.title, this.value, this.index,this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = index%2 == 0 ? Colors.blue : Colors.orange;
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
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
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right, color: Colors.white,),
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