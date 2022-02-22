import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:portal_louvor_app/components/constants.dart';

import '../../components/my_scroll_behavior.dart';
import '../home_page/index.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  void _onClickAcessar(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double bottomContainerSize = size.height * 0.33;
    double textFieldBorderRadius = 8;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: kPrimaryColor,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              height: bottomContainerSize,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: kSecondaryColor,
              ),
            ),
          ),
          Center(
            child: ScrollConfiguration(
              behavior: MyScrollBehavior(),
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                padding: const EdgeInsets.all(40.0),
                children: [
                  const SizedBox(
                    height: 100,
                    child: Image(
                      image: AssetImage('images/logo_siao_white_minimal.png'),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Text(
                    "Ministério de Louvor",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: kWhite,
                      fontFamily: 'Roboto-Regular',
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  Text(
                    "Faça login informando e-mail e senha",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: kWhite,
                      fontFamily: 'Roboto-Regular',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 60),
                  _buildLoginForm(textFieldBorderRadius, context)
                ].reversed.toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildLoginForm(double textFieldBorderRadius, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          height: 54,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(textFieldBorderRadius),
            ),
          ),
          child: const TextField(
            decoration: InputDecoration(
                hintText: 'E-mail',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: Icon(Icons.email_rounded)),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          height: 54,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(textFieldBorderRadius),
            ),
          ),
          child: const TextField(
            decoration: InputDecoration(
                hintText: 'Senha',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: Icon(Icons.lock_rounded)),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          height: 54,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(textFieldBorderRadius),
            ),
          ),
          child: ButtonTheme(
            minWidth: double.infinity,
            child: MaterialButton(
              onPressed: () {
                _onClickAcessar(context);
              },
              child: Text(
                'Acessar',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
