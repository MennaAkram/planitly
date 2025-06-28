import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/features/calendar/presentation/view/calendar_screen.dart';
import 'package:planitly/features/categories/presentation/view/categories_screen.dart';
import 'package:planitly/features/finance/presentation/view/finance_screen.dart';
import 'package:planitly/features/habit/presentation/view/habit_screen.dart';
import 'package:planitly/features/home_screen/presentation/cubit/home_cubit.dart';
import 'package:planitly/features/home_screen/presentation/widgets/template_card.dart';
import 'package:planitly/features/my_pages/presentation/view/my_pages_screen.dart';
import 'package:planitly/features/notifications/presentation/view/notifications_screen.dart';
import 'package:planitly/features/home_screen/presentation/widgets/cards.dart';
import 'package:planitly/features/home_screen/presentation/widgets/categories.dart';
import 'package:planitly/features/home_screen/presentation/widgets/expenses.dart';
import 'package:planitly/features/home_screen/presentation/widgets/homePlaceholder.dart';
import 'package:planitly/features/home_screen/presentation/widgets/home_appbar.dart';
import 'package:planitly/features/home_screen/presentation/widgets/most_visited.dart';
import 'package:planitly/features/home_screen/presentation/widgets/today_task_card.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import 'package:planitly/shared/widgets/title.dart';

import '../../../../generated/l10n.dart';
import '../../../../shared/bases/base_state.dart';
import '../../../../shared/validators.dart';
import '../../../../shared/widgets/text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _shouldScrollOnAdd = false;
  final HomeCubit _cubit = getIt.get<HomeCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.getData();
  }

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
        body: BlocBuilder<HomeCubit, BaseState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return Stack(children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Theme.of(context).appColors.white100,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: SvgPicture.asset(Assets.background)),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 11),
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
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    _buildPagesSection(context, _cubit),
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
                    if (_cubit.recentCategories.isNotEmpty)
                    _buildCategoriesSection(context, _cubit),
                    _buildTemplatesSection(context, _cubit),
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
                            }))),
                    const HomePlaceHolder()
                  ],
                ),
              ),
            ]);
          },
        ));
  }

  void _openAddPageDialog() {
    context.alertDialog(
      AppLocalizations.current.addNewPage,
      AppLocalizations.current.add,
      AppLocalizations.current.cancel,
          () {
        if (formKey.currentState?.validate() ?? false) {
          _shouldScrollOnAdd = true;
          _cubit.addPage(
              name: nameController.text,
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              category: '',
              template: '',
              timesVisited: 0,
              lastVisited: DateTime.now());
          nameController.clear();
          NavigatorHelper.pop();
        }
      },
          () => Navigator.of(context).pop(),
      Form(
        key: formKey,
        child: CustomTextField(
          labelText: AppLocalizations.current.pageName,
          controller: nameController,
          validator: Validators.cantBeEmpty,
        ),
      ),
    );
  }

  Widget _buildAddNewItemButton(BuildContext context, String text, VoidCallback onPressed,
      {double aspectRatio = 4 / 5}) {
  return AspectRatio(
    aspectRatio: aspectRatio,
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Theme.of(context).appColors.white100,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border:
              Border.all(color: Theme.of(context).appColors.black16, width: 0.5)),
      child: MaterialButton(
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.add),
              const SizedBox(height: 4),
              Text(
                text,
                style: Theme.of(context)
                    .appTexts
                    .bodyMedium
                    .copyWith(color: Theme.of(context).appColors.black60),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    ),
  );
}

  Widget _buildPagesSection(BuildContext context, HomeCubit _cubit) {

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_shouldScrollOnAdd && _scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        _shouldScrollOnAdd = false;
      }
    });

    return Column(
      children: [
        CustomTitle(
          title: "My Pages",
          onPressed: () => NavigatorHelper.push(MyPagesScreen()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cubit.mostVisitedSubjects.length + 1,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 154,
              mainAxisExtent: 125,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              if (index < _cubit.mostVisitedSubjects.length) {
                final subject = _cubit.mostVisitedSubjects[index];
                return most_visited(
                  name: subject.name,
                  onPressed: () {},
                );
              } else {
                return _buildAddNewItemButton(
                  context,
                  "Add new page",
                  _openAddPageDialog,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(BuildContext context, HomeCubit _cubit) {
  return Column(
    children: [
      CustomTitle(
          title: "Categories",
          onPressed: () {
            NavigatorHelper.push(const CategoriesScreen());
          }),
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 125,
        child: ListView(
          padding:
          const EdgeInsets.symmetric(horizontal: 11),
          scrollDirection: Axis.horizontal,
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _cubit.recentCategories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final subject = _cubit.recentCategories[index];
                return Categories(
                    name: subject.name, onPressed: () {});
              },
            ),
            _buildAddNewItemButton(context, "Add new category", (){}),
          ],
        ),
      ),
    ],
  );
}

  Widget _buildTemplatesSection(BuildContext context, HomeCubit _cubit) {
    return Column(
      children: [
        CustomTitle(
            title: "Templates",
            onPressed: () {

            }),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 85,
          child: ListView(
            padding:
            const EdgeInsets.symmetric(horizontal: 11),
            scrollDirection: Axis.horizontal,
            children: [
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _cubit.predefinedTemplate.length + _cubit.customTemplate.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final template = _cubit.allTemplates()[index];
                  return TemplateCard(
                      name: template.name, onPressed: () {});
                },
              ),
              _buildAddNewItemButton(context, "Add custom", (){}, aspectRatio: 4/3),
            ],
          ),
        ),
      ],
    );
  }

}


