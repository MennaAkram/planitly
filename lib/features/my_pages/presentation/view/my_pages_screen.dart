import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/my_pages/presentation/cubit/pages_cubit.dart';
import 'package:planitly/features/my_pages/presentation/widgets/my_pages_card.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
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
  final nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  final PagesCubit _cubit = getIt.get<PagesCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.getPages(initial: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    nameController.dispose();
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  _onScroll() {
    if (_scrollController.position.pixels >=
            (_scrollController.position.maxScrollExtent * 0.7) &&
        !_cubit.isLoading &&
        _cubit.hasMore) {
      _cubit.getPages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(title: AppLocalizations.current.myPages),
      body: BlocBuilder<PagesCubit, BaseState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is ErrorState && state.msg != "Token has expired") {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.msg!,
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                          color: Theme.of(context).appColors.red,
                        ),
                  ),
                  backgroundColor: Theme.of(context).appColors.white100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(24),
                ),
              );
            });
          }
          if (_cubit.pages.isEmpty && _cubit.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return _cubit.pages.isEmpty
              ? _myPagesPlaceholder()
              : _myPagesList(); 
        },
      ),
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
        controller: _scrollController,
        itemCount: _cubit.pages.length + (_cubit.hasMore ? 1 : 0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 154,
          mainAxisExtent: 125,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          if (index < _cubit.pages.length) {
            return MyPagesCard(name: _cubit.pages[index].name);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _openAddPageDialog() {
    context.alertDialog(
      AppLocalizations.current.addNewPage,
      AppLocalizations.current.add,
      AppLocalizations.current.cancel,
      () {
        if (formKey.currentState?.validate() ?? false) {
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
