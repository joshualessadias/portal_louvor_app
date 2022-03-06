import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';

typedef StringToVoidFunc = void Function(String);

class ToneExpansionWidget extends StatelessWidget {
  ToneExpansionWidget({
    Key? key,
    required this.tone,
    required this.onToneDown,
    required this.onToneUp,
    required this.onToneRestore,
    required this.onChangeTone,
  }) : super(key: key);

  final String tone;
  final VoidCallback? onToneDown;
  final VoidCallback? onToneUp;
  final VoidCallback? onToneRestore;
  final StringToVoidFunc onChangeTone;

  final _buttonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(kGrey),
    overlayColor: MaterialStateProperty.all(kSecondaryColor.withOpacity(0.2)),
  );

  Widget _buildToneButton(String buttonTone) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          onChangeTone(buttonTone);
        },
        style: buttonTone == tone
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kSecondaryColor),
                foregroundColor: MaterialStateProperty.all(kWhite),
                overlayColor:
                    MaterialStateProperty.all(kSecondaryColor.withOpacity(0.2)),
              )
            : _buttonStyle,
        child: Text(buttonTone),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(
        Icons.music_note_rounded,
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Tom: ',
              style: TextStyle(
                color: kBlack,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: tone,
              style: const TextStyle(
                color: kSecondaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: onToneDown,
                  style: _buttonStyle,
                  child: const Text('- 1/2 tom'),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: onToneUp,
                  style: _buttonStyle,
                  child: const Text('+ 1/2 tom'),
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
              _buildToneButton('A'),
              const SizedBox(width: 8.0),
              _buildToneButton('Bb'),
              const SizedBox(width: 8.0),
              _buildToneButton('B'),
              const SizedBox(width: 8.0),
              _buildToneButton('C'),
              const SizedBox(width: 8.0),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              _buildToneButton('Db'),
              const SizedBox(width: 8.0),
              _buildToneButton('D'),
              const SizedBox(width: 8.0),
              _buildToneButton('Eb'),
              const SizedBox(width: 8.0),
              _buildToneButton('E'),
              const SizedBox(width: 8.0),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              _buildToneButton('F'),
              const SizedBox(width: 8.0),
              _buildToneButton('F#'),
              const SizedBox(width: 8.0),
              _buildToneButton('G'),
              const SizedBox(width: 8.0),
              _buildToneButton('Ab'),
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
                  onPressed: onToneRestore,
                  style: _buttonStyle,
                  child: const Text('Restaurar tom inicial'),
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
