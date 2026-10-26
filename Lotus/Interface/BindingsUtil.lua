module(..., package.seeall)
defaultFilter = Resource("/SF/Types/Player/SFInputFilter")
powerMenuFilter = Resource("/SF/Types/Player/SFAimPowerInputFilter")
shawzinFilter = Resource("/Lotus/Interface/Test/ShawzinInputFilter")
SECTION_ID = { GENERAL = 1, POWER_MENU = 2, SHAWZIN = 3 }
LOCMAP = {
	CROUCH = {
		KEYBOARD = { "<HOLD_CROUCH>", "<CROUCH>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction", "/SF/Language/Actions/ToggleAction" },
		CONTROLLER = { "<PRE_CROUCH>", "<CROUCH>" }
	},
	CONSUMABLES = {
		KEYBOARD = { "<CONSUMABLES_HOLD>", "<CONSUMABLES_TOGGLE>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction", "/SF/Language/Actions/ToggleAction" },
		CONTROLLER = { "<CONSUMABLES_HOLD>", "<CONSUMABLES_TOGGLE>" },
		CONTROLLER_EVENTS = { "/SF/Language/Actions/HoldAction", "/SF/Language/Actions/ToggleAction" }
	},
	RUN = {
		KEYBOARD = { "<PRE_RUN>", "<RUN>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction", "/SF/Language/Actions/PressAction" }
	},
	ROLL = {
		KEYBOARD = { "<ACTION>", "<PRE_RUN>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/PressAction", "/SF/Language/Actions/DoubleTapAction" },
		CONTROLLER = { "<PRE_RUN>", "<PRE_CROUCH>" },
		CONTROLLER_EVENTS = { "/SF/Language/Actions/DoubleTapAction", "/SF/Language/Actions/DoubleTapAction" }
	},
	MELEE = {
		KEYBOARD = { "<MELEE>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/PressAction" }
	},
	MELEE_CHANNEL = {
		KEYBOARD = { "<MELEE_CHANNEL>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/PressAction" },
		CONTROLLER = { "<SECONDARY_FIRE>" }
	},
	POWER_STRIKE = {
		KEYBOARD = { "<AIM_WEAPON> + <MELEE_CHANNEL>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction" },
		CONTROLLER = { "<AIM_WEAPON> + <SECONDARY_FIRE>" }
	},
	SWITCH_WEAPON = {
		KEYBOARD = { "<NEXT_INV>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/PressAction" }
	},
	RELOAD = {
		KEYBOARD = { "<RELOAD>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/PressAction" }
	},
	ABILITY_0 = {
		KEYBOARD = { "<POWER_MENU> + <ACTIVATE_ABILITY_MENU_0>", "<ACTIVATE_ABILITY_0>" },
		KEYBOARD_REQ = { "<POWER_MENU>" },
		KEYBOARD_REQ_FILTERS = { defaultFilter },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction" }
	},
	ABILITY_1 = {
		KEYBOARD = { "<POWER_MENU> + <ACTIVATE_ABILITY_MENU_1>", "<ACTIVATE_ABILITY_1>" },
		KEYBOARD_REQ = { "<POWER_MENU>" },
		KEYBOARD_REQ_FILTERS = { defaultFilter },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction" }
	},
	ABILITY_2 = {
		KEYBOARD = { "<POWER_MENU> + <ACTIVATE_ABILITY_MENU_2>", "<ACTIVATE_ABILITY_2>" },
		KEYBOARD_REQ = { "<POWER_MENU>" },
		KEYBOARD_REQ_FILTERS = { defaultFilter },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction" }
	},
	ABILITY_3 = {
		KEYBOARD = { "<POWER_MENU> + <ACTIVATE_ABILITY_MENU_3>", "<ACTIVATE_ABILITY_3>" },
		KEYBOARD_REQ = { "<POWER_MENU>" },
		KEYBOARD_REQ_FILTERS = { defaultFilter },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction" }
	},
	ABILITY_4 = {
		KEYBOARD = { "<POWER_MENU> + <ACTIVATE_ABILITY_MENU_4>", "<ACTIVATE_ABILITY_4>" },
		KEYBOARD_REQ = { "<POWER_MENU>" },
		KEYBOARD_REQ_FILTERS = { defaultFilter },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/HoldAction" }
	},
	SELECT = {
		KEYBOARD = { "<MENU_CLICK>" },
		CONTROLLER = { "<MENU_SELECT>" }
	},
	INSPECT = {
		KEYBOARD = { "<INSPECT>" },
		KEYBOARD_EVENTS = { "/SF/Language/Actions/PressAction" },
		CONTROLLER = { "<INSPECT>", "<AIM_POWER> + <INSPECT>" },
		CONTROLLER_FILTERS = { defaultFilter, powerMenuFilter },
		CONTROLLER_EVENTS = { "/SF/Language/Actions/PressAction", "/SF/Language/Actions/HoldAction" }
	}
}
BINDINGS = {
	{
		{
			Label = "/Lotus/Language/Menu/Input_AIM_POWER",
			Action = "AIM_POWER",
			ExcludePowers = true
		},
		{
			Label = "/Lotus/Language/Menu/Move",
			Action = "MOVE_X",
			ExcludePowers = true,
			StickAction = true
		},
		{ Label = "/Lotus/Language/Menu/Sprint", Action = "RUN", ExcludePowers = true },
		{
			Label = "/Lotus/Language/Menu/Pause",
			Action = "SHOW_PAUSE_MENU",
			ExcludePowers = false,
			ReadOnly = true
		},
		{ Label = "/Lotus/Language/Menu/Input_MELEE", Action = "MELEE", ExcludePowers = true },
		{
			Label = "/Lotus/Language/Menu/Input_MELEE_THROW",
			Action = "MELEE_THROW",
			ExcludePowers = true
		},
		{
			Label = "/Lotus/Language/Menu/Input_MELEE_PARRY",
			Action = "MELEE_PARRY",
			ExcludePowers = true
		},
		{
			Label = "/Lotus/Language/Menu/Input_MELEE_HEAVY",
			Action = "MELEE_HEAVY",
			ExcludePowers = false
		},
		{ Label = "/Lotus/Language/Menu/SwitchWeapon", Action = "NEXT_INV", ExcludePowers = true },
		{ Label = "/Lotus/Language/Menu/ContextAction", Action = "USE", ExcludePowers = false },
		{
			Label = "/Lotus/Language/Menu/Input_CONSUMABLES_HOLD",
			Action = "CONSUMABLES_HOLD",
			ExcludePowers = false
		},
		{
			Label = "/Lotus/Language/Menu/Input_CONSUMABLES_TOGGLE",
			Action = "CONSUMABLES_TOGGLE",
			ExcludePowers = false
		},
		{ Label = "/Lotus/Language/Menu/Jump", Action = "JUMP", ExcludePowers = true },
		{
			Label = "/Lotus/Language/Menu/Look",
			Action = "LOOK_X",
			ExcludePowers = true,
			StickAction = true
		},
		{
			Label = "/Lotus/Language/Menu/ReverseCamera",
			Action = "REVERSE_CAMERA_OFFSET",
			ExcludePowers = true
		},
		{
			Label = "/Lotus/Language/Menu/Input_GEAR_HOTKEY_0",
			Action = "GEAR_HOTKEY_0",
			ExcludePowers = false
		},
		{
			Label = "/Lotus/Language/Menu/Input_PRESS_GAMEPAD",
			Action = "PRESS_GAMEPAD",
			ExcludePowers = false,
			Platform = "PS4"
		},
		{
			Label = "/Lotus/Language/Menu/Input_PRESS_GAMEPAD",
			Action = "PRESS_GAMEPAD",
			ExcludePowers = false,
			Platform = "PS5"
		},
		{
			Label = "/Lotus/Language/Menu/Input_SUMMON_SPARROW",
			Action = "SUMMON_SPARROW",
			ExcludePowers = false
		},
		{
			Label = "/Lotus/Language/Menu/Input_GOTO_NIGHT_FOLD",
			Action = "GOTO_NIGHT_FOLD",
			ExcludePowers = false
		},
		{ Label = "/Lotus/Language/Menu/Input_INSPECT", Action = "INSPECT", ExcludePowers = true },
		{ Label = "/Lotus/Language/Menu/Input_CROUCH", Action = "CROUCH", ExcludePowers = false },
		{ Label = "/Lotus/Language/Menu/Input_PRE_RUN", Action = "PRE_RUN", ExcludePowers = false },
		{ Label = "/Lotus/Language/Menu/Input_ACTION", Action = "ACTION", ExcludePowers = false },
		{ Label = "/Lotus/Language/Menu/NotAvailable", Action = "NONE", ExcludePowers = false }
	},
	{
		{ Label = "/Lotus/Language/Menu/Input_ACTIVATE_ABILITY_0", Action = "ACTIVATE_ABILITY_0" },
		{ Label = "/Lotus/Language/Menu/Input_ACTIVATE_ABILITY_1", Action = "ACTIVATE_ABILITY_1" },
		{ Label = "/Lotus/Language/Menu/Input_ACTIVATE_ABILITY_2", Action = "ACTIVATE_ABILITY_2" },
		{ Label = "/Lotus/Language/Menu/Input_ACTIVATE_ABILITY_3", Action = "ACTIVATE_ABILITY_3" },
		{ Label = "/Lotus/Language/Menu/Input_ACTIVATE_ABILITY_4", Action = "ACTIVATE_ABILITY_4" },
		{ Label = "/Lotus/Language/Menu/Input_INSPECT", Action = "INSPECT" }
	},
	{
		{
			Label = "/SF/Language/Settings/Input_SHAWZIN_NOTE_1",
			Action = "SHAWZIN_NOTE_1",
			ExcludePowers = true
		},
		{
			Label = "/SF/Language/Settings/Input_SHAWZIN_NOTE_2",
			Action = "SHAWZIN_NOTE_2",
			ExcludePowers = true
		},
		{
			Label = "/SF/Language/Settings/Input_SHAWZIN_NOTE_3",
			Action = "SHAWZIN_NOTE_3",
			ExcludePowers = true
		},
		{
			Label = "/SF/Language/Settings/Input_SHAWZIN_NOTE_4",
			Action = "SHAWZIN_NOTE_4",
			ExcludePowers = true
		},
		{
			Label = "/SF/Language/Settings/Input_SHAWZIN_NOTE_5",
			Action = "SHAWZIN_NOTE_5",
			ExcludePowers = true
		},
		{
			Label = "/SF/Language/Settings/Input_SHAWZIN_EXIT",
			Action = "SHAWZIN_EXIT",
			ExcludePowers = false,
			ReadOnly = true
		}
	}
}
PS5_CONTROLLER_BUTTON_LAYOUT = {
	{ Button = "GAMEPAD_L1", AnchorIndex = 1, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_L2", AnchorIndex = 2, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_UP", AnchorIndex = 3, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_LEFT", AnchorIndex = 4, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_DOWN", AnchorIndex = 5, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_RIGHT", AnchorIndex = 6, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_LX",
		IsStick = true,
		AnchorIndex = 7,
		TextAlign = "right",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_LTHUMB", AnchorIndex = 8, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_START",
		AnchorIndex = 9,
		TextAlign = "left",
		Platform = "ALL",
		ReadOnly = true
	},
	{ Button = "GAMEPAD_R1", AnchorIndex = 10, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_R2", AnchorIndex = 11, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_TRIANGLE", AnchorIndex = 12, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_CIRCLE", AnchorIndex = 13, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_X", AnchorIndex = 14, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_SQUARE", AnchorIndex = 15, TextAlign = "left", Platform = "ALL" },
	{
		Button = "GAMEPAD_RX",
		IsStick = true,
		AnchorIndex = 16,
		TextAlign = "left",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_RTHUMB", AnchorIndex = 17, TextAlign = "left", Platform = "ALL" },
	{
		Button = "GAMEPAD_SWIPE_UP",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability1"
	},
	{
		Button = "GAMEPAD_SWIPE_DOWN",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability2"
	},
	{
		Button = "GAMEPAD_SWIPE_LEFT",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability3"
	},
	{
		Button = "GAMEPAD_SWIPE_RIGHT",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability4"
	},
	{
		Button = "GAMEPAD_MOTION_PRESS",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability5"
	}
}
PS4_CONTROLLER_BUTTON_LAYOUT = {
	{ Button = "GAMEPAD_L1", AnchorIndex = 1, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_L2", AnchorIndex = 2, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_UP", AnchorIndex = 3, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_LEFT", AnchorIndex = 4, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_DOWN", AnchorIndex = 5, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_RIGHT", AnchorIndex = 6, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_LX",
		IsStick = true,
		AnchorIndex = 7,
		TextAlign = "right",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_LTHUMB", AnchorIndex = 8, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_START",
		AnchorIndex = 9,
		TextAlign = "left",
		Platform = "ALL",
		ReadOnly = true
	},
	{ Button = "GAMEPAD_R1", AnchorIndex = 10, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_R2", AnchorIndex = 11, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_TRIANGLE", AnchorIndex = 12, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_CIRCLE", AnchorIndex = 13, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_X", AnchorIndex = 14, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_SQUARE", AnchorIndex = 15, TextAlign = "left", Platform = "ALL" },
	{
		Button = "GAMEPAD_RX",
		IsStick = true,
		AnchorIndex = 16,
		TextAlign = "left",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_RTHUMB", AnchorIndex = 17, TextAlign = "left", Platform = "ALL" },
	{
		Button = "GAMEPAD_SWIPE_UP",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability1"
	},
	{
		Button = "GAMEPAD_SWIPE_DOWN",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability2"
	},
	{
		Button = "GAMEPAD_SWIPE_LEFT",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability3"
	},
	{
		Button = "GAMEPAD_SWIPE_RIGHT",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability4"
	},
	{
		Button = "GAMEPAD_MOTION_PRESS",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability5"
	}
}
PS4_REMOTE_PLAY_BUTTON_LAYOUT = {
	{ Button = "GAMEPAD_L2", AnchorIndex = 1, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_UP", AnchorIndex = 2, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_LEFT", AnchorIndex = 3, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_DOWN", AnchorIndex = 4, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_RIGHT", AnchorIndex = 5, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_LX",
		IsStick = true,
		AnchorIndex = 6,
		TextAlign = "right",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_R1", OverrideClipName = "Powers.RearAnchor2", Platform = "ALL" },
	{ Button = "GAMEPAD_L1", OverrideClipName = "Powers.RearAnchor1", Platform = "ALL" },
	{ Button = "GAMEPAD_LTHUMB", OverrideClipName = "Powers.RearAnchor3", Platform = "ALL" },
	{ Button = "GAMEPAD_RTHUMB", OverrideClipName = "Powers.RearAnchor4", Platform = "ALL" },
	{ Button = "GAMEPAD_R2", AnchorIndex = 7, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_TRIANGLE", AnchorIndex = 8, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_CIRCLE", AnchorIndex = 9, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_X", AnchorIndex = 10, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_SQUARE", AnchorIndex = 11, TextAlign = "left", Platform = "ALL" },
	{
		Button = "GAMEPAD_RX",
		IsStick = true,
		AnchorIndex = 12,
		TextAlign = "left",
		Platform = "ALL"
	},
	{
		Button = "GAMEPAD_START",
		AnchorIndex = 13,
		TextAlign = "left",
		Platform = "ALL",
		ReadOnly = true
	},
	{
		Button = "GAMEPAD_SELECT",
		AnchorIndex = 14,
		TextAlign = "left",
		Platform = "ALL",
		ReadOnly = true
	},
	{
		Button = "GAMEPAD_SWIPE_UP",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability1"
	},
	{
		Button = "GAMEPAD_SWIPE_DOWN",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability2"
	},
	{
		Button = "GAMEPAD_SWIPE_LEFT",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability3"
	},
	{
		Button = "GAMEPAD_SWIPE_RIGHT",
		TouchPad = true,
		Platform = "ALL",
		OverrideClipName = "Powers.Ability4"
	}
}
BIGPIC_CONTROLLER_BUTTON_LAYOUT = {
	{ Button = "GAMEPAD_SELECT", AnchorIndex = 18, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_L1", AnchorIndex = 1, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_L2", AnchorIndex = 2, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_LX",
		IsStick = true,
		AnchorIndex = 3,
		TextAlign = "right",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_LTHUMB", AnchorIndex = 4, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_UP", AnchorIndex = 5, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_LEFT", AnchorIndex = 6, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_DOWN", AnchorIndex = 7, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_RIGHT", AnchorIndex = 8, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_START",
		AnchorIndex = 9,
		TextAlign = "left",
		Platform = "ALL",
		ReadOnly = true
	},
	{ Button = "GAMEPAD_R1", AnchorIndex = 10, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_R2", AnchorIndex = 11, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_TRIANGLE", AnchorIndex = 12, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_CIRCLE", AnchorIndex = 13, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_X", AnchorIndex = 14, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_SQUARE", AnchorIndex = 15, TextAlign = "left", Platform = "ALL" },
	{
		Button = "GAMEPAD_RX",
		IsStick = true,
		AnchorIndex = 16,
		TextAlign = "left",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_RTHUMB", AnchorIndex = 17, TextAlign = "left", Platform = "ALL" }
}
XB1_CONTROLLER_BUTTON_LAYOUT = {
	{ Button = "GAMEPAD_SELECT", AnchorIndex = 18, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_L1", AnchorIndex = 1, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_L2", AnchorIndex = 2, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_LX",
		IsStick = true,
		AnchorIndex = 3,
		TextAlign = "right",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_LTHUMB", AnchorIndex = 4, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_UP", AnchorIndex = 5, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_LEFT", AnchorIndex = 6, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_DOWN", AnchorIndex = 7, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_RIGHT", AnchorIndex = 8, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_START",
		AnchorIndex = 9,
		TextAlign = "left",
		Platform = "ALL",
		ReadOnly = true
	},
	{ Button = "GAMEPAD_R1", AnchorIndex = 10, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_R2", AnchorIndex = 11, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_TRIANGLE", AnchorIndex = 12, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_CIRCLE", AnchorIndex = 13, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_X", AnchorIndex = 14, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_SQUARE", AnchorIndex = 15, TextAlign = "left", Platform = "ALL" },
	{
		Button = "GAMEPAD_RX",
		IsStick = true,
		AnchorIndex = 16,
		TextAlign = "left",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_RTHUMB", AnchorIndex = 17, TextAlign = "left", Platform = "ALL" }
}
SWITCH_CONTROLLER_BUTTON_LAYOUT = {
	{ Button = "GAMEPAD_SELECT", AnchorIndex = 3, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_L1", AnchorIndex = 1, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_L2", AnchorIndex = 2, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_LX",
		IsStick = true,
		AnchorIndex = 4,
		TextAlign = "right",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_LTHUMB", AnchorIndex = 5, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_UP", AnchorIndex = 6, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_LEFT", AnchorIndex = 7, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_DOWN", AnchorIndex = 8, TextAlign = "right", Platform = "ALL" },
	{ Button = "GAMEPAD_RIGHT", AnchorIndex = 9, TextAlign = "right", Platform = "ALL" },
	{
		Button = "GAMEPAD_START",
		AnchorIndex = 13,
		TextAlign = "left",
		Platform = "ALL",
		ReadOnly = true
	},
	{ Button = "GAMEPAD_R1", AnchorIndex = 11, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_R2", AnchorIndex = 12, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_TRIANGLE", AnchorIndex = 14, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_CIRCLE", AnchorIndex = 15, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_X", AnchorIndex = 16, TextAlign = "left", Platform = "ALL" },
	{ Button = "GAMEPAD_SQUARE", AnchorIndex = 17, TextAlign = "left", Platform = "ALL" },
	{
		Button = "GAMEPAD_RX",
		IsStick = true,
		AnchorIndex = 18,
		TextAlign = "left",
		Platform = "ALL"
	},
	{ Button = "GAMEPAD_RTHUMB", AnchorIndex = 19, TextAlign = "left", Platform = "ALL" }
}

local function fn(p)
	local v = __wf_atom_9a2b0be4("Graphics.DeviceIconType")

	if p then
		return PS4_REMOTE_PLAY_BUTTON_LAYOUT
	end

	if
		Engine.__wf_atom_6d151271()
		or v == "DIT_PS5"
		or v == "DIT_AUTO" and __wf_atom_8e4fda44:__wf_atom_5707e854() == 6
	then
		return PS5_CONTROLLER_BUTTON_LAYOUT
	end

	if
		Engine.__wf_atom_e43a530e()
		or v == "DIT_PS4"
		or v == "DIT_AUTO" and __wf_atom_8e4fda44:__wf_atom_5707e854() == 2
	then
		return PS4_CONTROLLER_BUTTON_LAYOUT
	end

	if Engine.__wf_atom_84bb79c2() then
		return XB1_CONTROLLER_BUTTON_LAYOUT
	end

	if Engine.__wf_atom_b290ec01() or __wf_atom_9a2b0be4("Graphics.DeviceIconType") == "DIT_SWITCH" then
		return SWITCH_CONTROLLER_BUTTON_LAYOUT
	end

	return BIGPIC_CONTROLLER_BUTTON_LAYOUT
end

function GetControllerButtonLayout(p)
	return (fn(p))
end

local function fn2(object, __wf_atom_622bc136, p, object2, p2, p3, p4)
	if __wf_atom_7e8ad928(object2) then
		print("Filter was null...NOT running ResetFilteredBindings")
		return
	end

	print("Running ResetFilteredBindings: " .. object2:__wf_atom_5b41f63b())
	local v = BINDINGS[p]

	for i = 1, #v do
		local v2 = v[i]
		local action = v2.Action
		local invert = v2.Invert == true
		local v3

		if p3[action] == nil then
			v3 = not p2
		else
			v3 = p2
		end

		if not v3 then
			continue
		end

		if p4 == nil or p4 == true then
			object:__wf_atom_042a8818(action, "unused", invert, object2, __wf_atom_622bc136, true)
		end

		if p4 == nil or p4 == false then
			object:__wf_atom_042a8818(action, "unused", invert, object2, __wf_atom_622bc136, false)
		end

		__wf_atom_8e4fda44:__wf_atom_b2822ea0(action, false)
	end
end

local function fn3(object, __wf_atom_622bc136, items)
	for k, item in pairs(items) do
		object:__wf_atom_042a8818(k, "unused", true, item, __wf_atom_622bc136, true)
		object:__wf_atom_042a8818(k, "unused", true, item, __wf_atom_622bc136, false)
		object:__wf_atom_042a8818(k, "unused", false, item, __wf_atom_622bc136, true)
		object:__wf_atom_042a8818(k, "unused", false, item, __wf_atom_622bc136, false)
		__wf_atom_8e4fda44:__wf_atom_b2822ea0(k, false)
	end
end

local function fn4(object, __wf_atom_622bc136)
	local __wf_atom_2203c0db = object:__wf_atom_2203c0db()

	for i = 1, __wf_atom_c67f9605:__wf_atom_ee321bee() do
		object:__wf_atom_f1bb918d(i - 1)
		object:__wf_atom_7e1a90c3(__wf_atom_622bc136, true)
		object:__wf_atom_7e1a90c3(__wf_atom_622bc136, false)
	end

	object:__wf_atom_f1bb918d(__wf_atom_2203c0db)
end

function ResetCustomBindings()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local settings = __wf_atom_18a5d83b:Settings()
	local __wf_atom_622bc136 = __wf_atom_c67f9605:__wf_atom_622bc136()
	local __wf_atom_6874db21 = settings:__wf_atom_6874db21()
	local v = __wf_atom_6874db21
	local v2 = 9
	Engine.__wf_atom_fc67ba71()
	local flag

	if v2 == nil or not (__wf_atom_6874db21 < v2) then
		flag = false
	else
		__wf_atom_6874db21 = v2
		flag = true
	end

	if flag then
		fn4(settings, __wf_atom_622bc136)
	end

	local v3 = 13
	Engine.__wf_atom_fc67ba71()
	local flag2

	if v3 == nil or not (__wf_atom_6874db21 < v3) then
		flag2 = false
	else
		__wf_atom_6874db21 = v3
		flag2 = true
	end

	if flag2 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			PRE_USE = true,
			USE = true,
			MINI_INVENTORY_HOLD = true,
			MINI_INVENTORY_TOGGLE = true
		})
	end

	local v4 = 15
	Engine.__wf_atom_fc67ba71()
	local flag3

	if v4 == nil or not (__wf_atom_6874db21 < v4) then
		flag3 = false
	else
		__wf_atom_6874db21 = v4
		flag3 = true
	end

	if flag3 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.POWER_MENU, powerMenuFilter, true, {
			ACTIVATE_ABILITY_0 = true,
			ACTIVATE_ABILITY_1 = true,
			ACTIVATE_ABILITY_2 = true,
			ACTIVATE_ABILITY_3 = true,
			ACTIVATE_ABILITY_4 = true
		})
	end

	local v5 = 16
	Engine.__wf_atom_fc67ba71()
	local flag4

	if v5 == nil or not (__wf_atom_6874db21 < v5) then
		flag4 = false
	else
		__wf_atom_6874db21 = v5
		flag4 = true
	end

	if flag4 then
		fn4(settings, __wf_atom_622bc136)
	end

	local v6 = 17
	Engine.__wf_atom_fc67ba71()
	local flag5

	if v6 == nil or not (__wf_atom_6874db21 < v6) then
		flag5 = false
	else
		__wf_atom_6874db21 = v6
		flag5 = true
	end

	if flag5 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			MINI_INVENTORY_HOLD = true,
			MINI_INVENTORY_TOGGLE = true,
			CONSUMABLES_HOLD = true,
			CONSUMABLES_TOGGLE = true
		})
	end

	local v7 = 18
	Engine.__wf_atom_fc67ba71()
	local flag6

	if v7 == nil or not (__wf_atom_6874db21 < v7) then
		flag6 = false
	else
		__wf_atom_6874db21 = v7
		flag6 = true
	end

	if flag6 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			AIM_POWER = true
		})
	end

	local v8 = 19
	Engine.__wf_atom_fc67ba71()
	local flag7

	if v8 == nil or not (__wf_atom_6874db21 < v8) then
		flag7 = false
	else
		__wf_atom_6874db21 = v8
		flag7 = true
	end

	if flag7 then
		fn3(settings, __wf_atom_622bc136, {
			AIM_POWER = defaultFilter,
			ACTIVATE_ABILITY_0 = powerMenuFilter
		})
	end

	local v9 = 20
	Engine.__wf_atom_fc67ba71()
	local flag8

	if v9 == nil or not (__wf_atom_6874db21 < v9) then
		flag8 = false
	else
		__wf_atom_6874db21 = v9
		flag8 = true
	end

	if flag8 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.POWER_MENU, powerMenuFilter, true, {
			ACTIVATE_ABILITY_1 = true,
			ACTIVATE_ABILITY_2 = true,
			ACTIVATE_ABILITY_3 = true
		})
	end

	local v10 = 21
	Engine.__wf_atom_fc67ba71()
	local flag9

	if v10 == nil or not (__wf_atom_6874db21 < v10) then
		flag9 = false
	else
		__wf_atom_6874db21 = v10
		flag9 = true
	end

	if flag9 then
		__wf_atom_7e8ad928("")
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			POWER_MENU = true
		})
		fn2(settings, __wf_atom_622bc136, SECTION_ID.POWER_MENU, powerMenuFilter, true, {
			POWER_MENU = true
		})
	end

	local v11 = 22
	Engine.__wf_atom_fc67ba71()
	local flag10

	if v11 == nil or not (__wf_atom_6874db21 < v11) then
		flag10 = false
	else
		__wf_atom_6874db21 = v11
		flag10 = true
	end

	if flag10 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			GEAR_HOTKEY_1 = true
		})
	end

	local v12 = 23
	Engine.__wf_atom_fc67ba71()
	local flag11

	if v12 == nil or not (__wf_atom_6874db21 < v12) then
		flag11 = false
	else
		__wf_atom_6874db21 = v12
		flag11 = true
	end

	if flag11 then
		settings:__wf_atom_426072c5("RUN", true, true, 0)
		settings:__wf_atom_426072c5("RUN", true, true, 1)
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			PRE_RUN = true,
			RUN = true,
			ACTION = true,
			CROUCH = true,
			MINI_INVENTORY_TOGGLE = true
		})
	end

	local v13 = 26
	Engine.__wf_atom_fc67ba71()
	local flag12

	if v13 == nil or not (__wf_atom_6874db21 < v13) then
		flag12 = false
	else
		__wf_atom_6874db21 = v13
		flag12 = true
	end

	if flag12 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			MINI_INVENTORY_HOLD = true,
			MINI_INVENTORY_TOGGLE = true,
			CONSUMABLES_HOLD = true,
			CONSUMABLES_TOGGLE = true
		})
	end

	local v14 = 27
	Engine.__wf_atom_fc67ba71()
	local flag13

	if v14 == nil or not (__wf_atom_6874db21 < v14) then
		flag13 = false
	else
		__wf_atom_6874db21 = v14
		flag13 = true
	end

	if flag13 then
		settings:__wf_atom_426072c5("RUN", false, true, 0)
	end

	local v15 = 28
	Engine.__wf_atom_fc67ba71()
	local flag14

	if v15 == nil or not (__wf_atom_6874db21 < v15) then
		flag14 = false
	else
		__wf_atom_6874db21 = v15
		flag14 = true
	end

	if flag14 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			POWER_MENU = true
		}, false)
		fn2(
			settings,
			__wf_atom_622bc136,
			SECTION_ID.POWER_MENU,
			defaultFilter,
			true,
			{ ACTIVATE_ABILITY_1 = true, ACTIVATE_ABILITY_2 = true, ACTIVATE_ABILITY_3 = true },
			false
		)
	end

	local v16 = 29
	Engine.__wf_atom_fc67ba71()
	local flag15

	if v16 == nil or not (__wf_atom_6874db21 < v16) then
		flag15 = false
	else
		__wf_atom_6874db21 = v16
		flag15 = true
	end

	if flag15 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			POWER_MENU = true,
			MELEE_HEAVY = true
		})
		fn2(settings, __wf_atom_622bc136, SECTION_ID.POWER_MENU, powerMenuFilter, true, {
			POWER_HELD = true,
			ACTIVATE_ABILITY_4 = true
		})
	end

	local v17 = 30
	Engine.__wf_atom_fc67ba71()
	local flag16

	if v17 == nil or not (__wf_atom_6874db21 < v17) then
		flag16 = false
	else
		__wf_atom_6874db21 = v17
		flag16 = true
	end

	if flag16 then
		fn3(settings, __wf_atom_622bc136, { POWER_MENU = powerMenuFilter })
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			NEXT_INV = true,
			POWER_MENU = true,
			MELEE_HEAVY = true
		})
	end

	local v18 = 31
	Engine.__wf_atom_fc67ba71()
	local flag17

	if v18 == nil or not (__wf_atom_6874db21 < v18) then
		flag17 = false
	else
		__wf_atom_6874db21 = v18
		flag17 = true
	end

	if flag17 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			POWER_HELD = true
		}, false)
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			MELEE_HEAVY = true
		})
	end

	local v19 = 32
	Engine.__wf_atom_fc67ba71()
	local flag18

	if v19 == nil or not (__wf_atom_6874db21 < v19) then
		flag18 = false
	else
		__wf_atom_6874db21 = v19
		flag18 = true
	end

	if flag18 then
		fn3(settings, __wf_atom_622bc136, { EMOTE_HOTKEY_0 = powerMenuFilter })
		fn2(settings, __wf_atom_622bc136, SECTION_ID.GENERAL, defaultFilter, true, {
			POWER_MENU = true,
			POWER_HELD = true,
			AIM_POWER = true
		})
		fn2(settings, __wf_atom_622bc136, SECTION_ID.POWER_MENU, powerMenuFilter, true, {
			POWER_MENU = true,
			POWER_HELD = true,
			AIM_POWER = true,
			ACTIVATE_ABILITY_0 = true
		})
	end

	local v20 = 33
	Engine.__wf_atom_fc67ba71()
	local flag19

	if v20 == nil or not (__wf_atom_6874db21 < v20) then
		flag19 = false
	else
		__wf_atom_6874db21 = v20
		flag19 = true
	end

	if flag19 then
		fn3(settings, __wf_atom_622bc136, { MINI_INVENTORY_HOLD = defaultFilter })
		fn2(
			settings,
			__wf_atom_622bc136,
			SECTION_ID.GENERAL,
			defaultFilter,
			true,
			{ PUSH_TO_TALK = true, CONSUMABLES_HOLD = true },
			false
		)
	end

	local v21 = 34
	Engine.__wf_atom_fc67ba71()
	local flag20

	if v21 == nil or not (__wf_atom_6874db21 < v21) then
		flag20 = false
	else
		__wf_atom_6874db21 = v21
		flag20 = true
	end

	if flag20 then
		fn2(settings, __wf_atom_622bc136, SECTION_ID.POWER_MENU, powerMenuFilter, true, {
			ACTIVATE_ABILITY_4 = true
		})
	end

	if __wf_atom_6874db21 ~= v then
		settings:__wf_atom_ebdcc42d(__wf_atom_6874db21)
		settings:__wf_atom_6b99bafa(false)
		__wf_atom_8e4fda44:__wf_atom_8ef89e30()
		__wf_atom_8e4fda44:__wf_atom_8cd74846()
		__wf_atom_dd7f4712(__wf_atom_18a5d83b:__wf_atom_9be88b01(), "OnProfileSaved")
		__wf_atom_a0f6588f:__wf_atom_507ce99c(0, "OnProfileSaved")
	end
