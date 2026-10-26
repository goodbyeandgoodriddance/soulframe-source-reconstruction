local module = require("EE.Interface.Utilities")
local module2 = require("SF.Scripts.Libs.StatsLib")
local module3 = require("SF.Interface.Components.Button")
local v = nil
local flag = false
local v2 = {}
local v3 = 1
local v4 = Type("/SF/Fx/Interface/CharacterSelect/CharacterSelectFX")

function Initialize()
	module.PlaySound(openSound)
	mMovie:__wf_atom_50d60589(
		"Menu.Title.Label",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Envoy/BodySelectTitle", false)
	)
	mMovie:SetCallbacks("Menu.LeftArrow.Button", "ArrowFocus", "ArrowUnfocus", "ArrowRelease", "ArrowPress")
	mMovie:__wf_atom_e57658c2("Menu.LeftArrow.Button", 100, -1)
	mMovie:SetCallbacks("Menu.RightArrow.Button", "ArrowFocus", "ArrowUnfocus", "ArrowRelease", "ArrowPress")
	mMovie:__wf_atom_e57658c2("Menu.RightArrow.Button", 100, 1)
	v = module3.Create(
		mMovie,
		"Menu.SelectBtn",
		"/SF/Language/Envoy/BodySelectConfirm",
		"BodySelected",
		"<MENU_SELECT>"
	)
	v:SetVariant(module3.VARIANTS.SPECIAL_BUTTON)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 1, { 12 }, { 100 }, 2)

	for _, v5 in ipairs(envoyDecoTypes) do
		table.insert(v2, gRegion:FindNearestTagged(v5:__wf_atom_db682341(), gRegion:GetGameCamera():GetPosition()))
	end
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
end

function AdvanceAndShutdown()
	if flag then
		return
	end

	flag = true

	for i = 1, #v2 do
		if i == v3 or __wf_atom_7e8ad928(v2[i]) then
			continue
		end

		gRegion:__wf_atom_dd1e4d10(v2[i])
	end

	module.PlaySound(selectSound)
	gGameData:__wf_atom_993aebc4("OnSaveLoadoutComplete")
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 2, 0, function()
		mMovie:Close()
	end)
end

local function fn(value) -- 4 equivalent calls inferred from this helper
	return string.gsub(value, ".Button", "")
end

function ArrowFocus(_, value)
	if flag then
		return
	end

	local v5 = fn(value) -- inferred equivalent call
	__wf_atom_ec43d06e(mMovie, v5, 2, { 14, 15 }, { 120, 120 }, 0.2)
	module.PlaySound(focusSound)
end

function ArrowUnfocus(_, value)
	if flag then
		return
	end

	local v5 = fn(value) -- inferred equivalent call
	__wf_atom_ec43d06e(mMovie, v5, 2, { 14, 15 }, { 102, 102 }, 0.2)
end

function ArrowRelease(p, value)
	if flag then
		return
	end

	local v5 = fn(value) -- inferred equivalent call
	mMovie:__wf_atom_e57658c2(v5 .. ".Icon", 0, 0)
	v2[v3]:SetVisibility(false)
	v3 += p

	if v3 < 1 then
		v3 = #v2
	elseif v3 > #v2 then
		v3 = 1
	end

	local v6

	if v3 == nil then
		v6 = false
	else
		v6 = v3 > 1
	end

	gRegion:__wf_atom_c4f78a8f():__wf_atom_72cd7949(v6)
	gGameData:__wf_atom_575ed439(v6)
	v2[v3]:SetVisibility(true)
	v2[v3]:Attach(v4, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
end

function ArrowPress(_, value)
	if flag then
		return
	end

	local v5 = fn(value) -- inferred equivalent call
	mMovie:__wf_atom_e57658c2(v5 .. ".Icon", 0, -2)
end

function BodySelected()
	module2.ReplicateLogEvent("PROLOGUE_QUEST", "ChooseFrame", v3, nil, nil, "ChooseFrame")
	AdvanceAndShutdown()
	module.PlaySound(exitSound)
end

function onKeyDown_MENU_SELECT(_, _)
	BodySelected()
	return true
end

function OnSaveLoadoutComplete(_, _)
	print("FirstLogin - BodySelection : OnSaveLoadoutComplete")
end