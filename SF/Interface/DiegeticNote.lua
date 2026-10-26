local v = nil
local v2 = nil
local v3 = nil
local module = require("SF.Interface.SFUtilities")
local module2 = require("EE.Interface.Utilities")
local fn
local fn2
local v4 = nil
local flag = false
local v5 = __wf_atom_10cd16b2(1, 0.4)
local v6 = nil
local flag2 = false
local v7 = false
local v8 = 0
local v9 = nil
local v10 = nil
local v11 = { "Note.Text", "Note.HeaderText", "Note.FooterText", "Note.NoteOverlay" }
local v12 = nil

local function fn3(p, p2, p3)
	mMovie:__wf_atom_1ca72041(p, p2, p3, 0, 0, 0)
end

local function fn4(p, p2)
	for _, v13 in ipairs(v11) do
		fn3(v13, p, p2)
	end
end

local function fn5(p)
	if p == 0 then
		v6 = 1
	elseif p == 1 then
		v6 = 0.6
		fn4("DissolveScale", 1.35)
	else
		v6 = 0.75
		fn4("DissolveAnimSpeed", 0.03)
	end
end

function OnDamaged()
	Close()
end

function Initialize()
	module.RegisterHideHud(true)
	module2.PlaySound(openSound)
	local module3 = require("SF.Interface.Components.Button")
	v4 = module3.Create(mMovie, "Note.CloseButton", "/Menu/Continue", "Close", "<MENU_CANCEL>", nil, true, nil, nil)
	v4.mSilent = true

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_5a87af66("OnDamaged")
	end
end

function Shutdown()
	module.RegisterHideHud(false)
end

function InitializeGraveStone(p, p2, p3)
	if p2 == nil or p == nil then
		Close()
		return
	end

	v = Resource(p3) or defualtNoteBackerImage
	mMovie:__wf_atom_2dedec1a("Note.NoteOverlay", 13, false)
	mMovie:__wf_atom_2dedec1a("Note.Text", 13, false)
	mMovie:__wf_atom_2dedec1a("Note.HeaderText", 13, false)
	mMovie:__wf_atom_2dedec1a("Note.FooterText", 13, false)
	mMovie:__wf_atom_c90af43a("Note.Backer", v)
	fn(p, "Note.NameText", 20, 20)
	fn2()
	mMovie:__wf_atom_e57658c2("Note.NameText", 12, 70)
	mMovie:__wf_atom_e57658c2("Note.DeathText", 12, 70)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 1, { 12 }, { 100 }, 0.4)
end

function InitializeNote(p, p2, p3, p4, p5, p6, p7, p8)
	if p2 == nil then
		Close()
		return
	end

	v8 = tonumber(p5) or 0
	v7 = p4 == "true"
	v = Resource(p6) or defualtNoteBackerImage
	v2 = Resource(p7) or nil
	v3 = Resource(p8) or nil
	mMovie:__wf_atom_2dedec1a("Note.NameText", 13, false)
	mMovie:__wf_atom_2dedec1a("Note.DeathText", 13, false)
	mMovie:__wf_atom_2dedec1a("Note.NoteOverlay", 13, false)
	mMovie:__wf_atom_e57658c2("Note.NoteOverlayImage", 12, 0)
	mMovie:__wf_atom_c90af43a("Note.Backer", v)

	if not __wf_atom_7e8ad928(v2) then
		mMovie:__wf_atom_c90af43a("Note.NoteOverlay", v2)
		mMovie:__wf_atom_2dedec1a("Note.NoteOverlay", 13, true)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Note.Backer", 14)
		mMovie:__wf_atom_e57658c2("Note.NoteOverlay", 0, __wf_atom_5e6e15c8 * 0.55)
	end

	module2.PlaySound(openSound)

	if __wf_atom_7e8ad928(p) or p == "" then
		fn("", "Note.HeaderText", 20, 20)
	else
		fn(p, "Note.HeaderText", 20, 20)
	end

	v9 = p
	fn(p2, "Note.Text", 20, 380)

	if __wf_atom_7e8ad928(p3) or p3 == "" then
		fn("", "Note.FooterText", 20, 20)
	else
		fn(p3, "Note.FooterText", 20, 20)
	end

	v10 = p3
	fn2()
	CreateScrollBar("Note.Text")
	mMovie:__wf_atom_e57658c2("Note.HeaderText", 12, 70)
	mMovie:__wf_atom_e57658c2("Note.Text", 12, 70)
	mMovie:__wf_atom_e57658c2("Note.FooterText", 12, 70)

	if v7 then
		mMovie:OverrideMaterial("Note.Text", invisibleInkMaterial)
		mMovie:OverrideMaterial("Note.HeaderText", invisibleInkMaterial)
		mMovie:OverrideMaterial("Note.FooterText", invisibleInkMaterial)
	end

	fn5(v8)

	if __wf_atom_7e8ad928(v2) then
		module.DissolveIn(mMovie)
		return
	end

	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 1, { 12 }, { 100 }, 0.4)
end

local function fn6(p)
	if not v7 then
		return
	end

	fn4("Dissolve", p)
