import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';
import 'dart:developer' as developer;

class FarmerRegisteration extends ConsumerStatefulWidget {
  const FarmerRegisteration({super.key});
  @override
  ConsumerState<FarmerRegisteration> createState() {
    return _FarmerRegisteration();
  }
}

class _FarmerRegisteration extends ConsumerState<FarmerRegisteration> {
  var fromkey = GlobalKey<FormState>();
  var fromkey2 = GlobalKey<FormState>();
  OtpFieldController otpController = OtpFieldController();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String password = "";

  String username = "";
  String pin = "";
  int currentStep = 0;

  Step step1(Size size) {
    return Step(
        isActive: true,
        title: SizedBox(),
        content: Form(
          key: fromkey,
          child: Column(
            children: [
              Image.asset(
                "assets/login/slide4.png",
                fit: BoxFit.cover,
                height: size.height * 0.2,
              ),
              const Text(
                "Its Time To Elevate Your wool Game",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        // width: size.width * 0.4,
                        child: TextFormField(
                          onSaved: (newValue) {
                            firstName = newValue!;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              // prefixIcon: const Icon(Icons.account_circle),
                              label: const Text("FirstName"),
                              hintText: "FirstName"),
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
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        // width: size.width * 0.4,
                        child: TextFormField(
                          onSaved: (newValue) {
                            lastName = newValue!;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              // prefixIcon: const Icon(Icons.account_circle),
                              label: const Text("LastName"),
                              hintText: "LastName"),
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
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) {
                    developer.log("emaol " + newValue!);
                    email = newValue;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35)),
                      prefixIcon: const Icon(Icons.email),
                      label: const Text("E-mail"),
                      hintText: "user@gmail.com"),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  onSaved: (newValue) {
                    phone = "+91" + newValue!;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35)),
                      prefixIcon: const Icon(Icons.phone),
                      label: const Text("Phone"),
                      hintText: "91987654321"),
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
              ),
            ],
          ),
        ));
  }

  Step step2(Size size) {
    return Step(
        isActive: currentStep >= 1 ? true : false,
        // title: const Icon(Icons.password),
        title: SizedBox(),
        content: Form(
            key: fromkey2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    onSaved: (newValue) {
                      username = newValue!;
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35)),
                        prefixIcon: const Icon(Icons.account_circle),
                        label: const Text("username"),
                        hintText: "username"),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    onSaved: (newValue) {
                      password = newValue!;
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35)),
                        prefixIcon: const Icon(Icons.key),
                        label: const Text("password"),
                        hintText: "password"),
                    validator: (value) {
                      if (value != null) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return "Invalid passwors";
                        }
                      } else {
                        return "password cannot be empty";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    onSaved: (newValue) {},
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35)),
                        prefixIcon: const Icon(Icons.key),
                        label: const Text("Confrim password"),
                        hintText: "password"),
                    validator: (value) {
                      if (value != null) {
                        if (value.isNotEmpty) {
                          if (password != value) {
                            return "Password doesn`t match";
                          }

                          return null;
                        } else {
                          return "Invalid Password";
                        }
                      } else {
                        return "password cannot be empty";
                      }
                    },
                  ),
                )
              ],
            )));
  }

  Step step3(Size size) {
    return Step(
        title: SizedBox(),
        content: Column(
          children: [
            Image.asset(
              "assets/login/login2.png",
              height: size.height * 0.26,
            ),
            Text(
              "OTP is sent to $phone",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 25),
              child: Center(
                child: OTPTextField(
                    controller: otpController,
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: TextStyle(fontSize: 17),
                    onChanged: (p) {
                      print("Changed: " + p);
                    },
                    onCompleted: (p) {
                      pin = p;
                      print("Completed: " + p);
                    }),
              ),
            ),
          ],
        ));
  }

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              controlsBuilder:
                  (BuildContext context, ControlsDetails controlsDetails) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: controlsDetails.onStepContinue,
                        child: currentStep >= 2
                            ? const Text('Submit')
                            : const Text("continue"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      currentStep == 0
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: controlsDetails.onStepCancel,
                              child: const Text('Back'),
                            ),
                    ]);
              },
              steps: [step1(size), step2(size), step3(size)],
              currentStep: currentStep,
              type: StepperType.horizontal,
              onStepContinue: () async {
                if (currentStep == 1) {
                  if (fromkey2.currentState!.validate()) {
                    fromkey2.currentState!.save();

                    FarmerModel data = FarmerModel(
                        firstName: firstName.trim(),
                        lastName: lastName.trim(),
                        role: "farmer",
                        password: password.trim(),
                        phone: phone.trim(),
                        confirmPassword: password.trim(),
                        email: email.trim(),
                        username: username.trim());
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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

                    FocusManager.instance.primaryFocus?.unfocus();
                    Map<String, dynamic> location =
                        await FarmerModel.getCurrentLocation();
                    developer.log(location.toString());

                    var res =
                        await ServerAuthenticationRoutes.farmerRegisteration(
                            data, location);
                    Navigator.of(context).pop();
                    if (res != null) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content:
                              Text("Account Created Please Verify Your self")));
                      setState(() {
                        currentStep++;
                      });
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Some internal error !")));
                    }
                  }
                } else if (currentStep == 2) {
                  if (pin.length >= 3) {
                    var res = await ServerAuthenticationRoutes.verifyOtp(
                        phone: phone, pin: pin);
                    if (res == "success") {
                      GoRouter.of(context)
                          .pushReplacementNamed(CommonRoutes.login);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Account created  SuccessFull !")));
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Wrong OTP !")));
                    }
                  }
                } else if (currentStep == 0) {
                  if (fromkey.currentState!.validate()) {
                    fromkey.currentState!.save();

                    setState(() {
                      currentStep++;
                    });
                  } else {
                    developer.log("fai");
                  }
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  setState(() {
                    currentStep--;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
