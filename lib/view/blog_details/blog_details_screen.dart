import 'package:final_project_blog_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../model/model.dart';


class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({super.key, required this.blogData});

  final BlogDataModel blogData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Details"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: 180.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.w),
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://c4.wallpaperflare.com/wallpaper/410/867/750/vector-forest-sunset-forest-sunset-forest-wallpaper-preview.jpg",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    blogData.attributes!.title!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Divider(
                  height: 18.h,
                  thickness: 1.5,
                  color: ColorManager.greyColor,
                ),
                Text(blogData.attributes!.description!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
