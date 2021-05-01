import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'more_books_view_model.dart';

class MoreBooksView extends StatelessWidget {
  final Stream stream;
  final String text;

  const MoreBooksView({Key key, this.stream, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreBooksViewModel>.reactive(
      builder: (BuildContext context, MoreBooksViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(text),
          ),
          body: StreamBuilder(
              stream: stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) return snapshot.error;

                if (snapshot.hasData) {
                  print(snapshot.data.docs[0].data()['id']);
                  return GridView.builder(
                      itemCount: snapshot.data.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1.6, crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: GestureDetector(
                            onTap: () => viewModel.pushBookView(
                              authors:
                                  snapshot.data.docs[index].data()['authors'],
                              image: snapshot.data.docs[index].data()['medium'],
                              id: snapshot.data.docs[index].data()['id'],
                              bookTitle:
                                  snapshot.data.docs[index].data()['title'],
                              previewLink: snapshot.data.docs[index]
                                  .data()['previewLink'],
                            ),
                            child: Hero(
                              tag: snapshot.data.docs[index].data()['id'],
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot
                                            .data.docs[index]
                                            .data()['medium']))),
                              ),
                            ),
                          ),
                        );
                      });
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        );
      },
      viewModelBuilder: () => MoreBooksViewModel(),
    );
  }
}