end

function CapitalizeFirstCharacter(value)
	return string.gsub(value, "^(%a)", string.upper, 1)
end

function Valid(value)
	return #value > 0 and not (string.find(value, "<") or string.find(value, "\""))
end

function GetLocForAction(p, p2, p3, p4, p5)
	local v = p2 or _T.BackgroundMovie

	if not __wf_atom_7e8ad928(v) then
		local v2 = LOCMAP[p]

		if v2 then
			local keyboard = v2.KEYBOARD
			local KEYBOARD_EVENTS = v2.KEYBOARD_EVENTS
			local KEYBOARD_FILTERS = v2.KEYBOARD_FILTERS or {}
			local KEYBOARD_REQ = v2.KEYBOARD_REQ or {}
			local KEYBOARD_REQ_FILTERS = v2.KEYBOARD_REQ_FILTERS or {}

			if Engine.IsPlayingWithController() then
				if v2.CONTROLLER ~= nil then
					keyboard = v2.CONTROLLER
					KEYBOARD_EVENTS = v2.CONTROLLER_EVENTS or KEYBOARD_EVENTS
					KEYBOARD_FILTERS = v2.CONTROLLER_FILTERS or {}
					KEYBOARD_REQ = v2.CONTROLLER_REQS or {}
					KEYBOARD_REQ_FILTERS = v2.CONTROLLER_REQS_FILTERS or {}
				end
			elseif Engine.__wf_atom_2a979d69() and v2.MOBILE ~= nil then
				keyboard = v2.MOBILE
				KEYBOARD_EVENTS = v2.MOBILE_EVENTS or KEYBOARD_EVENTS
				KEYBOARD_FILTERS = v2.MOBILE_FILTERS or {}
				KEYBOARD_REQ = v2.MOBILE_REQS or {}
				KEYBOARD_REQ_FILTERS = v2.MOBILE_REQS_FILTERS or {}
			end

			local v3 = nil

			for i, action in ipairs(keyboard) do
				if not p4 then
					local v4 = KEYBOARD_EVENTS[i]

					if v4 == nil then
						v3 = nil
					else
						v3 = { ACTION = action }

						if p5 then
							action = v4 .. "Alt"
						else
							action = v4
						end
					end
				end

				local v4 = KEYBOARD_FILTERS[i]
				local v5

				if v4 == nil then
					v5 = v:__wf_atom_8e9ac384(action, true, v3)
				else
					v5 = v:__wf_atom_c7fa5e0c(action, v4, v3)
				end

				local v6 = KEYBOARD_REQ[i]

				if v6 ~= nil then
					local v7 = KEYBOARD_REQ_FILTERS[i]

					if v7 == nil then
						v6 = v:__wf_atom_8e9ac384(v6, true)
					else
						v6 = v:__wf_atom_c7fa5e0c(v6, v7)
					end

					if Valid(v6) then
						v6 = nil
					end
				end

				if v6 == nil and Valid(v5) then
					return v5, v4
				end
			end

			if p3 then
				return nil
			end
		end
	end

	if p3 then
		return p
	end

	return Localize("/Lotus/Language/Menu/UnboundKey", nil)
end