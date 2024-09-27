part of '../view/poll_details_view.dart';

class _TimesLeft extends StatelessWidget {
  const _TimesLeft({required this.isExpired, required this.timeLeft});
  final bool isExpired;
  final String timeLeft;
  @override
  Widget build(BuildContext context) {
    if (isExpired) return const SizedBox.shrink();
    return Row(
      children: [
        Text(
          LocaleKeys.poll_timeLeftText.tr(),
          style: TextStyle(
            fontSize: 14,
            fontFamily: FontConstants.gilroyBold,
          ),
        ),
        const SizedBox(width: WidgetSizes.s),
        Text(
          timeLeft,
          style: TextStyle(
            fontSize: 15,
            fontFamily: FontConstants.gilroyRegular,
          ),
        ),
      ],
    );
  }
}

final class _PollTitle extends StatelessWidget {
  const _PollTitle(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontFamily: FontConstants.gilroyBold,
      ),
    );
  }
}
