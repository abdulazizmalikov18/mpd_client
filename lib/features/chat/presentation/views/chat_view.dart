import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/app_images.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/pagination/presentation/paginator_list.dart';
import 'package:mpd_client/features/chat/presentation/bloc/chat_group/chat_group_bloc.dart';
import 'package:mpd_client/features/chat/presentation/views/in_app_chat.dart';
import 'package:mpd_client/features/chat/presentation/widgets/w_user_chat_button.dart';
import 'package:mpd_client/src/widgets/w_shimmer.dart';
import 'package:mpd_client/src/widgets/w_text_field.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.color.white,
      appBar: AppBar(
        title: Text(context.l10n.chat),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 52),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: WTextField(
              onChanged: (searchText) {
                context.read<ChatGroupBloc>().add(
                  ChatGroupSearchEvent(search: searchText),
                );
              },
              fillColor: background,
              borderColor: Colors.transparent,
              prefixIcon: AppIcons.search.svg(color: context.color.grey),
              hintText: context.l10n.search,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: context.color.black,
              ),
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: context.color.grey,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<ChatGroupBloc, ChatGroupState>(
        builder: (context, state) {
          if (state.status.isInProgress) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return const WShimmer(
                  width: double.infinity,
                  height: 60,
                  radius: 0,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 2);
              },
              itemCount: 100,
            );
          }
          if (state.groups.isEmpty) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  Image.asset(AppImages.chatNotFound),
                  const SizedBox(height: 32),
                  Text(
                    'Chat Not Found',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The page you are looking\nfor doesn’t exits',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: context.color.grey,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          }
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<ChatGroupBloc>().add(const ChatGetGroupEvent());
            },
            child: PaginatorList(
              paginatorStatus: state.status,
              padding: EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) => DecoratedBox(
                decoration: BoxDecoration(
                  color: state.groups[index].unreadMessageCount != 0
                      ? null
                      : context.color.background,
                ),
                child: WUserChatButton(
                  onTap: () {
                    final bloc = context.read<UserInfoBloc>();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: bloc,
                          child: InChatView(group: state.groups[index]),
                        ),
                      ),
                    );
                  },
                  group: state.groups[index],
                ),
              ),
              itemCount: state.groups.length,
              fetchMoreFunction: () {},
              hasMoreToFetch: false,
            ),
          );
        },
      ),
    );
  }
}
