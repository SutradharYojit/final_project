import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import '../view.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void onTap() async {
    if (_emailController.text.trim() == "" ||
        _emailController.text.trim().isEmpty ||
        _nameController.text.trim() == "" ||
        _nameController.text.trim().isEmpty ||
        _descriptionController.text.trim() == "" ||
        _descriptionController.text.trim().isEmpty ||
        _phoneController.text.trim() == "" ||
        _phoneController.text.trim().isEmpty) {
      requiredAllFilled(context); // send the message to the user for required all the fields
    } else {
      // Function to send the contact us data and store in firebase
      await FireBaseServices().contactUs(
        context,
        name: _nameController.text.trim(),
        number: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        description: _descriptionController.text.trim(),
      );
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(
            title: StringManager.contactAppBarTxt,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _nameController,
                    hintText: StringManager.nameHintTxt,
                    labelText: StringManager.nameLabelTxt,
                    prefixIcon: const Icon(
                      Icons.text_format_rounded,
                      color: ColorManager.gradientPurpleColor,
                    ),
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _phoneController,
                    hintText: StringManager.phoneHintTxt,
                    labelText: StringManager.phoneLabelTxt,
                    prefixIcon: const Icon(
                      Icons.call,
                      color: ColorManager.gradientPurpleColor,
                    ),
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    prefixText: "+91-",
                    maxLength: 10,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _emailController,
                    hintText: StringManager.emailHintTxt,
                    labelText: StringManager.emailLabelTxt,
                    prefixIcon: const Icon(
                      Icons.mail_rounded,
                      color: ColorManager.gradientPurpleColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _descriptionController,
                    hintText: StringManager.descriptionHintTxt,
                    labelText: StringManager.descriptionLabelTxt,
                    prefixIcon: const Icon(
                      Icons.description,
                      color: ColorManager.gradientPurpleColor,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                PrimaryButton(
                  title: StringManager.sendMessageBtn,
                  onTap: onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
