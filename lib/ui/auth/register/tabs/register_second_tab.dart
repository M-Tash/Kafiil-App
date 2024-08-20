import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kafiil_test/ui/auth/login/login_screen_view.dart';
import 'package:kafiil_test/ui/auth/register/cubit/register_screen_view_model.dart';
import 'package:kafiil_test/utils/custom_widgets/custom_row_check_box.dart';
import 'package:kafiil_test/utils/custom_widgets/drop_down.dart';

import '../../../../utils/custom_widgets/custom_radio.dart';
import '../../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../../../utils/custom_widgets/date_widget.dart';
import '../../../../utils/custom_widgets/salary_widget.dart';
import '../../../../utils/my_theme.dart';
import '../cubit/states.dart';

class RegisterSecondTab extends StatefulWidget {
  final RegisterScreenViewModel viewModel;
  final VoidCallback onSubmit;

  const RegisterSecondTab({
    super.key,
    required this.viewModel,
    required this.onSubmit,
  });

  @override
  State<RegisterSecondTab> createState() => _RegisterSecondTabState();
}

class _RegisterSecondTabState extends State<RegisterSecondTab> {
  int gender = 0;
  List<String> social = [];
  int salary = 1000;
  File? _image;
  DateTime selectedDate = DateTime(2000, 01, 01);
  bool isFacebookChecked = false;
  bool isTwitterChecked = false;
  bool isInstagramChecked = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.birthDate =
        selectedDate.toIso8601String().split('T').first;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.viewModel.avatar = _image;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;
    double padding = screenWidth * 0.05;
    double fixedBorderRadius = 12;

