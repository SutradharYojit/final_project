import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';
import '../../services/api_services.dart';

final blogDataList = StateNotifierProvider<BlogData, List<BlogDataModel>>((ref) => BlogData());

class BlogData extends StateNotifier<List<BlogDataModel>> {
  BlogData() : super([]);

  Future<void> blogData() async {
    state = await ApiServices().blogData();
    state = [...state];
  }

// void removeSkills(int index) {
//   state.remove(index);
//   state = [...state];
// }
}
