import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loader.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? borderRadius;
  final double? bottomBorderRadius;
  final bool isPlaceHolder;

  const CachedImage(
    this.url, {
    Key? key,
    this.height,
    this.borderRadius,
    this.bottomBorderRadius,
    this.isPlaceHolder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : bottomBorderRadius != null
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(bottomBorderRadius!),
                      bottomRight: Radius.circular(bottomBorderRadius!),
                    )
                  : null,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          // border: Border.all(color: Styles.k_border_gray_color)
        ),
      ),
      placeholder: (context, string) => const Center(
        child: LoaderWidget(),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : bottomBorderRadius != null
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(bottomBorderRadius!),
                      bottomRight: Radius.circular(bottomBorderRadius!),
                    )
                  : null,
        ),
        child: isPlaceHolder
            ? Image.asset(
                'assets/images/jpeg/no-image.jpeg',
                fit: BoxFit.cover,
              )
            : Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 24.sp,
              ),
      ),
    );
  }
}
