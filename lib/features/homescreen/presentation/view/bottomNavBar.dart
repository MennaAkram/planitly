import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/homescreen/presentation/view/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planitly/shared/assests.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  int selectedindex = 0;
  List<Widget> listwidget = [
     Home_Page(),
    const Text("chat"),
    const Text("Email")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: selectedindex,
                onTap: (val) {
                  setState(() {
                    selectedindex = val;
                  });
                },
                selectedItemColor: Theme.of(context).appColors.primary,
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Assests.home,
                        color: selectedindex == 0
                            ? Theme.of(context).appColors.primary
                            : Theme.of(context).appColors.black60,
                      ),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(Assests.chat,
                          color: selectedindex == 1
                              ? Theme.of(context).appColors.primary
                              : Theme.of(context).appColors.black60),
                      label: "Chat"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(Assests.email,
                          color: selectedindex == 2
                              ? Theme.of(context).appColors.primary
                              : Theme.of(context).appColors.black60),
                      label: "Email"),
                ]),
            body: Container(
              child: listwidget.elementAt(selectedindex),
            )));
  }
}
