import 'package:biblioteca_digital/pages/widgets/display_text_widget.dart';
import 'package:biblioteca_digital/pages/widgets/primary_button_widget.dart';
import 'package:biblioteca_digital/until/theme_until.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: AppBackgroundProperties.boxDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: DisplayTextWidget("Cadastre-se"),
                ),
                SizedBox(
                  width: 246,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: TextFormField(
                            style: InputDecorationProperties.textDecoration,
                            decoration:
                                InputDecorationProperties.newInputDecoration(
                                    "Seu nome aqui", "Nome"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: TextFormField(
                            style: InputDecorationProperties.textDecoration,
                            decoration:
                                InputDecorationProperties.newInputDecoration(
                                    "seuemail@dominio.com", "E-mail"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            style: InputDecorationProperties.textDecoration,
                            decoration:
                                InputDecorationProperties.newInputDecoration(
                                    "******", "Senha"),
                            obscureText: true,
                          ),
                        ),
                        PrimaryButtonWidget(text: "Cadastrar", onTap: () {}),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: const Size.fromWidth(246),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Fazer login",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
