import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/card.dart';
import 'package:planitly/features/Notifications/presentation/cubit/notification_operations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationsOP _notificationsOP = NotificationsOP();

  @override
  void initState() {
    Map<DateTime, String> notificationsData = {
      DateTime(2025, 7, 10):
          '"Summer Music and Arts Festival Brings Vibrant Performances to the City"',
      DateTime(2025, 8, 25):
          '"Farmers\' Market Opens at Downtown Plaza with Fresh Local Produce"',
      DateTime(2025, 9, 5):
          '"City Park Hosts Annual Charity Run to Support Local Animal Shelters"',
      DateTime(2025, 10, 18):
          '"Tech Conference on Innovations in AI and Robotics Comes to Town"',
      DateTime(2025, 11, 12):
          '"Food Truck Festival Offers Culinary Delights from Around the World"',
      DateTime(2025, 12, 1):
          '"Winter Wonderland Holiday Fair Kicks Off with Ice Skating and Festive Stalls"',
      DateTime(2026, 1, 15):
          '"City\'s First Indoor Climbing Gym Opens with State-of-the-Art Facilities"',
      DateTime(2026, 2, 20):
          '"Community Garden Opens to Encourage Sustainable Urban Farming"',
      DateTime(2025, 6, 2):
          '"Music Festival Featuring Emerging Artists Takes Place in City Square"',
      DateTime(2025, 4, 17):
          '"Volunteer Cleanup Event Planned to Beautify Local Riverbank"',
      DateTime(2025, 3, 9):
          '"City Library Launches Reading Program for Children to Foster Love for Books"',
      DateTime(2025, 1, 28):
          '"Art Exhibition Showcasing Local Artists\' Work Opens at Community Gallery"',
      DateTime(2024, 12, 12):
          '"Local Park Hosts Outdoor Yoga Sessions for Stress Relief and Mindfulness"',
      DateTime(2024, 11, 5):
          '"Popular Cafe Introduces Vegan Menu Options to Cater to Diverse Customers"',
      DateTime(2024, 9, 21):
          '"New Gym Opens in Downtown Area with State-of-the-Art Equipment"',
      DateTime(2024, 6, 15):
          '"Local Community Center Offers Free Cooking Classes for Families"',
    };
    notificationsData.forEach((date, text) {
      _notificationsOP.addNotification(text, date: date);
    });
    super.initState();
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
                const CustomAppBar(title: 'Notifications'),
                const SizedBox(height: 16),
                _notificationsOP.isEmpty()
                    ? const Center(child: Text('No notifications'))
                    : Column(
                        children: _notificationsOP
                            .getNotifications()
                            .map((notification) => CardWidget(
                                  icon: notification.icon,
                                  text: notification.text,
                                  date: notification.getDate(),
                                  type: Notify,
                                ))
                            .toList(),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
