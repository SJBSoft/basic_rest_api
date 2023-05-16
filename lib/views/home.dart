import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../PostModel.dart';
import '../models/UserModel.dart';

void main(){
  runApp(myApp());
}
class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  late Future<Post> post;
  late Future<User> user;
  Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  Uri url = Uri.parse('http://10.0.2.2:8000/api/users/1');

  Future<User>getUser() async{
    final response = await http.get(url);
    if(response.statusCode == 200){
      //print('GGG'+response.body);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      print(jsonResponse['user']['name']);
      return User.fromJson(json.decode(response.body));
    }else{
      throw Exception('Error Getting Data');
    }
  }

  Future<Post>fetchData() async{
    final response = await http.get(uri);
    try{
      if(response.statusCode == 200){
        //print(response.body);
        return Post.fromJson(json.decode(response.body));
      }else{
        throw Exception('Error Getting Data');
      }
    }catch (e){
      print(e.toString());
    }
    return Post.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Basic API'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                child: FutureBuilder<Post>(
                  future: post,
                  builder: (context, abc){
                    if(abc.hasData){
                      return Text(abc.data!.title, style: TextStyle(
                        fontSize: 24,
                      ),);
                    }else if(abc.hasError){
                      return Text(abc.error.toString());
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: FutureBuilder<User>(
                  future: user,
                  builder: (context, abc){
                    if(abc.hasData){
                      return Text(abc.data.toString(), style: TextStyle(
                        fontSize: 24,
                      ),);
                    }else if(abc.hasError){
                      return Text(abc.error.toString(), style: TextStyle(
                        fontSize: 24,
                      ));
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    post = fetchData();
    user = getUser();
  }
}
