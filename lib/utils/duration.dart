class DurationUtils {
  static String toFormattedString(Duration duration) {
    var durationSec = duration.inSeconds;

    var minutesStr = (durationSec / 60).floor().toString();
    var secondsStr = durationSec.remainder(60).toString().padLeft(2, '0');

    return minutesStr + ':' + secondsStr;
  }
}
