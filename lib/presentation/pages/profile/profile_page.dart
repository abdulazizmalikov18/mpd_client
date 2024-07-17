import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/common/token_ext.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/expandable_column.dart';
import 'package:orient_motors/presentation/pages/auth/auth_dialog.dart';
import 'package:orient_motors/presentation/pages/home/home_menu/comp/login_comp.dart';
import 'package:orient_motors/presentation/pages/profile/comp/profile_other_comp.dart';
import 'package:orient_motors/presentation/pages/profile/comp/your_balance_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';

import '../../styles/theme_wrapper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(1.sw, 160.h),
                child: Column(
                  children: [
                    Container(
                      color: colors.white,
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Expanded(
                      child: ColoredBox(
                        color: colors.white,
                        child: LoggedInComp(
                          isProfile: true,
                          onTap: () {
                            checkTokenDialog(context, () {
                              Navigator.push(
                                  context, AppRoutes.getEditProfile(context));
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: colors.white,
              body: state.profileParam == null
                  ? ScrollColumnExpandable(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      children: const [
                        Expanded(child: OtherProfileWidget()),
                      ],
                    )
                  : ListView(
                      children: [
                        if (context.read<DBService>().token.toToken.isNotEmpty)
                          const YourBalanceComp(),
                        const ProfileOtherComp(),
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}
