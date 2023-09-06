import 'dart:convert';
import 'dart:developer';
import 'package:final_project_blog_app/services/status_code.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class ApiServices {

  Future blogData() async {
    List<BlogDataModel> blogData = [];
    http.Response response = await http.get(Uri.parse("http://10.1.81.185:1337/api/blogs"));
    log(response.statusCode.toString());
    if(response.statusCode == ServerStatusCodes.success){
      var jsonData = jsonDecode(response.body)['data'];
      for (Map<String, dynamic> i in jsonData) {
        blogData.add(BlogDataModel.fromJson(i));
      }
      log(blogData[0].attributes!.title.toString());
      return blogData;
    }
    log("asdasasd");

  }
}
