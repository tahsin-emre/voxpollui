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
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: PagePaddings.horL,
                  padding: PagePaddings.horS,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.black,
                  ),
                  child: Text(
                    LocaleKeys.profile_follow.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.white,
                      fontFamily: FontConstants.gilroySemibold,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              user.name ?? '',
              style: TextStyle(
                fontSize: 28,
                fontFamily: FontConstants.gilroyBold,
              ),
            ),
          ],
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

final class _ProfileTabNav extends StatelessWidget {
  const _ProfileTabNav(this.pageNotifier, this.onTap);
  final ValueNotifier<int> pageNotifier;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageNotifier,
      builder: (_, page, __) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.opposite.withOpacity(.3),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          margin: PagePaddings.horL,
          padding: PagePaddings.allXS,
          child: Row(
            children: [
              _TabNavBox(
                index: 0,
                label: LocaleKeys.profile_myParticipatedPolls.tr(),
                isSelected: page == 0,
                onTap: onTap,
              ),
              _TabNavBox(
                index: 1,
                label: LocaleKeys.profile_myCreatedPolls.tr(),
                isSelected: page == 1,
                onTap: onTap,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileTabView extends StatelessWidget {
  const _ProfileTabView(this.pageNotifier, {required this.createdPolls});
  final ValueNotifier<int> pageNotifier;
  final List<PollModel> createdPolls;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageNotifier,
      builder: (_, page, __) {
        if (page == 0) return const _ProfileParticipatedPolls();
        if (page == 1) return _ProfileCreatedPolls(createdPolls);
        return const SizedBox.shrink();
      },
    );
  }
}

final class _ProfileCreatedPolls extends StatelessWidget {
  const _ProfileCreatedPolls(this.polls);
  final List<PollModel> polls;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...polls.map(PollTile.new),
      ],
    );
  }
}

final class _ProfileParticipatedPolls extends StatelessWidget {
  const _ProfileParticipatedPolls();
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('data'),
      ],
    );
  }
}

final class _TabNavBox extends StatelessWidget {
  const _TabNavBox({
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final bool isSelected;
  final int index;
  final String label;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          print(index);

          onTap(index);
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.white : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            label,
            maxLines: 1,
            style: TextStyle(
              fontFamily: FontConstants.gilroyBold,
            ),
          ),
        ),
      ),
    );
  }
}

final class _InfoBox extends StatelessWidget {
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
