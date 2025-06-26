import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/categories/domain/entity/category_entity.dart';
import 'package:planitly/features/category/presentation/cubit/category_cubit.dart';
import 'package:planitly/features/my_pages/presentation/widgets/custom_card.dart';
import 'package:planitly/features/subject/presentation/view/subject_screen.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import 'package:planitly/shared/widgets/fab_button.dart';
import 'package:planitly/shared/widgets/text_field.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryEntity category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryCubit _cubit = getIt.get<CategoryCubit>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _shouldScrollOnAdd = false;

  @override
  void initState() {
    _cubit.getCategoryInfo(categoryName: widget.category.name, initial: true);
    _scrollController.addListener(_onScroll);
    super.initState();
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
      _cubit.getCategoryInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(title: widget.category.name),
      body: BlocListener<CategoryCubit, BaseState>(
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
        child: BlocBuilder<CategoryCubit, BaseState>(
          bloc: _cubit,
          builder: (context, state) {
            if (_cubit.pages.isEmpty && (_cubit.isLoading || _cubit.isAdding)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_cubit.pages.isEmpty) {
              return _buildPlaceholder();
            }
            return _buildGrid();
          },
        ),
      ),
      floatingActionButton: AddButton(onPressed: () => _openAddPageDialog()),
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
            AppLocalizations.current.noPagesFound,
            style: Theme.of(context).appTexts.bodyLarge.copyWith(
                  color: Theme.of(context).appColors.black87,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container _buildGrid() {
    final addSlot = _cubit.isAdding ? 1 : 0;
    final moreSlot = _cubit.hasMore ? 1 : 0;
    final itemCount = addSlot + _cubit.pages.length + moreSlot;

    return Container(
      color: Theme.of(context).appColors.background,
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
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

          if ((index - addSlot) < _cubit.pages.length) {
            return CustomCard(
              name: _cubit.pages[index - addSlot].name,
              onClick: () => NavigatorHelper.push(SubjectScreen(
                page: _cubit.pages[index - addSlot],
              )),
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
    context.alertDialog(
      AppLocalizations.current.addNewPage,
      AppLocalizations.current.add,
      AppLocalizations.current.cancel,
      () {
        if (formKey.currentState?.validate() ?? false) {
          _shouldScrollOnAdd = true;
          _cubit.addPageToCategory(pageName: nameController.text.trim());
          NavigatorHelper.pop();
          nameController.clear();
        }
      },
      () => Navigator.of(context).pop(),
      Form(
        key: formKey,
        child: CustomTextField(
          labelText: AppLocalizations.current.pageName,
          controller: nameController,
          validator: Validators.cantBeEmpty,
        ),
      ),
    );
  }
}
