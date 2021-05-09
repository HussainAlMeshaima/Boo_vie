import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'door_type_1_view_model.dart';

class DoorType1Widget extends StatelessWidget {
  final String doorName;

  const DoorType1Widget({Key key, @required this.doorName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoorType1ViewModel>.reactive(
      builder: (BuildContext context, DoorType1ViewModel viewModel, Widget _) {
        return Container(
          child: Stack(
            clipBehavior: Clip.none,
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
                bottom: 31,
                left: 18,
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.multiply),
                    child: Container(
                      height: 37,
                      width: 83,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 3.5, color: Theme.of(context).primaryColor),
                      ),
                    )),
              ),
              Positioned(
                bottom: 80,
                left: 18,
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.multiply),
                    child: Container(
                      height: 37,
                      width: 83,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 3.5, color: Theme.of(context).primaryColor),
                      ),
                    )),
              ),
              Positioned(
                top: 15,
                left: 18,
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.multiply),
                    child: Container(
                      height: 77,
                      width: 83,
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
          ),
        );
      },
      viewModelBuilder: () => DoorType1ViewModel(),
    );
  }
}
