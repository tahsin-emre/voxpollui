part of '../view/discover_view.dart';

class _DiscoverTabView extends StatelessWidget {
  const _DiscoverTabView({
    required this.pageNotifier,
    required this.onTap,
    required this.users,
    required this.communities,
    required this.polls,
  });
  final ValueNotifier<int> pageNotifier;
  final ValueChanged<int> onTap;
  final List<UserModel> users;
  final List<CommunityModel> communities;
  final List<PollModel> polls;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageNotifier,
      builder: (_, page, __) {
        return Column(
          children: [
            if (users.isNotEmpty || communities.isNotEmpty || polls.isNotEmpty)
              _DiscoverTabNav(
                pageNotifier,
                (index) => pageNotifier.value = index,
              ),
            if (page == 0 || page == 1)
              ...users.map(
                (e) => Padding(
                  padding: PagePaddings.allS,
                  child: OwnerTile(owner: e),
                ),
              ),
            if (page == 0 || page == 2)
              ...communities.map(
                (e) => Padding(
                  padding: PagePaddings.allS,
                  child: OwnerTile(owner: e),
                ),
              ),
            if (page == 0 || page == 3) ...polls.map(PollTile.new),
            if (users.isNotEmpty || communities.isNotEmpty || polls.isNotEmpty)
              const Divider(),
          ],
        );
      },
    );
  }
}

final class _DiscoverTabNav extends StatelessWidget {
  const _DiscoverTabNav(this.pageNotifier, this.onTap);
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
          margin: PagePaddings.horS,
          padding: PagePaddings.allXS,
          child: Row(
            children: [
              _TabNavBox(
                index: 0,
                label: LocaleKeys.discover_all.tr(),
                isSelected: page == 0,
                onTap: onTap,
              ),
              _TabNavBox(
                index: 1,
                label: LocaleKeys.discover_people.tr(),
                isSelected: page == 1,
                onTap: onTap,
              ),
              _TabNavBox(
                index: 2,
                label: LocaleKeys.discover_communities.tr(),
                isSelected: page == 2,
                onTap: onTap,
              ),
              _TabNavBox(
                index: 3,
                label: LocaleKeys.discover_polls.tr(),
                isSelected: page == 3,
                onTap: onTap,
              ),
            ],
          ),
        );
      },
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
        onTap: () => onTap(index),
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
              fontFamily: isSelected
                  ? FontConstants.gilroyBold
                  : FontConstants.gilroyRegular,
            ),
          ),
        ),
      ),
    );
  }
}
