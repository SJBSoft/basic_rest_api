import 'dart:convert';

import 'package:basic/constant.dart';
import 'package:basic/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PostModel.dart';
import 'models/UserModel.dart';
import 'models/data.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  late Future<Post> post;
  var userData;
  User? user;
  Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  Uri url = Uri.parse(users + '1');

  Future<User> getUser() async {
    //ApiResponse apiResponse = ApiResponse();
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //apiResponse.data = User.fromJson(jsonDecode(response.body));
      //print('GGG'+response.body);
      // var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      // print(jsonResponse['user']['name']);
      //
      // print(user?.email);
      var data = User.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Error Getting Data');
    }
  }
  Future<List<Data>> fetchDatas() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<User>> fetchDatass() async {
    var url = Uri.parse(allUser);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['users'];
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<User>> getAllUser() async {
    final response = await http.get(Uri.parse(allUser));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print('Workingggg');
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Post> fetchData() async {
    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        //print(response.body);
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error Getting Data');
      }
    } catch (e) {
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
              /*Container(
                child: FutureBuilder<Post>(
                  future: post,
                  builder: (context, abc) {
                    if (abc.hasData) {
                      return Text(
                        abc.data!.title,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      );
                    } else if (abc.hasError) {
                      return Text(abc.error.toString());
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),*/
              SizedBox(
                height: 50,
              ),
              Text(user!.email.toString()),

              Container(
                height: 500,
                width: 300,
                child: FutureBuilder<List<User>>(
                  future: fetchDatass(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 75,
                              color: Colors.white,
                              child: Center(
                                child: Text(snapshot.data![index].name),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    // By default show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    //post = fetchData();
    getData();
    //getAllUser();
    //var data = userData as User;
  }

  getData() async {
    userData = await getUser();
    user = userData as User;
    print(user!.email);
  }
}
