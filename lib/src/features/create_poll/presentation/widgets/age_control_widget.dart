import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';

class AgeControlWidget extends StatefulWidget {
  const AgeControlWidget({
    super.key,
    required this.onMinAgeChanged,
    required this.onMaxAgeChanged,
    required this.initialMinAge,
    required this.initialMaxAge,
  });
  final ValueChanged<int> onMinAgeChanged;
  final ValueChanged<int> onMaxAgeChanged;
  final int initialMinAge;
  final int initialMaxAge;

  @override
  State<AgeControlWidget> createState() => _AgeControlWidgetState();
}

class _AgeControlWidgetState extends State<AgeControlWidget> {
  late RangeValues _values = RangeValues(widget.initialMinAge.toDouble(), widget.initialMaxAge.toDouble());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_values.start.toInt()} - ${_values.end.toInt()}',
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 17, color: AppColors.c_5856D6, letterSpacing: 0.3),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbColor: AppColors.c_F8F8FF,
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 14.0,
                disabledThumbRadius: 14.0,
              ),
              rangeTrackShape: const CustomRoundedRectRangeSliderTrackShape(),
              activeTrackColor: AppColors.c_5856D6,
              inactiveTrackColor: AppColors.secondary,
              overlayColor: AppColors.c_5856D6.withValues(alpha: 0.3),
              trackHeight: 4.0,
            ),
            child: RangeSlider(
              values: _values,
              max: 100,
              min: 0,
              labels: RangeLabels(
                _values.start.round().toString(),
                _values.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                if (values.start < 14) return;
                setState(() => _values = values);
              },
              onChangeEnd: (RangeValues values) {
                widget.onMinAgeChanged(_values.start.toInt());
                widget.onMaxAgeChanged(_values.end.toInt());
              },
            ),
          )
          /*  RangeSlider(
            values: values,
            max: 300,
            min: 0,
            divisions: 20,
            activeColor:Colors.red,
            inactiveColor: AppColors.secondary,
            labels: RangeLabels(
              values.start.round().toString(),
              values.end.round().toString(),
            ),
            onChanged: (values) => setState(() =>this.values = values),
          ),*/
        ],
      ),
    );
  }
}

class CustomRoundedRectRangeSliderTrackShape extends RangeSliderTrackShape with BaseRangeSliderTrackShape {
  /// Create a slider track with rounded outer edges.
  ///
  /// The middle track segment is the selected range and is active, and the two
  /// outer track segments are inactive.
  const CustomRoundedRectRangeSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.rangeThumbShape != null);

    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are left: active, right: inactive,
    // but reversed for right to left text.
    final ColorTween activeTrackColorTween = ColorTween(
      begin: sliderTheme.disabledActiveTrackColor,
      end: sliderTheme.activeTrackColor,
    );
    final ColorTween inactiveTrackColorTween = ColorTween(
      begin: sliderTheme.disabledInactiveTrackColor,
      end: sliderTheme.inactiveTrackColor,
    );
    final Paint activePaint = Paint()..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()..color = inactiveTrackColorTween.evaluate(enableAnimation)!;

    final Offset leftThumbOffset;
    final Offset rightThumbOffset;
    switch (textDirection) {
      case TextDirection.ltr:
        leftThumbOffset = startThumbCenter;
        rightThumbOffset = endThumbCenter;
      case TextDirection.rtl:
        leftThumbOffset = endThumbCenter;
        rightThumbOffset = startThumbCenter;
    }
    final Size thumbSize = sliderTheme.rangeThumbShape!.getPreferredSize(isEnabled, isDiscrete);
    final double thumbRadius = thumbSize.width / 2;
    assert(thumbRadius > 0);

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Radius trackRadius = Radius.circular(trackRect.height / 2);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        trackRect.top,
        leftThumbOffset.dx,
        trackRect.bottom,
        topLeft: trackRadius,
        bottomLeft: trackRadius,
      ),
      inactivePaint,
    );
    context.canvas.drawRect(
      Rect.fromLTRB(
        leftThumbOffset.dx,
        trackRect.top, // - (additionalActiveTrackHeight / 2),
        rightThumbOffset.dx,
        trackRect.bottom, // + (additionalActiveTrackHeight / 2),
      ),
      activePaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        rightThumbOffset.dx,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
        topRight: trackRadius,
        bottomRight: trackRadius,
      ),
      inactivePaint,
    );
  }
}
