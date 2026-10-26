local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")

function CreateCustomMarker(object, _)
	if not (icon and object == gRegion:__wf_atom_c4f78a8f()) then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		return
	end

	local v = __wf_atom_e97f3142(object:__wf_atom_cea57010())
	local v2 = object:GetPosition() + v
	__wf_atom_9be88b01:__wf_atom_15e1e57b(icon, v2, markerLimit)
	Sleep(1)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local v3 = 10

	while v3 > 0 do
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("CustomMarker"), v2, 0, 0.5)

		for i = 1, #__wf_atom_439c0d29 do
			if __wf_atom_439c0d29[i]:__wf_atom_6a3d8b57() ~= __wf_atom_eab484a7 then
				continue
			end

			local __wf_atom_bb3e7833 = __wf_atom_439c0d29[i]:__wf_atom_bb3e7833(decoType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				local __wf_atom_bb3e7833_2 = __wf_atom_bb3e7833:__wf_atom_bb3e7833(contextActionType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
					__wf_atom_bb3e7833_2:DoPostAction(object)
				end
			end

			return
		end

		v3 -= 1
		Sleep(0.1)
	end
end

local function fn(p) -- 5 equivalent calls inferred from this helper
	if _T.ShowImpactMessage then
		_T.ShowImpactMessage(p, 3, true, nil, false)
	end

	return false
end

function Evaluate(object, _)
	local __wf_atom_e800787c = object:__wf_atom_e800787c()

	if __wf_atom_7e8ad928(__wf_atom_e800787c) then
		return fn("/Lotus/Language/Menu/InvalidCustomMarkerZone") -- inferred equivalent call
	else
		local __wf_atom_58b2e21e = __wf_atom_e800787c:__wf_atom_58b2e21e()

		if __wf_atom_7e8ad928(__wf_atom_58b2e21e) or __wf_atom_58b2e21e:__wf_atom_1f42e0ec() == EMPTY_SYMBOL then
			return fn("/Lotus/Language/Menu/InvalidCustomMarkerZone") -- inferred equivalent call
		else
			if object ~= gRegion:__wf_atom_c4f78a8f() then
				return true
			end

			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				return
			end

			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				return
			end

			if object:__wf_atom_7b82e9e1(15) then
				return fn("/Lotus/Language/Game/AbilityErrorCannontUseInAir") -- inferred equivalent call
			elseif __wf_atom_9be88b01:__wf_atom_b0998d35(__wf_atom_58b2e21e) >= markerLimit then
				return fn("/Lotus/Language/SystemMessages/CustomMarkerLimit") -- inferred equivalent call
			else
				local v = __wf_atom_e97f3142(object:__wf_atom_cea57010())
				local v2 = object:GetPosition() + v
				local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
				local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("CustomMarker"), v2, 0, minimumRange)

				for i = 1, #__wf_atom_439c0d29 do
					if __wf_atom_439c0d29[i]:__wf_atom_6a3d8b57() == __wf_atom_eab484a7 then
						return fn("/Lotus/Language/SystemMessages/CustomMarkerVicinityLimit") -- inferred equivalent call
					end
				end
			end

			return true
		end
	end
end

function Interact(object, _)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) or __wf_atom_7e8ad928(genericSettingsMovie) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd():__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local __wf_atom_e32e2012 = __wf_atom_3d96ddcd:__wf_atom_e32e2012()
		local mStartIndex = 1

		if not __wf_atom_7e8ad928(__wf_atom_e32e2012) then
			for i = 1, #customIcons do
				if __wf_atom_e32e2012 ~= customIcons[i] then
					continue
				end

				mStartIndex = i
				break
			end
		end

		local screen = _T.OpenScreen("GenericSettings")
		module.PlaySound(_G.UISound_Select)
		screen:Execute(
			"SetTitle",
			screen:__wf_atom_8e9ac384("/Lotus/Language/SystemMessages/CustomMarker_EditTitle", true)
		)

		function _T.EditCustomMarkerSettingsDone(list, p)
			_T.EditCustomMarkerSettingsDone = nil
			_T.GetSettings = nil
			_T.RemoveCustomMarker = nil

			if not __wf_atom_7e8ad928(p) then
				return
			end

			if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				print("Edit custom marker has no game data!")
			elseif list[1].mChanged or list[2].mChanged or list[3].mChanged or list[4].mChanged then
				local v = __wf_atom_f8f86fc5(list[1].mContent, 0)
				local mSelectedIndex = list[2].mIconGrid.mSelectedIndex
				local v2

				if not (mSelectedIndex == nil or not (mSelectedIndex <= #customIcons)) then
					v2 = customIcons[mSelectedIndex]
				end

				local mValue = list[3].mValue
				__wf_atom_9be88b01:__wf_atom_57afab19(__wf_atom_3d96ddcd, v2, v, Color(list[4].mCurrColor), mValue)
			end
		end

		screen:Execute("SetCallBack", "EditCustomMarkerSettingsDone")
		local mRows = math.max(1, (math.ceil(#customIcons / 12)))

		function _T.GetSettings()
			return {
				{
					mLabel = "/Lotus/Language/Menu/Photobooth_EditText",
					mType = module2.INPUTBOX,
					mMaxChars = maxChars,
					mWidth = 500,
					mContent = tostring(__wf_atom_3d96ddcd:__wf_atom_af0b9766()),
					mMultiLine = false
				},
				{
					mLabel = "/Lotus/Language/SystemMessages/CustomMarker_EditIcon",
					mType = module2.ICONBUTTON,
					mWidth = 500,
					mButtonWidth = 520,
					mIcons = customIcons,
					mRows = mRows,
					mColumns = 12,
					mStartIndex = mStartIndex
				},
				{
					mLabel = "/Lotus/Language/SystemMessages/CustomMarker_VisibleInHud",
					mType = module2.CHECKBOX,
					mValue = __wf_atom_3d96ddcd:__wf_atom_4f43112b(),
					mWidth = 500,
					mButtonWidth = 520,
					mValueOffset = 6
				},
				{
					mLabel = TitleCase(Localize("/Lotus/Language/Menu/Color", false)),
					mType = module2.COLOR,
					mWidth = 500,
					mButtonWidth = 520,
					mCurrColor = module.ConvertColorNumberToHex(__wf_atom_3d96ddcd:__wf_atom_8bb9cbd2()):gsub(
						"#",
						"0x00"
					),
					mOnColorSelected = function(p)
						__wf_atom_3d96ddcd:__wf_atom_4a41cc60(Color(p))
					end
				}
			}
		end

		function _T.RemoveCustomMarker()
			return {
				Label = "/Lotus/Language/Actions/Destroy",
				CallBack = function()
					screen:Execute(
						"ShowCustomButtonConfirmation",
						"/Lotus/Language/SystemMessages/CustomMarker_DestroyConfirm"
					)
				end,
				CallOut = "MENU_GENERIC2",
				ConfirmLabel = "/Lotus/Language/SystemMessages/CustomMarker_DestroyConfirm",
				ConfirmCallback = function(p)
					if p then
						if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
							__wf_atom_9be88b01:RemoveCustomMarker(__wf_atom_3d96ddcd)
						end

						screen:Execute("ExitScreen", "")
					end
				end
			}
		end

		screen:Execute("SetElementsFunction", "GetSettings")
		screen:Execute("SetConfirmButtonActive", "true")
		screen:Execute("SetTargetBackgroundAlpha", "0")
		screen:Execute("SetTargetBluerAlpha", "0")
		screen:Execute("SetCustomButtonFunction", "RemoveCustomMarker")
	end
end

local function fn2(object, object2)
	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		if tostring(__wf_atom_be0bea4a[i]:__wf_atom_db682341()) ~= "TextDisplay" then
			continue
		end

		local v = __wf_atom_be0bea4a[i]
		v:Start()
		local __wf_atom_10aa6d9d = v:__wf_atom_10aa6d9d()

		if __wf_atom_7e8ad928(__wf_atom_10aa6d9d) then
			break
		end

		__wf_atom_10aa6d9d:Execute("SetText", (tostring(object2:__wf_atom_af0b9766())))
		break
	end
end

function InitializeContextAction(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local __wf_atom_3d96ddcd2 = __wf_atom_3d96ddcd:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd2) then
			local __wf_atom_6a3d8b57 = __wf_atom_3d96ddcd2:__wf_atom_6a3d8b57()

			while __wf_atom_7e8ad928(__wf_atom_6a3d8b57) do
				Sleep(0.1)

				if __wf_atom_7e8ad928(__wf_atom_3d96ddcd2) then
					return
				else
					__wf_atom_6a3d8b57 = __wf_atom_3d96ddcd2:__wf_atom_6a3d8b57()
				end
			end

			if not __wf_atom_7e8ad928(__wf_atom_6a3d8b57) and __wf_atom_6a3d8b57 == gRegion:__wf_atom_eab484a7() then
				object:Enable()
			end

			fn2(__wf_atom_3d96ddcd, __wf_atom_3d96ddcd2)
		end
	end
end

function UpdateMarkerVisibility(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(gGameData) then
		return
	end

	if module2.InQuestCommitment(gGameData) then
		object:Disable()
	end
end

function InitializeDevOnlyMarker(object)
	object:Disable()
end