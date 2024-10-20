import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/services/firebase/firebase_auth/auth_service.dart';
import 'package:gymnastics_app/core/ui/helpers/gymnastics_snackbar_.dart';
import 'package:gymnastics_app/core/ui/styles/gymnastics_app_colors.dart';
import 'package:gymnastics_app/core/ui/widgets/gymnastics_textform_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailEC = TextEditingController();
  final _passwrodEC = TextEditingController();
  final _nomeEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool wantToLogin = true;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailEC.dispose();
    _passwrodEC.dispose();
    _nomeEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: GymnasticsAppColors.blueGradient),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 128,
                      ),
                      const Text(
                        'Gymnastics App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: GymnasticsAppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      GymnasticsTextformFieldWidget(
                        controller: _emailEC,
                        label: 'E-mail',
                        validator: (String? value) {
                          if (value == null) {
                            return 'Favor digitar um E-mail';
                          }
                          if (value.length < 7) {
                            return 'E-mail muito curto';
                          }
                          if (!value.contains('@')) {
                            return 'E-mail inválido.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      GymnasticsTextformFieldWidget(
                        controller: _passwrodEC,
                        label: 'PassWord',
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null) {
                            return 'Favor digitar um Password';
                          }
                          if (value.length < 7) {
                            return 'Password muito curto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                          visible: !wantToLogin,
                          child: Column(
                            children: [
                              GymnasticsTextformFieldWidget(
                                label: 'Confirme o Password',
                                validator: (String? value) {
                                  if (value == null) {
                                    return 'Favor digitar um Password';
                                  }
                                  if (value.length < 7) {
                                    return 'Password muito curto';
                                  }
                                  return null;
                                },
                                obscureText: true,
                              ),
                              const SizedBox(height: 8),
                              GymnasticsTextformFieldWidget(
                                controller: _nomeEC,
                                label: 'Nome',
                                validator: (String? value) {
                                  if (value == null) {
                                    return 'Favor digitar um Nome';
                                  }
                                  if (value.length < 7) {
                                    return 'Nome muito curto';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          buttonMainClicked();
                        },
                        child: Text((wantToLogin) ? 'Entrar' : 'Cadastrar'),
                      ),
                      const Divider(
                        color: GymnasticsAppColors.blackColor,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            wantToLogin = !wantToLogin;
                          });
                        },
                        child: Text((wantToLogin)
                            ? 'Ainda não tem conta? Cadastre-se aqui!!'
                            : 'Já tem uma conta? Entre!'),
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

  buttonMainClicked() {
    String name = _nomeEC.text;
    String password = _passwrodEC.text;
    String email = _emailEC.text;

    if (_formKey.currentState!.validate()) {
      if (wantToLogin) {
        print('Entrada validada');
        _authService
            .loadUser(
          email: email,
          password: password,
        )
            .then(
          (String? error) {
            if (error != null) {
              showSnackbar(context: context, text: error);
            }
          },
        );
      } else {
        print('Cadastro validado');
        _authService
            .userRegister(
          name: name,
          password: password,
          email: email,
        )
            .then(
          (String? error) {
            if (error != null) {
              // voltou com erro
              showSnackbar(
                context: context,
                text: error,
              );
              // } else {
              //   // deu certo
              //   showSnackbar(
              //     context: context,
              //     text: 'Cadastro efeturado com sucesso',
              //     isError: false,
              //   );
            }
          },
        );
      }
    } else {
      print('Form Invalido');
    }
  }
}