    return BlocConsumer<RegisterScreenViewModel, RegisterStates>(
      bloc: widget.viewModel,
      listener: (context, state) async {
        if (state is RegisterLoadingState) {
          widget.viewModel.showLoadingDialog(context);
        } else if (state is RegisterSuccessState) {
          widget.viewModel.dismissLoadingDialog(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registration successful!"),
              backgroundColor: MyTheme.primary900Color,
            ),
          );
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else if (state is RegisterErrorState) {
          widget.viewModel.dismissLoadingDialog(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${state.errorMessage}"),
              backgroundColor: MyTheme.primary900Color,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: isPortrait ? screenHeight * 0.01 : screenHeight * 0.02,
              horizontal: padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: widget.viewModel.isErrorVisible,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: isPortrait
                          ? screenHeight * 0.02
                          : screenHeight * 0.03),
                  child: Container(
                    width: double.infinity,
                    height:
                        isPortrait ? screenHeight * 0.04 : screenHeight * 0.09,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(fixedBorderRadius),
                      color: MyTheme.error50Color,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: isPortrait
                                  ? screenWidth * 0.05
                                  : screenWidth * 0.03,
                              right: isPortrait
                                  ? screenWidth * 0.02
                                  : screenWidth * 0.01),
                          child: SvgPicture.asset(
                            'assets/icons/mark_vector.svg',
                            height: isPortrait
                                ? screenHeight * 0.020
                                : screenHeight * 0.05,
                            width: isPortrait
                                ? screenWidth * 0.020
                                : screenWidth * 0.05,
                          ),
                        ),
                        Text(
                          'Fill the required fields',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontSize: isPortrait
                                    ? screenHeight * 0.015
                                    : screenHeight * 0.04,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical:
                        isPortrait ? screenHeight * 0.02 : screenHeight * 0.03),
                child: Image.asset(
                  'assets/icons/stepper2nd.png',
                  width: isPortrait ? screenWidth * 0.9 : screenWidth * 0.6,
                  height: isPortrait ? screenHeight * 0.05 : screenHeight * 0.1,
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width:
                          isPortrait ? screenHeight * 0.1 : screenHeight * 0.3,
                      height:
                          isPortrait ? screenHeight * 0.1 : screenHeight * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: MyTheme.primary900Color, width: 2.0),
                      ),
                      child: CircleAvatar(
                        backgroundColor: MyTheme.primary100Color,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Image.asset('assets/images/profile_img.png')
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: isPortrait
                              ? screenHeight * 0.015
                              : screenHeight * 0.045,
                          backgroundColor: MyTheme.primary900Color,
                          child: Icon(Icons.add,
                              color: MyTheme.bgGrey900Color,
                              size: isPortrait
                                  ? screenHeight * 0.02
                                  : screenHeight * 0.04),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: widget.viewModel.formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      height:
                          isPortrait ? screenHeight * 0.15 : screenHeight * 0.5,
                      maxLines: 5,
                      hasError: widget.viewModel.isErrorVisible,
                      keyboardType: TextInputType.text,
                      tagText: 'About',
                      controller: widget.viewModel.aboutController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          setState(() {
                            widget.viewModel.isErrorVisible = true;
                          });
                          return '';
                        } else if (value.length < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('About must be at least 10 characters.'),
                              backgroundColor: MyTheme.primary900Color,
                            ),
                          );
                          return '';
                        } else if (value.length > 1000) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('About cannot exceed 1000 characters.'),
                              backgroundColor: MyTheme.primary900Color,
                            ),
                          );
                          return '';
                        }
                        widget.viewModel.isErrorVisible = false;
                        return null;
                      },
                    ),
                    SalaryCounter(
                      onSalaryChanged: (int newSalary) {
                        setState(() {
                          salary = newSalary.clamp(100, 1000);
                          widget.viewModel.salary = salary;
                        });
                      },
                    ),
                    DateWidget(onDateSelected: widget.viewModel.onDateSelected),
                    Padding(
                      padding: EdgeInsets.only(
                          top: isPortrait
                              ? screenHeight * 0.02
                              : screenHeight * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Gender',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: isPortrait
                                      ? screenHeight * 0.017
                                      : screenHeight * 0.05,
                                ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Row(
                            children: [
                              CustomRadio(
                                title: 'Male',
                                value: 0,
                                groupValue: gender,
                                onChanged: (int value) {
                                  setState(() {
                                    gender = value;
                                    widget.viewModel.gender = false;
                                  });
                                },
                                activeBorderColor: MyTheme.primary900Color,
                                inactiveBorderColor: MyTheme.grey300Color,
                              ),
                              CustomRadio(
                                title: 'Female',
                                value: 1,
                                groupValue: gender,
                                onChanged: (int value) {
                                  setState(() {
                                    gender = value;
                                    widget.viewModel.gender = true;
                                  });
                                },
                                activeBorderColor: MyTheme.primary900Color,
                                inactiveBorderColor: MyTheme.grey300Color,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                          child: Text(
                            'Skills',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: isPortrait
                                      ? screenHeight * 0.017
                                      : screenHeight * 0.05,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.015),
                          child: TagsDropdownSearch(
                            viewModel: widget.viewModel,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Favourite Social Media',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: isPortrait
                                          ? screenHeight * 0.017
                                          : screenHeight * 0.05,
                                    ),
                          ),
                          CustomRowCheckBox(
                            icon: 'assets/icons/facebook.png',
                            title: 'Facebook',
                            isChecked: isFacebookChecked,
                            onChanged: (bool selected) {
                              setState(() {
                                if (selected) {
                                  isFacebookChecked = true;
                                  social.add('facebook');
                                } else {
                                  isFacebookChecked = false;
                                  social.remove('facebook');
                                }
                                widget.viewModel.social = social;
                              });
                            },
                          ),
                          CustomRowCheckBox(
                            icon: 'assets/icons/x.png',
                            title: 'X',
                            isChecked: isTwitterChecked,
                            onChanged: (bool selected) {
                              setState(() {
                                if (selected) {
                                  isTwitterChecked = true;
                                  social.add('x');
                                } else {
                                  isTwitterChecked = false;
                                  social.remove('x');
                                }
                                widget.viewModel.social = social;
                              });
                            },
                          ),
                          CustomRowCheckBox(
                            icon: 'assets/icons/instagram.png',
                            title: 'Instagram',
                            isChecked: isInstagramChecked,
                            onChanged: (bool selected) {
                              setState(() {
                                if (selected) {
                                  isInstagramChecked = true;
                                  social.add('instagram');
                                } else {
                                  isInstagramChecked = false;
                                  social.remove('instagram');
                                }
                                widget.viewModel.social = social;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: isPortrait ? screenHeight * 0.05 : screenHeight * 0.05,
                    bottom:
                        isPortrait ? screenHeight * 0.02 : screenHeight * 0.05),
                child: GestureDetector(
                  onTap: widget.viewModel.validateAndRegister,
                  child: Container(
                    width: screenWidth * 0.9,
                    height:
                        isPortrait ? screenHeight * 0.07 : screenHeight * 0.16,
                    decoration: BoxDecoration(
                      color: MyTheme.primary900Color,
                      borderRadius: BorderRadius.circular(fixedBorderRadius),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: isPortrait
                                ? screenHeight * 0.017
                                : screenHeight * 0.05,
                            color: MyTheme.bgGrey900Color),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
