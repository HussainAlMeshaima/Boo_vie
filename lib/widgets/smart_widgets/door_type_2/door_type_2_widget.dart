import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'door_type_2_view_model.dart';

class DoorType2Widget extends StatelessWidget {
  final String doorName;

  const DoorType2Widget({Key key, @required this.doorName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoorType2ViewModel>.reactive(
      builder: (BuildContext context, DoorType2ViewModel viewModel, Widget _) {
        return Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              width: 120,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadiusDirectional.circular(5),
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColor, BlendMode.multiply),
                  child: Container(
                    height: 77,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 3.5, color: Theme.of(context).primaryColor),
                    ),
                  )),
            ),
            Positioned(
              right: 15,
              bottom: 31,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColor, BlendMode.multiply),
                  child: Container(
                    height: 77,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 3.5, color: Theme.of(context).primaryColor),
                    ),
                  )),
            ),
            Positioned(
              left: 15,
              bottom: 31,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColor, BlendMode.multiply),
                  child: Container(
                    height: 77,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 3.5, color: Theme.of(context).primaryColor),
                    ),
                  )),
            ),
            Positioned(
              left: 15,
              top: 15,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColor, BlendMode.multiply),
                  child: Container(
                    height: 77,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 3.5, color: Theme.of(context).primaryColor),
                    ),
                  )),
            ),
            Positioned(
              left: 11,
              top: 90,
              child: Container(
                height: 38,
                width: 18,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/doorHandleWhite.png'))),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: 120,
                  child: Text(
                    doorName,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          ],
        );
      },
      viewModelBuilder: () => DoorType2ViewModel(),
    );
  }
}
