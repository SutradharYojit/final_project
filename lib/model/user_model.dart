import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? userName;
  final String? email;
  final String? uid;
  final List<String>? project;
  final List<String>? achievement;
  final List<String>? skill;

  UserDataModel({this.userName, this.email, this.uid, this.project, this.achievement, this.skill});

  factory UserDataModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return UserDataModel(
      userName: data?['user_name'],
      email: data?['email'],
      uid: data?['uid'],
      project: data?['project'] is Iterable ? List.from(data?['project']) : null,
      achievement: data?['achievement'] is Iterable ? List.from(data?['achievement']) : null,
      skill: data?['skill'] is Iterable ? List.from(data?['skill']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['emai'] = this.email;
    data['uid'] = this.uid;
    data['project'] = this.project;
    data['achievement'] = this.achievement;
    data['skill'] = this.skill;
    return data;
  }
}
