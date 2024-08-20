import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/ui/auth/login/login_screen_view.dart';
import 'package:kafiil_test/utils/my_theme.dart';

import '../../../../domain/di.dart';
import '../../../../utils/custom_widgets/custom_chip.dart';
import '../../../../utils/custom_widgets/custom_radio.dart';
import '../../../../utils/custom_widgets/custom_row_check_box.dart';
import '../../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../cubit/home_screen_view_model.dart';
import '../../cubit/states.dart';

class WhoAmI extends StatefulWidget {
  const WhoAmI({super.key});

  @override
  State<WhoAmI> createState() => _WhoAmIState();
}

class _WhoAmIState extends State<WhoAmI> {
  int selectedUserType = 1;
  int selectedGenderType = 0;
  var firstNameController = TextEditingController();
  var secondNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var aboutController = TextEditingController();
  var salaryController = TextEditingController();
  var dateController = TextEditingController();
  final bool socialMediaChecked = true;
  bool isObscure = true;
  File? _image;

  HomeScreenViewModel viewModel = HomeScreenViewModel(
      getCountriesUseCase: injectGetCountriesUseCase(),
      getServicesUseCase: injectGetServicesUseCase(),
      getPopularServicesUseCase: injectPopularServicesUseCase(),
      getProfileUseCase: injectGetProfileUseCase());

  final List<String> allSocialMediaPlatforms = ['Facebook', 'Instagram', 'X'];

