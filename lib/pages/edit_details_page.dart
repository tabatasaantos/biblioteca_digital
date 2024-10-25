import 'package:biblioteca_digital/models/personal_book_model.dart';
import 'package:biblioteca_digital/pages/widgets/date_input_widget.dart';
import 'package:biblioteca_digital/pages/widgets/display_text_widget.dart';
import 'package:biblioteca_digital/pages/widgets/entry_widget.dart';
import 'package:biblioteca_digital/pages/widgets/primary_button_widget.dart';
import 'package:biblioteca_digital/until/theme_until.dart';
import 'package:flutter/material.dart';

class EditDetailsPage extends StatefulWidget {
  EditDetailsPage({super.key, required this.personalBookModel});

  PersonalBookModel personalBookModel;

  @override
  State<EditDetailsPage> createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController initialDateController = TextEditingController();
  final TextEditingController finalDateController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.personalBookModel.comments != "") {
      commentsController.text = widget.personalBookModel.comments;
    }
    if (widget.personalBookModel.dayStarted != "") {
      initialDateController.text = widget.personalBookModel.dayStarted;
    }
    if (widget.personalBookModel.dayFinished != "") {
      finalDateController.text = widget.personalBookModel.dayFinished;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: AppBackgroundProperties.boxDecoration,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.black,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: DisplayTextWidget("Editando o Livro"),
                ),
                SizedBox(
                  width: 244,
                  child: Column(
                    children: <Widget>[
                      Entry(
                          googleBooksModel:
                              widget.personalBookModel.googleBook),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: DateInputWidget(
                                  textController: initialDateController,
                                  label: "Início da Leitura"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: DateInputWidget(
                                  textController: finalDateController,
                                  label: "Final da Leitura"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: TextFormField(
                                controller: commentsController,
                                decoration: InputDecorationProperties
                                    .newInputDecoration(
                                  "",
                                  "Comentários",
                                ),
                                maxLines: 5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: PrimaryButtonWidget(
                                  text: "Salvar",
                                  onTap: () {
                                    // Navigator.pop(context, "Updated book");
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
