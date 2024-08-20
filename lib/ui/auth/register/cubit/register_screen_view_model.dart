import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kafiil_test/domain/entities/AppDependenciesEntity.dart';
import 'package:kafiil_test/domain/use_cases/register_use_case.dart';
import 'package:kafiil_test/ui/auth/register/cubit/states.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../domain/use_cases/get_app_dependencies_use_case.dart';
import '../../../../utils/my_theme.dart';

class RegisterScreenViewModel extends Cubit<RegisterStates> {
  RegisterScreenViewModel({
    required this.registerUseCase,
    required this.appDependenciesUseCase,
  }) : super(RegisterInitialState());

  final RegisterUseCase registerUseCase;
  final GetAppDependenciesUseCase appDependenciesUseCase;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController tagSearchController = TextEditingController();

  List<String> social = [];
  List<int> tags = [];
  int salary = 100;
  String birthDate = '';
  bool gender = false;
  File? avatar;
  int userType = 1;
  List<TagsEntity>? skillList = [];
  List<String> tagsLabels = [];
  List<int> selectedTagValues = [];
  bool isObscure = true;
  bool isObscure2 = true;
  bool rememberMe = false;
  bool isErrorVisible = false;
  OverlayEntry? loadingOverlayEntry;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      avatar = File(pickedFile.path);
      emit(RegisterAvatarPickedState(avatar!));
    }
  }

  Future<File> loadDefaultImage() async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/profile_img.png';

    final byteData = await rootBundle.load('assets/images/profile_img.png');
    final buffer = byteData.buffer;

    final file = File(path);
    await file.writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: MyTheme.primary900Color.withOpacity(0.5),
          ),
        );
      },
    );
  }

  void dismissLoadingDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void validateAndRegister() async {
    if (!formKey.currentState!.validate()) {
      emit(RegisterValidationErrorState());
      return;
    }

    if (selectedTagValues.isEmpty) {
      emit(RegisterErrorState(
          errorMessage: 'You should add at least one skill.'));
      return;
    }

    if (social.isEmpty) {
      emit(RegisterErrorState(
          errorMessage: 'Please select at least one social media.'));
      return;
    }

    if (salary < 100 || salary > 99999) {
      emit(RegisterErrorState(
          errorMessage: 'Salary must be between 100 and 99999.'));
      return;
    }

    if (avatar == null) {
      avatar = await loadDefaultImage();
    }
    register();
  }

  void onDateSelected(DateTime date) {
    birthDate = date.toIso8601String().split('T').first;
  }

  void updateSocialMediaSelection(String media, bool selected) {
    if (selected) {
      social.add(media);
    } else {
      social.remove(media);
    }
    emit(SocialMediaUpdatedState(social));
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      isErrorVisible = false;
      emit(RegisterLoadingState());
      try {
        String formattedBirthDate =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(birthDate));

        var either = await registerUseCase.invoke(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          aboutController.text.trim(),
          selectedTagValues,
          social,
          salary,
          passwordController.text.trim(),
          confirmPasswordController.text.trim(),
          emailController.text.trim(),
          formattedBirthDate,
          gender ? 1 : 0,
          userType,
          avatar!,
        );

        either.fold(
          (failure) =>
              emit(RegisterErrorState(errorMessage: failure.errorMessage)),
          (response) => emit(RegisterSuccessState()),
        );
      } catch (error) {
        emit(RegisterErrorState(errorMessage: "$error"));
      }
    } else {
      isErrorVisible = true;
      emit(RegisterValidationErrorState());
    }
  }

  Future<void> fetchTags() async {
    var either = await appDependenciesUseCase.invoke();
    either.fold(
      (failure) => emit(RegisterErrorState(
          errorMessage: 'An error occurred while fetching tags.')),
      (appDep) {
        skillList = appDep.data?.tags ?? [];
        if (skillList != null && skillList!.isNotEmpty) {
          emit(RegisterTagsLoadedState(skillList!));
        } else {
          emit(RegisterErrorState(
              errorMessage: 'No tags found. Please try again later.'));
        }
      },
    );
  }

  List<TagsEntity> filterTags(String pattern) {
    return skillList?.where((tag) {
          return tag.label!.toLowerCase().contains(pattern.toLowerCase());
        }).toList() ??
        [];
  }

  void onTagSelected(TagsEntity selectedTag) {
    if (selectedTag.value != null &&
        !selectedTagValues.contains(selectedTag.value!)) {
      selectedTagValues.add(selectedTag.value!);
      tagsLabels.add(selectedTag.label!);

      emit(TagUpdatedState(selectedTagValues, tagsLabels));

      tagSearchController.clear();
    }
  }

  void onTagRemoved(int index) {
    if (index >= 0 && index < selectedTagValues.length) {
      selectedTagValues.removeAt(index);
      tagsLabels.removeAt(index);
      emit(TagSelectionState(selectedTagValues));
    }
  }
}
