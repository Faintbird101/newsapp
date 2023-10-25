import 'package:mohoro/common.libs.dart';

export 'colors.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  /// The current theme colors for the app
  final AppColors colors = AppColors();

  /// Text styles
  // ignore: library_private_types_in_public_api
  late final _Text text = _Text();
}

@immutable
class _Text {
  TextStyle get titleFont => const TextStyle(fontFamily: 'Causten');
  TextStyle get titleAltFont => const TextStyle(fontFamily: 'Pedut');
  TextStyle get quoteFont => const TextStyle(fontFamily: 'Causten');
  TextStyle get contentFont => const TextStyle(fontFamily: 'Causten');
  TextStyle get monoTitleFont => const TextStyle(fontFamily: 'Causten');
  TextStyle get monocontentFont => const TextStyle(fontFamily: 'RobotoMono');

  late final TextStyle dropCase = copy(quoteFont, sizePx: 56, heightPx: 20);

  late final TextStyle h1 = copy(titleFont, sizePx: 35, heightPx: 62);
  late final TextStyle h2 =
      copy(titleFont, sizePx: 28, heightPx: 46, weight: FontWeight.w800);
  late final TextStyle h3 =
      copy(titleFont, sizePx: 23, heightPx: 18, weight: FontWeight.w700);
  late final TextStyle h4 = copy(contentFont,
      sizePx: 18, heightPx: 23, spacingPc: 1, weight: FontWeight.w500);
  late final TextStyle h5 = copy(contentFont,
      sizePx: 16, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  late final TextStyle onboarding =
      copy(titleFont, sizePx: 21, heightPx: 36, weight: FontWeight.w800);

  late final TextStyle title1 = copy(titleFont,
      sizePx: 18, heightPx: 0, spacingPc: 1, weight: FontWeight.w700);
  late final TextStyle title2 = copy(titleFont, sizePx: 15, heightPx: 16.38);

  late final TextStyle body = copy(contentFont, sizePx: 16);
  late final TextStyle bodyBold =
      copy(contentFont, sizePx: 16, weight: FontWeight.w600);
  late final TextStyle bodySmall = copy(contentFont, sizePx: 14);
  late final TextStyle bodySmallBold =
      copy(contentFont, sizePx: 14, weight: FontWeight.w600);

  late final TextStyle quote1 = copy(quoteFont,
      sizePx: 32, heightPx: 40, weight: FontWeight.w600, spacingPc: -3);
  late final TextStyle quote2 =
      copy(quoteFont, sizePx: 21, heightPx: 32, weight: FontWeight.w400);
  late final TextStyle quote2Sub =
      copy(body, sizePx: 16, heightPx: 40, weight: FontWeight.w400);

  late final TextStyle nav =
      copy(contentFont, sizePx: 12, heightPx: 0, weight: FontWeight.w500);

  late final TextStyle caption =
      copy(contentFont, sizePx: 12, heightPx: 18, weight: FontWeight.w500)
          .copyWith(fontStyle: FontStyle.italic);

  late final TextStyle callout =
      copy(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600)
          .copyWith(fontStyle: FontStyle.italic);
  late final TextStyle btn =
      copy(titleFont, sizePx: 12, weight: FontWeight.w600, heightPx: 13.2);

  TextStyle copy(TextStyle style,
      {required double sizePx,
      double? heightPx,
      double? spacingPc,
      FontWeight? weight}) {
    return style.copyWith(
      fontSize: sizePx,
      // height: heightPx != null ? (heightPx / sizePx) : style.height,
      letterSpacing:
          spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
      fontWeight: weight,
    );
  }
}
