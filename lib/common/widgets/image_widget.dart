import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget cachedNetworkImage(
    {String? networkImage,
    double? width = 60,
    double? height = 60,
    String? defaultImage,
    BoxFit? boxFit,
    Widget? child}) {
  return CachedNetworkImage(
    imageUrl: networkImage ?? "",
    imageBuilder: (context, imageProvider) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        image: DecorationImage(
          //image size fill
          image: imageProvider,
          fit: boxFit ?? BoxFit.fitHeight,
        ),
      ),
      child: child,
    ),
    placeholder: (context, url) => Container(
      alignment: Alignment.center,
      child:
          const CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
    ), //show progress  while loading image
    errorWidget: (context, url, error) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20.w),
        image: DecorationImage(
          //image size fill
          image: AssetImage(defaultImage!),
          fit: BoxFit.fitHeight,
        ),
      ),
    ),
    //show no image available image on error loading
  );
}
