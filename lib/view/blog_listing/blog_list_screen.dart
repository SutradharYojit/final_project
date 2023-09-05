import 'package:final_project_blog_app/resources/resources.dart';
import 'package:final_project_blog_app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        elevation: 1,
        title: Padding(
          padding: EdgeInsets.only(top: 8.0.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                ImageAssets.projectLogo,
                height: 33.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: "DancingScript",
                      ),
                    ),
                    Text(
                      "Yojit Suthar",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0.r),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_task_rounded,
                size: 25.h,
              ),
            ),
          ),
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
                  padding: EdgeInsets.only(bottom: 15.w),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.push(RoutesName.blogDetailsScreen);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(10.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Yojit Suthar",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 7.w),
                                    child: Text(
                                      "Lorem Ipsum Hello world",
                                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0,bottom: 15),
                            child: Text(
                              "26-09-2022",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorManager.greyColor,
                              ),
                            ),
                          )
                        ],
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
