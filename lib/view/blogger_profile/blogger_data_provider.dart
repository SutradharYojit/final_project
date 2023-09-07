import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_blog_app/resources/resources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';

final bloggerData = StateNotifierProvider<BloggersData, List<UserDataModel>>((ref) => BloggersData());

class BloggersData extends StateNotifier<List<UserDataModel>> {
  BloggersData() : super([]);
  bool loading = true;

  final db = FirebaseFirestore.instance;

  Future<void> getUserData() async {
    // log(UserGlobalVariables.docId.toString());
    state.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection(FBServiceManager.dbUser).get();
    log("Enter 2");
    state.addAll(snapshot.docs.map((docSnapshot) => UserDataModel.fromFirestore(docSnapshot)).toList());
    loading = false;
    log(state.length.toString());
    state = [...state];
  }



  void add(UserDataModel data) {
    state.remove(data);
    state.insert(0,data);
    state = [...state];
  }

}
