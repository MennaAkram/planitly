import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Emails/presentation/cubit/email_operations.dart';
import 'package:planitly/shared/widgets/card.dart';

class EmailsScreen extends StatefulWidget {
  const EmailsScreen({super.key});

  @override
  State<EmailsScreen> createState() => _EmailsScreenState();
}

class _EmailsScreenState extends State<EmailsScreen> {
  final EmailsOP _emailsOP = EmailsOP();

  @override
  void initState() {
    List<Map<String, dynamic>> emails = [
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

    for (var email in emails) {
      _emailsOP.addEmail(
        email['text'],
        icon: email['icon'],
        date: email['date'],
      );
    }

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
                left: 16.0, right: 16.0, top: 58.0, bottom: 8),
            child: _emailsOP.isEmpty()
                ? const Center(
                    child: Text('No emails yet'),
                  )
                : Column(
                    children: _emailsOP.getEmails().map((email) {
                      return CardWidget(
                          icon: email.icon,
                          text: email.text,
                          date: email.getDate(),
                          type: Email);
                    }).toList(),
                  ),
          ),
        ),
      ),
    );
  }
}
