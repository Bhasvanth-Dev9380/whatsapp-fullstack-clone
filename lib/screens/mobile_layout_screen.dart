import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:whatsapp_ui/common/utils/colors.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';
//import 'package:whatsapp_ui/features/group/screens/create_group_screen.dart';
import 'package:whatsapp_ui/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:whatsapp_ui/features/chat/widgets/contacts_list.dart';
//import 'package:whatsapp_ui/features/status/screens/confirm_status_screen.dart';
//import 'package:whatsapp_ui/features/status/screens/status_contacts_screen.dart';

import '../colors.dart';
import '../features/status/screens/confirm_status_screen.dart';
import '../features/status/screens/status_contacts_screen.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  static const routeName = '/mobile-layout';
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: true,
          title: const Text(
            'dev💓devi',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
        //     IconButton(
        //       icon: const Icon(Icons.search, color: Colors.grey),
        //       onPressed: () {},
        //     ),
        //     PopupMenuButton(
        //       icon: const Icon(
        //         Icons.more_vert,
        //         color: Colors.grey,
        //       ),
        //       itemBuilder: (context) => [
        //         PopupMenuItem(
        //           child: const Text(
        //             'Create Group',
        //           ),
        //           onTap: () => (){}
        // // Future(
        // //                 () => Navigator.pushNamed(
        // //                 context, CreateGroupScreen.routeName),
        // //           ),
        //         )
        //       ],
        //     ),
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorColor: tabColor,
            indicatorWeight: 4,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              // Tab(
              //   text: 'STATUS',
              // ),
              // Tab(
              //   text: 'CALLS',
              // ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: Container(
                height:double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/bg1.jpg"), opacity:(0.01),fit: BoxFit.cover),
                ),
                child: Center(child: Text('',style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0
                ),)),
              ),
            ),
            TabBarView(
              controller: tabBarController,
              children: const [
                ContactsList(),
                // StatusContactsScreen(),
                // Text('Calls')
              ],
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     if (tabBarController.index == 0) {
        //       // Navigator.pushNamed(context, SelectContactsScreen.routeName);
        //     } else {
        //       File? pickedImage = await pickImageFromGallery(context);
        //       if (pickedImage != null) {
        //         Navigator.pushNamed(
        //           context,
        //           ConfirmStatusScreen.routeName,
        //           arguments: pickedImage,
        //         );
        //       }
        //     }
        //   },
        //   backgroundColor: tabColor,
        //   child:  Icon(
        //     (tabBarController.index == 0)?Icons.comment: null,
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }
}