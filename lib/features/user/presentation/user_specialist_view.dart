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
  Widget _statusChip(BuildContext context, String? status) {
    final isPending = status == '0';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isPending
            ? context.color.orange.withValues(alpha: .12)
            : context.color.green.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPending ? context.color.orange : context.color.green,
          width: 1,
        ),
      ),
      child: Text(
        isPending
            ? context.l10n.specialist_status_pending
            : context.l10n.specialist_status_approved,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isPending ? context.color.orange : context.color.green,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage:
                            state.specailistModel[index].avatar.isNotEmpty
                            ? CachedNetworkImageProvider(
                                state.specailistModel[index].avatar,
                              )
                            : null,
                        backgroundColor: context.color.border,
                        child: state.specailistModel[index].avatar.isEmpty
                            ? Icon(Icons.person, color: context.color.white)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${state.specailistModel[index].name} ${state.specailistModel[index].lastname}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _statusChip(
                                  context,
                                  state.specailistModel[index].status,
                                ),
                              ],
                            ),

                            Text(
                              state.specailistModel[index].org.name,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: context.color.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${context.l10n.category}: ${state.specailistModel[index].specCat.name}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: context.color.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${context.l10n.job}: ${state.specailistModel[index].job.name}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: context.color.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
