import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();
  final NotificationsCubit _cubit = getIt.get<NotificationsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.getNotifications(initial: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.7 &&
        !_cubit.isLoading &&
        _cubit.hasMore) {
      _cubit.getNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NotificationsCubit, BaseState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ErrorState) {
            if (state.msg != "Token has expired") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.msg!,
                      style: Theme.of(context).appTexts.bodySmall.copyWith(
                            color: Theme.of(context).appColors.red,
                          )),
                  backgroundColor: Theme.of(context).appColors.white100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(24),
                ),
              );
            }
          }
        },
        child: Container(
          color: Theme.of(context).appColors.background,
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const CustomAppBar(title: 'Notifications'),
                const SizedBox(height: 8),
                Expanded(
                  child: BlocBuilder<NotificationsCubit, BaseState>(
                    bloc: _cubit,
                    builder: (context, state) {
                      if (state is LoadingState || state is InitState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ErrorState) {
                        return const Center(
                          child: Text('Error loading notifications'),
                        );
                      } else {
                        if (_cubit.notifications.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                      Assets.notificationPlaceholder),
                                  width: 200,
                                  height: 200,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No notifications found',
                                  style: Theme.of(context)
                                      .appTexts
                                      .bodyLarge
                                      .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .black87),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: _cubit.notifications.length +
                                (_cubit.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == _cubit.notifications.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              final notification = _cubit.notifications[index];
                              return CardWidget(
                                icon: Assets.notificationCircularOutline,
                                text: notification.message,
                                date: notification.created_at,
                                type: 'Notify',
                              );
                            });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
