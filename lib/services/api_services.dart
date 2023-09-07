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
    if (response.statusCode == ServerStatusCodes.success) {
      var jsonData = jsonDecode(response.body)['data'];
      for (Map<String, dynamic> i in jsonData) {
        blogData.add(BlogDataModel.fromJson(i));
      }
      log(blogData[0].attributes!.title.toString());
      return blogData;
    }
  }

  Future<void> addProduct(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse("http://10.1.81.185:1337/api/blogs"),
      headers: {
        'Content-Type': 'application/json', // Set the Content-Type header
      },
      body: json.encode({
        "data": product
      }),
    );

    if (response.statusCode == 201) {
      print('Product with ID has been added.');
    } else {
      print('Failed to add product. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }


  Future<void> deleteProduct(int blogId) async {

    final response = await http.delete(
      Uri.parse("http://10.1.81.185:1337/api/blogs/$blogId"),
    );

    if (response.statusCode == 200) {
      print('Product with ID $blogId has been deleted.');
    } else {
      print('Failed to delete product. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }







}