end

function Update()
	local v13 = __wf_atom_084b3e93()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if v7 then
		if flag2 then
			v5:__wf_atom_09294a87(0)
		else
			v5:__wf_atom_09294a87(v6)
		end

		v5:Update(v13)
		fn6(v5:__wf_atom_9e368823())
	end
end

function CreateScrollBar(mClipToScroll)
	local _, v13 = module2.GetRootBasedPosition(mMovie, "Note.Backer")
	local total = 300
	local v14 = __wf_atom_7e8ad928(v9) or v9 == ""
	local v15 = __wf_atom_7e8ad928(v10) or v10 == ""
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Note.HeaderText", 1)
	mMovie:__wf_atom_5e6e15c8("Note.FooterText", 1)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Note.HeaderText", 15)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Note.FooterText", 15)
	local v16 = v13 + __wf_atom_5e6e15c8_2 / 2
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(mClipToScroll, 41)
	local v17 = __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2

	if v14 and v15 then
		total += __wf_atom_5e6e15c8_2 / 2
		v17 = __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 - 20
		v16 = v13
	elseif v14 then
		total += __wf_atom_5e6e15c8_2 / 2
		v16 = v13 - (__wf_atom_5e6e15c8 - __wf_atom_5e6e15c8_2)
		v17 = __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 / 2
	elseif v15 then
		total += __wf_atom_5e6e15c8_3 / 2
		v16 = v13 + 20
		v17 = __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2
	end

	local mVisibleProp = total / (__wf_atom_5e6e15c8_4 + total / 8)
	local module3 = require("SF.Interface.Components.Scrollbar")
	v12 = module3.CreateScrollBar(getfenv(1), "Note.ScrollBar", {
		mClipToScroll = mClipToScroll,
		mVisibleProp = mVisibleProp,
		mHeight = total
	})
	v12.mEnableSmoothScroll = true
	mMovie:__wf_atom_e57658c2("Note.ScrollBar", 1, v17)
	mMovie:OverrideMaterial(mClipToScroll, _G.UIMaterial_VerticalVisibilityRangeText)
	mMovie:__wf_atom_1ca72041(mClipToScroll, "VisibilitySize", module2.GetVisibilitySize(mMovie, total), 0, 1000, 0)
	mMovie:__wf_atom_1ca72041(
		mClipToScroll,
		"VisibilityCenter",
		module2.GetVisibilityCenter(mMovie, v16 + total + 30),
		0,
		0,
		0
	)
	mMovie:__wf_atom_1ca72041(mClipToScroll, "VisibilityFadeSize", module2.GetVisibilitySize(mMovie, 10), 0, 0, 0)
end

function Close()
	if flag then
		return
	end

	flag = true
	module2.PlaySound(closeSound)

	if not __wf_atom_7e8ad928(v3) then
		module2.CreateUIParticles(mMovie, "_root", v3, 0, 0)
	end

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.HideBackground()
	end

	if __wf_atom_7e8ad928(v2) then
		module.DissolveOut(mMovie, function()
			mMovie:Close()
		end, 2, 0)
	else
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 1, 0, function()
			mMovie:Close()
		end)
	end
end

fn2 = function()
	if not __wf_atom_7e8ad928(v9) then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Note.HeaderText", 1)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Note.HeaderText", 41)
		mMovie:__wf_atom_e57658c2("Note.Text", 1, __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 + 20)
	end
end

fn = function(p, p2, p3, p4)
	mMovie:__wf_atom_50d60589(p2, 36, p)
	module.ShrinkTextToFit(mMovie, p2, p, 380, p4, p3)
end

function onKeyDown_POWER_MENU(_, _)
	if v7 and not __wf_atom_7e8ad928(revealInvisibleSound) then
		module2.PlaySound(revealInvisibleSound)
	end

	flag2 = true
end

function onKeyUp_POWER_MENU(_, _)
	if v7 and not __wf_atom_7e8ad928(hideInvisibleSound) then
		module2.PlaySound(hideInvisibleSound)
	end

	flag2 = false
end

function onKeyDown_MENU_CANCEL(_, _)
	Close()
end

function OpenFileFlashMovie()
	local v13 = Resource("/SF/Types/Lore/DiageticNotes/OrlickDiscoveryQuestNotesLoreFragment")

	if __wf_atom_7e8ad928(v13) then
		return
	end

	local __wf_atom_22020464 = v13:__wf_atom_22020464()

	if #__wf_atom_22020464 < 1 then
		return
	end

	local v14 = __wf_atom_22020464[1]
	local v15 = Localize(v14:c_str(), nil)
	local v16 = StringSplit("+", v15)
	local v17 = v16[1] or ""
	local v18 = v16[2] or ""
	local v19 = v16[3] or ""
	InitializeNote(
		v17,
		v18,
		v19,
		nil,
		nil,
		Resource("/SF/Interface/Graphics/Note/NoteBackerSilentRose.png"),
		Resource("/SF/Interface/Graphics/StoreItems/Quests/Orlick/SpectersQuillRotated.png")
	)
end