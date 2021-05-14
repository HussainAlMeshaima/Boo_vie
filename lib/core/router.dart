// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:boo_vi_app/core/router_constants.dart';

import 'package:boo_vi_app/views/start_up/start_up_view.dart' as view0;
import 'package:boo_vi_app/views/login/login_view.dart' as view1;
import 'package:boo_vi_app/views/splash_screen/splash_screen_view.dart'
    as view2;
import 'package:boo_vi_app/views/profile/profile_view.dart' as view3;
import 'package:boo_vi_app/views/user_details/user_details_view.dart' as view4;
import 'package:boo_vi_app/views/challenges/challenges_view.dart' as view5;
import 'package:boo_vi_app/views/home/home_view.dart' as view6;
import 'package:boo_vi_app/views/search/search_view.dart' as view7;
import 'package:boo_vi_app/views/more_books/more_books_view.dart' as view8;
import 'package:boo_vi_app/views/book/book_view.dart' as view9;
import 'package:boo_vi_app/views/book_author_grid/book_author_grid_view.dart'
    as view10;
import 'package:boo_vi_app/views/book_information/book_information_view.dart'
    as view11;
import 'package:boo_vi_app/views/searched/searched_view.dart' as view12;
import 'package:boo_vi_app/views/comunintys/comunintys_view.dart' as view13;
import 'package:boo_vi_app/views/book_categories_grid/book_categories_grid_view.dart'
    as view14;
import 'package:boo_vi_app/views/similer_books_grid/similer_books_grid_view.dart'
    as view15;
import 'package:boo_vi_app/views/book_reviews/book_reviews_view.dart' as view16;
import 'package:boo_vi_app/views/user_revieww/user_revieww_view.dart' as view17;
import 'package:boo_vi_app/views/global_challenge/global_challenge_view.dart'
    as view18;
import 'package:boo_vi_app/views/user_global_challenge/user_global_challenge_view.dart'
    as view19;
import 'package:boo_vi_app/views/profile_to_edit_details/profile_to_edit_details_view.dart'
    as view20;
import 'package:boo_vi_app/views/comuninty_information/comuninty_information_view.dart'
    as view21;
import 'package:boo_vi_app/views/trophies/trophies_view.dart' as view22;
import 'package:boo_vi_app/views/trophy/trophy_view.dart' as view23;
import 'package:boo_vi_app/views/user_review_to_profile/user_review_to_profile_view.dart'
    as view24;
import 'package:boo_vi_app/views/completed_challenges/completed_challenges_view.dart'
    as view25;
import 'package:boo_vi_app/views/my_challanges/my_challanges_view.dart'
    as view26;
import 'package:boo_vi_app/views/introduction_screen/introduction_screen_view.dart'
    as view27;
import 'package:boo_vi_app/views/room/room_view.dart' as view28;
import 'package:boo_vi_app/views/comunity_members/comunity_members_view.dart'
    as view29;
import 'package:boo_vi_app/views/community_notifications/community_notifications_view.dart'
    as view30;
import 'package:boo_vi_app/views/comunity_active_challenges/comunity_active_challenges_view.dart'
    as view31;
import 'package:boo_vi_app/views/edit_community_rules_and_discription/edit_community_rules_and_discription_view.dart'
    as view32;
import 'package:boo_vi_app/views/community_challange/community_challange_view.dart'
    as view34;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startUpViewRoute:
        return MaterialPageRoute(builder: (_) => view0.StartUpView());
      case loginViewRoute:
        return MaterialPageRoute(builder: (_) => view1.LoginView());
      case splashScreenViewRoute:
        return MaterialPageRoute(builder: (_) => view2.SplashScreenView());
      case profileViewRoute:
        return MaterialPageRoute(builder: (_) => view3.ProfileView());
      case userDetailsViewRoute:
        return MaterialPageRoute(builder: (_) => view4.UserDetailsView());
      case challengesViewRoute:
        return MaterialPageRoute(builder: (_) => view5.ChallengesView());
      case homeViewRoute:
        return MaterialPageRoute(builder: (_) => view6.HomeView());
      case searchViewRoute:
        return MaterialPageRoute(builder: (_) => view7.SearchView());
      case moreBooksViewRoute:
        return MaterialPageRoute(builder: (_) => view8.MoreBooksView());
      case bookViewRoute:
        return MaterialPageRoute(builder: (_) => view9.BookView());
      case bookAuthorGridViewRoute:
        return MaterialPageRoute(builder: (_) => view10.BookAuthorGridView());
      case bookInformationViewRoute:
        return MaterialPageRoute(builder: (_) => view11.BookInformationView());
      case searchedViewRoute:
        return MaterialPageRoute(builder: (_) => view12.SearchedView());
      case comunintysViewRoute:
        return MaterialPageRoute(builder: (_) => view13.ComunintysView());
      case bookCategoriesGridViewRoute:
        return MaterialPageRoute(
            builder: (_) => view14.BookCategoriesGridView());
      case similerBooksGridViewRoute:
        return MaterialPageRoute(builder: (_) => view15.SimilerBooksGridView());
      case bookReviewsViewRoute:
        return MaterialPageRoute(builder: (_) => view16.BookReviewsView());
      case userReviewwViewRoute:
        return MaterialPageRoute(builder: (_) => view17.UserReviewwView());
      case globalChallengeViewRoute:
        return MaterialPageRoute(builder: (_) => view18.GlobalChallengeView());
      case userGlobalChallengeViewRoute:
        return MaterialPageRoute(
            builder: (_) => view19.UserGlobalChallengeView());
      case profileToEditDetailsViewRoute:
        return MaterialPageRoute(
            builder: (_) => view20.ProfileToEditDetailsView());
      case comunintyInformationViewRoute:
        return MaterialPageRoute(
            builder: (_) => view21.ComunintyInformationView());
      case trophiesViewRoute:
        return MaterialPageRoute(builder: (_) => view22.TrophiesView());
      case trophyViewRoute:
        return MaterialPageRoute(builder: (_) => view23.TrophyView());
      case userReviewToProfileViewRoute:
        return MaterialPageRoute(
            builder: (_) => view24.UserReviewToProfileView());
      case completedChallengesViewRoute:
        return MaterialPageRoute(
            builder: (_) => view25.CompletedChallengesView());
      case myChallangesViewRoute:
        return MaterialPageRoute(builder: (_) => view26.MyChallangesView());
      case introductionScreenViewRoute:
        return MaterialPageRoute(
            builder: (_) => view27.IntroductionScreenView());
      case roomViewRoute:
        return MaterialPageRoute(builder: (_) => view28.RoomView());
      case comunityMembersViewRoute:
        return MaterialPageRoute(builder: (_) => view29.ComunityMembersView());
      case communityNotificationsViewRoute:
        return MaterialPageRoute(
            builder: (_) => view30.CommunityNotificationsView());
      case comunityActiveChallengesViewRoute:
        return MaterialPageRoute(
            builder: (_) => view31.ComunityActiveChallengesView());
      case editCommunityRulesAndDiscriptionViewRoute:
        return MaterialPageRoute(
            builder: (_) => view32.EditCommunityRulesAndDiscriptionView());

      case communityChallangeViewRoute:
        return MaterialPageRoute(
            builder: (_) => view34.CommunityChallangeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
