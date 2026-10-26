module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("SF.Interface.Libs.ItemUtil")
local module4 = require("SF.Interface.Libs.MoteUtil")
local v = WeakResource("/SF/Souls/Common/SFIdolMod")

local function fn(object, p, p2, p3)
	local visRangeMaterials, v2 = module3.GetVisRangeMaterials(p2, p3)
	object:OverrideMaterial(p .. ".Name", v2)
	object:OverrideMaterial(p .. ".Subheading", v2)
	object:OverrideMaterial(p .. ".StatusIcon", visRangeMaterials)
	object:OverrideMaterial(p .. ".PremiumGlow", visRangeMaterials)
	object:__wf_atom_933bbce0(p .. ".BgEndLeft", _G.UITexture_ItemList[1], visRangeMaterials)
	object:__wf_atom_933bbce0(p .. ".BgEndRight", _G.UITexture_ItemList[1], visRangeMaterials)
	object:__wf_atom_933bbce0(p .. ".BgFill", _G.UITexture_ItemList[2], visRangeMaterials)
	object:__wf_atom_933bbce0(p .. ".Bookend", _G.UITexture_ItemList[4], visRangeMaterials)
	object:__wf_atom_4c1c1986(p, "BgEndLeft", 12, 70)
	object:__wf_atom_4c1c1986(p, "BgEndRight", 12, 70)
	object:__wf_atom_4c1c1986(p, "BgFill", 12, 70)
	object:__wf_atom_4c1c1986(p, "PremiumGlow", 12, 70)
	object:__wf_atom_4c1c1986(p, "PremiumGlow", 11, _G.UIColor_Yellow)
	object:__wf_atom_7f57ab2f(p, "Name", 54, true)
	object:__wf_atom_7f57ab2f(p, "Subheading", 54, true)
	object:__wf_atom_4c1c1986(p, "Name", 44, _G.UIColor_Beige)
	object:__wf_atom_4c1c1986(p, "Subheading", 44, _G.UIColor_Beige)
	object:__wf_atom_4c1c1986(p, "Status", 44, _G.UIColor_Beige)
	object:__wf_atom_933bbce0(p .. ".Glow", _G.UITexture_ItemList[13], visRangeMaterials)
end

local function fn2(object, p, data, _)
	local focused = data.Focused or false
	local selected = data.Selected or false
	local ternary = module.Ternary(focused, 90, 70)

	if data.Header then
		object:__wf_atom_7f57ab2f(p, "Btn", 67, false)
		object:__wf_atom_7f57ab2f(p, "BgEndLeft", 13, false)
		object:__wf_atom_7f57ab2f(p, "BgEndRight", 13, false)
		object:__wf_atom_7f57ab2f(p, "BgFill", 13, false)
		object:__wf_atom_7f57ab2f(p, "Bookend", 13, false)
	else
		object:__wf_atom_7f57ab2f(p, "Btn", 67, true)
		object:__wf_atom_7f57ab2f(p, "BgEndLeft", 13, true)
		object:__wf_atom_7f57ab2f(p, "BgEndRight", 13, true)
		object:__wf_atom_7f57ab2f(p, "BgFill", 13, true)
		object:__wf_atom_4c1c1986(p, "BgEndLeft", 12, ternary)
		object:__wf_atom_4c1c1986(p, "BgEndRight", 12, ternary)
		object:__wf_atom_4c1c1986(p, "BgFill", 12, ternary)
		object:__wf_atom_c90af43a(p .. ".Bookend", _G.UITexture_ItemList[module.Ternary(selected, 4, 5)])
		object:__wf_atom_7f57ab2f(p, "Bookend", 13, focused and not data.HideBookend)
	end
end

