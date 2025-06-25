import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/emails/domain/entity/email_entity.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/di.dart';
import '../cubit/emails_cubit.dart';

class EmailDetailScreen extends StatefulWidget {
  final EmailEntity email ;
   EmailDetailScreen({super.key, required this.email});

  @override
  State<EmailDetailScreen> createState() => _EmailDetailScreenState();
}

class _EmailDetailScreenState extends State<EmailDetailScreen> {
  late final WebViewController _controller;
  EmailEntity get email => widget.email;
  final _cubit = getIt<EmailsCubit>();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadHtmlString(widget.email.fullBody ?? widget.email.snippet);
  }

  @override
  Widget build(BuildContext context) {
    print('EmailDetailScreen: ${email.fullBody}');
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              email.subject,
              style: Theme.of(context).appTexts.titleSmall.copyWith(
                color: Theme.of(context).appColors.black87,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: _cubit.colorFromEmail(email.senderEmail),
                  child: Text(
                    _cubit.getInitials(email.sender),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded( // <-- Add this
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(email.sender,
                          style: Theme.of(context).appTexts.labelLarge.copyWith(
                            color: Theme.of(context).appColors.black87,
                          ),
                          overflow: TextOverflow.ellipsis),
                      Text(email.senderEmail,
                          style: Theme.of(context).appTexts.bodySmall.copyWith(
                            color: Theme.of(context).appColors.black60,
                          ),
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 8),
                      Text(email.date,
                          style: Theme.of(context).appTexts.labelMedium.copyWith(
                            color: Theme.of(context).appColors.black60,
                          ),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: WebViewWidget(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }
}