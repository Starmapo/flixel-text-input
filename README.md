# flixel-text-input

An improved text input object for HaxeFlixel.

## How to Use

Simply create a new `flixel.addons.text.FlxTextInput` object and add it to your state or group:

```haxe
var textInput = new FlxTextInput(0, 0, 150, "Hello world!");
textInput.fieldHeight = 50; // Set `fieldHeight` if you want a fixed height for the text
add(textInput);
```

### With flixel-ui

You can instead use `flixel.addons.text.ui.FlxUITextInput` for a text input that mimics the style (and some properties) of the flixel-ui text input:

```haxe
var textInput = new FlxUITextInput(0, 0, 150, "Hello world!");
textInput.multiline = true; // Enable this if you want the text to be multiline. You'll probably want to change `fieldHeight` as well
add(textInput);
```

If you want `FlxUINumericStepper` but with this text input, use `flixel.addons.text.ui.FlxUINumericStepper`.

## Features

The base text input includes:

- Insertion point (caret): You can select the position to insert new text in by clicking somewhere on the text object, or pressing the arrow keys.
- Text selection: You can select multiple characters at once by pressing and dragging on the text object, or holding the Shift key and pressing the left and right arrow keys.
- Multiline support: A text input object can have multiple lines. New lines can be added by pressing the Enter key. This feature can be turned off by setting the `multiline` property to `false`.
- Password text input: By setting `displayAsPassword` to `true`, the text input will display asterisks instead of the actual characters, and copy/cut commands will be disabled.
- Maximum text length: By changing `maxChars`, you can force a maximum amount of characters that the user can type.
- Restricting characters: By changing `restrict`, you can restrict the characters that the user can type.
- Text field type: You can change `selectable` to specify if the text object can be selected and `type` to specify if the text object receives text input (`INPUT`) or not (`DYNAMIC`).

And more!

## Limitations

- Border styles from `FlxText` do not work
- Caret color and width & selection color aren't changeable

## Dependencies

Of course, you will need HaxeFlixel in your project. "flixel-ui" is optional, as you can use `FlxUITextInput` without it. Including it makes the text input able to dispatch `FlxUI` events.

## Compatibility

### Library Versions

This library has been last tested with Haxe 4.3.3, Lime 8.1.1, OpenFL 9.3.2, HaxeFlixel 5.5.0, and flixel-ui 2.5.0. Compatibility has been tested with Lime 7.9.0, OpenFL 9.1.0, and HaxeFlixel 4.11.0.

### Compilation Targets

This library has been tested on Windows (C++, HashLink & Neko) and HTML5.

macOS and Linux haven't been tested, but they should work properly like Windows. Android & iOS haven't been tested either.

## Credits

- Starmapo: Creator & Programmer
- The OpenFL Team: Original text input system
