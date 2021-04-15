import 'dart:convert';
import 'package:boo_vi_app/core/models/bookModels/bookIdModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';

class BookServices {
  String apiKey = 'AIzaSyA0QDTNbXqGPHfdu4AiTBcA09S10yDIvyE';

  Future<BookIdVolume> getBookById({@required String volumeId}) async {
    volumeId = volumeId.trim().replaceAll(' ', '+');
    Uri url =
        Uri.parse('https://www.googleapis.com/books/v1/volumes/$volumeId');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    return BookIdVolume.fromJson(responseBody);
  }

  Future<BooksResponse> getBooksByVolumes(
      {@required String volumeName,
      @required int maxResults,
      @required String sortBy}) async {
    volumeName = volumeName.trim().replaceAll(' ', '+');
    print('getBooksByVolumes: ' + volumeName);

    Uri url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$volumeName&maxResults=$maxResults&orderBy=$sortBy&printType=books');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    return BooksResponse.fromJson(responseBody);
  }

  Future<BooksResponse> getBooksByCategories(
      {@required String categoriesName,
      @required int maxResults,
      @required String sortBy}) async {
    print('------------------');
    //categoriesName = categoriesName.trim();
    print('getBooksByCategories: ' + categoriesName);
    print('------------------');
    Uri url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=subject:$categoriesName&maxResults=$maxResults');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    return BooksResponse.fromJson(responseBody);
  }

  Future<BooksResponse> getBooksByAuthor(
      {@required String authorName,
      @required int maxResults,
      @required String sortBy}) async {
    authorName = authorName.trim().replaceAll(' ', '+');
    print('getBooksByAuthor: ' + authorName);
    Uri url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=inauthor:$authorName&maxResults=$maxResults&orderBy=$sortBy&printType=books');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    return BooksResponse.fromJson(responseBody);
  }

  Future<BooksResponse> getBooksByISBN(
      {@required String isbn,
      @required int maxResults,
      @required String sortBy}) async {
    isbn = isbn.trim().replaceAll(' ', '+');
    print('getBooksByISBN: ' + isbn);
    Uri url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn&orderBy=$sortBy&printType=books');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    return BooksResponse.fromJson(responseBody);
  }

  Future<BooksResponse> getBooksByPublisher(
      {@required String publisherName,
      @required int maxResults,
      @required String sortBy}) async {
    publisherName = publisherName.trim().replaceAll(' ', '+');
    print('getBooksByPublisher: ' + publisherName);

    Uri url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=inpublisher:$publisherName&orderBy=$sortBy&printType=books&maxResults=$maxResults');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    return BooksResponse.fromJson(responseBody);
  }
}
