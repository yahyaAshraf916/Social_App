import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:social_app/modules/social_app/social_register/cubit/cubit.dart';
import 'package:social_app/modules/social_app/social_register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';


class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
          }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Register now to communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defulteditTextx(
                            Controller: namecontroller,
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "name must not be empty";
                              } else {
                                return null;
                              }
                            },
                            Label: 'enter your name',
                            prefix: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child:
                                ImageIcon(AssetImage("assets/images/Paper.png")),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defulteditTextx(
                            Controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "email must not be empty";
                              } else {
                                return null;
                              }
                            },
                            Label: 'enter your email',
                             prefix: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child:
                                ImageIcon(AssetImage("assets/images/Profile.png")),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defulteditTextx(
                          Controller: passwordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "password must not be empty";
                            } else {
                              return null;
                            }
                          },
                          Label: 'enter your password',
                           prefix: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child:
                                ImageIcon(AssetImage("assets/images/Lock.png")),
                          ),
                          suffix: cubit.suffix,
                          isPassword: cubit.isPassword,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defulteditTextx(
                            Controller: phonecontroller,
                            keyboardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "phone must not be empty";
                              } else {
                                return null;
                              }
                            },
                            Label: 'enter your phone',
                             prefix: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child:
                                ImageIcon(AssetImage("assets/images/Call.png")),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                  );
                                }
                              },
                              text: "register",
                              isUpperCase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Do you have an account ?"),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, SocialLoginScreen());
                                },
                                text: "Login")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
