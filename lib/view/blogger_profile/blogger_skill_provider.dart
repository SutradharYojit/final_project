import 'package:flutter_riverpod/flutter_riverpod.dart';

final skillsList = StateNotifierProvider<BloggerSkills, List>((ref) => BloggerSkills());

class BloggerSkills extends StateNotifier<List> {
  BloggerSkills() : super([]);

  void addSkills(String skills) {
    state.insert(0,skills);
    state = [...state];
  }

  void removeSkills(int index) {
    state.remove(index);
    state = [...state];
  }

  void addAllSkills(List skills) {
    state.addAll(skills);
    state = [...state];
  }
}


final achievementsList = StateNotifierProvider<BloggerAchievements, List>((ref) => BloggerAchievements());

class BloggerAchievements extends StateNotifier<List> {
  BloggerAchievements() : super([]);

  void addAchievements(String achievements) {
    state.add(achievements);
    state = [...state];
  }

  void removeAchievements(int index) {
    state.remove(index);
    state = [...state];
  }

  void addAllAchievements(List achievements) {
    state.addAll(achievements);
    state = [...state];
  }
}

final projectList = StateNotifierProvider<BloggerProject, List>((ref) => BloggerProject());


class BloggerProject extends StateNotifier<List> {
  BloggerProject() : super([]);

  void addProject(String project) {
    state.add(project);
    state = [...state];
  }

  void removeProject(int index) {
    state.remove(index);
    state = [...state];
  }

  void addAllProject(List project) {
    state.addAll(project);
    state = [...state];
  }
}