import 'package:flutter/material.dart';
import 'package:gallery_v3/providers/my_image_provider.dart';
import 'package:gallery_v3/providers/my_tags_provider.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/themes/custom_themes.dart';

class TagsDialog extends StatefulWidget {
  @override
  _TagsDialogState createState() => _TagsDialogState();
}

class _TagsDialogState extends State<TagsDialog> {
  List<Tag> _tags = Tags.instance.getTags;

  List<Tag> _activeTags = MyImageProvider.instance.getSelectedTags == null
      ? []
      : MyImageProvider.instance.getSelectedTags.isEmpty
          ? []
          : MyImageProvider.instance.getSelectedTags;

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
                              MyImageProvider.instance.setSelectedTags =
                                  _activeTags;
                            } else {
                              _activeTags.remove(tag);
                              tag.isSelected = false;
                              MyImageProvider.instance.setSelectedTags =
                                  _activeTags;
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
              onPressed: _activeTags.isEmpty ? null : () {},
              icon: Icon(Icons.send),
              disabledColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
