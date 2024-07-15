import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/features/call/screens/call_pickup_screen.dart';
import 'package:whatsapp_ui/features/chat/widgets/bottom_chat_field.dart';
import 'package:whatsapp_ui/info.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/user_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../../call/controller/call_controller.dart';
import '../widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = "/mobile-chat-screen";
  const MobileChatScreen({Key? key, required this.name, required this.uid,required this.profilePic}) : super(key: key);
  final String name;
  final String uid;
  final String profilePic;

  void makeCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).makeCall(
      context,
      name,
      uid,
      profilePic,
    );
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: StreamBuilder<UserModel>(
              stream: ref.read(authControllerProvider).userDataById(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:CachedNetworkImageProvider(profilePic),     backgroundColor: Colors.transparent,),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text(name),
                        Text(
                          snapshot.data!.isOnline ? 'online' : 'offline',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: ()=> makeCall(ref,context),
              icon: const Icon(Icons.video_call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Column(
          children: [
             Expanded(
              child: ChatList(recieverUserId: uid,),
            ),
            BottomChatField(recieverUserId: uid)
          ],
        ),
      ),
    );
  }
}
