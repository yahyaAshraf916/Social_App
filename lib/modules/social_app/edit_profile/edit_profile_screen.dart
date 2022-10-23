import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_state.dart';
import 'package:social_app/shared/styles/colors.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Updete Profile"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const ImageIcon(
                  AssetImage("assets/images/Arrow - Left 2.png")),
            ),
            actions: [
              defaultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text);
                        
                  },
                  text: "Update"),
              SizedBox(
                width: 15,
              )
            ],
            titleSpacing: 5.0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 250,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    alignment: Alignment.center,////////////////////////////////////////
                                    image: coverImage == null
                                        ? NetworkImage(userModel.cover!)
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: defaultcolor,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const ImageIcon(
                                    AssetImage("assets/images/Camera.png"),
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,////////////////////////////////////////////////////////
                                backgroundImage: profileImage == null
                                    ? NetworkImage(userModel.image!)
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: defaultcolor,
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const ImageIcon(
                                  AssetImage("assets/images/Camera.png"),
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialCubit.get(context).upLoadCoverImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text);
                                  },
                                  text: "Upload Cover",
                                ),
                                
                                 if (state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                  height: 5,
                                ),
                                  if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                              
                                defaultButton(
                                  function: () {
                                    SocialCubit.get(context).upLoadProfileImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text);
                                  },
                                  text: "Upload profile",
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                               
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    const SizedBox(
                      height: 20,
                    ),
                  defulteditTextx(
                    Controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "name must not be empty";
                      } else {
                        return null;
                      }
                    },
                    Label: "Name",
                    prefix: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: ImageIcon(
                        AssetImage("assets/images/Profile.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defulteditTextx(
                    Controller: bioController,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "bio must not be empty";
                      } else {
                        return null;
                      }
                    },
                    Label: "Bio",
                    prefix: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: ImageIcon(
                        AssetImage("assets/images/Info Circle.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defulteditTextx(
                    Controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "phone must not be empty";
                      } else {
                        return null;
                      }
                    },
                    Label: "phone",
                    prefix: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: ImageIcon(
                        AssetImage("assets/images/Call.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
