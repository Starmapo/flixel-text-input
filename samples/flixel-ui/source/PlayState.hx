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

		final textInput = new FlxUITextInput(10, 10, 150, "This is a default text input.");

		final textInput2 = new FlxUITextInput(textInput.x, textInput.y + textInput.height + 5, 150, "This is a multiline text input.");
		textInput2.multiline = true;
		textInput2.fieldHeight = 44;

		final textInput3 = new FlxUITextInput(textInput2.x, textInput2.y + textInput2.height + 5, 150, "only lowercase letters allowed.");
		textInput3.forceCase = LOWER_CASE;

		final textInput4 = new FlxUITextInput(textInput3.x, textInput3.y + textInput3.height + 5, 150, "ONLY UPPERCASE LETTERS ALLOWED.");
		textInput4.forceCase = UPPER_CASE;

		final textInput5 = new FlxUITextInput(textInput4.x, textInput4.y + textInput4.height + 5, 150, "onlyLettersAllowed");
		textInput5.filterMode = ONLY_ALPHA;

		final textInput6 = new FlxUITextInput(textInput5.x, textInput5.y + textInput5.height + 5, 150, "1234567890");
		textInput6.filterMode = ONLY_NUMERIC;

		tab.add(textInput);
		tab.add(textInput2);
		tab.add(textInput3);
		tab.add(textInput4);
		tab.add(textInput5);
		tab.add(textInput6);

		tabMenu.addGroup(tab);

		final tab = new FlxUI(tabMenu);
		tab.name = "Numeric Stepper";

		final stepper = new FlxUINumericStepper(10, 10);

		final stepper2 = new FlxUINumericStepper(stepper.x, stepper.y + stepper.height + 5, STACK_VERTICAL);

		final stepper3 = new FlxUINumericStepper(stepper.x, stepper.y + stepper.height + 5, 0.01, 0, 0, 1, 2, true);

		tab.add(stepper);
		tab.add(stepper2);
		tab.add(stepper3);

		tabMenu.addGroup(tab);

		add(tabMenu);

		super.create();
	}
}
