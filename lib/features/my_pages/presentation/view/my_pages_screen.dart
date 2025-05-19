import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/my_pages/presentation/widgets/my_pages_card.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import 'package:planitly/shared/widgets/fab_button.dart';
import 'package:planitly/shared/widgets/text_field.dart';

class MyPagesScreen extends StatefulWidget {
  const MyPagesScreen({super.key});

  @override
  State<MyPagesScreen> createState() => _MyPagesScreenState();
}

class _MyPagesScreenState extends State<MyPagesScreen> {
  final myPages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(title: AppLocalizations.current.myPages),
      body: myPages.isEmpty ? _myPagesPlaceholder() : _myPagesList(),
      floatingActionButton: AddButton(onPressed: () => _openAddPageDialog()),
    );
  }

  Container _myPagesPlaceholder() {
    return Container(
      color: Theme.of(context).appColors.background,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.myPagesPlaceholder,
              width: 200,
              height: 149,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.current.noPagesFound,
              style: Theme.of(context).appTexts.bodyLarge.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Container _myPagesList() {
    return Container(
      color: Theme.of(context).appColors.background,
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: myPages.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 154,
          mainAxisExtent: 125,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return MyPagesCard(name: myPages[index]);
        },
      ),
    );
  }

  void _openAddPageDialog() {
    final nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    context.alertDialog(
      AppLocalizations.current.addNewPage,
      AppLocalizations.current.add,
      AppLocalizations.current.cancel,
      () {
        if (formKey.currentState?.validate() ?? false) {
          setState(() {
            myPages.add(nameController.text);
          });
          NavigatorHelper.pop();
        }
      },
      () => Navigator.of(context).pop(),
      Form(
        key: formKey,
        child: CustomTextField(
          labelText: AppLocalizations.current.pageName,
          controller: nameController,
          validator: (value) => Validators.cantBeEmpty(value),
        ),
      ),
    );
  }
}
