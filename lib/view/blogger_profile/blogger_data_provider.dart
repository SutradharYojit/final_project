import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_blog_app/resources/resources.dart';
import 'package:final_project_blog_app/services/firebase_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import '../../model/model.dart';
// List of blogger portfolio models
final bloggerData = StateNotifierProvider<BloggersData, List<UserDataModel>>((ref) => BloggersData());

class BloggersData extends StateNotifier<List<UserDataModel>> {
  BloggersData() : super([]);
  bool loading = true;

  final db = FirebaseFirestore.instance;
  // function to get the list of blogger portfolio
  Future<void> getUserData() async {
    state.clear();
    // Get the list of users from the firebase database
    QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection(FBServiceManager.dbUser).get();
    state.addAll(snapshot.docs.map((docSnapshot) => UserDataModel.fromFirestore(docSnapshot)).toList());
    loading = false;
    final current = state.where((element) => element.uid==UserGlobalVariables.uid).toList(); // the current user data from the list
    state.remove(current.first);// remove the current user from the blogger list
    state.insert(0, current.first);// insert the current user in the first of the list
    log(current.length.toString());
    state = [...state];
  }

}
