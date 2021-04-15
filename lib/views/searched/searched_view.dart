import 'package:boo_vi_app/core/models/bookModels/booksResponseModel.dart';
import 'package:boo_vi_app/widgets/smart_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'searched_view_model.dart';

class SearchedView extends StatelessWidget {
  final String timedText;
  final String noneTrimedText;

  const SearchedView(
      {Key key, @required this.timedText, @required this.noneTrimedText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchedViewModel>.reactive(
      onModelReady: (SearchedViewModel viewModel) =>
          viewModel.handleStartUpLogic(timedText),
      builder: (BuildContext context, SearchedViewModel viewModel, Widget _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Searched'),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  TextfieldWidget(
                    // onChanged: (aString) {
                    //   if (aString == '' || aString.isEmpty)
                    //     viewModel.searchTextfieldController.text = timedText;
                    //   else
                    //     viewModel.searchTextfieldController.text = aString;

                    //   viewModel.changesearchTextfieldControllerAndBringBooks();
                    // },
                    hintText: noneTrimedText,
                    onSubmitted: (String aString) {
                      if (aString == '' || aString.isEmpty)
                        viewModel.searchTextfieldController.text = timedText;
                      else
                        viewModel.searchTextfieldController.text = aString;

                      viewModel.changesearchTextfieldControllerAndBringBooks();
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: DropdownButton<String>(
                              value: viewModel.dropdownValueSortBy,
                              dropdownColor: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Theme.of(context).primaryColor,
                              ),
                              underline: Container(
                                height: 0,
                                color: Theme.of(context).primaryColor,
                              ),
                              onChanged: (String newValue) =>
                                  viewModel.changeDropdownValueSortBy(newValue),
                              items: <String>[
                                'Relevance',
                                'Newest',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Spacer(),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: DropdownButton<String>(
                              value: viewModel.dropdownValueNameFilter,
                              dropdownColor: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Theme.of(context).primaryColor,
                              ),
                              underline: Container(
                                height: 0,
                                color: Theme.of(context).primaryColor,
                              ),
                              onChanged: (String newValue) {
                                viewModel.changeDropdownValue(newValue);
                              },
                              items: <String>[
                                'Title',
                                'Author',
                                'Categories',
                                'Publisher',
                                'ISBN',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Spacer(),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: DropdownButton<String>(
                              value: viewModel.dropdownValueNumber.toString(),
                              dropdownColor: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Theme.of(context).primaryColor,
                              ),
                              underline: Container(
                                height: 0,
                                color: Theme.of(context).primaryColor,
                              ),
                              onChanged: (String newValue) {
                                viewModel.changeDropdownValueNumber(
                                    int.parse(newValue));
                              },
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: viewModel
                          .changesearchTextfieldControllerAndBringBooks(),
                      builder: (BuildContext context,
                          AsyncSnapshot<BooksResponse> snapshot) {
                        if (snapshot.hasError)
                          return Container(
                            height: 400,
                            child: Center(
                              child: Text('An error has been found'),
                            ),
                          );
                        else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: 450,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (snapshot.data.totalItems == 0) {
                          return Container(
                            height: 450,
                            child: Center(
                              child: Text('No Books Found'),
                            ),
                          );
                        }

                        if (snapshot.hasData && snapshot.data.totalItems != 0) {
                          return Container(
                            child: GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1 / 1.6,
                                        crossAxisCount:
                                            viewModel.dropdownValueNumber),
                                itemCount: snapshot.data.items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  BooksResponse books;

                                  books = snapshot.data;
                                  print(books.totalItems);
                                  return snapshot.data.items[index].volumeInfo
                                              .imageLinks !=
                                          null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () => viewModel.pushBookView(
                                                id: snapshot
                                                    .data.items[index].id,
                                                image: snapshot
                                                    .data
                                                    .items[index]
                                                    .volumeInfo
                                                    .imageLinks
                                                    .thumbnail,
                                                previewLink: snapshot
                                                    .data
                                                    .items[index]
                                                    .volumeInfo
                                                    .previewLink,
                                                bookTitle: snapshot
                                                    .data
                                                    .items[index]
                                                    .volumeInfo
                                                    .title),
                                            child: Hero(
                                              tag:
                                                  snapshot.data.items[index].id,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot
                                                        .data
                                                        .items[index]
                                                        .volumeInfo
                                                        .imageLinks
                                                        .thumbnail),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              child: Center(
                                                  child: Text(
                                                'Book not available',
                                                textAlign: TextAlign.center,
                                              )),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(.5),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              )),
                                        );
                                }),
                          );
                        }

                        return Container(
                          height: 450,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      })
                ],
              ),
            ));
      },
      viewModelBuilder: () => SearchedViewModel(),
    );
  }
}
