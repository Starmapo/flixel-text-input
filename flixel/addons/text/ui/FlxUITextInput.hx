package flixel.addons.text.ui;

import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSignal;
import lime.system.Clipboard;
#if flixel_ui
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.addons.ui.interfaces.IHasParams;
import flixel.addons.ui.interfaces.IResizable;
#end

/**
 * A custom version of `FlxTextInput` that implements the style of the "flixel-ui" text input.
 * 
 * This isn't meant to replicate the original `FlxUIInputText` one-for-one, so you might have to make some modifications to your
 * code if you want to replace all instances of the original text input.
 * 
 * **Note:** Multiline and word wrapping is disabled by default.
 */
class FlxUITextInput extends FlxSpriteGroup #if flixel_ui implements IResizable implements IFlxUIWidget implements IHasParams #end
{
	#if flixel_ui
	/**
	 * This event is dispatched when the text is changed in any way.
	 */
	public static var CHANGE_EVENT(get, never):String;

	/**
	 * This event is dispatched when text is deleted.
	 */
	public static var DELETE_EVENT(get, never):String;

	/**
	 * This event is dispatched when the `Enter` key is pressed.
	 */
	public static var ENTER_EVENT(get, never):String;

	/**
	 * This event is dispatched when text is inputted.
	 */
	public static var INPUT_EVENT(get, never):String;

	static inline function get_CHANGE_EVENT():String
	{
		return FlxUIInputText.CHANGE_EVENT;
	}

	static inline function get_DELETE_EVENT():String
	{
		return FlxUIInputText.DELETE_EVENT;
	}

	static inline function get_ENTER_EVENT():String
	{
		return FlxUIInputText.ENTER_EVENT;
	}

	static inline function get_INPUT_EVENT():String
	{
		return FlxUIInputText.INPUT_EVENT;
	}
	#end

	/**
	 * Whether or not the textbox has a background.
	 */
	public var background:Bool = false;

	/**
	 * The color of the background of the textbox.
	 */
	public var backgroundColor(default, set):FlxColor = FlxColor.WHITE;

	#if flixel_ui
	/**
	 * If false, this does not issue FlxUI.event() calls.
	 */
	public var broadcastToFlxUI:Bool;
	#end

	/**
	 * The index of the insertion point (caret) position. If no insertion point is displayed, the value is the position the insertion point
	 * would be if you restored focus to the text (typically where the insertion point last was, or 0 if the text has not had focus).
	 */
	public var caretIndex(get, set):Int;

	/**
	 * Specifies whether the text object is a password text field, which hides the input characters using asterisks instead of the actual
	 * characters. When password mode is enabled, the Cut and Copy commands and their respective keyboard shortcuts will not function.
	 */
	public var displayAsPassword(get, set):Bool;

	/**
	 * The color of the field borders.
	 */
	public var fieldBorderColor(default, set):FlxColor = FlxColor.BLACK;

	/**
	 * The thickness of the field borders.
	 */
	public var fieldBorderThickness(default, set):Int = 1;

	/**
	 * The height of `TextField` object used for bitmap generation for the text object.
	 * Use it when you want to change the visible height of the text. Enables "auto height" if `<= 0`.
	 * 
	 * **NOTE:** Fixed height has no effect if `autoSize = true`.
	 */
	public var fieldHeight(get, set):Float;

	/**
	 * The width of the `TextField` object used for bitmap generation for the text object.
	 * Use it when you want to change the visible width of text. Enables `autoSize` if `<= 0`.
	 * 
	 * **NOTE:** auto width always implies auto height
	 */
	public var fieldWidth(get, set):Float;

	/**
	 * Defines what text to filter. It can be `NO_FILTER`, `ONLY_ALPHA`, `ONLY_NUMERIC`, `ONLY_ALPHA_NUMERIC` or `CUSTOM_FILTER(EReg)`
	 */
	public var filterMode(get, set):FilterMode;

	/**
	 * Specifies whether the text object currently has focus and is able to receive text input.
	 */
	public var focus(get, set):Bool;

	/**
	 * The case that's being enforced. Either `ALL_CASES`, `UPPER_CASE` or `LOWER_CASE`.
	 */
	public var forceCase(get, set):CaseMode;

	/**
	 * The maximum number of characters that the text object can contain, as entered by a user. A script can insert more text than `maxChars`
	 * allows; the `maxChars` property indicates only how much text a user can enter.
	 */
	public var maxChars(get, set):Int;

