import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voxpollui/product/services/firebase/upload_service.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

final class ImageChangeTile extends StatelessWidget {
  const ImageChangeTile({
    required this.userId,
    required this.onProfileUrl,
    required this.onBackUrl,
    this.initProfile,
    this.initBack,
    super.key,
  });
  final String userId;
  final ValueChanged<String?> onProfileUrl;
  final ValueChanged<String?> onBackUrl;
  final String? initProfile;
  final String? initBack;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Badge(
              offset: const Offset(-20, -10),
              backgroundColor: AppColor.primary.withOpacity(.8),
              padding: PagePaddings.allS,
              alignment: Alignment.bottomRight,
              label: InkWell(
                onTap: changeBackImage,
                child: IconConstants.newImage.toCustomIcon(
                  size: 24,
                  color: AppColor.white,
                ),
              ),
              child: Image.network(
                initBack ?? 'https://picsum.photos/200',
                width: double.infinity,
                height: WidgetSizes.maxiL,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: WidgetSizes.x4L),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Badge(
              offset: const Offset(-20, -15),
              backgroundColor: AppColor.primary.withOpacity(.8),
              padding: PagePaddings.allS,
              alignment: Alignment.bottomRight,
              label: InkWell(
                onTap: changeProfileImage,
                child: IconConstants.newImage.toCustomIcon(
                  size: 24,
                  color: AppColor.white,
                ),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColor.black,
                backgroundImage:
                    initProfile != null ? NetworkImage(initProfile!) : null,
                child: initProfile == null
                    ? IconConstants.profile
                        .toCustomIcon(size: 64, color: AppColor.white)
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> changeProfileImage() async {
    final uploadService = UploadService();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile == null) return;
    final imageUrl = await uploadService.uploadImage(
      userId: userId,
      file: pickedFile,
      folder: UploadFolder.userImage,
    );
    onProfileUrl(imageUrl);
  }

  Future<void> changeBackImage() async {
    final uploadService = UploadService();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile == null) return;
    final imageUrl = await uploadService.uploadImage(
      userId: userId,
      file: pickedFile,
      folder: UploadFolder.userImage,
    );
    onBackUrl(imageUrl);
  }
}
