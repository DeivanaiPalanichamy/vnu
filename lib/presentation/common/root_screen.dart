import 'dart:collection';
import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:rxcommon/presentation/navigation/navigation.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/presentation/fnb/view/fnb_page.dart';
import 'package:vnu/presentation/more/more_page.dart';
import 'package:vnu/presentation/webview/webview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../constant/applog.dart';
import '../../constant/strings.dart';
import '../../textfieldt.dart';
import '../home/view/home_page.dart';
import '../whatson/view/whatson_page.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  AppLifecycleState? _notification;
  final controller1 = Get.put(Controllergetwhatson());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
      print("Deivanai +$_notification");
    });
  }

  @override
  void initState() {
    firebasetkengeneration();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late FirebaseMessaging messaging;
  @override
  Future<void> firebasetkengeneration() async {
    messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      Applog.printlog('Message token $value');
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage?.data != null) {
      Applog.printlog(
          'Message from bkg to fgd ${initialMessage?.data.entries}');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      Applog.printlog(
          "message recieved'Message data: ${event.notification!.title} ${event.notification!.body}");
      setState(() {
        print(Get.currentRoute);
        String? a = event.notification!.body;
        if (a == null) {
          print("hi");
        } else {
          setState(() {
            controller1.updategift(a);
          });
        }
      });
      if (event.data != null) {
        Applog.printlog(
            'Message data: ${event.data} ${event.data.entries} ${event.data.length} ${event.data.keys}');
      }
      // NotificationService.showNotification(event);
      /*      Map<String, dynamic> user = jsonDecode(event.data['aps']);
      var title = user['systemid'];
      var msg = user['alert'];
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title!),
              content: Text(msg!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }); */
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Applog.printlog('Message clicked! $message.');

      Map<String, dynamic> user = jsonDecode(message.data['aps']);
      var title = user['systemid'];
      var msg = user['alert'];
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title!),
              content: Text(msg!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 55),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              currentIndex: state.index,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              selectedItemColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    LocalImages.whatson_,
                    height: Constant.footernormal,
                    width: Constant.footernormal,
                  ),
                  activeIcon: Image.asset(
                    LocalImages.whatsonhover,
                    height: Constant.footerSelected,
                    width: Constant.footerSelected,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    LocalImages.favourite_,
                    height: Constant.footernormal,
                    width: Constant.footernormal,
                  ),
                  activeIcon: Image.asset(
                    LocalImages.favouritehover,
                    height: Constant.footerSelected,
                    width: Constant.footerSelected,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    LocalImages.home_,
                    height: Constant.footernormal,
                    width: Constant.footernormal,
                  ),
                  activeIcon: Image.asset(
                    LocalImages.homehover,
                    height: Constant.footerSelected,
                    width: Constant.footerSelected,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    LocalImages.profile_,
                    height: Constant.footernormal,
                    width: Constant.footernormal,
                  ),
                  activeIcon: Image.asset(
                    LocalImages.profilehover,
                    height: Constant.footerSelected,
                    width: Constant.footerSelected,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    LocalImages.offers_,
                    height: Constant.footernormal,
                    width: Constant.footernormal,
                  ),
                  activeIcon: Image.asset(
                    LocalImages.offershover,
                    height: Constant.footerSelected,
                    width: Constant.footerSelected,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    LocalImages.products_,
                    height: Constant.footernormal,
                    width: Constant.footernormal,
                  ),
                  activeIcon: Image.asset(
                    LocalImages.productshover,
                    height: Constant.footerSelected,
                    width: Constant.footerSelected,
                  ),
                  label: '',
                ),
              ],
              onTap: (index) {
                if (index == 0) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.whatson);
                } else if (index == 1) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.fav);
                } else if (index == 2) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.home);
                } else if (index == 3) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.profile);
                } else if (index == 4) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.wallet);
                }
              },
            ),
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        if (state.navbarItem == NavbarItem.whatson) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.toNamed('/whatsonpagescreen');
          });
          //  return WhatsonPage();
          // print(Get.currentRoute);
          //return WhatsonPage();
        } else if (state.navbarItem == NavbarItem.fav) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.toNamed('/whatsonpagescreen');
          });
          //return WhatsonPage();
        } else if (state.navbarItem == NavbarItem.home) {
          return HomePage();
        } else if (state.navbarItem == NavbarItem.profile) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.toNamed('/whatsonpagescreen');
          });
          // return WhatsonPage();
        } else if (state.navbarItem == NavbarItem.wallet) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.toNamed('/morepagescreen');
          });
          //return MorePage();
        } else if (state.navbarItem == NavbarItem.fnb) {
          return FnbPage();
        } /*else if (state.navbarItem == NavbarItem.more) {
          return MorePage();
        }else if (state.navbarItem == NavbarItem.html) {
          return  WebViewPage( "https://www.google.com","sada");
        }else if (state.navbarItem == NavbarItem.more) {
          return MorePage();
        }*/
        return Container();
      }),
    );
  }
}
