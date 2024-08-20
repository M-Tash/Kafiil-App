import 'dart:io';

import '../../../../domain/entities/AppDependenciesEntity.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String? errorMessage;

  RegisterErrorState({required this.errorMessage});
}

class RegisterSuccessState extends RegisterStates {}

class RegisterValidationErrorState extends RegisterStates {}

class TagSelectionState extends RegisterStates {
  final List<int> selectedTagValues;

  TagSelectionState(this.selectedTagValues);
}

class TagsFetchedState extends RegisterStates {
  final List<TagsEntity>? skillList;

  TagsFetchedState(this.skillList);
}

class RegisterTagsLoadedState extends RegisterStates {
  final List<TagsEntity> skillList;

  RegisterTagsLoadedState(this.skillList);
}

class TagUpdatedState extends RegisterStates {
  final List<int> selectedTagValues;
  final List<String> tagsLabels;

  TagUpdatedState(this.selectedTagValues, this.tagsLabels);
}

class RegisterAvatarPickedState extends RegisterStates {
  final File avatar;

  RegisterAvatarPickedState(this.avatar);
}

class SocialMediaUpdatedState extends RegisterStates {
  final List<String> socialMedia;

  SocialMediaUpdatedState(this.socialMedia);
}

class LoadingDialogShownState extends RegisterStates {}

class LoadingDialogDismissedState extends RegisterStates {}
