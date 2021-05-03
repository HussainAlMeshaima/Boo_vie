import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';

import 'package:boo_vi_app/views/trophy/trophy_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TrophiesViewModel extends BaseViewModel {
  Logger log;

  TrophiesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();
  NavigationService _navigationService = locator<NavigationService>();

  Stream<QuerySnapshot> getUserTrophies() async* {
    yield* _cloudFirestoreServices.getUserTrophies();
  }

  void pushTrophyView({
    String trophyTitle,
    String trophyDescription,
    Timestamp trophyReceivedDate,
    //
    String bookAuthors,
    String bookId,
    String bookImage,
    String previewLink,
    bool isNormalTrophy,
  }) {
    _navigationService.navigateWithTransition(
        TrophyView(
          isNormalTrophy: isNormalTrophy,
          trophyTitle: trophyTitle,
          previewLink: previewLink ?? '',
          bookId: bookId ?? ' ',
          bookAuthors: bookAuthors ?? '',
          bookImage: bookImage ?? '',
          trophyDescription: trophyDescription,
          trophyReceivedDate: trophyReceivedDate,
        ),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 400));
  }
}
