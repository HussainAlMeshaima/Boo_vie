import 'package:boo_vi_app/widgets/smart_widgets/theme_list_tile/theme_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'theme_grid_view_model.dart';

class ThemeGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ThemeGridViewModel>.reactive(
      builder: (BuildContext context, ThemeGridViewModel viewModel, Widget _) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 1,
              children: [
                ListTile(
                  leading: Icon(Icons.wb_sunny),
                  title: Text('Light'),
                ),
                ListTile(
                  leading: Icon(Icons.nightlight_round),
                  title: Text('Dark'),
                ),
                ThemeListTileWidget(
                  title: 'Red',
                  color: Color(0xffEC4646),
                  context: context,
                  colorIndex: 0,
                ),
                ThemeListTileWidget(
                  title: 'Red',
                  color: Color(0xffEC4646),
                  context: context,
                  colorIndex: 1,
                ),
                ThemeListTileWidget(
                  title: 'Orange',
                  color: Color(0xffEC6E46),
                  context: context,
                  colorIndex: 2,
                ),
                ThemeListTileWidget(
                  title: 'Orange',
                  color: Color(0xffEC6E46),
                  context: context,
                  colorIndex: 3,
                ),
                // -------
                ThemeListTileWidget(
                  title: 'Merigold',
                  color: Color(0xffECA046),
                  context: context,
                  colorIndex: 4,
                ),
                ThemeListTileWidget(
                  title: 'Merigold',
                  color: Color(0xffECA046),
                  context: context,
                  colorIndex: 5,
                ),
                ThemeListTileWidget(
                  title: 'Gold',
                  color: Color(0xffECD146),
                  context: context,
                  colorIndex: 6,
                ),
                ThemeListTileWidget(
                  title: 'Gold',
                  color: Color(0xffECD146),
                  context: context,
                  colorIndex: 7,
                ),
                ThemeListTileWidget(
                  title: 'Lemon',
                  color: Color(0xffEECE546),
                  context: context,
                  colorIndex: 8,
                ),
                ThemeListTileWidget(
                  title: 'Lemon',
                  color: Color(0xffECE546),
                  context: context,
                  colorIndex: 9,
                ),
                ThemeListTileWidget(
                  title: 'Blonde',
                  color: Color(0xffE9EC46),
                  context: context,
                  colorIndex: 10,
                ),
                ThemeListTileWidget(
                  title: 'Blonde',
                  color: Color(0xffE9EC46),
                  context: context,
                  colorIndex: 11,
                ),
                ThemeListTileWidget(
                  title: 'Pistachio',
                  color: Color(0xffCBEC46),
                  context: context,
                  colorIndex: 12,
                ),
                ThemeListTileWidget(
                  title: 'Pistachio',
                  color: Color(0xffCBEC46),
                  context: context,
                  colorIndex: 13,
                ),
                ThemeListTileWidget(
                  title: 'Seafoam',
                  color: Color(0xff8FEC46),
                  context: context,
                  colorIndex: 14,
                ),
                ThemeListTileWidget(
                  title: 'Seafoam',
                  color: Color(0xff8FEC46),
                  context: context,
                  colorIndex: 15,
                ),
                ThemeListTileWidget(
                  title: 'Mint',
                  color: Color(0xff53EC46),
                  context: context,
                  colorIndex: 16,
                ),
                ThemeListTileWidget(
                  title: 'Mint',
                  color: Color(0xff53EC46),
                  context: context,
                  colorIndex: 17,
                ),
                ThemeListTileWidget(
                  title: 'Lime',
                  color: Color(0xff46EC9C),
                  context: context,
                  colorIndex: 18,
                ),
                ThemeListTileWidget(
                  title: 'Lime',
                  color: Color(0xff46EC9C),
                  context: context,
                  colorIndex: 19,
                ),
                ThemeListTileWidget(
                  title: 'Sea',
                  color: Color(0xff46ECC4),
                  context: context,
                  colorIndex: 20,
                ),
                ThemeListTileWidget(
                  title: 'Sea',
                  color: Color(0xff46ECC4),
                  context: context,
                  colorIndex: 22,
                ),
                ThemeListTileWidget(
                  title: 'Teal',
                  color: Color(0xff46ECE2),
                  context: context,
                  colorIndex: 23,
                ),
                ThemeListTileWidget(
                  title: 'Teal',
                  color: Color(0xff46ECE2),
                  context: context,
                  colorIndex: 24,
                ),
                ThemeListTileWidget(
                  title: 'Cerulean',
                  color: Color(0xff46ECE2),
                  context: context,
                  colorIndex: 25,
                ),
                ThemeListTileWidget(
                  title: 'Cerulean',
                  color: Color(0xff46ECE2),
                  context: context,
                  colorIndex: 26,
                ),
                ThemeListTileWidget(
                  title: 'Sky',
                  color: Color(0xff46D8EC),
                  context: context,
                  colorIndex: 27,
                ),
                ThemeListTileWidget(
                  title: 'Sky',
                  color: Color(0xff46D8EC),
                  context: context,
                  colorIndex: 28,
                ),
                ThemeListTileWidget(
                  title: 'Lapis',
                  color: Color(0xff46C4EC),
                  context: context,
                  colorIndex: 29,
                ),
                ThemeListTileWidget(
                  title: 'Lapis',
                  color: Color(0xff46C4EC),
                  context: context,
                  colorIndex: 30,
                ),
                ThemeListTileWidget(
                  title: 'Berry',
                  color: Color(0xff46C4EC),
                  context: context,
                  colorIndex: 31,
                ),
                ThemeListTileWidget(
                  title: 'Berry',
                  color: Color(0xff46B0EC),
                  context: context,
                  colorIndex: 32,
                ),
                ThemeListTileWidget(
                  title: 'Azure',
                  color: Color(0xff4692EC),
                  context: context,
                  colorIndex: 33,
                ),
                ThemeListTileWidget(
                  title: 'Azure',
                  color: Color(0xff4692EC),
                  context: context,
                  colorIndex: 34,
                ),
                ThemeListTileWidget(
                  title: 'Blue',
                  color: Color(0xff467EEC),
                  context: context,
                  colorIndex: 35,
                ),
                ThemeListTileWidget(
                  title: 'Blue',
                  color: Color(0xff467EEC),
                  context: context,
                  colorIndex: 36,
                ),
                ThemeListTileWidget(
                  title: 'Navy',
                  color: Color(0xff467EEC),
                  context: context,
                  colorIndex: 37,
                ),
                ThemeListTileWidget(
                  title: 'Navy',
                  color: Color(0xff467EEC),
                  context: context,
                  colorIndex: 38,
                ),
                ThemeListTileWidget(
                  title: 'Violet',
                  color: Color(0xff5346EC),
                  context: context,
                  colorIndex: 41,
                ),
                ThemeListTileWidget(
                  title: 'Violet',
                  color: Color(0xff5346EC),
                  context: context,
                  colorIndex: 42,
                ),
                ThemeListTileWidget(
                  title: 'Purple',
                  color: Color(0xff7B46EC),
                  context: context,
                  colorIndex: 39,
                ),
                ThemeListTileWidget(
                  title: 'Purple',
                  color: Color(0xff7B46EC),
                  context: context,
                  colorIndex: 40,
                ),
                ThemeListTileWidget(
                  title: 'Amethyst',
                  color: Color(0xff9946EC),
                  context: context,
                  colorIndex: 43,
                ),
                ThemeListTileWidget(
                  title: 'Amethyst',
                  color: Color(0xff9946EC),
                  context: context,
                  colorIndex: 44,
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ThemeGridViewModel(),
    );
  }
}
