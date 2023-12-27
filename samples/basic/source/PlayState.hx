package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.text.FlxTextInput;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	override public function create()
	{
		bgColor = 0xFF808080;

		final textInput = new FlxTextInput(5, 5, 0, "This is a default text input.", 16);
		add(textInput);

		#if (flixel >= "5.4.0")
		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20,
			"This is a text input with fieldWidth and fieldHeight set.", 16);
		textInput.fieldHeight = 44;
		#else
		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20,
			"This is a text input with fieldWidth set.", 16);
		#end
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "This is a single-line text input.", 16);
		textInput.multiline = false;
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "This is a text input with a DYNAMIC type.", 16);
		textInput.type = DYNAMIC;
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "This is an unselectable text input.", 16);
		textInput.selectable = false;
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20,
			"This is an unselectable text input with a DYNAMIC type.", 16);
		textInput.type = DYNAMIC;
		textInput.selectable = false;
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "This is a formatted text input.");
		textInput.setFormat(FlxAssets.FONT_DEBUGGER, 16, FlxColor.LIME);
		textInput.italic = textInput.bold = true;
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "This text input is aligned to the center.", 16);
		textInput.alignment = CENTER;
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "This text input is aligned to the right.", 16);
		textInput.alignment = RIGHT;
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "Maximum characters: 30", 16);
		textInput.maxChars = 30;
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "ONLY UPPERCASE LETTERS ALLOWED", 16);
		textInput.restrict = "A-Z ";
		add(textInput);

		final textInput = new FlxTextInput(textInput.x, textInput.y + textInput.height + 5, FlxG.width - 20, "password", 16);
		textInput.displayAsPassword = true;
		add(textInput);

		super.create();
	}
}
