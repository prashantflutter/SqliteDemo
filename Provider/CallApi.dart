

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'UserModel.dart';

class UserData extends ChangeNotifier {

  Dio dio = Dio();

  var studData = <UserModel>[];

  // Future<void> getStudData()async{
  //    var url = 'https://jsonplaceholder.typicode.com/posts';
  //   var response = await dio.get(url);
  //   debugPrint('start');
  //   if(response.data != null && response.statusCode == 200){
  //     debugPrint('stop');
  //     for(var i in response.data){
  //       studData.add(UserModel.fromJson(i));
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void>getData()async{
    try{
      var url = 'https://jsonplaceholder.typicode.com/posts';
      var response = await dio.get(url);

      if(response.statusCode == 200){
        debugPrint('stop');
         for(var i in response.data){
           studData.add(UserModel.fromJson(i));
         }
        notifyListeners();

      }else{
        print('Response  statusCode ==> ${response.statusCode}');
      }
    }catch(e){
      print('Error ==> ${e}');
    }
  }
}