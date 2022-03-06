import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';

class FontSizeExpansionWidget extends StatelessWidget {
  FontSizeExpansionWidget({
    Key? key,
    required this.onIncreaseFontSize,
    required this.onDecreaseFontSize,
  }) : super(key: key);

  final VoidCallback? onIncreaseFontSize;
  final VoidCallback? onDecreaseFontSize;

  final _buttonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(kGrey),
    overlayColor: MaterialStateProperty.all(kSecondaryColor.withOpacity(0.2)),
  );

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.font_download_rounded),
      title: Text(
        'Tamanho da fonte',
        style: TextStyle(
            fontSize: 15.0, color: kBlack, fontWeight: FontWeight.w500),
      ),
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: onDecreaseFontSize,
                  style: _buttonStyle,
                  child: Text(
                    'A',
                    style: TextStyle(color: kGrey, fontSize: 12.0),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: onIncreaseFontSize,
                  style: _buttonStyle,
                  child: Text(
                    'A',
                    style: TextStyle(color: kGrey, fontSize: 22.0),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
            ],
          ),
        ),
        const Divider(thickness: 1.0),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: onDecreaseFontSize,
                  style: _buttonStyle,
                  child: Text(
                    'Restaurar tamanho incial',
                    style: TextStyle(color: kGrey),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
