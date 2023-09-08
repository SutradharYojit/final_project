// import 'dart:developer';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../model/model.dart';
// import '../../services/api_services.dart';
//
// final blogDataList = StateNotifierProvider<BlogData, List<BlogDataModel>>((ref) => BlogData());
//
// class BlogData extends StateNotifier<List<BlogDataModel>> {
//   BlogData() : super([]);
//
//   Future<void> blogData() async {
//     try{
//       log(state.length.toString());
//       state.clear();
//       state = await ApiServices().blogData();
//       state =  List.from(state.reversed);
//       log(state.length.toString());
//       state = [...state];
//     }catch(error) {
//       log(error.toString());
//     }
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';
import '../../services/api_services.dart';

final blogDataList = StateNotifierProvider<BlogData, List<BlogDataModel>>((ref) => BlogData());

class BlogData extends StateNotifier<List<BlogDataModel>> {
  BlogData() : super([]);

  Future<void> blogData() async {
    state.clear();
    state = await ApiServices().blogData();
    state =  List.from(state.reversed);
    state = [...state];
  }

  Future<void> blogDelete(int blogId,int index) async {
    state.removeAt(index);
    await ApiServices().deleteBlog(blogId);
    state = [...state];
  }


// void removeSkills(int index) {
//   state.remove(index);
//   state = [...state];
// }
}