import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_state.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) navigateTo(context, NewPostScreen());
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const ImageIcon(
                    AssetImage("assets/images/Notification.png")),
              ),
              IconButton(
                onPressed: () {},
                icon: const ImageIcon(AssetImage("assets/images/Search.png")),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/Home.png")),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/Chat.png")),
                    label: "Chat"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/Upload.png")),
                    label: "Post"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/Location.png")),
                    label: "Location"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/Setting.png")),
                    label: "Settings"),
              ]),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}



// Widget emailVertified()=> 

//                  Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.amber.withOpacity(.7),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Row(
//                             children: [
//                               const Icon(Icons.info),
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               const Expanded(
//                                   child: Text("Please vertify your email")),
//                               const SizedBox(
//                                 width: 20,
//                               ),
//                               defaultTextButton(
//                                 function: () {
//                                   FirebaseAuth.instance.currentUser!
//                                       .sendEmailVerification()
//                                       .then((value) {
//                                     showToast(
//                                         text: "Check your mail",
//                                         state: ToastStates.SUCCSESS);
//                                   }).catchError((error) {});
//                                 },
//                                 text: "send",
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 );
              