	/**
	 * Indicates whether the text object is a multiline text field. In a field of type `TextFieldType.INPUT`, the `multiline` value determines
	 * whether the `Enter` key creates a new line (a value of `false`, and the `Enter` key is ignored).
	 * 
	 * **Note:** If `wordWrap` is set to `true`, the text will still be split into lines if it is longer than `fieldWidth`.
	 */
	public var multiline(get, set):Bool;

	#if flixel_ui
	/**
	 * Required for `IFlxUIWIdget`.
	 */
	public var name:String;
	#end

	/**
	 * This signal is dispatched when the `Backspace` key is pressed while this object is receiving text input.
	 */
	public var onBackspace(get, never):FlxSignal;

	/**
	 * This signal is dispatched when the text is changed by the user.
	 */
	public var onChange(get, never):FlxSignal;

	/**
	 * This signal is dispatched when the `Delete` key is pressed while this object is receiving text input.
	 */
	public var onDelete(get, never):FlxSignal;

	/**
	 * This signal is dispatched when the `Enter` key is pressed by the user while this object is receiving text input.
	 */
	public var onEnter(get, never):FlxSignal;

	/**
	 * This signal is dispatched when this text object gains focus.
	 */
	public var onFocusGained(get, never):FlxSignal;

	/**
	 * This signal is dispatched when this text object loses focus.
	 */
	public var onFocusLost(get, never):FlxSignal;

	/**
	 * This signal is dispatched when text is added by the user to this object.
	 */
	public var onInput(get, never):FlxSignal;

	/**
	 * This signal is dispatched when the text is scrolled horizontally or vertically.
	 */
	public var onScroll(get, never):FlxSignal;

	#if flixel_ui
	/**
	 * Required for `IHasParams`.
	 */
	public var params(default, set):Array<Dynamic>;
	#end

	/**
	 * The text being displayed.
	 */
	public var size(get, set):Int;

	/**
	 * The text being displayed.
	 */
	public var text(get, set):String;

	/**
	 * The actual `FlxTextInput` object in the group.
	 */
	public var tf(default, null):UITextInput;

	/**
	 * Whether to use word wrapping or not (`true` by default).
	 */
	public var wordWrap(get, set):Bool;

	/**
	 * A `FlxSprite` representing the background sprite.
	 */
	var backgroundSprite:FlxSprite;

	/**
	 * A `FlxSprite` representing the field borders.
	 */
	var fieldBorderSprite:FlxSprite;

	/**
	 * Creates a new `FlxUITextInput` object.
	 * @param x The x position of the text.
	 * @param y The y position of the text.
	 * @param fieldWidth The `width` of the text object. (`height` is determined automatically).
	 * @param text The actual text you would like to display initially.
	 * @param size The font size for this text object.
	 * @param textColor The color of the text.
	 * @param backgroundColor The color of the background (`FlxColor.TRANSPARENT` for no background color).
	 * @param embeddedFont Whether this text field uses embedded fonts or not.
	 */
	public function new(x:Float = 0, y:Float = 0, fieldWidth:Float = 150, ?text:String, size:Int = 8, textColor:FlxColor = FlxColor.BLACK,
			backgroundColor:FlxColor = FlxColor.WHITE, embeddedFont:Bool = true)
	{
		super(x, y);

		tf = new UITextInput(0, 0, fieldWidth, text, size, embeddedFont);
		tf.wordWrap = tf.multiline = false;
		tf.color = textColor;

		fieldBorderSprite = new FlxSprite();

		backgroundSprite = new FlxSprite();

		add(fieldBorderSprite);
		add(backgroundSprite);
		add(tf);

		this.backgroundColor = backgroundColor;

		if (backgroundColor != FlxColor.TRANSPARENT)
		{
			background = true;
		}

		#if flixel_ui
		onEnter.add(_onEnter);
		onDelete.add(_onDelete);
		onBackspace.add(_onDelete);
		onInput.add(_onInput);
		#end
	}

	override public function destroy():Void
	{
		backgroundSprite = FlxDestroyUtil.destroy(backgroundSprite);
		fieldBorderSprite = FlxDestroyUtil.destroy(fieldBorderSprite);
		tf = FlxDestroyUtil.destroy(tf);

		super.destroy();
	}

	override public function draw():Void
	{
		updateSprites();

		super.draw();
	}

	override public function updateHitbox():Void
	{
		updateSprites();

		super.updateHitbox();
	}

