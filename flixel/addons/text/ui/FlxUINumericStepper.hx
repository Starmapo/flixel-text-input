#if flixel_ui
package flixel.addons.text.ui;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIAssets;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUITypedButton;
import flixel.addons.ui.interfaces.IFlxUIClickable;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.addons.ui.interfaces.IHasParams;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxStringUtil;

/**
 * A recreation of the "flixel-ui" numeric stepper that uses `FlxUITextInput`.
 */
class FlxUINumericStepper extends FlxUIGroup implements IFlxUIWidget implements IFlxUIClickable implements IHasParams
{
	/**
	 * This event is dispatched when a numeric stepper button is clicked or the text field is edited.
	 */
	public static var CHANGE_EVENT(get, never):String;

	/**
	 * This event is dispatched when a numeric stepper button is clicked.
	 */
	public static var CLICK_EVENT(get, never):String;

	/**
	 * This event is dispatched when the text field is edited.
	 */
	public static var EDIT_EVENT(get, never):String;

	static inline function get_CHANGE_EVENT():String
	{
		return flixel.addons.ui.FlxUINumericStepper.CHANGE_EVENT;
	}

	static inline function get_CLICK_EVENT():String
	{
		return flixel.addons.ui.FlxUINumericStepper.CLICK_EVENT;
	}

	static inline function get_EDIT_EVENT():String
	{
		return flixel.addons.ui.FlxUINumericStepper.EDIT_EVENT;
	}

	/**
	 * The maximum amount of decimals that the value can have.
	 */
	public var decimals(default, set):Int = 0;

	/**
	 * Whether this numeric stepper displays a percentage (example: a value of `0.5` becomes `50%`).
	 */
	public var isPercent(default, set):Bool = false;

	/**
	 * The maximum value this stepper can have.
	 */
	public var max(default, set):Float = 10;

	/**
	 * The minimum value this stepper can have.
	 */
	public var min(default, set):Float = 0;

	/**
	 * Required for `IHasParams`.
	 */
	public var params(default, set):Array<Dynamic>;

	/**
	 * Required for `IFlxUIClickable`.
	 */
	public var skipButtonUpdate(default, set):Bool;

	/**
	 * Specifies how to stack this stepper's buttons. Can be either `STACK_HORIZONTAL` (default) or `STACK_VERTICAL`.
	 */
	public var stack(default, set):StackMode = STACK_HORIZONTAL;

	/**
	 * The amount that is added or subtracted to the value whenever the plus or minus button is pressed.
	 */
	public var stepSize:Float = 0;

	/**
	 * The current numeric value for this stepper.
	 */
	public var value(default, set):Float = 0;

	/**
	 * The "minus" button for this stepper.
	 */
	var buttonMinus:FlxUITypedButton<FlxSprite>;

	/**
	 * The "plus" button for this stepper.
	 */
	var buttonPlus:FlxUITypedButton<FlxSprite>;

	/**
	 * The text input object for this stepper.
	 */
	var textInput:FlxUITextInput;

