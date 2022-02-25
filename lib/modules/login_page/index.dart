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
    double spacerSize = size.height * 0.1;
    double biggerSpacerSize = size.height * 0.13;
    double textFieldHeight = 50.0;
    double textFieldSpacerHeight = size.height * 0.012;
    double bottomMargin = size.height * 0.155;
    double textFieldBorderRadius = 8;

    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: kPrimaryColor,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ScrollConfiguration(
              behavior: MyScrollBehavior(),
              child: SingleChildScrollView(
                reverse: true,
                child: SizedBox(
                  height: size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0.0,
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
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 100,
                                child: Image(
                                  image: AssetImage(
                                      'images/logo_siao_white_minimal.png'),
                                ),
                              ),
                              SizedBox(height: biggerSpacerSize),
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
                              SizedBox(height: spacerSize),
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
                              SizedBox(height: spacerSize),
                              _buildLoginForm(textFieldBorderRadius, context,
                                  textFieldHeight, textFieldSpacerHeight),
                              SizedBox(height: bottomMargin),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildLoginForm(double textFieldBorderRadius, BuildContext context,
      double textFieldHeight, double textFieldSpacerHeight) {
    return Column(
      children: [
        SizedBox(
          height: textFieldHeight,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintText: 'E-mail',
                filled: true,
                fillColor: kWhite,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius:
                      BorderRadius.all(Radius.circular(textFieldBorderRadius)),
                ),
                prefixIcon: const Icon(Icons.email_rounded)),
          ),
        ),
        SizedBox(height: textFieldSpacerHeight),
        SizedBox(
          height: textFieldHeight,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Senha',
              filled: true,
              fillColor: kWhite,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.all(Radius.circular(textFieldBorderRadius)),
              ),
              prefixIcon: const Icon(Icons.lock_rounded),
            ),
          ),
        ),
        SizedBox(height: textFieldSpacerHeight),
        Container(
          alignment: Alignment.center,
          height: textFieldHeight,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(textFieldBorderRadius),
            ),
          ),
          child: ButtonTheme(
            minWidth: double.infinity,
            height: double.infinity,
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