  @override
  void initState() {
    super.initState();
    context.read<HomeScreenViewModel>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double paddingVertical =
        isPortrait ? screenHeight * 0.05 : screenHeight * 0.03;
    double paddingHorizontal =
        isPortrait ? screenWidth * 0.05 : screenWidth * 0.04;
    double avatarSize = isPortrait ? screenHeight * 0.10 : screenHeight * 0.25;
    double iconSize = isPortrait ? screenHeight * 0.03 : screenHeight * 0.05;
    double spacing = isPortrait ? screenHeight * 0.02 : screenHeight * 0.03;
    double buttonSize = isPortrait ? screenHeight * 0.04 : screenHeight * 0.06;
    double iconScale = isPortrait ? 2.7 : 2.5;

    return Scaffold(
      body: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primary900Color,
              ),
            );
          } else if (state is ProfileSuccessState) {
            var profile = state.profileData.data;
            firstNameController.text = profile?.firstName ?? '';
            secondNameController.text = profile?.lastName ?? '';
            emailController.text = profile?.email ?? '';
            passwordController.text = state.password;
            aboutController.text = profile?.about ?? '';
            salaryController.text = profile?.salary?.toString() ?? '';
            dateController.text = profile?.birthDate ?? '';
            selectedGenderType = profile?.gender ?? 0;
            selectedUserType = profile?.type?.code ?? 1;

            var tagsList = profile?.tags
                    ?.map((e) => e.name)
                    .where((name) => name != null)
                    .cast<String>()
                    .toList() ??
                [];

            var favoriteSocialMedia = profile?.favoriteSocialMedia ?? [];

            Map<String, bool> socialMediaCheckState = {
              'Facebook': favoriteSocialMedia.contains('facebook'),
              'Instagram': favoriteSocialMedia.contains('instagram'),
              'X': favoriteSocialMedia.contains('x'),
            };

            var sortedSocialMediaPlatforms = allSocialMediaPlatforms
                .map((platform) => {
                      'platform': platform,
                      'isChecked': socialMediaCheckState[platform] ?? false
                    })
                .toList()
              ..sort((a, b) => (b['isChecked'] as bool) ? 1 : -1);

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: paddingVertical, horizontal: paddingHorizontal),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: paddingVertical, bottom: spacing),
                      child: Row(
                        children: [
                          Text(
                            'Who Am I',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: isPortrait
                                      ? screenHeight * 0.022
                                      : screenHeight * 0.055,
                                ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              viewModel.logout();
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Icon(
                              Icons.logout,
                              color: MyTheme.primary900Color,
                              size: iconSize,
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: avatarSize,
                            height: avatarSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: MyTheme.primary900Color, width: 2),
                            ),
                            child: CircleAvatar(
                              backgroundColor: MyTheme.primary100Color,
                              backgroundImage: _image != null
                                  ? FileImage(_image!)
                                  : (profile?.avatar != null
                                      ? NetworkImage(profile!.avatar!)
                                          as ImageProvider
                                      : null),
                              child: _image == null && profile?.avatar == null
                                  ? Image.asset(
                                      'assets/images/profile_img_2.png')
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spacing),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: firstNameController,
                            tagText: 'First Name',
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: spacing),
                        Expanded(
                          child: CustomTextFormField(
                            controller: secondNameController,
                            tagText: 'Last Name',
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spacing),
                    CustomTextFormField(
                      tagText: 'Email Address',
                      controller: emailController,
                      readOnly: true,
                    ),
                    SizedBox(height: spacing),
                    CustomTextFormField(
                      tagText: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: isObscure,
                      isSuffixIcon: true,
                      readOnly: true,
                      suffixIcon: GestureDetector(
                        child: isObscure
                            ? Icon(Icons.visibility_off_outlined,
                                size: iconSize, color: MyTheme.grey400Color)
                            : Icon(Icons.visibility_outlined,
                                size: iconSize, color: MyTheme.grey400Color),
                        onTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: spacing),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'User Type',
                          style: TextStyle(
                            fontSize: isPortrait
                                ? screenHeight * 0.017
                                : screenHeight * 0.05,
                          ),
                        ),
                        SizedBox(height: spacing),
                        Row(
                          children: [
                            CustomRadio(
                              title: 'Seller',
                              value: 1,
                              groupValue: selectedUserType,
                              onChanged: (int value) {},
                              activeBorderColor: MyTheme.primary900Color,
                              inactiveBorderColor: MyTheme.grey300Color,
                            ),
                            CustomRadio(
                              title: 'Buyer',
                              value: 2,
                              groupValue: selectedUserType,
                              onChanged: (int value) {},
                              activeBorderColor: MyTheme.primary900Color,
                              inactiveBorderColor: MyTheme.grey300Color,
                            ),
                            CustomRadio(
                              title: 'Both',
                              value: 3,
                              groupValue: selectedUserType,
                              onChanged: (int value) {},
                              activeBorderColor: MyTheme.primary900Color,
                              inactiveBorderColor: MyTheme.grey300Color,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spacing),
                    CustomTextFormField(
                      height:
                          isPortrait ? screenHeight * 0.15 : screenHeight * 0.5,
                      maxLines: 5,
                      tagText: 'About',
                      controller: aboutController,
                      readOnly: true,
                    ),
                    SizedBox(height: spacing),
                    CustomTextFormField(
                      tagText: 'Salary',
                      controller: salaryController,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                    ),
                    SizedBox(height: spacing),
                    CustomTextFormField(
                      tagText: 'Birth Date',
                      controller: dateController,
                      keyboardType: TextInputType.text,
                      isSuffixIcon: true,
                      readOnly: true,
                      suffixIcon: Image.asset(
                        'assets/icons/calender.png',
                        scale: iconScale,
                      ),
                    ),
                    SizedBox(height: spacing),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: isPortrait
                                ? screenHeight * 0.017
                                : screenHeight * 0.05,
                          ),
                        ),
                        SizedBox(height: spacing),
                        Row(
                          children: [
                            CustomRadio(
                              title: 'Male',
                              value: 0,
                              groupValue: selectedGenderType,
                              onChanged: (int value) {},
                              activeBorderColor: MyTheme.primary900Color,
                              inactiveBorderColor: MyTheme.grey300Color,
                            ),
                            CustomRadio(
                              title: 'Female',
                              value: 1,
                              groupValue: selectedGenderType,
                              onChanged: (int value) {},
                              activeBorderColor: MyTheme.primary900Color,
                              inactiveBorderColor: MyTheme.grey300Color,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spacing),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Skills',
                          style: TextStyle(
                            fontSize: isPortrait
                                ? screenHeight * 0.017
                                : screenHeight * 0.05,
                          ),
                        ),
                        SizedBox(height: spacing),
                        ItemChip(
                          readonly: true,
                          textEditingController: TextEditingController(),
                          values: tagsList,
                        ),
                      ],
                    ),
                    SizedBox(height: spacing),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Favourite Social Media',
                          style: TextStyle(
                            fontSize: isPortrait
                                ? screenHeight * 0.017
                                : screenHeight * 0.05,
                          ),
                        ),
                        SizedBox(height: spacing),
                        Column(
                          children:
                              sortedSocialMediaPlatforms.map((platformData) {
                            bool isChecked = platformData['isChecked'] as bool;
                            String platform =
                                platformData['platform'] as String;
                            return CustomRowCheckBox(
                              icon:
                                  'assets/icons/${platform.toLowerCase()}.png',
                              title: platform,
                              isChecked: isChecked,
                              readonly: true,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: spacing),
                  ],
                ),
              ),
            );
          } else if (state is ProfileErrorState) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primary900Color,
              ),
            );
          }
        },
      ),
    );
  }
}
