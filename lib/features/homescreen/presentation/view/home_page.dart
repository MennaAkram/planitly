
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planitly/features/homescreen/presentation/widgets/cards.dart';
import 'package:planitly/features/homescreen/presentation/widgets/categories.dart';
import 'package:planitly/features/homescreen/presentation/widgets/expenses.dart';
import 'package:planitly/features/homescreen/presentation/widgets/habits_card.dart';
import 'package:planitly/features/homescreen/presentation/widgets/most_visited.dart';
import 'package:planitly/features/homescreen/presentation/widgets/tasxs_card.dart';
import 'package:planitly/shared/assests.dart';
import 'package:planitly/design_system/theme.dart';

class Home_Page extends StatefulWidget {
   Home_Page({super.key});

  @override
  State<Home_Page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   home:  Scaffold(
        appBar: AppBar(
          title: Text(
            "Hello, Menna",
            style: Theme.of(context).appTexts.titleSmall.copyWith(color: 
            Theme.of(context).appColors.black87),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(60), 
                  child: Image.asset(Assests.person, fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).appColors.white100,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined),
              color: Theme.of(context).appColors.black60,
            ),
          ],
        ),
        body: Stack(children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).appColors.white100,
            child: FittedBox(
                fit: BoxFit.cover, child: SvgPicture.asset(Assests.background)),
          ),
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                        child: MyCards(
                      imageAssetPath: Assests.calendar,
                      name: "Calender", onPressed: () {},
                    )),
                    Expanded(
                        child: MyCards(
                      imageAssetPath: Assests.habit,
                      name: "Hapit Tracker", onPressed: () {},
                    )),
                    Expanded(
                        child: MyCards(
                            imageAssetPath: Assests.finance, name: "Finance", onPressed: () {},)),
                    Expanded(
                        child: MyCards(
                      imageAssetPath: Assests.studywork,
                      name: "Study&Work", onPressed: () {},
                    )),
                  ],
                ),
              ),
              Container(
                        margin: const EdgeInsets.all(3),
                        height: 20,
                        child:  Stack(children: [
                          Positioned(
                              left: 0,
                              child: Text(
                                "Today Tasks",
                               style: Theme.of(context)
                          .appTexts
                          .titleMedium
                          .copyWith(color: Theme.of(context).appColors.black87),
                              )),
                        ])),
                    SizedBox(
                        height: 118,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            tasks(task: "Task"),
                            tasks(task: "Task")
                          ],
                        )),
              Container(
                  margin: const EdgeInsets.all(3),
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.all(7),
                      height: 20,
                      child: Stack(
                        children: [
                           Positioned(
                              left: 0,
                              child: Text(
                                "Categories",
                                     style: Theme.of(context)
                          .appTexts
                          .titleMedium
                          .copyWith(color: Theme.of(context).appColors.black87),
                              )),
                          Positioned(
                              right: 0,
                              child: MaterialButton(
                                  child:  Text(
                                    "see all",
                                    style: Theme.of(context).appTexts.labelLarge.copyWith(
                                      color: Theme.of(context).appColors.black37
                                    ),
                                  ),
                                  onPressed: () {}))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Categories(name: "Tasks", onPressed: () {},),
                          Categories(name: "Habits", onPressed: () {},),
                          Container(
                            height: 120,
                            width: 100,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Theme.of(context).appColors.white100,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color: Theme.of(context).appColors.black16,
                                    width: 0.5)),
                            child: MaterialButton(
                                onPressed: () {},
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  SvgPicture.asset(Assests.icon ),
                                     Text(
                                      "Add new Category",
                                      style: Theme.of(context).appTexts.bodyMedium.copyWith(
                                      color:   Theme.of(context).appColors.black60
                                      )),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                     Container(
                        margin: const EdgeInsets.all(3),
                        height: 20,
                        child: Stack(children: [
                          Positioned(
                              left: 0,
                              child: Text(
                                "Today Hapits",
                                    style: Theme.of(context)
                          .appTexts
                          .titleMedium
                          .copyWith(color:  Theme.of(context).appColors.black87),
                              )),
                        ])),
                        SizedBox(
                        height: 118,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            Habits(habit: "Habit"),
                            Habits(habit:"Habit")
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.all(3),
                      height: 20,
                      child: Stack(
                        children: [
                           Positioned(
                              left: 0,
                              child: Text(
                                "Today Expenses",
                                     style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color:Theme.of(context).appColors.black87)
                                ,
                              )),
                          Positioned(
                              right: 0,
                              child: MaterialButton(
                                  child:  Text(
                                    "see all",
                                    style: Theme.of(context).appTexts.labelLarge.copyWith(
                                      color: Theme.of(context).appColors.black37
                                    ),
                                  ),
                                  onPressed: () {}))
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 84,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            Expenses(name: "Expense", value: "+60.00",state: true,),
                            Expenses(name: "Expense", value: "-70.00",state: false,)
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.all(3),
                      height: 20,
                      child: Stack(
                        children: [
                           Positioned(
                              left: 0,
                              child: Text(
                                "Most Visited",
                                   style: Theme.of(context)
                          .appTexts
                          .titleMedium
                          .copyWith(color:Theme.of(context).appColors.black87 ),
                              )),
                          Positioned(
                              right: 0,
                              child: MaterialButton(
                                  child:  Text(
                                    "see all",
                                    style: Theme.of(context).appTexts.labelLarge.copyWith(
                                      color: Theme.of(context).appColors.black37
                                    ),
                                  ),
                                  onPressed: () {}))
                        ],
                      ),
                    ),
                    const most_visited(name: "Me"),
                    const most_visited(name: "Gym"),
                    const most_visited(name: "Movie"),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).appColors.white100,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              color:Theme.of(context).appColors.black16, width: 0.5)),
                      height: 52,
                      width: 329,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                           SvgPicture.asset(Assests.icon1),
                            Text("Add new item",
                                style: Theme.of(context)
                                    .appTexts
                                    .bodyLarge
                                    .copyWith(color: Theme.of(context).appColors.black87)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 195.96,
                      width: 232,
                      margin: const EdgeInsets.all(45),
                      child: Image.asset(Assests.pictute),
                    )
                  ])),
            ],
          ),
        ]))
    );
  }
}





 




