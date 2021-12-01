import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Expanded(
            child: Container(
          color: Theme.of(context).colorScheme.primary,
        )),
        Column(
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              height: 256,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16))),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 128,
              ),
              const Center(
                child: Image(
                  image: AssetImage('images/logo_siao_black_minimal.png'),
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                "Ministério de Louvor",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 45,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                child: Text(
                  "Faça seu login informando o e-mail e senha",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      fillColor: Theme.of(context).colorScheme.background,
                      filled: true,
                      hintText: "E-mail",
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                height: 55,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      fillColor: Theme.of(context).colorScheme.background,
                      filled: true,
                      hintText: "Senha",
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: null,
                  child: Text(
                    "Acessar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
