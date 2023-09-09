import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import '../../model/model.dart';
import '../../services/api_services.dart';
// Riverpod state management
final blogDataList = StateNotifierProvider<BlogData, List<BlogDataModel>>((ref) => BlogData());
// used to get the list of blog data
class BlogData extends StateNotifier<List<BlogDataModel>> {
  BlogData() : super([]);


  // function to add the blog data into the list
  Future<void> blogData() async {
    state.clear();
    state = await ApiServices().blogData();
    state =  List.from(state.reversed);

    state = [...state];
  }
  // function to remove the blog data from the list
  Future<void> blogDelete(int blogId,int index) async {
    state.removeAt(index);
    await ApiServices().deleteBlog(blogId);
    state = [...state];
  }
}