local function fn3(object, p, data, _)
	local v2 = data.Level ~= nil
	local isMoteType = module2.IsMoteType(data.Type)
	local v3 = v2 or #data.Subheading > 0 or isMoteType
	object:__wf_atom_7f57ab2f(p, "Subheading", 13, v3)

	if v3 then
		local subheading = data.Subheading or ""

		if data.MoteItemId then
			local __wf_atom_43563387 = gGameData:GetInventory():__wf_atom_43563387(data.MoteItemId, 0, false)

			for i = 1, #__wf_atom_43563387 do
				if
					__wf_atom_7e8ad928(__wf_atom_43563387[i])
					or __wf_atom_7e8ad928(__wf_atom_43563387[i].mItemType)
					or __wf_atom_43563387[i].mItemType:IsA(v)
				then
					continue
				end

				subheading ..= "<MOTE_ICON>"
			end
		end

		if isMoteType then
			subheading ..= module4.GetMoteDescription(data)
		end

		if v2 then
			local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/SF/Language/Items/Level_Text", true, {
				LEVEL = data.Level
			})
			subheading = ("<font color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">") .. __wf_atom_8e9ac384 .. "</font>" .. "  " .. subheading
		end

		object:__wf_atom_48bd5a59(
			p,
			"Subheading",
			36,
			"<p><font >" .. object:__wf_atom_8e9ac384(subheading, true) .. "</font></p>"
		)
	end
end

local function fn4(object, p, data, _)
	local v2 = data.Name ~= nil
	object:__wf_atom_7f57ab2f(p, "Name", 13, v2)

	if v2 then
		object:__wf_atom_48bd5a59(p, "Name", 36, data.Name)
		object:__wf_atom_7f57ab2f(p, "Name", 54, true)
		object:__wf_atom_4c1c1986(p, "Name", 44, module.Ternary(data.Focused, _G.UIColor_Yellow, _G.UIColor_Beige))
		local v3 = data.Header and 10 or 91
		object:__wf_atom_4c1c1986(p, "Name", 0, data.Status ~= nil and 50 or v3)
		object:__wf_atom_4c1c1986(
			p,
			"Name",
			1,
			-45 + (object:__wf_atom_bd8fa442(p, "Subheading", 13) and 12 or data.Header and 18 or 27)
		)

		if data.ShowStatusIcon then
			object:__wf_atom_4c1c1986(p, "Name", 14, 355)
		end
	end
end

local function fn5(object, p, data, _)
	local focused = data.Focused or false

	if data.GlowOnFocus and focused then
		object:__wf_atom_7f57ab2f(p, "Glow", 13, true)
		object:__wf_atom_4c1c1986(p, "Glow", 1, object:__wf_atom_cfc41e35(p, "BgFill", 1))
		object:__wf_atom_4c1c1986(p, "Glow", 14, object:__wf_atom_cfc41e35(p, "Btn", 14))
		object:__wf_atom_4c1c1986(p, "Glow", 15, object:__wf_atom_cfc41e35(p, "Btn", 15) - 32)
		object:__wf_atom_4c1c1986(p, "Glow", 12, 30)
	else
		object:__wf_atom_7f57ab2f(p, "Glow", 13, false)
	end

	object:__wf_atom_7f57ab2f(p, "PremiumGlow", 13, data.Premium == true)
end

local function fn6(object, p, data, _)
	object:__wf_atom_7f57ab2f(p, "Status", 13, data.Status ~= nil)

	if data.Status ~= nil then
		object:__wf_atom_4c1c1986(p, "Status", 1, object:__wf_atom_cfc41e35(p, "Name", 1))
		object:__wf_atom_7f57ab2f(p, "Status", 54, true)
		object:__wf_atom_4c1c1986(p, "Status", 44, module.Ternary(data.Focused, _G.UIColor_Yellow, _G.UIColor_Beige))
	end

	object:__wf_atom_c90af43a(p .. ".StatusIcon", data.StatusIconRight)
	object:__wf_atom_7f57ab2f(p, "StatusIcon", 13, data.ShowStatusIcon == true)

	if not __wf_atom_7e8ad928(data.StatusIconScale) then
		object:__wf_atom_4c1c1986(p, "StatusIcon", 5, data.StatusIconScale)
		object:__wf_atom_4c1c1986(p, "StatusIcon", 6, data.StatusIconScale)
	end
end

local function fn7(...)
	fn2(...)
	fn4(...)
	fn5(...)
	fn6(...)
end

local function fn8(...)
	fn3(...)
	fn7(...)
end

local function fn9(...)
	fn(...)
	fn8(...)
end

local function fn10(p) -- 3 equivalent calls inferred from this helper
	return p .. ".Item"
end

function Initialize(p, p2, p3, p4)
	if p2 == nil then
		return
	end

	fn9(p, p2, p3, p4)
	module3.Initialize(p, fn10(p2), p3, p4) -- inferred equivalent call
end

function Update(p, p2, p3, p4)
	if p2 == nil then
		return
	end

	fn8(p, p2, p3, p4)
	module3.Update(p, fn10(p2), p3, p4) -- inferred equivalent call
end

function UpdateFocus(p, p2, p3, p4)
	if p2 == nil then
		return
	end

	fn7(p, p2, p3, p4)
	module3.UpdateFocus(p, fn10(p2), p3, p4) -- inferred equivalent call
end