	/**
	 * Creates a new `FlxUINumericStepper` object.
	 * @param x The x position of the stepper.
	 * @param y The y position of the stepper.
	 * @param stepSize The amount that is added or subtracted to the value whenever the plus or minus button is pressed.
	 * @param defaultValue The value that this stepper starts with.
	 * @param min The minimum value this stepper can have.
	 * @param max The maximum value this stepper can have.
	 * @param decimals The maximum amount of decimals that the value can have.
	 * @param stack Specifies how to stack this stepper's buttons.
	 * @param textInput An optional text input object to use for this stepper.
	 * @param buttonPlus An optional "plus" button to use for this stepper.
	 * @param buttonMinus An optional "minus" button to use for this stepper.
	 * @param isPercent Whether this numeric stepper displays a percentage (example: a value of `0.5` becomes `50%`).
	 */
	public function new(x:Float = 0, y:Float = 0, stepSize:Float = 1, defaultValue:Float = 0, min:Float = -999, max:Float = 999, decimals:Int = 0,
			stack:StackMode = STACK_HORIZONTAL, ?textInput:FlxUITextInput, ?buttonPlus:FlxUITypedButton<FlxSprite>, ?buttonMinus:FlxUITypedButton<FlxSprite>,
			isPercent:Bool = false)
	{
		super(x, y);

		if (textInput == null)
		{
			textInput = new FlxUITextInput(0, 0, 25);
		}
		textInput.setPosition(0, 0);
		this.textInput = textInput;
		textInput.text = Std.string(defaultValue);

		textInput.onChange.add(_onChange);
		textInput.broadcastToFlxUI = false;

		this.stepSize = stepSize;
		this.decimals = decimals;
		this.min = min;
		this.max = max;
		value = defaultValue;
		this.isPercent = isPercent;

		var btnSize:Int = cast textInput.height;

		if (buttonPlus == null)
		{
			buttonPlus = new FlxUITypedButton<FlxSprite>();
			buttonPlus.loadGraphicSlice9([FlxUIAssets.IMG_BUTTON_THIN], btnSize, btnSize, [FlxStringUtil.toIntArray(FlxUIAssets.SLICE9_BUTTON_THIN)],
				FlxUI9SliceSprite.TILE_NONE, -1, false, FlxUIAssets.IMG_BUTTON_SIZE, FlxUIAssets.IMG_BUTTON_SIZE);
			buttonPlus.label = new FlxSprite(0, 0, FlxUIAssets.IMG_PLUS);
			buttonPlus.autoCenterLabel();
		}
		if (buttonMinus == null)
		{
			buttonMinus = new FlxUITypedButton<FlxSprite>();
			buttonMinus.loadGraphicSlice9([FlxUIAssets.IMG_BUTTON_THIN], btnSize, btnSize, [FlxStringUtil.toIntArray(FlxUIAssets.SLICE9_BUTTON_THIN)],
				FlxUI9SliceSprite.TILE_NONE, -1, false, FlxUIAssets.IMG_BUTTON_SIZE, FlxUIAssets.IMG_BUTTON_SIZE);
			buttonMinus.label = new FlxSprite(0, 0, FlxUIAssets.IMG_MINUS);
			buttonMinus.autoCenterLabel();
		}

		this.buttonPlus = buttonPlus;
		this.buttonMinus = buttonMinus;

		add(textInput);
		add(buttonPlus);
		add(buttonMinus);

		buttonPlus.onUp.callback = _onPlus;
		buttonPlus.broadcastToFlxUI = false;

		buttonMinus.onUp.callback = _onMinus;
		buttonMinus.broadcastToFlxUI = false;

		this.stack = stack;
	}

	/**
	 * Cleans up memory.
	 */
	override public function destroy()
	{
		buttonMinus = FlxDestroyUtil.destroy(buttonMinus);
		buttonPlus = FlxDestroyUtil.destroy(buttonPlus);
		textInput = FlxDestroyUtil.destroy(textInput);

		super.destroy();
	}

	/**
	 * Reduces a number to the required decimal amount.
	 * @param f The number to modify.
	 * @param digits How many decimals are allowed.
	 */
	function decimalize(f:Float, digits:Int):String
	{
		var tens:Float = Math.pow(10, digits);
		return Std.string(Math.round(f * tens) / tens);
	}

	/**
	 * Dispatches `FlxUI.event()`.
	 * @param eventName The name of the event to dispatch.
	 */
	function doCallback(eventName:String):Void
	{
		if (broadcastToFlxUI)
		{
			FlxUI.event(eventName, this, value, params);
		}
	}

	/**
	 * Listener for when the text input is modified.
	 */
	function _onChange()
	{
		var text = textInput.text;
		if (Math.isNaN(Std.parseFloat(text)))
		{
			text = Std.string(min);
		}

		var numDecimals:Int = 0;
		for (i in 0...text.length)
		{
			var char = text.charAt(i);
			if (char == ".")
			{
				numDecimals++;
			}
		}

		var justAddedDecimal = (numDecimals == 1 && text.indexOf(".") == text.length - 1);

		// if I just added a decimal don't treat that as having changed the value just yet
		if (!justAddedDecimal)
		{
			value = Std.parseFloat(text);
			doCallback(EDIT_EVENT);
			doCallback(CHANGE_EVENT);
		}
	}

