import 'package:final_project_blog_app/resources/resources.dart';
import 'package:flutter/material.dart';
import '../view.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final ValueNotifier<int> _screenIndex = ValueNotifier(0);

  final List<Widget> _screens = [
    const PortfolioScreen(),
    const BlogListScreen(),
    const ContactFormScreen(),
  ];

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
                icon: Icon(Icons.supervised_user_circle_outlined),
                label: StringManager.portfolioScreen,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: StringManager.blogScreen,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contactless_outlined),
                label: StringManager.contactUsScreen,
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
