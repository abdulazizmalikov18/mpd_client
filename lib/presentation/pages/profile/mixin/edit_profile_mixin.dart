part of '../edit_profile_view.dart';

mixin EditProfileMixin on State<EditProfileView> {
  final ValueNotifier<String?> avatar = ValueNotifier(null);
  late final ValueNotifier<UserModel> user = ValueNotifier(context.read<AccountsBloc>().state.userContainer.user);
  late final UserModel oldUser = context.read<AccountsBloc>().state.userContainer.user;

  void updateUserOnPress() async {
    // $loading.on(context);
    context.read<AccountsBloc>().add(UpdateUserEvent(
          user: UserModel(
            username: user.value.username != oldUser.username ? user.value.username : '',
            name: user.value.name != oldUser.name ? user.value.name : '',
            surname: user.value.surname != oldUser.surname ? user.value.surname : '',
            lastname: user.value.lastname != oldUser.lastname ? user.value.lastname : '',
            email: user.value.email != oldUser.email ? user.value.email : '',
            phone: user.value.phone != oldUser.phone ? user.value.phone : '',
            publicPhone: user.value.publicPhone != oldUser.publicPhone ? user.value.publicPhone : '',
            pinfl: user.value.pinfl != oldUser.pinfl ? user.value.pinfl : '',
            birthday: user.value.birthday != oldUser.birthday ? user.value.birthday : '',
            gender: user.value.gender != oldUser.gender ? user.value.gender : '',
            bio: user.value.bio != oldUser.bio ? user.value.bio : '',
            lang: user.value.lang != oldUser.lang ? user.value.lang : '',
            status: user.value.status != oldUser.status ? user.value.status : -10,
            isRelated: oldUser.isRelated,
            login: user.value.login != oldUser.login ? user.value.login : '',
            region: user.value.region.id != oldUser.region.id ? user.value.region : const DataEntity(),
            mainCat: user.value.mainCat != oldUser.mainCat ? user.value.mainCat : const DataEntity(),
            qrcode: user.value.qrcode != oldUser.qrcode ? user.value.qrcode : '',
            backgroundImage: user.value.backgroundImage != oldUser.backgroundImage ? user.value.backgroundImage : '',
          ),
          avatar: avatar.value,
          onSuccess: () {
            print("succes");
            context.read<AccountsBloc>().add(GetAccountUserEvent(
                  onSuccess: () {
                    // $loading.off(context);

                    context.pop();
                  },
                  onError: (errorMessage) {
                    // $loading.off(context);
                  },
                ));
          },
          onError: (errorMessage) {
            print("error");
            // $loading.off(context);
          },
        ));
    await Future.delayed(const Duration(seconds: 3));
  }

  void pickImageBottomSheet() {
    showModalBottomSheet(
      backgroundColor: white,
      elevation: 0,
      context: context,
      builder: (context) {
        return WBottomSheet(
          title: 'Avatar yuk-lash',
          child: Column(
            children: [
              const SizedBox(height: 24),
              WShadowedItemContainer(
                title: 'Сфотографировать',
                icon: '', //AppIcons.camera,
                onTap: () async {
                  final result = await ImagePicker().pickImage(source: ImageSource.camera);
                  if (result != null) {
                    avatar.value = result.path;
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              WShadowedItemContainer(
                title: 'Из галареии',
                icon: '',//AppIcons.folderAdd,
                onTap: () async {
                  final result = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (result != null) {
                    avatar.value = result.path;
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onPressedSelectSpecialist() {
    context.read<AccountsBloc>().add(const GetProfession());
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const WSelectProfessionSheet();
      },
    ).then((value) {
      if (value is MapEntry<int, String>) {
        user.value = user.value.copyWith(
          mainCat: DataEntity(id: value.key, name: value.value),
        );
      }
    });
  }

  void onPressedSelectAddress() {
    context.read<AccountsBloc>().add(const GetRegion());
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const WSelectRegionBottomSheet();
      },
    ).then((value) {
      if (value is MapEntry<int, String>) {
        user.value = user.value.copyWith(
          region: DataEntity(id: value.key, name: value.value),
        );
      }
    });
  }
}
