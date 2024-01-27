import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CallApi.dart';

class UserDataViewPage extends StatefulWidget {
  const UserDataViewPage({super.key});

  @override
  State<UserDataViewPage> createState() => _UserDataViewPageState();
}


class _UserDataViewPageState extends State<UserDataViewPage> {

  @override
  void initState() {
    super.initState();
    userData = Provider.of<UserData>(context,listen: false);
    userData?.getData();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   userData = Provider.of<UserData>(context,listen: false);
  //   userData?.getData();
  // }

  UserData? userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('User Data View',style: TextStyle(color: Colors.white),),
      ),
      body: Consumer<UserData>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.studData.length,
              itemBuilder: (context,index){
            return ListTile(
              title: Text(value.studData[index].title.toString(),maxLines: 1,),
              subtitle: Text(value.studData[index].body.toString(),maxLines: 1,),
            );
          });
        }
      ),
    );
  }
}
