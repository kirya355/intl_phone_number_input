import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/utils/util.dart';

import 'input_widget.dart';

/// [Item]
class Item extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;
  final TextStyle? textStyle;
  final bool withCountryNames;
  final double? leadingPadding;
  final bool trailingSpace;
  final double? height;
  final PhoneInputSelectorType phoneInputSelectorType;
  final bool needSeparator;
  final Color? separatorColor;

  const Item({
    Key? key,
    required this.phoneInputSelectorType,
    required this.needSeparator,
    this.country,
    this.showFlag,
    this.useEmoji,
    this.textStyle,
    this.withCountryNames = false,
    this.leadingPadding = 12,
    this.trailingSpace = true,
    this.height,
    this.separatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dialCode = (country?.dialCode ?? '');
    if (trailingSpace) {
      dialCode = dialCode.padRight(5, "   ");
    }
    return Container(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(width: leadingPadding),
          if (country != null && showFlag == true) ...[
            _Flag(
              country: country,
              showFlag: showFlag,
              useEmoji: useEmoji,
            ),
            SizedBox(width: 6.0),
            if (phoneInputSelectorType != PhoneInputSelectorType.DROPDOWN)
              Image.asset(
                'assets/dropdown.png',
                width: 12.0,
                package: 'country_code_phone_number_input',
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox.shrink();
                },
              ),
            SizedBox(width: 6.0),
          ],
          Text(
            '$dialCode',
            textDirection: TextDirection.ltr,
            style: textStyle,
          ),
          if (needSeparator) ...[
            SizedBox(width: 12.0),
            Container(
              width: 1,
              height: 14,
              color: separatorColor ?? Colors.black.withOpacity(0.2),
            ),
          ],
        ],
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;

  const _Flag({Key? key, this.country, this.showFlag, this.useEmoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null && showFlag!
        ? Container(
            child: useEmoji!
                ? Text(
                    Utils.generateFlagEmojiUnicode(country?.alpha2Code ?? ''),
                    style: Theme.of(context).textTheme.headline5,
                  )
                : Image.asset(
                    country!.flagUri,
                    width: 24.0,
                    package: 'intl_phone_number_input',
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox.shrink();
                    },
                  ),
          )
        : SizedBox.shrink();
  }
}
