/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/home_label.png
  AssetGenImage get homeLabel =>
      const AssetGenImage('assets/png/home_label.png');

  /// File path: assets/png/home_top_bar.png
  AssetGenImage get homeTopBar =>
      const AssetGenImage('assets/png/home_top_bar.png');

  /// List of all assets
  List<AssetGenImage> get values => [homeLabel, homeTopBar];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/bread.svg
  SvgGenImage get bread => const SvgGenImage('assets/svg/bread.svg');

  /// File path: assets/svg/bread_brioche.svg
  SvgGenImage get breadBrioche =>
      const SvgGenImage('assets/svg/bread_brioche.svg');

  /// File path: assets/svg/bread_potato.svg
  SvgGenImage get breadPotato =>
      const SvgGenImage('assets/svg/bread_potato.svg');

  /// File path: assets/svg/bread_regular.svg
  SvgGenImage get breadRegular =>
      const SvgGenImage('assets/svg/bread_regular.svg');

  /// File path: assets/svg/bread_whole_wheat.svg
  SvgGenImage get breadWholeWheat =>
      const SvgGenImage('assets/svg/bread_whole_wheat.svg');

  /// File path: assets/svg/hotdog.svg
  SvgGenImage get hotdog => const SvgGenImage('assets/svg/hotdog.svg');

  /// File path: assets/svg/sausage.svg
  SvgGenImage get sausage => const SvgGenImage('assets/svg/sausage.svg');

  /// File path: assets/svg/sausage_bratwurst.svg
  SvgGenImage get sausageBratwurst =>
      const SvgGenImage('assets/svg/sausage_bratwurst.svg');

  /// File path: assets/svg/sausage_chorizo.svg
  SvgGenImage get sausageChorizo =>
      const SvgGenImage('assets/svg/sausage_chorizo.svg');

  /// File path: assets/svg/sausage_frankfurter.svg
  SvgGenImage get sausageFrankfurter =>
      const SvgGenImage('assets/svg/sausage_frankfurter.svg');

  /// File path: assets/svg/sausage_wiener.svg
  SvgGenImage get sausageWiener =>
      const SvgGenImage('assets/svg/sausage_wiener.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        bread,
        breadBrioche,
        breadPotato,
        breadRegular,
        breadWholeWheat,
        hotdog,
        sausage,
        sausageBratwurst,
        sausageChorizo,
        sausageFrankfurter,
        sausageWiener
      ];
}

class Assets {
  Assets._();

  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
