import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/home_screen/presentation/view/home_screen.dart';
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
     const HomeScreen(),
    const Text("chat"),
    const Text("Email")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: selectedindex,
                onTap: (val) {
                  setState(() {
                    selectedindex = val;
                  });
                },
                selectedItemColor: Theme.of(context).appColors.primary,
                backgroundColor: Theme.of(context).appColors.white100,
                selectedLabelStyle: Theme.of(context).appTexts.labelMedium.copyWith(
                  color: Theme.of(context).appColors.primary,
                ),
                unselectedItemColor: Theme.of(context).appColors.black60,
                unselectedLabelStyle: Theme.of(context).appTexts.labelMedium.copyWith(
                  color: Theme.of(context).appColors.black60,
                ),
                items: [
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(
                          Assests.home,
                          height: 20,
                          width: 20,
                          color: selectedindex == 0
                              ? Theme.of(context).appColors.primary
                              : Theme.of(context).appColors.black60,
                        ),
                      ),
                      label: "Home",
                  ),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(Assests.chat,
                            color: selectedindex == 1
                                ? Theme.of(context).appColors.primary
                                : Theme.of(context).appColors.black60),
                      ),
                      label: "Chat"),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(Assests.email,
                            color: selectedindex == 2
                                ? Theme.of(context).appColors.primary
                                : Theme.of(context).appColors.black60),
                      ),
                      label: "Email"),
                ]),
            body: Container(
              child: listwidget.elementAt(selectedindex),
            ));
  }
}
