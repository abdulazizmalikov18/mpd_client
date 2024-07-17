import 'package:dwed_client/core/utils/debouncer.dart';
import 'package:dwed_client/features/common/view/w_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/auth/presentation/controller/registration_view_model.dart';
import 'package:dwed_client/features/auth/presentation/widgets/sheets/profession_list.dart';
import 'package:dwed_client/features/common/widgets/dialog_title.dart';
import 'package:dwed_client/features/common/widgets/w_textfield.dart';
import 'package:dwed_client/features/profile/presentation/controller/accounts/accounts_bloc.dart';

class WSelectProfessionSheet extends StatefulWidget {
  const WSelectProfessionSheet({super.key});

  @override
  State<WSelectProfessionSheet> createState() => _WSelectProfessionSheetState();
}

class _WSelectProfessionSheetState extends State<WSelectProfessionSheet> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    context.read<AccountsBloc>().add(const GetProfession());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WBackground(
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<AccountsBloc, AccountsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const DialogTitle(title: "Mutaxasligingizni tanlang "),
                          const SizedBox(height: 16),
                          WTextField(
                            style: context.textTheme.bodyLarge.copyWith(
                              color: white,
                            ),
                            onChanged: (value) {
                              Debouncer(milliseconds: 300).run(
                                () {
                                  context.read<AccountsBloc>().add(GetProfession(search: value));
                                },
                              );
                            },
                            hintText: "Search",
                            borderColor: borderColor,
                            fillColor: white.withOpacity(0.2),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: AppIcons.icHome.svg(color: gray),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if ($regVM().professionList.isNotEmpty)
                            InkWell(
                              onTap: () {
                                if (controller.hasClients) {
                                  controller.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                }
                                $regVM().selectPagProffesion(context, 0, "", 0);
                                setState(() {});
                              },
                              child: Container(
                                height: 24,
                                margin: const EdgeInsets.only(bottom: 16),
                                child: const Icon(
                                  Icons.arrow_left,
                                  color: black,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 460,
                      child: PageView(
                        controller: controller,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ProfessionListView(
                            profession: state.regionAndProfessionContainer.profession,
                            controller: controller,
                            index: 1,
                            isLoading: state.regionAndProfessionContainer.statusd.isInProgress,
                          ),
                          ProfessionListView(
                            profession: state.regionAndProfessionContainer.profession2,
                            controller: controller,
                            index: 2,
                            isLoading: state.regionAndProfessionContainer.statusd.isInProgress,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
