import 'package:biblioteca_digital/controller/book_controller.dart';
import 'package:biblioteca_digital/models/personal_book_model.dart';
import 'package:biblioteca_digital/pages/book_details_page.dart';
import 'package:biblioteca_digital/pages/search_books_page.dart';
import 'package:biblioteca_digital/pages/widgets/display_text_widget.dart';
import 'package:biblioteca_digital/pages/widgets/floating_button_widget.dart';
import 'package:biblioteca_digital/until/theme_until.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookController bookController = BookController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: AppBackgroundProperties.boxDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: FutureBuilder(
            future: bookController.getBooks(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return _FilledHome(listPersonalBook: snapshot.data!);
                  }
                  break;
                default:
                  break;
              }
              return const _EmptyHome();
            },
          ),
        ),
      ),
    ));
  }
}

class _FilledHome extends StatefulWidget {
  _FilledHome({required this.listPersonalBook});

  List<PersonalBookModel> listPersonalBook;

  @override
  State<_FilledHome> createState() => _FilledHomeState();
}

class _FilledHomeState extends State<_FilledHome> {
  final BookController bookController = BookController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 8.0),
                  child: DisplayTextWidget("Biblioteca"),
                ),
              ),
              SliverGrid.builder(
                itemCount: widget.listPersonalBook.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 167,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsPage(
                          personalBookModel: widget.listPersonalBook[index],
                        ),
                      ),
                    ).then((value) async {
                      widget.listPersonalBook = await bookController.getBooks();
                      setState(() {});
                    });
                  },
                  child: Image.network(
                    widget.listPersonalBook[index].googleBook.thumbnailLink,
                    height: 220,
                    width: 144,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 72,
            width: MediaQuery.of(context).size.width,
            decoration: HomeShadowProperties.boxDecoration,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height - 125,
          left: MediaQuery.of(context).size.width / 2 - 28,
          child: FloatingButtonWidget(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchBooksPage()));
            },
          ),
        ),
      ],
    );
  }
}

class _EmptyHome extends StatelessWidget {
  const _EmptyHome();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(bottom: 32.0),
        child: DisplayTextWidget("Biblioteca Digital"),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: SvgPicture.asset("assets/images/grimorio_empty.svg"),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          "Sua biblioteca está vazia!",
          style: TextStyle(
              fontFamily: "Bigelow Rules",
              fontSize: 36,
              color: AppColors.lightPink),
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 40.0),
        child: Text(
          "Vamos aprender algo novo?",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      FloatingButtonWidget(onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchBooksPage()));
      }),
    ]);
  }
}
