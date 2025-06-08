import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:planitly/features/my_pages/domain/entity/page_entity.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/drop_down_list.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'package:planitly/features/categories/presentation/widgets/selected_page.dart';

class AddCategoryDialog extends StatefulWidget {
  final CategoriesCubit categoriesCubit;
  final TextEditingController nameController;
  final GlobalKey<FormState> formKey;

  const AddCategoryDialog({
    super.key,
    required this.categoriesCubit,
    required this.nameController,
    required this.formKey,
  });

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.categoriesCubit.getUncategorizedPages(initial: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNameField(),
        _buildSelectPagesSection(),
      ],
    );
  }

  Form _buildNameField() {
    return Form(
      key: widget.formKey,
      child: CustomTextField(
        labelText: AppLocalizations.current.categoryName,
        controller: widget.nameController,
        validator: Validators.cantBeEmpty,
      ),
    );
  }

  BlocBuilder<CategoriesCubit, BaseState> _buildSelectPagesSection() {
    return BlocBuilder<CategoriesCubit, BaseState>(
      bloc: widget.categoriesCubit,
      builder: (context, state) {
        final pages = widget.categoriesCubit.uncategorizedPages;

        if (state is ErrorState) {
          context.showCustomSnackBar(state.msg!);
          return const SizedBox.shrink();
        }

        if (state is LoadingState && pages.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const CircularProgressIndicator(),
          );
        }

        if (pages.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              AppLocalizations.current.addPages,
              style: Theme.of(context).appTexts.labelSmall.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
            ),
            const SizedBox(height: 8),
            _buildDropDownList(pages),
            _buildSelectedPagesChips(),
          ],
        );
      },
    );
  }

  DropDownList _buildDropDownList(List<PageEntity> pages) {
    return DropDownList(
      hintText: AppLocalizations.current.selectPages,
      menuItems: pages.map((e) => e.name).toList(),
      scrollController: _scrollController,
      isLoading: widget.categoriesCubit.isUncategorizedLoading,
      onItemSelected: (pageName) {
        if (!widget.categoriesCubit.selectedPages
            .any((page) => page.name == pageName)) {
          if (widget.categoriesCubit.selectedPages.length >= 10) {
            context.showCustomSnackBar(
              AppLocalizations.current.maxPagesSelected,
            );
          } else {
            widget.categoriesCubit.selectPage(
              widget.categoriesCubit.uncategorizedPages
                  .firstWhere((page) => page.name == pageName),
            );
          }
        }
      },
      onScrollEnd: () {
        if (widget.categoriesCubit.hasUncategorizedMore) {
          widget.categoriesCubit.getUncategorizedPages();
        }
      },
    );
  }

  BlocBuilder<CategoriesCubit, BaseState<dynamic>> _buildSelectedPagesChips() {
    return BlocBuilder<CategoriesCubit, BaseState>(
        bloc: widget.categoriesCubit,
        builder: (context, state) {
          final selectedPages = widget.categoriesCubit.selectedPages;

          if (selectedPages.isEmpty) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedPages
                      .map((page) => SelectedPage(
                            itemName: page.name,
                            onRemove: () =>
                                widget.categoriesCubit.unselectPage(page),
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        });
  }
}