	public function resize(w:Float, h:Float):Void
	{
		fieldWidth = w;
		fieldHeight = h;
	}

	/**
	 * Updates the sprites' positions and graphics.
	 */
	function updateSprites()
	{
		if (background && fieldBorderThickness > 0)
		{
			fieldBorderSprite.makeGraphic(1, 1, fieldBorderColor);
			fieldBorderSprite.setGraphicSize(tf.width + fieldBorderThickness * 2, tf.height + fieldBorderThickness * 2);
			fieldBorderSprite.updateHitbox();
			fieldBorderSprite.exists = true;
		}
		else
		{
			fieldBorderSprite.exists = false;
		}

		if (background)
		{
			backgroundSprite.makeGraphic(1, 1, backgroundColor);
			backgroundSprite.setGraphicSize(tf.width, tf.height);
			backgroundSprite.updateHitbox();
			backgroundSprite.setPosition(x + fieldBorderThickness, y + fieldBorderThickness);
			backgroundSprite.exists = true;
		}
		else
		{
			backgroundSprite.exists = false;
		}

		if (background)
		{
			tf.setPosition(x + fieldBorderThickness, y + fieldBorderThickness);
		}
		else
		{
			tf.setPosition(x, y);
		}
	}

	#if flixel_ui
	function _onDelete()
	{
		if (broadcastToFlxUI)
		{
			FlxUI.event(DELETE_EVENT, this, text, params);
			FlxUI.event(CHANGE_EVENT, this, text, params);
		}
	}

	function _onEnter()
	{
		if (broadcastToFlxUI)
		{
			FlxUI.event(ENTER_EVENT, this, text, params);
		}
	}

	function _onInput()
	{
		if (broadcastToFlxUI)
		{
			FlxUI.event(INPUT_EVENT, this, text, params);
			FlxUI.event(CHANGE_EVENT, this, text, params);
		}
	}
	#end

	function set_backgroundColor(value:Int):Int
	{
		backgroundColor = value;
		updateSprites();
		return backgroundColor;
	}

	function get_caretIndex():Int
	{
		return tf.caretIndex;
	}

	function set_caretIndex(value:Int):Int
	{
		return tf.caretIndex = value;
	}

	function get_displayAsPassword():Bool
	{
		return tf.displayAsPassword;
	}

	function set_displayAsPassword(value:Bool):Bool
	{
		if (tf.displayAsPassword != value)
		{
			tf.displayAsPassword = value;
			updateSprites();
		}
		return value;
	}

	function set_fieldBorderColor(value:Int):Int
	{
		fieldBorderColor = value;
		updateSprites();
		return fieldBorderColor;
	}

	function set_fieldBorderThickness(value:Int):Int
	{
		fieldBorderThickness = value;
		updateSprites();
		return fieldBorderThickness;
	}

	function get_fieldHeight():Float
	{
		return tf.fieldHeight;
	}

	function set_fieldHeight(value:Float):Float
	{
		tf.fieldHeight = value;
		updateSprites();
		return value;
	}

	function get_fieldWidth():Float
	{
		return tf.fieldWidth;
	}

	function set_fieldWidth(value:Float):Float
	{
		tf.fieldWidth = value;
		updateSprites();
		return value;
	}

	function get_filterMode():FilterMode
	{
		return tf.filterMode;
	}

	function set_filterMode(value:FilterMode):FilterMode
	{
		if (tf.filterMode != value)
		{
			tf.filterMode = value;
			updateSprites();
		}
		return value;
	}

	function get_focus():Bool
	{
		return tf.focus;
	}

	function set_focus(value:Bool):Bool
	{
		return tf.focus = value;
	}

	function get_forceCase():CaseMode
	{
		return tf.forceCase;
	}

	function set_forceCase(value:CaseMode):CaseMode
	{
		if (tf.forceCase != value)
		{
			tf.forceCase = value;
			updateSprites();
		}
		return value;
	}

	function get_maxChars():Int
	{
		return tf.maxChars;
	}

	function set_maxChars(value:Int):Int
	{
		return tf.maxChars = value;
	}

	function get_multiline():Bool
	{
		return tf.multiline;
	}

	function set_multiline(value:Bool):Bool
	{
		return tf.multiline = value;
	}

	function get_onBackspace():FlxSignal
	{
		return tf.onBackspace;
	}

	function get_onChange():FlxSignal
	{
		return tf.onChange;
	}

