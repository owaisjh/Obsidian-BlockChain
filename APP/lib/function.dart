import 'package:http/http.dart' as http;

// import 'package:sticky_headers/sticky_headers.dart';
import 'dart:convert';
import 'package:obsidian/models/user.dart';
import 'package:obsidian/models/transaction.dart';
import 'package:obsidian/models/contract.dart';
import 'models/abc.dart';




final String url = 'http://664cdbe3ce46.ngrok.io';

Future<dynamic> login(String email, String password) async {
  
  var response = await http.post('$url/login',
  headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

  body: jsonEncode({
    "email": "$email",
    "password": "$password"
  }),
  
  );
  return response;
}

Future<dynamic> createUser({String name, String password, String email, String aadharNumber, String contactNo, }) async {
   try { 
    return await http.post('$url/sign_up',
  headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },
    body: json.encode({
    "name": "$name",
    "password": "$password",
    "email": "$email",
    "aadhar_no": "$aadharNumber",
    "contact": "$contactNo"
  }), 
  );
  //print("hi");
  }
  catch(e){
    print(e);
  }
 
}

Future<User> getProfile (String email) async {
  var response = await http.post('$url/get_profile',
  headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

  body: jsonEncode({
    "email": "$email",
  }),
  
  );
  print(response.body);
  var jsonData = json.decode(response.body);
  print(jsonData);

  User user = User(
    walletId : jsonData['wallet_id'],
    aadharNo: jsonData['aadhar_no'],
    name: jsonData['name'],
    contactNo: jsonData['contact'],
    email: email

    
  );

  return user;

  //for loop in jsonData and create user Models

  //return response.statusCode;

}


Future<List> getOngoingContracts(String email) async {

    var response = await http.post('$url/list_ongoing',
    headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

    body: jsonEncode({
    "email": "$email",
  }),
  
  );
  var jsonData = json.decode(response.body);
  print("ongoing");
  print(jsonData);
  int n = jsonData[0];
  print(n);
  List ongoing = jsonData[1];
  print(ongoing);
 
  return ongoing;
}


Future<List> getCompletedContracts(String email) async {

    var response = await http.post('$url/list_completed',
    headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

    body: jsonEncode({
    "email": "$email",
  }),
  
  );
  var jsonData = json.decode(response.body);
  print("completed");
  print(jsonData);
  int n = jsonData[0];
  print(n);
  List completed = jsonData[1];
  print(completed);
 
  return completed;
}

Future<List> getPendingContracts(String email) async {

    var response = await http.post('$url/list_pending',
    headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

    body: jsonEncode({
    "email": "$email",
  }),
  
  );
  var jsonData = json.decode(response.body);
  print("pending");
  print(jsonData);
  int n = jsonData[0];
  print(n);
  List pending = jsonData[1];
  print(pending);
 
  return pending;
}

Future<List> getCanceledContracts(String email) async {

    var response = await http.post('$url/list_canceled',
    headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

    body: jsonEncode({
    "email": "$email",
  }),
  
  );
  var jsonData = json.decode(response.body);
  print("canceled");
  print(jsonData);
  int n = jsonData[0];
  print(n);
  List canceled = jsonData[1];
  print(canceled);
 
  return canceled;
}


Future<dynamic> acceptContract (int id) async {
  var response = await http.post('$url/accept_contract',
    headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

    body: jsonEncode({
    "id": "$id",
  }),
  
  );

  print(response.statusCode);

  return response;
}

Future<dynamic> declineContract (int id) async {
  var response = await http.post('$url/decline_contract',
    headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

    body: jsonEncode({
    "id": "$id",
  }),
  
  );

  print(response.statusCode);

  return response;
}


Future<dynamic> getMyContracts (String email) async {
  var response = await http.post('$url/emp_contracts',
    headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

    body: jsonEncode({
    "email": "$email",
  }),
  
  );
  var jsonData = json.decode(response.body);
  print("my contracts");
  print(jsonData);
  int n = jsonData[0];
  print(n);
  List mycontracts = jsonData[1];
  print(mycontracts);
 
  return mycontracts;
}


Future<dynamic> completeContract (int id, int hoursWorked, int noOfLeaves) async {
  var response = await http.post('$url/complete',
    headers : {
    "Accept" : "application/json",
    "Content-type": "application/json"
    },

    body: jsonEncode({
    "id": id,
    "hoursWorked" : hoursWorked,
    "leaves" : noOfLeaves
  }),
  
  );

  print(response.statusCode);

  return response;
}