import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class EmailsScreen extends StatefulWidget {
  const EmailsScreen({super.key});

  @override
  State<EmailsScreen> createState() => _EmailsScreenState();
}

class _EmailsScreenState extends State<EmailsScreen> {
  @override
  void initState() {
    [
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/adobe_photoshop.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/slack.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/google_drive.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/ms_powerpoint.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/tinder.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/adobe_photoshop.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/slack.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/google_drive.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/ms_powerpoint.svg',
        'date': DateTime(2024, 6, 15),
      },
      {
        'text':
            '"Local Community Center Offers Free Cooking Classes for Families"',
        'icon': 'assets/icons/tinder.svg',
        'date': DateTime(2024, 6, 15),
      },
    ].reversed.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).appColors.background,
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 32.0, bottom: 8),
              child: const Center(
                child: Text('No emails yet'),
              )),
        ),
      ),
    );
  }
}
