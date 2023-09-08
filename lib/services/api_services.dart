import 'dart:convert';
import 'dart:developer';
import 'package:final_project_blog_app/services/api_constants.dart';
import 'package:final_project_blog_app/services/status_code.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';

// Class of the Api service , Define all the api functions Like GET, POST, PUT AND DELETE
class ApiServices {
  // GET APi , Function to return the List of Blog Data
  Future blogData() async {
    List<BlogDataModel> blogData = [];
    try {
      http.Response response = await http.get(Uri.parse(APIConstants.baseUrl));
      log(response.statusCode.toString());
      if (response.statusCode == ServerStatusCodes.success) {
        var jsonData = jsonDecode(response.body)['data'];
        for (Map<String, dynamic> i in jsonData) {
          //add all the data to blogData List
          blogData.add(BlogDataModel.fromJson(i));
        }
        return blogData;
      }
    } catch (e) {
      log(e.toString());
    }
  }

//POST APi , Function to Send new Blog Data to the Database
  Future<void> addBlogData(Map<String, dynamic> blog) async {
    final response = await http.post(
      Uri.parse(APIConstants.baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({"data": blog}),
    );

    if (response.statusCode == ServerStatusCodes.addSuccess) {
      log('blog Added.');
    } else {
      log('Failed to add Blog. Status code: ${response.statusCode}');
      log('Response body: ${response.body}');
    }
  }

//DELETE Api , Function to delete Blog With Specific ID
  Future<void> deleteBlog(int blogId) async {
    final response = await http.delete(
      Uri.parse("${APIConstants.baseUrl}/$blogId"),
    );
    if (response.statusCode == ServerStatusCodes.success) {
      log('Blog with ID $blogId has been deleted.');
    } else {
      log('Failed to delete Blog. Status code: ${response.statusCode}');
      log('Response body: ${response.body}');
    }
  }

//PUT Api , Function to Update the existing Blog With Specific ID
  Future<void> editBlogData(Map<String, dynamic> blog, int blogId) async {
    final response = await http.put(
      Uri.parse("${APIConstants.baseUrl}/$blogId"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({"data": blog}),
    );

    if (response.statusCode == ServerStatusCodes.success) {
      log('Blog  with ID has been edited.');
    } else {
      log('Failed to edit Blog: Status code: ${response.statusCode}');
      log('Response body: ${response.body}');
    }
  }
}
