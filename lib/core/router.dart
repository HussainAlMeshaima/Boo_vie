// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:boo_vi_app/core/router_constants.dart';

import 'package:boo_vi_app/views/start_up/start_up_view.dart' as view0;
import 'package:boo_vi_app/views/login/login_view.dart' as view1;
import 'package:boo_vi_app/views/splash_screen/splash_screen_view.dart' as view2;
import 'package:boo_vi_app/views/profile/profile_view.dart' as view3;
import 'package:boo_vi_app/views/user_details/user_details_view.dart' as view4;
import 'package:boo_vi_app/views/challenges/challenges_view.dart' as view5;
import 'package:boo_vi_app/views/home/home_view.dart' as view6;
import 'package:boo_vi_app/views/search/search_view.dart' as view7;
import 'package:boo_vi_app/views/more_books/more_books_view.dart' as view8;
import 'package:boo_vi_app/views/book/book_view.dart' as view9;
import 'package:boo_vi_app/views/book_author_grid/book_author_grid_view.dart' as view10;
import 'package:boo_vi_app/views/book_information/book_information_view.dart' as view11;
import 'package:boo_vi_app/views/searched/searched_view.dart' as view12;
import 'package:boo_vi_app/views/comunintys/comunintys_view.dart' as view13;
import 'package:boo_vi_app/views/book_categories_grid/book_categories_grid_view.dart' as view14;
import 'package:boo_vi_app/views/similer_books_grid/similer_books_grid_view.dart' as view15;
import 'package:boo_vi_app/views/book_reviews/book_reviews_view.dart' as view16;
import 'package:boo_vi_app/views/user_revieww/user_revieww_view.dart' as view17;
import 'package:boo_vi_app/views/global_challenge/global_challenge_view.dart' as view18;
import 'package:boo_vi_app/views/user_global_challenge/user_global_challenge_view.dart' as view19;

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
        return MaterialPageRoute(builder: (_) => view14.BookCategoriesGridView());
      case similerBooksGridViewRoute:
        return MaterialPageRoute(builder: (_) => view15.SimilerBooksGridView());
      case bookReviewsViewRoute:
        return MaterialPageRoute(builder: (_) => view16.BookReviewsView());
      case userReviewwViewRoute:
        return MaterialPageRoute(builder: (_) => view17.UserReviewwView());
      case globalChallengeViewRoute:
        return MaterialPageRoute(builder: (_) => view18.GlobalChallengeView());
      case userGlobalChallengeViewRoute:
        return MaterialPageRoute(builder: (_) => view19.UserGlobalChallengeView());
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