import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/database/upload_image.dart';
import 'package:gallery_v3/providers/my_tags_provider.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';

class SearchTagDialog extends StatefulWidget {
  @override
  _SearchTagDialogState createState() => _SearchTagDialogState();
}

class _SearchTagDialogState extends State<SearchTagDialog> {
  UploadImage uploadImage = UploadImage();

  List<Tag> _tags = Tags.instance.getTags;

  List<Tag> _activeTags = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SimpleDialog(
        backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Container(
          padding: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ColorPallete.vermillion,
              ),
            ),
          ),
          child: Center(
            child: Text(
              'Select Tags',
              style: TextStyle(
                color: CustomTheme.reverseTextColor,
              ),
            ),
          ),
        ),
        children: [
          Container(
            width: 300,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                childAspectRatio: 3,
                mainAxisSpacing: 10,
                children: _tags.map<Widget>((tag) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      border: Border.all(
                        color: tag.isSelected ? tag.c2 : tag.c1,
                      ),
                      color: tag.isSelected
                          ? tag.c2
                          : CustomTheme.currentTheme.scaffoldBackgroundColor,
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (!_activeTags.contains(tag)) {
                              _activeTags.add(tag);
                              tag.isSelected = true;
                            } else {
                              _activeTags.remove(tag);
                              tag.isSelected = false;
                            }
                          });
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          tag.value,
                          style: TextStyle(
                            color: tag.isSelected
                                ? ColorPallete.fullWhite
                                : CustomTheme.reverseTextColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Ink(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    _activeTags.isEmpty ? Colors.grey : ColorPallete.vermillion,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              color: ColorPallete.vermillion,
              iconSize: 32,
              onPressed: _activeTags.isEmpty
                  ? null
                  : () {
                      List<String> _selectedTags = [];
                      _activeTags.forEach((tag) {
                        _selectedTags.add(tag.value);
                        tag.isSelected = false;
                      });
                      _activeTags.clear();
                      Navigator.pop(context, _selectedTags);
                    },
              icon: Icon(Icons.search),
              disabledColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
