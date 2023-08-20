import 'package:easy_dialogs/utils/dialog_utils.dart';
import 'package:easy_dialogs/utils/my_alert_dialog.dart';
import 'package:flutter/material.dart';

class SingleChoiceDialog<T> extends StatelessWidget {
  /// The choice items of type [T] to be used while building items of ListView
  /// which is content of the dialog
  final List<T> items;

  /// Callback that is called with selected item of type T when item is selected
  final ValueChanged<T>? onSelected;

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

  ///Callback that is called with selected item of type T which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder<T>? itemBuilder;

  /// The (optional) horizontal separator used between title, content and
  /// actions.
  ///
  /// If this divider is not provided a [Divider] is used with [height]
  /// property is set to 0.0
  final Widget divider;

  /// The [divider] is not displayed if set to false. Default is set to true.
  final bool isDividerEnabled;

  SingleChoiceDialog(
      {Key? key,
      required this.items,
      this.onSelected,
      this.title,
      this.titlePadding,
      this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
      this.semanticLabel,
      this.itemBuilder,
      this.isDividerEnabled = false,
      this.divider = const Divider(
        height: 0.0,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAlertDialog(
      title: title,
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      semanticLabel: semanticLabel,
      content: _buildContent(context),
      isDividerEnabled: isDividerEnabled,
      divider: divider,
    );
  }

  _buildContent(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: items
          .map((item) => SimpleDialogOption(
                child: itemBuilder != null
                    ? itemBuilder!(item)
                    : Text(item.toString()),
                onPressed: () {
                  onSelected?.call(item);
                  Navigator.pop(context);
                },
              ))
          .toList(),
    );
  }
}
