import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../domain/entities/AppDependenciesEntity.dart';
import '../../ui/auth/register/cubit/register_screen_view_model.dart';
import '../my_theme.dart';

class TagsDropdownSearch extends StatefulWidget {
  final RegisterScreenViewModel viewModel;

  const TagsDropdownSearch({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  _TagsDropdownSearchState createState() => _TagsDropdownSearchState();
}

class _TagsDropdownSearchState extends State<TagsDropdownSearch> {
  List<TagsEntity> _tagsList = [];

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  Future<void> _fetchTags() async {
    var either = await widget.viewModel.appDependenciesUseCase.invoke();
    either.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load tags: ${failure.errorMessage}'),
          ),
        );
      },
      (appDep) {
        setState(() {
          _tagsList = appDep.data?.tags ?? [];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double padding = isPortrait
        ? screenWidth * 0.03 : screenWidth * 0.02;
    double chipSpacing = isPortrait ? screenWidth * 0.013 : screenWidth * 0.01;
    double chipRunSpacing =
        isPortrait ? screenHeight * 0.005 : screenHeight * 0.004;
    double fixedBorderRadius = 12.0;

    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: MyTheme.grey50Color,
        borderRadius: BorderRadius.circular(fixedBorderRadius),
        border: Border.all(color: Colors.transparent, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: chipSpacing,
            runSpacing: chipRunSpacing,
            children:
                List.generate(widget.viewModel.tagsLabels.length, (index) {
              return _Chip(
                label: widget.viewModel.tagsLabels[index],
                index: index,
                onDeleted: (index) {
                  widget.viewModel.onTagRemoved(index);
                },
              );
            }),
          ),
          SizedBox(height: screenHeight * 0.012),
          TypeAheadField<TagsEntity>(
            controller: widget.viewModel.tagSearchController,
            suggestionsCallback: (pattern) async {
              return _tagsList.where((tag) {
                return tag.label!.toLowerCase().contains(pattern.toLowerCase());
              }).toList();
            },
            itemBuilder: (context, TagsEntity tag) {
              return ListTile(
                title: Text(tag.label!,
                    style: TextStyle(
                      fontSize: isPortrait
                          ? screenHeight * 0.017
                          : screenHeight * 0.05,
                    )),
              );
            },
            onSelected: (TagsEntity tag) {
              setState(() {
                widget.viewModel.onTagSelected(tag);
              });
            },
            builder: (context, controller, focusNode) {
              return TextField(
                controller: widget.viewModel.tagSearchController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Search and select a skill',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(fixedBorderRadius),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(fixedBorderRadius),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                      horizontal: screenWidth * 0.03),
                ),
                cursorColor: MyTheme.primary900Color,
                style: TextStyle(
                  fontSize:
                      isPortrait ? screenHeight * 0.017 : screenHeight * 0.05,
                ),
              );
            },
            decorationBuilder: (context, child) {
              return Material(
                type: MaterialType.card,
                elevation: 4,
                borderRadius: BorderRadius.circular(fixedBorderRadius),
                child: child,
              );
            },
            offset: const Offset(0, -30),
            listBuilder: (context, children) {
              return ListView.builder(
                itemCount: children.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return children[index];
                },
              );
            },
            loadingBuilder: (context) => const Text('Loading...'),
            errorBuilder: (context, error) => const Text('Error!'),
            emptyBuilder: (context) => const Text('No items found!'),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    return Chip(
      side: BorderSide.none,
      backgroundColor: const Color(0xffEAFFF5),
      labelStyle: TextStyle(fontSize: screenHeight * 0.02, color: Colors.white),
      elevation: 0,
      labelPadding: EdgeInsets.only(left: screenWidth * 0.02),
      label: Text(
        label,
        style: TextStyle(
          color: const Color(0xff1DBF73),
          fontSize: isPortrait ? screenHeight * 0.017 : screenHeight * 0.05,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            isPortrait ? screenWidth * 0.025 : screenWidth * 0.02),
      ),
      deleteIcon: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.01),
        child: Icon(
          Icons.close,
          size: isPortrait ? screenHeight * 0.018 : screenHeight * 0.044,
          color: const Color(0xff1DBF73),
        ),
      ),
      onDeleted: () => onDeleted(index),
    );
  }
}
