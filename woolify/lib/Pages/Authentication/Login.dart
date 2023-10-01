import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final List<String> imageList = [
    "assets/login/slide4.png",
  ];
  String username = "";
  String password = "";
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: size.height * 0.3,
            child: CarouselSlider(
                items: imageList
                    .map((e) => Image.asset(
                          e,
                          fit: BoxFit.fill,
                        ))
                    .toList(),
                options: CarouselOptions(autoPlay: true, viewportFraction: 1)),
          ),
          Text("LOGIN",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.w600)),
          Container(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (newValue) {
                      username = newValue!;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        label: Text("Username"),
                        hintText: "username12"),
                    validator: (value) {
                      if (value != null) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return "Invalid Username";
                        }
                      } else {
                        return "username cannot be empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (newValue) {
                      password = newValue!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.key),
                        label: Text("Password"),
                        hintText: "************"),
                    validator: (value) {
                      if (value != null) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return "Invalid Password";
                        }
                      } else {
                        return "username cannot be empty";
                      }
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(CommonRoutes.selectRoll);
                          },
                          child: const Text("Sign up ?")),
                      const Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Forgot Password ?")),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      width: size.width * 0.4,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                              var data = await ServerAuthenticationRoutes.login(
                                  username.trim(), password.trim());
                              Navigator.of(context).pop();
                              if (data['status'] == "success") {
                                // ignore: use_build_context_synchronously
                                ServerAuthenticationRoutes.redirectUser(
                                    context, data['role']!);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Invalid Creds/Some internal error")));
                              }
                            }
                          },
                          child: Text("Submit"))),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
