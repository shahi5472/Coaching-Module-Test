import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  const CustomImageView({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.margin,
    this.padding,
    this.border,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.isFileImage = false,
    required this.path,
    this.constraints,
  });

  final String path;

  final double? width;
  final double? height;

  final BoxFit fit;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry borderRadius;
  final BoxBorder? border;

  final Color? color;

  final bool isFileImage;

  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      constraints: constraints,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: _getImageWidget(path, context),
      ),
    );
  }

  Widget _getImageWidget(String url, BuildContext context) {
    if (url.startsWith("http") || url.startsWith("https") || url.startsWith("www")) {
      if (url.endsWith(".svg")) {
        return SvgPicture.network(
          url,
          width: width,
          height: height,
          fit: fit,
          placeholderBuilder: (_) => _ImageLoader(
            width: width,
            height: height,
            borderRadius: borderRadius,
          ),
          colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        );
      } else {
        return CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => _ImageLoader(
            width: width,
            height: height,
            borderRadius: borderRadius,
          ),
          color: color,
          errorWidget: (_, __, ___) => const Icon(Icons.error),
          width: width,
          height: height,
          fit: fit,
        );
      }
    } else {
      if (url.endsWith(".svg")) {
        return SvgPicture.asset(
          url,
          width: width,
          height: height,
          fit: fit,
          colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        );
      } else if (isFileImage) {
        return Image.file(
          File(url),
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
      } else {
        return Image.asset(
          url,
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
      }
    }
  }
}

class _ImageLoader extends StatelessWidget {
  const _ImageLoader({
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
  });

  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.grey.withValues(alpha: 0.1),
        ),
      ),
    );
  }
}
