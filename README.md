# flixel-text-input

An improved text input object for HaxeFlixel.

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

## Credits

- Starmapo: Creator & Programmer
- The OpenFL Team: Original text input system