	/**
	 * Listener for when the "minus" button is pressed.
	 */
	function _onMinus()
	{
		value -= stepSize;
		doCallback(CLICK_EVENT);
		doCallback(CHANGE_EVENT);
	}

	/**
	 * Listener for when the "plus" button is pressed.
	 */
	function _onPlus()
	{
		value += stepSize;
		doCallback(CLICK_EVENT);
		doCallback(CHANGE_EVENT);
	}

	override function set_color(value:FlxColor):FlxColor
	{
		color = value;
		buttonPlus.color = value;
		buttonMinus.color = value;
		textInput.backgroundColor = value;
		return value;
	}

	function set_decimals(i:Int):Int
	{
		decimals = i;
		if (i < 0)
		{
			decimals = 0;
		}
		value = value;
		return decimals;
	}

	function set_isPercent(b:Bool):Bool
	{
		isPercent = b;
		value = value;
		return isPercent;
	}

	function set_max(f:Float):Float
	{
		max = f;
		if (value > max)
		{
			value = max;
		}
		return max;
	}

	function set_min(f:Float):Float
	{
		min = f;
		if (value < min)
		{
			value = min;
		}
		return min;
	}

	function set_params(p:Array<Dynamic>):Array<Dynamic>
	{
		params = p;
		return params;
	}

	function set_skipButtonUpdate(b:Bool):Bool
	{
		skipButtonUpdate = b;
		buttonPlus.skipButtonUpdate = b;
		buttonMinus.skipButtonUpdate = b;
		return b;
	}

	function set_stack(s:StackMode):StackMode
	{
		stack = s;
		var btnSize:Int = 10;
		switch (stack)
		{
			case STACK_HORIZONTAL:
				btnSize = cast textInput.height;
				if (buttonPlus.height != btnSize)
				{
					buttonPlus.resize(btnSize, btnSize);
				}
				if (buttonMinus.height != btnSize)
				{
					buttonMinus.resize(btnSize, btnSize);
				}
				buttonPlus.x = textInput.x + textInput.width;
				buttonPlus.y = textInput.y;
				buttonMinus.x = buttonPlus.x + buttonPlus.width;
				buttonMinus.y = buttonPlus.y;
			case STACK_VERTICAL:
				btnSize = cast textInput.height / 2;
				if (buttonPlus.height != btnSize)
				{
					buttonPlus.resize(btnSize, btnSize);
				}
				if (buttonMinus.height != btnSize)
				{
					buttonMinus.resize(btnSize, btnSize);
				}
				buttonPlus.x = textInput.x + textInput.width;
				buttonPlus.y = textInput.y;
				buttonMinus.x = textInput.x + textInput.width;
				buttonMinus.y = textInput.y + (textInput.height - buttonMinus.height);
		}
		return stack;
	}

	function set_value(f:Float):Float
	{
		value = f;
		if (value < min)
		{
			value = min;
		}
		if (value > max)
		{
			value = max;
		}
		if (textInput != null)
		{
			var displayValue:Float = value;
			if (isPercent)
			{
				displayValue *= 100;
				textInput.text = Std.string(decimalize(displayValue, decimals)) + "%";
			}
			else
			{
				textInput.text = decimalize(displayValue, decimals);
			}
		}
		return value;
	}
}

/**
 * An enumeration of stacking modes for the stepper's buttons.
 */
enum StackMode
{
	/**
	 * Stacks the buttons vertically, on top of eachother. Their size is half the height of the text input.
	 */
	STACK_VERTICAL;

	/**
	 * Stacks the buttons horizontally, next to eachother. Their size is the height of the text input.
	 */
	STACK_HORIZONTAL;
}
#end
