import 'dart:convert';

import 'package:flutter_mev/models/mev_models.dart';
import 'package:http/http.dart' as http;

class MevApiProvider{
  final String URL = 'https://mevnovosti.000webhostapp.com/sql.php';
  Future<MevModels> getApi() async{
    var client = http.Client();
    var mevModels = null;

    try{
      var response = await client.get(URL);
      if(response.statusCode == 200){
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        mevModels = MevModels.fromJson(jsonMap);
      }
    }catch (Exception){
      return mevModels;
    }
    return mevModels;

  }

}