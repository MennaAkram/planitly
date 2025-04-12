import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/graph_View/presentation/view/graph_view_screen.dart';
import 'package:planitly/features/graph_View/presentation/widgets/graph_view.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/calendar.dart';
import 'package:planitly/shared/widgets/fab_button.dart';
import 'package:planitly/shared/widgets/title.dart';
import 'package:planitly/features/calendar/presentation/widgets/dialog.dart';
import 'package:planitly/features/graph_view/presentation/cubit/graph_view_operations.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalendarScreen> {
  final GraphViewOP _graphViewOP = GraphViewOP();
  DateTime? _selectedDate;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _graphViewOP.screenSize = MediaQuery.of(context).size;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _graphViewOP.screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).appColors.background,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const CustomAppBar(title: 'Calender'),
                CalendarWidget(
                  currentDate: _selectedDate!,
                  onDateSelected: (selectedDate) => {
                    setState(() {
                      _selectedDate = selectedDate;
                    }),
                  },
                ),
                _graphViewOP.isEmpty(date: _selectedDate)
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 116),
                        child: Center(
                            child: Column(
                          children: [
                            Image.asset(Assets.calendarPlaceholder),
                            const SizedBox(
                              height: 16,
                            ),
                            Text("Add your first task",
                                style: Theme.of(context)
                                    .appTexts
                                    .bodyLarge
                                    .copyWith(
                                      color:
                                          Theme.of(context).appColors.black87,
                                    ))
                          ],
                        )),
                      )
                    : Column(
                        children: [
                          const CustomTitle(title: 'Connections'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _graphViewOP
                                .getGraphViews(date: _selectedDate)
                                .map((graphView) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  InkWell(
                                    onTap: () => NavigatorHelper.push(
                                        GraphViewScreen(
                                            graphView: graphView.clone())),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      width: double.infinity,
                                      height: 192,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .appColors
                                            .white100,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .appColors
                                                .secondary,
                                            width: 1),
                                      ),
                                      child: GraphViewWidget(
                                          graphNodes: graphView.nodes,
                                          scrollable: false,
                                          scaleable: false),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AddButton(
        onPressed: () async {
          final result = await showDialog<Map<String, String?>>(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomDialog(),
          );
          if (result != null && result["firstItem"] != result["secondItem"]) {
            setState(() {
              _graphViewOP.addRelation(_selectedDate!, result["firstItem"]!,
                  result["secondItem"]!, result["relation"]!);
            });
          }
        },
      ),
    );
  }
}
