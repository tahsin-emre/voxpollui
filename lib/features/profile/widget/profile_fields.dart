part of '../view/profile_view.dart';

final class _ProfileImageHeader extends StatelessWidget {
  const _ProfileImageHeader(this.user, {required this.hasAppBar});
  final UserModel user;
  final bool hasAppBar;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Image.network(
              user.imageUrl ?? 'https://picsum.photos/200',
              width: double.infinity,
              height: WidgetSizes.maxiL,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: WidgetSizes.x4L),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColor.black,
              backgroundImage:
                  user.imageUrl != null ? NetworkImage(user.imageUrl!) : null,
              child: user.imageUrl == null
                  ? IconConstants.profile
                      .toCustomIcon(size: 64, color: AppColor.secondary)
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}

final class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo(this.user, {required this.pollCount});
  final UserModel user;
  final num pollCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          user.name ?? '',
          style: TextStyle(
            fontSize: 28,
            fontFamily: FontConstants.gilroyBold,
          ),
        ),
        Text(
          '@${user.userName}',
          style: TextStyle(
            fontSize: 16,
            color: AppColor.opposite,
            fontFamily: FontConstants.gilroySemibold,
          ),
        ),
        Text(
          user.description ?? '',
          style: TextStyle(
            fontSize: 16,
            color: AppColor.black,
            fontFamily: FontConstants.gilroyRegular,
          ),
        ),
        const SizedBox(height: WidgetSizes.xl),
        Row(
          children: [
            _InfoBox(
              title: LocaleKeys.profile_following.tr(),
              value: user.followingCount,
            ),
            _InfoBox(
              title: LocaleKeys.profile_followers.tr(),
              value: user.followersCount,
            ),
            _InfoBox(
              title: LocaleKeys.profile_pollCount.tr(),
              value: pollCount,
            ),
          ],
        ),
        const SizedBox(height: WidgetSizes.l),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.title, required this.value});
  final String title;
  final num value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontFamily: FontConstants.gilroyRegular,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 20,
              fontFamily: FontConstants.gilroyBold,
            ),
          ),
        ],
      ),
    );
  }
}
