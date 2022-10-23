import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/message_model.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_state.dart';
import 'package:social_app/shared/styles/colors.dart';


class ChatDetailsScreen extends StatelessWidget {
  var messageController = TextEditingController();
  SocialUserModel? userModel;
  ChatDetailsScreen(context, {super.key, this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getmessage(receiverId: userModel!.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(userModel!.image!),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(userModel!.name!),
              ]),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).message.isNotEmpty,
              fallback: (BuildContext context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            var message =
                                SocialCubit.get(context).message[index];
                            if (SocialCubit.get(context).userModel!.uId ==
                                message.senderId) {
                              return buildMyMessage(message);
                            } else {
                              return buildMessage(message);
                            }
                          },
                          itemCount: SocialCubit.get(context).message.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 15,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                    hintText: "Type your message here .... ",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                             
                              width: 50,
                              color: defaultcolor,
                              child: MaterialButton(
                                onPressed: () {
                                  
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                      messageController.text = "";
                                },
                                minWidth: 1,
                                child: const ImageIcon(
                                  AssetImage("assets/images/Send.png"),
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: defaultcolor.withOpacity(.2),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text(model.text!),
        ),
      );

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text(model.text!),
        ),
      );
}
