import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/images.dart';

class WPickAvatar extends StatelessWidget {
  final void Function() pickImage;
  final ValueNotifier avatar;
  const WPickAvatar({
    super.key,
    required this.pickImage,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: avatar,
      builder: (BuildContext context, value, Widget? child) {
        return SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: value != null
                    ? Image.file(
                        File(value),
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      )
                    : Image.asset(
                        AppImages.noUserImg,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: pickImage,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: wgradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.add,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
