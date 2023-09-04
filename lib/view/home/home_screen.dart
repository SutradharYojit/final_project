import 'package:final_project_blog_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                    return Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Text(
                              "Yojit Suthar",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(minHeight: 150.h, maxHeight: 150.h),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://c4.wallpaperflare.com/wallpaper/39/346/426/digital-art-men-city-futuristic-night-hd-wallpaper-preview.jpg",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
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
