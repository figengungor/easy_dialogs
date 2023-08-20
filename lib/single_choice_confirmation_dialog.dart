import 'package:easy_dialogs/utils/dialog_utils.dart';
import 'package:easy_dialogs/utils/my_alert_dialog.dart';
import 'package:flutter/material.dart';

class SingleChoiceConfirmationDialog<T> extends StatefulWidget {
  /// The initial selected item when Dialog is opened.

  /// The  groupValue of [RadioListTile]'s inside [ListView] is set to this
  /// value initially

  /// If not provided, no RadioListTile is selected.

  final T? initialValue;

  /// The choice items of type [T] to be used while building items of ListView
  /// which is content of the dialog
  final List<T> items;

  /// Callback that is called with selected item of type T when item is selected
  final ValueChanged<T>? onSelected;

  /// Callback that is called with selected item of type T when submit button
  /// inside actions is tapped.
  ///
  /// This is only called when default actions are used.
  ///
  /// If [actions] are provided, then user should save the value when
  /// [onSelected] is called and handle the submit with this value inside a
  /// submit button of this actions.
  final ValueChanged<T>? onSubmitted;

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 12 pixels on the top,
  /// 16 pixels on bottom of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry? titlePadding;

  /// Padding around the content.

  final EdgeInsetsGeometry contentPadding;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// If this label is not provided, a semantic label will be infered from the
  /// [title] if it is not null.  If there is no title, the label will be taken
  /// from [MaterialLocalizations.alertDialogLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.isRouteName], for a description of how this
  ///    value is used.
  final String? semanticLabel;

  /// Callback that is called with selected item of type T which returns a
  /// Widget to build list view item inside dialog
  final ItemBuilder<T>? itemBuilder;

  /// The (optional) set of actions that are displayed at the bottom of the
  /// dialog.
  ///
  /// Typically this is a list of [TextButton] widgets.
  ///
  /// These widgets will be wrapped in a [ButtonBar], which introduces 8 pixels
  /// of padding on each side.
  ///
  /// If the [title] is not null but the [content] _is_ null, then an extra 20
  /// pixels of padding is added above the [ButtonBar] to separate the [title]
  /// from the [actions].
  final List<Widget>? actions;

  /// The color of the selected item's radio
  final Color? activeColor;

  /// The label of cancel button inside actions
  final String? cancelActionButtonLabel;

  /// The label of submit button inside actions
  final String? submitActionButtonLabel;

  /// The color of label of the default action buttons
  final Color? actionButtonLabelColor;

  /// The (optional) horizontal separator used between title, content and
  /// actions.
  ///
  /// If this divider is not provided a [Divider] is used with [height]
  /// property is set to 0.0
  final Widget divider;

  SingleChoiceConfirmationDialog({
    Key? key,
    this.initialValue,
    required this.items,
    this.onSelected,
    this.onSubmitted,
    this.title,
    this.titlePadding,
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    this.semanticLabel,
    this.actions,
    this.itemBuilder,
    this.activeColor,
    this.cancelActionButtonLabel,
    this.submitActionButtonLabel,
    this.actionButtonLabelColor,
    this.divider = const Divider(height: 0.0),
  }) : super(key: key);

  @override
  _SingleChoiceConfirmationDialogState<T> createState() =>
      _SingleChoiceConfirmationDialogState<T>();
}

class _SingleChoiceConfirmationDialogState<T>
    extends State<SingleChoiceConfirmationDialog<T>> {
  T? _chosenItem;

  @override
  void initState() {
    _chosenItem = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAlertDialog(
      title: widget.title,
      titlePadding: widget.titlePadding,
      contentPadding: widget.contentPadding,
      semanticLabel: widget.semanticLabel,
      content: _buildContent(),
      actions: _buildActions(),
      divider: widget.divider,
    );
  }

  _buildContent() {
    return ListView(
      shrinkWrap: true,
      children: widget.items
          .map(
            (item) => RadioListTile<T>(
              title: widget.itemBuilder != null
                  ? widget.itemBuilder!(item)
                  : Text(item.toString()),
              activeColor: widget.activeColor ?? Theme.of(context).colorScheme.secondary,
              value: item,
              groupValue: _chosenItem,
              onChanged: (value) {
                if (value != null) {
                  widget.onSelected?.call(value);
                  setState(() {
                    _chosenItem = value;
                  });
                }
              },
            ),
          )
          .toList(),
    );
  }

  _buildActions() {
    return widget.actions ??
        <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: widget.actionButtonLabelColor ??
                    Theme.of(context).colorScheme.secondary),
            child: Text(widget.cancelActionButtonLabel ?? 'CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: widget.actionButtonLabelColor ??
                    Theme.of(context).colorScheme.secondary),
            child: Text(widget.submitActionButtonLabel ?? 'OK'),
            onPressed: () {
              Navigator.pop(context);
              if (_chosenItem != null) {
                widget.onSubmitted?.call(_chosenItem!);
              }
            },
          )
        ];
  }
}
