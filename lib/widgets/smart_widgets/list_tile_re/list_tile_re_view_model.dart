import 'package:boo_vi_app/core/locator.dart';
import 'package:boo_vi_app/core/services/cloudFirestoreServices.dart';
import 'package:boo_vi_app/views/user_review_to_profile/user_review_to_profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:boo_vi_app/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ListTileReViewModel extends BaseViewModel {
  Logger log;

  ListTileReViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();

  handleStartUpLogic(String bookId, String bookImage) async {
    _bookId = bookId;
    _bookImage = bookImage;
  }

  String _bookId;
  String _bookImage;
  CloudFirestoreServices _cloudFirestoreServices =
      locator<CloudFirestoreServices>();

  Future<bool> isThatTileLikedByCurrentUser(String _bookId) async {
    DocumentSnapshot doc =
        await _cloudFirestoreServices.getIsLikedBoolDoc(_bookId);
    print(doc.exists);
    print(doc.data());
    print(doc.id);

    return doc.data()['isReviewLiked'];
  }

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void pushUserReviewToProfileView({String userEmail, String userImage}) {
    _navigationService.navigateWithTransition(
        UserReviewToProfileView(userEmail: userEmail, userImage: userImage),
        transition: 'rightToLeftWithFade',
        duration: Duration(milliseconds: 500));
  }
}
