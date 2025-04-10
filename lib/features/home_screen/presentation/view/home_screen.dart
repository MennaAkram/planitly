import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planitly/features/calendar/presentation/view/calendar_screen.dart';
import 'package:planitly/features/finance/presentation/view/finance_screen.dart';
import 'package:planitly/features/habit/presentation/view/habit_screen.dart';
import 'package:planitly/features/notifications/presentation/view/notifications_screen.dart';
import 'package:planitly/features/home_screen/presentation/widgets/cards.dart';
import 'package:planitly/features/home_screen/presentation/widgets/categories.dart';
import 'package:planitly/features/home_screen/presentation/widgets/expenses.dart';
import 'package:planitly/features/home_screen/presentation/widgets/homePlaceholder.dart';
import 'package:planitly/features/home_screen/presentation/widgets/home_appbar.dart';
import 'package:planitly/features/home_screen/presentation/widgets/most_visited.dart';
import 'package:planitly/features/home_screen/presentation/widgets/today_task_card.dart';
import 'package:planitly/features/login/view/login_screen.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/widgets/title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        imageAssetPath: Assets.person,
        name: "Menna",
        onPressed: () {
          NavigatorHelper.push(const NotificationsScreen());
        },
      ),
      backgroundColor: Theme.of(context).appColors.background,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).appColors.white100,
            child: FittedBox(
                fit: BoxFit.cover, child: SvgPicture.asset(Assets.background)),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 11),
                  child: Row(
                    children: [
                      MyCards(
                        imageAssetPath: Assets.calendar,
                        name: "Calender",
                        onPressed: () {
                          NavigatorHelper.push(const CalendarScreen());
                        },
                      ),
                      MyCards(
                        imageAssetPath: Assets.habit,
                        name: "Habit Tracker",
                        onPressed: () {
                          NavigatorHelper.push(const HabitTrackerScreen());
                        },
                      ),
                      MyCards(
                        imageAssetPath: Assets.finance,
                        name: "Finance",
                        onPressed: () {
                          NavigatorHelper.push(const FinanceScreen());
                        },
                      ),
                      MyCards(
                        imageAssetPath: Assets.studyWork,
                        name: "Study&Work",
                        onPressed: () {
                          NavigatorHelper.push(const LoginScreen());
                        },
                      ),
                    ],
                  ),
                ),
                const CustomTitle(title: "Today Tasks", seeAll: false),
                Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 118,
                    child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        scrollDirection: Axis.horizontal,
                        children: List.generate(5, (int index) {
                          return const TodayTaskCard(task: "Task");
                        }))),
                CustomTitle(title: "Categories", onPressed: () {}),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 120,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                          height: 120,
                          child: Row(
                              children: List.generate(3, (int index) {
                            return Categories(name: "Task", onPressed: () {});
                          }))),
                      Container(
                        height: 120,
                        width: 100,
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Theme.of(context).appColors.white100,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            border: Border.all(
                                color: Theme.of(context).appColors.black16,
                                width: 0.5)),
                        child: MaterialButton(
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.add),
                                const SizedBox(height: 8),
                                Text(
                                  "Add new Category",
                                  style: Theme.of(context).appTexts.bodyMedium
                                      .copyWith(color: Theme.of(context).appColors.black60),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                const CustomTitle(title: "Today Habits", seeAll: false),
                Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 118,
                    child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        scrollDirection: Axis.horizontal,
                        children: List.generate(5, (int index) {
                          return const TodayTaskCard(
                            task: "Habit",
                            isHabit: true,
                          );
                        }))),
                CustomTitle(title: "Today Expenses", onPressed: () {}),
                Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 84,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      scrollDirection: Axis.horizontal,
                      children: List.generate(5, (int index) {
                        return const Expenses(
                          name: "Expense",
                          value: "+60.00",
                          state: true,
                        );
                      })
                    )),
                CustomTitle(title: "Most Visited", onPressed: () {}),
                const Column(
                  children: [
                    most_visited(name: "Me"),
                    most_visited(name: "Gym"),
                    most_visited(name: "Movie"),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Theme.of(context).appColors.white100,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(
                          color: Theme.of(context).appColors.black16,
                          width: 0.5)),
                  child: MaterialButton(
                      padding: const EdgeInsets.all(16),
                      onPressed: () {},
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.add, height: 24, width: 24, color: Theme.of(context).appColors.black87,),
                          const SizedBox(width: 8),
                          Text(
                            "add new item",
                            style: Theme.of(context).appTexts.bodyLarge
                                .copyWith(color: Theme.of(context).appColors.black87),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                ),
                const HomePlaceHolder()
              ],
            ),
          ),
        ]));
  }
}