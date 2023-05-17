import 'package:basic/constant.dart';
import 'package:flutter/material.dart';
import '../controller/user_controller.dart';
import '../models/UserModel.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        logout();
      }, child: Icon(Icons.logout)),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<User>(
                    future: getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(
                              snapshot.data!.name,
                              style: profileTextStyle(),
                            ),
                            Text(snapshot.data!.username,
                                style: profileTextStyle()),
                            Text(snapshot.data!.email, style: profileTextStyle()),
                            snapshot.data!.profileImage != null
                                ? Image.network(websiteUrl +
                                    'upload/' +
                                    snapshot.data!.profileImage.toString())
                                : const Icon(Icons.no_accounts),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),


                Container(
                  color: Colors.yellow,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                  child: FutureBuilder<List<User>>(
                    future: getAllUser(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              height: 75,
                                color: Colors.white,
                                child: Center(child: Text(snapshot.data![index].name)));
                          },
                        );
                      }else if(snapshot.hasError){
                        return Text(snapshot.error.toString());
                      }return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
