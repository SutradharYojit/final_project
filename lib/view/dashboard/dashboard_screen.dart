import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../view.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final ValueNotifier<int> _screenIndex = ValueNotifier(0);
  final List<Widget> _screens = [const MyHomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _screenIndex,
        builder: (context, value, child) {
          return _screens[value];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _screenIndex,
        builder: (context, value, child) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: "Blog",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_rounded),
                label: "Add Blog",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_rounded),
                label: "Profile",
              ),
            ],
            currentIndex: value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            iconSize: 35,
            elevation: 10,
            onTap: (value) {
              _screenIndex.value = value;
            },
          );
        },
      ),
    );
  }
}
