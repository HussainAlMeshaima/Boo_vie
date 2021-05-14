import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'notification_card_view_model.dart';

class NotificationCardWidget extends StatelessWidget {
  final String docId;
  final String userImage;
  final String displayedName;
  final String memberEmail;

  final Function onLongPress;
  final Function onPressed;

  const NotificationCardWidget(
      {Key key,
      @required this.userImage,
      @required this.displayedName,
      @required this.memberEmail,
      @required this.onLongPress,
      @required this.onPressed,
      this.docId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationCardViewModel>.reactive(
      builder: (BuildContext context, NotificationCardViewModel viewModel,
          Widget _) {
        return Container(
          height: 75,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor.withOpacity(.5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(userImage),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 143,
                    child: Text(
                      displayedName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 45,
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Long press to remove.')));
                      },
                      onLongPress: onLongPress ?? () {},
                      child: Icon(
                        Icons.dangerous,
                        size: 15,
                      ),
                      style: OutlinedButton.styleFrom(
                        primary:
                            Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          primary:
                              Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: onPressed ?? () {},
                        child: Icon(
                          Icons.check,
                          size: 15,
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => NotificationCardViewModel(),
    );
  }
}
