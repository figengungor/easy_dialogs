# example

An example using dialogs from easy_dialogs package.

- SingleChoiceDialog
- SingleChoiceConfirmationDialog

SingleChoiceConfirmationDialog 1           |  SingleChoiceConfirmationDialog 2 |  SingleChoiceDialog
:-------------------------:|:-------------------------:|:-------------------------:
![](art/single_choice_confirm_01.png)  |  ![](art/single_choice_confirm_02.png) | ![](art/single_choice_confirm_03.png)

SingleChoiceConfirmationDialog 1

```dart
SingleChoiceConfirmationDialog<String>(
            title: Text('Phone ringtone'),
            initialValue: _ringTone,
            items: _ringTones,
            onSelected: _onSelected,
            onSubmitted: _onSubmitted)
```

SingleChoiceConfirmationDialog 2

```dart
SingleChoiceConfirmationDialog<Color>(
            title: Text('Color'),
            initialValue: _color,
            items: _colors,
            contentPadding: EdgeInsets.symmetric(vertical: 16.0),
            divider: Container(
              height: 1.0,
              color: Colors.blue,
            ),
            onSubmitted: (Color color) {
              setState(() => _color = color);
            },
            itemBuilder: (Color color) =>
                Container(height: 100.0, color: color))
```

SingleChoiceDialog

```dart
SingleChoiceDialog<Color>(
              isDividerEnabled: true,
              title: Text('Pick a color'),
              items: _colors,
              onSelected: (Color color) {
                setState(() => _color = color);
              },
              itemBuilder: (Color color) =>
                  Container(height: 100.0, color: color))
```