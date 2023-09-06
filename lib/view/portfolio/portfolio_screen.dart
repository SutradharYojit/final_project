import 'package:final_project_blog_app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../resources/resources.dart';
import '../../widget/widget.dart';


class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Portfolio",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0.w),
            child: IconButton(
              onPressed: () {
                context.push(RoutesName.bloggerProfileScreen);
              },
              icon: const Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 10,
                      color: ColorManager.whiteColor,
                      child: Padding(
                        padding: EdgeInsets.all(15.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(children: []),
                            Text(
                              "Yojit Suthar",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email: abc@gmail.com",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  Text(
                                    "Skills: 25",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  Text(
                                    "Achivements: 25",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  Text(
                                    "Project: 25",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