	function get_onDelete():FlxSignal
	{
		return tf.onDelete;
	}

	function get_onEnter():FlxSignal
	{
		return tf.onEnter;
	}

	function get_onFocusGained():FlxSignal
	{
		return tf.onFocusGained;
	}

	function get_onFocusLost():FlxSignal
	{
		return tf.onFocusLost;
	}

	function get_onInput():FlxSignal
	{
		return tf.onInput;
	}

	function get_onScroll():FlxSignal
	{
		return tf.onScroll;
	}

	#if flixel_ui
	function set_params(p:Array<Dynamic>):Array<Dynamic>
	{
		params = p;
		if (params == null)
		{
			params = [];
		}
		var namedValue:NamedString = {name: "value", value: text};
		params.push(namedValue);
		return p;
	}
	#end

	function get_size():Int
	{
		return tf.size;
	}

	function set_size(value:Int):Int
	{
		tf.size = value;
		updateSprites();
		return value;
	}

	function get_text():String
	{
		return tf.text;
	}

	function set_text(value:String):String
	{
		if (tf.text != value)
		{
			tf.text = value;
			updateSprites();
		}
		return value;
	}

	function get_wordWrap():Bool
	{
		return tf.wordWrap;
	}

	function set_wordWrap(value:Bool):Bool
	{
		if (tf.wordWrap != value)
		{
			tf.wordWrap = value;
			updateSprites();
		}
		return value;
	}
}

/**
 * A custom version of `FlxTextInput`, adding properties from `FlxUIInputText`.
 */
class UITextInput extends FlxTextInput
{
	/**
	 * Defines what text to filter. It can be `NO_FILTER`, `ONLY_ALPHA`, `ONLY_NUMERIC`, `ONLY_ALPHA_NUMERIC` or `CUSTOM_FILTER(EReg)`
	 */
	public var filterMode(default, set):FilterMode = NO_FILTER;

	/**
	 * The case that's being enforced. Either `ALL_CASES`, `UPPER_CASE` or `LOWER_CASE`.
	 */
	public var forceCase(default, set):CaseMode = ALL_CASES;

	override function onPasteHandler(text:String):Void
	{
		super.onPasteHandler(filter(text));
	}

	override function onWindowTextInputHandler(value:String):Void
	{
		super.onWindowTextInputHandler(filter(value));
	}

	/**
	 * Filters the text based on `forceCase` and `filterMode`.
	 * @param text The text to filter.
	 * @return The filtered text.
	 */
	function filter(text:String):String
	{
		switch (forceCase)
		{
			case UPPER_CASE:
				text = text.toUpperCase();
			case LOWER_CASE:
				text = text.toLowerCase();
			default:
		}

		if (filterMode != NO_FILTER)
		{
			final pattern:EReg = switch (filterMode)
			{
				case ONLY_ALPHA:
					~/[^a-zA-Z]*/g;
				case ONLY_NUMERIC:
					~/[^0-9]*/g;
				case ONLY_ALPHANUMERIC:
					~/[^a-zA-Z0-9]*/g;
				case CUSTOM_FILTER(e):
					e;
				default:
					throw "FlxUITextInput: Unknown filterMode (" + filterMode + ")";
			}
			text = pattern.replace(text, "");
		}

		return text;
	}

	function set_filterMode(value:FilterMode):FilterMode
	{
		filterMode = value;
		text = filter(text);
		return value;
	}

	function set_forceCase(value:CaseMode):CaseMode
	{
		forceCase = value;
		text = filter(text);
		return value;
	}
}

/**
 * An enumeration for all letter case modes.
 */
enum CaseMode
{
	/**
	 * Any case is allowed.
	 */
	ALL_CASES;

	/**
	 * All text is forced into uppercase.
	 */
	UPPER_CASE;

	/**
	 * All text is forced into lowercase.
	 */
	LOWER_CASE;
}

/**
 * An enumeration of all text filter modes.
 */
enum FilterMode
{
	/**
	 * All characters are allowed.
	 */
	NO_FILTER;

	/**
	 * Only alphabet letters are allowed.
	 */
	ONLY_ALPHA;

	/**
	 * Only numbers are allowed.
	 */
	ONLY_NUMERIC;

	/**
	 * Only alphabet letters and numbers are allowed.
	 */
	ONLY_ALPHANUMERIC;

	/**
	 * A custom filter is applied to the text.
	 */
	CUSTOM_FILTER(filter:EReg);
}
