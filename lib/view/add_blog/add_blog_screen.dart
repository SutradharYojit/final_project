import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:final_project_blog_app/resources/resources.dart';
import 'package:final_project_blog_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/api_services.dart';
import '../../services/firebase_services.dart';
import '../view.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({
    super.key,
    required this.blogPreference,
  });

  //Getting the blog Data from the list of the blogs
  final BlogPreferences blogPreference;

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final TextEditingController _titleController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  File? imageFile;
  final bar = WarningBar();

  @override
  void initState() {
    super.initState();
    // the condition check while data is coming from blog list screen and used to update the blog data
    if (widget.blogPreference.blogChoice) {
      _titleController.text = widget.blogPreference.title!;
      _descriptionController.text = widget.blogPreference.description!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          title: widget.blogPreference.blogChoice
              ? StringManager.updateBlogTxt
              : StringManager.addBlogTxt, //check weather its should be add blog or update blog
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _titleController,
                    hintText: StringManager.titleHintTxt,
                    labelText: StringManager.titleLabelTxt,
                    prefixIcon: const Icon(
                      Icons.title,
                      color: ColorManager.gradientPurpleColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _descriptionController,
                    hintText: StringManager.descriptionHintTxt,
                    labelText: StringManager.descriptionLabelTxt,
                    prefixIcon: const Icon(
                      Icons.title,
                      color: ColorManager.gradientPurpleColor,
                    ),
                  ),
                ),
                PrimaryButton(
                  title: widget.blogPreference.blogChoice ? StringManager.updateBlogTxt : StringManager.addBlogTxt,
                  onTap: () async {
                    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                    if (_titleController.text.trim() == "" ||
                        _titleController.text.trim().isEmpty ||
                        _descriptionController.text.trim() == "" ||
                        _descriptionController.text.trim().isEmpty) {
                      // through the error snack bar when one of the text filled is empty
                      requiredAllFilled(context);
                    } else {
                      final addBlog = bar.snack(ApiServiceManager.blogAdd, ColorManager.greenColor);
                      final updateBlog = bar.snack(ApiServiceManager.blogUpdate, ColorManager.greenColor);
                      // Loading screen
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: Loading(),
                          );
                        },
                      );
                      // condition is invoke when the data is pas through from blog details screen
                      if (widget.blogPreference.blogChoice) {
                        // function to update the existing blog
                        ApiServices().editBlogData(
                          {
                            ApiServiceManager.apiTitleKey: _titleController.text.trim(),
                            ApiServiceManager.apiDescriptionKey: _descriptionController.text.trim(),
                            ApiServiceManager.apiAuthorKey: UserGlobalVariables.uid!.toString(),
                            ApiServiceManager.apiImageUrlKey:
                                "https://c4.wallpaperflare.com/wallpaper/410/867/750/vector-forest-sunset-forest-sunset-forest-wallpaper-preview.jpg"
                          },
                          widget.blogPreference.index!,
                        ).then((value) {
                          _titleController.clear();
                          _descriptionController.clear();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(addBlog);
                        });
                      } else {
                        //function to add blog data
                        ApiServices().addBlogData(
                          {
                            ApiServiceManager.apiTitleKey: _titleController.text.trim(),
                            ApiServiceManager.apiDescriptionKey: _descriptionController.text.trim(),
                            ApiServiceManager.apiAuthorKey: UserGlobalVariables.uid!.toString(),
                            ApiServiceManager.apiImageUrlKey:
                                "https://c4.wallpaperflare.com/wallpaper/410/867/750/vector-forest-sunset-forest-sunset-forest-wallpaper-preview.jpg"
                          },
                        ).then(
                          (value) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(updateBlog);
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
