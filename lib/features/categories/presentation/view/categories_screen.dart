import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:planitly/features/categories/presentation/widgets/add_category_dialog.dart';
import 'package:planitly/features/category/presentation/view/category_screen.dart';
import 'package:planitly/features/my_pages/presentation/widgets/custom_card.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import 'package:planitly/shared/widgets/fab_button.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesCubit _cubit = getIt.get<CategoriesCubit>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _shouldScrollOnAdd = false;

  @override
  void initState() {
    super.initState();
    _cubit.getCategories(initial: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    nameController.dispose();
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onScroll() {
    final threshold = _scrollController.position.maxScrollExtent * 0.7;
    if (_scrollController.position.pixels >= threshold &&
        !_cubit.isLoading &&
        _cubit.hasMore) {
      _cubit.getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(title: AppLocalizations.current.categories),
      body: BlocListener<CategoriesCubit, BaseState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ErrorState && state.msg != "Token has expired") {
            context.showCustomSnackBar(state.msg!);
          } else if (state is DoneState && _shouldScrollOnAdd) {
            _shouldScrollOnAdd = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            });
          }
        },
        child: BlocBuilder<CategoriesCubit, BaseState>(
          bloc: _cubit,
          builder: (context, state) {
            if (_cubit.categories.isEmpty &&
                (_cubit.isLoading || _cubit.isAdding)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_cubit.categories.isEmpty) {
              return _buildPlaceholder();
            }

            return _buildGrid();
          },
        ),
      ),
      floatingActionButton: AddButton(onPressed: _openAddPageDialog),
    );
  }

  Center _buildPlaceholder() {
    return Center(
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
            AppLocalizations.current.noCategoriesFound,
            style: Theme.of(context).appTexts.bodyLarge.copyWith(
                  color: Theme.of(context).appColors.black87,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final addSlot = _cubit.isAdding ? 1 : 0;
    final moreSlot = _cubit.hasMore ? 1 : 0;
    final itemCount = addSlot + _cubit.categories.length + moreSlot;

    return Container(
      color: Theme.of(context).appColors.background,
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        key: const PageStorageKey('categoriesGrid'),
        controller: _scrollController,
        itemCount: itemCount,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 154,
          mainAxisExtent: 125,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          if (_cubit.isAdding && index == 0) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if ((index - addSlot) < _cubit.categories.length) {
            return CustomCard(
              name: _cubit.categories[index - addSlot].name,
              onClick: () => NavigatorHelper.push(
                  CategoryScreen(category: _cubit.categories[index - addSlot])),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _openAddPageDialog() {
    context.alertDialog(AppLocalizations.current.addNewCategory,
        AppLocalizations.current.add, AppLocalizations.current.cancel, () {
      if (formKey.currentState?.validate() ?? false) {
        _shouldScrollOnAdd = true;
        _cubit.addCategory(name: nameController.text.trim());
        nameController.clear();
        _cubit.selectedPages.clear();
        NavigatorHelper.pop();
      }
    }, () {
      nameController.clear();
      _cubit.selectedPages.clear();
      Navigator.of(context).pop();
    },
        AddCategoryDialog(
          categoriesCubit: _cubit,
          formKey: formKey,
          nameController: nameController,
        ));
  }
}
