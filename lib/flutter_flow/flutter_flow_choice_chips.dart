import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double _kChoiceChipsHeight = 40.0;

class ChipData {
  const ChipData(this.label, [this.iconData]);
  final String label;
  final IconData iconData;
}

class ChipStyle {
  const ChipStyle(
      {this.backgroundColor,
      this.textStyle,
       this.iconColor,
      this.iconSize,
      this.labelPadding,
       this.elevation});
  final Color backgroundColor;
  final TextStyle textStyle;
  final Color iconColor;
  final double iconSize;
  final EdgeInsetsGeometry labelPadding;
  final double elevation;
}

class FlutterFlowChoiceChips extends StatefulWidget {
  const FlutterFlowChoiceChips({
    this.initiallySelected,
       this.options,
       this.onChanged,
       this.selectedChipStyle,
       this.unselectedChipStyle,
       this.chipSpacing,
    this.rowSpacing = 0.0,
       this.multiselect,
    this.initialized = true,
    this.alignment = WrapAlignment.start,
    this.selectedValuesVariable,
  });

  final List<String> initiallySelected;
  final List<ChipData> options;
  final void Function(List<String >) onChanged;
  final ChipStyle selectedChipStyle;
  final ChipStyle unselectedChipStyle;
  final double chipSpacing;
  final double rowSpacing;
  final bool multiselect;
  final bool initialized;
  final WrapAlignment alignment;
  final ValueNotifier<List<String > > selectedValuesVariable;

  @override
  State<FlutterFlowChoiceChips> createState() => _FlutterFlowChoiceChipsState();
}

class _FlutterFlowChoiceChipsState extends State<FlutterFlowChoiceChips> {
   List<String> choiceChipValues;
  ValueListenable<List<String > > get changeSelectedValues =>
      widget.selectedValuesVariable;
  List<String > get selectedValues => widget.selectedValuesVariable?.value;

  @override
  void initState() {
    super.initState();
    choiceChipValues = widget.initiallySelected ?? [];
    if (!widget.initialized && choiceChipValues.isNotEmpty) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          if (widget.onChanged != null) {
            widget.onChanged(choiceChipValues);
          }
        },
      );
    }
    changeSelectedValues?.addListener(() {
      if (widget.selectedValuesVariable != null &&
          selectedValues != null &&
          choiceChipValues != selectedValues) {
        setState(() => choiceChipValues = List.from(selectedValues));
      }
    });
  }

  @override
  void dispose() {
    changeSelectedValues?.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: widget.chipSpacing,
        runSpacing: widget.rowSpacing,
        alignment: widget.alignment,
        children: [
          ...widget.options.map(
            (option) {
              final selected = choiceChipValues.contains(option.label);
              final style = selected
                  ? widget.selectedChipStyle
                  : widget.unselectedChipStyle;
              return Container(
                height: _kChoiceChipsHeight,
                child: ChoiceChip(
                  selected: selected,
                  onSelected: widget.onChanged != null
                      ? (isSelected) {
                          if (isSelected) {
                            widget.multiselect
                                ? choiceChipValues.add(option.label)
                                : choiceChipValues = [option.label];
                            widget.onChanged(choiceChipValues);
                            setState(() {});
                          } else {
                            if (widget.multiselect) {
                              choiceChipValues.remove(option.label);
                              widget.onChanged(choiceChipValues);
                              setState(() {});
                            }
                          }
                        }
                      : null,
                  label: Text(
                    option.label,
                    style: style.textStyle,
                  ),
                  labelPadding: style.labelPadding,
                  avatar: option.iconData != null
                      ? FaIcon(
                          option.iconData,
                          size: style.iconSize,
                          color: style.iconColor,
                        )
                      : null,
                  elevation: style.elevation,
                  selectedColor: selected
                      ? widget.selectedChipStyle.backgroundColor
                      : null,
                  backgroundColor: selected
                      ? null
                      : widget.unselectedChipStyle.backgroundColor,
                ),
              );
            },
          ).toList(),
        ],
      );
}
