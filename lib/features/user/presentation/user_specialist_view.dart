import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/utils/caller.dart';

class UserSpecialistView extends StatefulWidget {
  const UserSpecialistView({super.key});

  @override
  State<UserSpecialistView> createState() => _UserSpecialistViewState();
}

class _UserSpecialistViewState extends State<UserSpecialistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.mySpecialties),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.registerSpecialist);
            },
            icon: AppIcons.plusCircle.svg(),
          ),
        ],
      ),
      body: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<UserInfoBloc>().add(GetSpecialistUser());
              await Future.delayed(const Duration(seconds: 1));
            },
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Caller.openPlayStore();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: context.color.white,
                    boxShadow: [
                      BoxShadow(
                        color: context.color.cardShadow,
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: CachedNetworkImageProvider(
                          state.specailistModel[index].org.logo,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ORG: ${state.specailistModel[index].org.name}",
                            ),
                            Text(
                              "${context.l10n.register_firstname}: ${state.specailistModel[index].name} ${state.specailistModel[index].lastname}",
                            ),
                            Text(
                              "${context.l10n.category}: ${state.specailistModel[index].specCat.name}",
                            ),
                            Text(
                              "${context.l10n.job}: ${state.specailistModel[index].job.name}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: state.specailistModel.length,
            ),
          );
        },
      ),
    );
  }
}
