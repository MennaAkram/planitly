import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/widgets/button.dart';
import '../../../../app/di.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/bases/base_state.dart';
import '../../../../shared/widgets/card.dart';
import '../cubit/emails_cubit.dart';
import 'email_details.dart';

class EmailsScreen extends StatefulWidget {
  const EmailsScreen({super.key});

  @override
  State<EmailsScreen> createState() => _EmailsScreenState();
}

class _EmailsScreenState extends State<EmailsScreen> {
  final _cubit = getIt<EmailsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.checkIfSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).appColors.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<EmailsCubit, BaseState>(
            bloc: _cubit,
            builder: (context, state) {
              // Show loading only before we've checked sign-in
              if (!_cubit.hasCheckedSignIn || state is LoadingState || state is InitState) {
                return const Center(child: CircularProgressIndicator());
              }

              // Show sign-in prompt ONLY if user is not signed in
              if (!_cubit.isSignedIn) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(49.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.current.emailsHint,
                          style: Theme.of(context).appTexts.labelLarge.copyWith(
                            color: Theme.of(context).appColors.black60,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: AppLocalizations.current.signInGoogle,
                          onPressed: () async {
                            await _cubit.handleSignIn();
                          },
                          outlined: false,
                        ),
                      ],
                    ),
                  ),
                );
              }

              // If signed in but no emails
              if (_cubit.emails.isEmpty) {
                return const Center(child: Text("No emails found."));
              }

              // Show emails
              return ListView.builder(
                itemCount: _cubit.emails.length,
                itemBuilder: (context, index) {
                  final email = _cubit.emails[index];
                  return CardWidget(
                    type: 'Email',
                    text: email.subject,
                    date: email.date,
                    icon: email.gravatarUrl,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailDetailScreen(email: email),
                        ),
                      );
                    },
                    initialsColor: _cubit.colorFromEmail(email.senderEmail),
                    initials: _cubit.getInitials(email.sender),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
