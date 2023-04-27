import 'package:bitirme/core/model/user_model.dart';
import 'package:bitirme/core/service/i_auth_service.dart';
import 'package:bitirme/providers/home_provider.dart';
import 'package:bitirme/view/home_page.dart';
import 'package:bitirme/view/login_page.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool isVisibility = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _password2FocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  late IAuthService _authService;
  void initState() {
    super.initState();
    _authService = Provider.of<IAuthService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: myPrimaryColor,
        title: const Text(
          "Kayıt Ekranı",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: LottieBuilder.asset("assets/login.json")),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          decoration: InputDecoration(
                            hintText: "Adınızı ve Soyadınızı giriniz",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            prefixIcon:
                                const Icon(Icons.person, color: myPrimaryColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: myPrimaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          validator: (value) {
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value.toString());
                            return !emailValid
                                ? "Geçerli bir email giriniz"
                                : null;
                          },
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          decoration: InputDecoration(
                            hintText: "Email giriniz",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            prefixIcon:
                                const Icon(Icons.email, color: myPrimaryColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: myPrimaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          obscureText: !isVisibility,
                          obscuringCharacter: "*",
                          validator: (value) {
                            if (_passwordController2.text == value) {
                              return null;
                            }
                            return "Lütfen aynı şifreyi girin";
                          },
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                            hintText: "Şifrenizi giriniz",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            prefixIcon:
                                const Icon(Icons.lock, color: myPrimaryColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: myPrimaryColor,
                                width: 2,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisibility = !isVisibility;
                                });
                              },
                              child: Icon(
                                isVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_password2FocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          obscureText: !isVisibility,
                          obscuringCharacter: "*",
                          validator: (value) {
                            if (_passwordController.text == value) {
                              return null;
                            }
                            return "Lütfen aynı şifreyi girin";
                          },
                          controller: _passwordController2,
                          focusNode: _password2FocusNode,
                          decoration: InputDecoration(
                            hintText: "Şifrenizi tekrar giriniz",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            prefixIcon:
                                const Icon(Icons.lock, color: myPrimaryColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: myPrimaryColor,
                                width: 2,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisibility = !isVisibility;
                                });
                              },
                              child: Icon(
                                isVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            _submitForm();
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await _authService.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _nameController.text);
                            _submitForm();
                          },
                          child: const Text("Kayıt Ol"),
                          style: ElevatedButton.styleFrom(
                              primary: myPrimaryColor,
                              minimumSize: const Size(double.infinity, 50)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text, // Add this line
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Kayıt işlemi başarılı"),
          ),
        );
        await context.read<HomeProvider>().fetchItems();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Kayıt işlemi başarısız: ${e.toString()}"),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    _nameController.dispose(); // Add this line
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _password2FocusNode.dispose();
    _nameFocusNode.dispose(); // Add this line
    super.dispose();
  }
}

const Color myPrimaryColor = Colors.amber;
