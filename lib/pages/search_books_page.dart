import 'package:biblioteca_digital/models/google_book_model.dart';
import 'package:biblioteca_digital/pages/widgets/display_text_widget.dart';
import 'package:biblioteca_digital/pages/widgets/primary_button_widget.dart';
import 'package:biblioteca_digital/services/google_book_service.dart';
import 'package:biblioteca_digital/until/theme_until.dart';
import 'package:flutter/material.dart';

class SearchBooksPage extends StatefulWidget {
  const SearchBooksPage({super.key});

  @override
  State<SearchBooksPage> createState() => _SearchBooksPageState();
}

class _SearchBooksPageState extends State<SearchBooksPage> {
  final GoogleBooksService googleBooksService = GoogleBooksService();
  Future<List<GoogleBooksModel>>? booksList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: AppBackgroundProperties.boxDecoration,
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.black),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: DisplayTextWidget("Adicionar Livro"),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: TextFormField(
                    onChanged: (value) {
                      // Populate list of books from API
                      setState(() {
                        booksList = googleBooksService.searchBooks(value);
                      });
                    },
                    decoration: InputDecorationProperties.newInputDecoration(
                        "Procure por título/autor(a)",
                        "Busca",
                        const Icon(Icons.search)),
                  ),
                ),
              ),
              (booksList == null)
                  ? const SliverToBoxAdapter()
                  : _BooksList(future: booksList),
            ],
          ),
        ),
      ),
    ));
  }
}

class _BooksList extends StatelessWidget {
  const _BooksList({required this.future});
  final Future<List<GoogleBooksModel>>? future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;

          case ConnectionState.waiting:
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );

          case ConnectionState.active:
            break;

          case ConnectionState.done:
            if (snapshot.hasData || snapshot.data != []) {
              return SliverList.builder(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        insetPadding: const EdgeInsets.all(16),
                        clipBehavior: Clip.hardEdge,
                        shape: ModalDecorationProperties.modalBorder,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(32.0),
                            decoration: ModalDecorationProperties.boxDecoration,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      InkWell(
                                        child: const Icon(Icons.close),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 24.0),
                                  child: DisplayTextWidget("Detalhes do Livro"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Image.network(
                                    snapshot.data![index].thumbnailLink,
                                    height: 220,
                                    width: 144,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    snapshot.data![index].title,
                                    style: ModalDecorationProperties.bookTitle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    child: Text(
                                      snapshot.data![index].authors,
                                      style:
                                          ModalDecorationProperties.bookAuthor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: Text(
                                    snapshot.data![index].description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                PrimaryButtonWidget(
                                    text: "Adicionar livro",
                                    onTap: () {
                                      // Need a googleBook instance
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => NewEntry(
                                      //               googleBook:
                                      //                   snapshot.data![index],
                                      //             )));
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  // child: Entry(book: snapshot.data![index]),
                ),
                itemCount: snapshot.data!.length,
              );
            }
            break;
        }
        return const SliverToBoxAdapter();
      },
    );
  }
}
