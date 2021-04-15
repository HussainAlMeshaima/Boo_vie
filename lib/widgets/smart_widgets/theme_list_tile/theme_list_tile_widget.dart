import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'theme_list_tile_view_model.dart';

class ThemeListTileWidget extends StatelessWidget {
  final String title;
  final Color color;
  final int colorIndex;
  final BuildContext context;

  const ThemeListTileWidget(
      {Key key,
      @required this.title,
      @required this.color,
      @required this.colorIndex,
      @required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ThemeListTileViewModel>.reactive(
      builder:
          (BuildContext context, ThemeListTileViewModel viewModel, Widget _) {
        return ListTile(
          onTap: () {
            Navigator.pop(context);
            getThemeManager(context).selectThemeAtIndex(colorIndex ?? 0);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                content: Text('Theme has been applyed')));
          },
          leading: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: color ?? Colors.transparent),
          ),
          title: Text(title ?? 'not set'),
        );
      },
      viewModelBuilder: () => ThemeListTileViewModel(),
    );
  }
}
