package;

import flixel.FlxState;
import flixel.addons.text.ui.FlxUINumericStepper;
import flixel.addons.text.ui.FlxUITextInput;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUITabMenu;

class PlayState extends FlxState
{
	override public function create()
	{
		bgColor = 0xFF808080;

		final tabMenu = new FlxUITabMenu([
			{name: "Text Input", label: "Text Input"},
			{name: "Numeric Stepper", label: "Numeric Stepper"}
		]);
		tabMenu.setPosition(10, 10);
		tabMenu.resize(170, 190);

		final tab = new FlxUI(tabMenu);
		tab.name = "Text Input";

		final sprites:Array<flixel.FlxSprite> = [];

		final textInput = new FlxUITextInput(10, 10, 150, "This is a default text input.");
		sprites.push(textInput);

		#if (flixel >= "5.4.0")
		final textInput = new FlxUITextInput(textInput.x, textInput.y + textInput.height + 5, 150, "This is a multiline text input.");
		textInput.multiline = true;
		textInput.resize(textInput.tf.width, 44);
		sprites.push(textInput);
		#end

		final textInput = new FlxUITextInput(textInput.x, textInput.y + textInput.height + 5, 150, "only lowercase letters allowed.");
		textInput.forceCase = LOWER_CASE;
		sprites.push(textInput);

		final textInput = new FlxUITextInput(textInput.x, textInput.y + textInput.height + 5, 150, "ONLY UPPERCASE LETTERS ALLOWED.");
		textInput.forceCase = UPPER_CASE;
		sprites.push(textInput);

		final textInput = new FlxUITextInput(textInput.x, textInput.y + textInput.height + 5, 150, "onlyLettersAllowed");
		textInput.filterMode = ONLY_ALPHA;
		sprites.push(textInput);

		final textInput6 = new FlxUITextInput(textInput.x, textInput.y + textInput.height + 5, 150, "1234567890");
		textInput6.filterMode = ONLY_NUMERIC;
		sprites.push(textInput);

		for (sprite in sprites)
		{
			tab.add(sprite);
		}
		sprites.resize(0);

		tabMenu.addGroup(tab);

		final tab = new FlxUI(tabMenu);
		tab.name = "Numeric Stepper";

		final stepper = new FlxUINumericStepper(10, 10);
		sprites.push(stepper);

		final stepper = new FlxUINumericStepper(stepper.x, stepper.y + stepper.height + 5, STACK_VERTICAL);
		sprites.push(stepper);

		final stepper = new FlxUINumericStepper(stepper.x, stepper.y + stepper.height + 5, 0.01, 0, 0, 1, 2, true);
		sprites.push(stepper);

		for (sprite in sprites)
		{
			tab.add(sprite);
		}
		sprites.resize(0);

		tabMenu.addGroup(tab);

		add(tabMenu);

		super.create();
	}
}
