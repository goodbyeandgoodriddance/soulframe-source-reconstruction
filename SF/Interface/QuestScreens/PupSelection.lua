local v = { Edge = nil, Inner = nil }
local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("EE.Interface.Utilities")
local module4 = require("Lotus.Interface.LotusUtilities")
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local flag = false
local v7 = false
local v8 = nil
local v9 = false
local v10 = nil
local v11 = {}
local v12 = { Symbol("GraceCubSelectedCine"), Symbol("CourageCubSelectedCine"), Symbol("SpiritCubSelectedCine") }
local v13 = { "Default", "LightBrown", "DarkBrown" }
local _ = {
	{
		tint0 = 16777215,
		tint1 = 16777215,
		tint2 = 4008747,
		tint3 = 16777215,
		tint4 = 16777215
	},
	{
		tint0 = 13016690,
		tint1 = 11171130,
		tint2 = 1445647,
		tint3 = 15249525,
		tint4 = 16777215
	},
	{
		tint0 = 4538939,
		tint1 = 11177341,
		tint2 = 1973530,
		tint3 = 5657683,
		tint4 = 4538939
	}
}
local _ = {
	{
		tint0 = 16777215,
		tint1 = 9731429,
		tint2 = 459778,
		tint3 = 6381921,
		tint4 = 16777215
	},
	{
		tint0 = 11765071,
		tint1 = 10118438,
		tint2 = 13814468,
		tint3 = 986638,
		tint4 = 8618883
	},
	{
		tint0 = 5914403,
		tint1 = 9269844,
		tint2 = 14143413,
		tint3 = 0,
		tint4 = 657673
	}
}

local function fn(p)
	for i = 1, 3 do
		mMovie:__wf_atom_e57658c2("Picker" .. i .. ".Hover", 12, module3.Ternary(p == i, 100, 50))
	end
end

local function fn2(p)
	mMovie:__wf_atom_48bd5a59(p, "Label.Label", 36, Localize("/SF/Language/Quests/OrengallPupSelection", false))
	mMovie:__wf_atom_e57658c2(p .. ".HighlightNode", 12, 0)
	mMovie:OverrideMaterial(p .. ".Label.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(p .. ".Label.Bg", "RectInnerColor", v.Inner.r, v.Inner.g, v.Inner.b, 1)
	mMovie:__wf_atom_1ca72041(p .. ".Label.Bg", "RectEdgeColor", v.Edge.r, v.Edge.g, v.Edge.b, 1)
	mMovie:__wf_atom_c90af43a(p .. ".Label.LeftCap", catLabelEdgeTexture)
	mMovie:__wf_atom_c90af43a(p .. ".Label.RightCap", catLabelEdgeTexture)
	local v14 = mMovie:__wf_atom_cfc41e35(p, "Label.Label", 40) + 10
	mMovie:__wf_atom_4c1c1986(p, "Label.Bg", 14, v14)
	mMovie:__wf_atom_4c1c1986(p, "Label.LeftCap", 0, -(v14 / 2) - 15)
	mMovie:__wf_atom_4c1c1986(p, "Label.RightCap", 0, v14 / 2 + 15)
	mMovie:__wf_atom_4c1c1986(p, "Label", 12, 0)
	mMovie:SetCallbacks(p .. ".Hover", "NodeRollOver", "NodeRollOut", "NodeClicked", nil)
end

local function fn3(p, p2)
	mMovie:__wf_atom_50d60589("Title.Name", 36, p)
	mMovie:__wf_atom_50d60589("Title.Details", 36, p2)
	module2.CenterClipAroundText(mMovie, "Title.Name", "Title.LeftLeaf", true, 20)
	module2.CenterClipAroundText(mMovie, "Title.Name", "Title.RightLeaf", false, 10)
	mMovie:__wf_atom_e57658c2("Title.Backer", 14, mMovie:__wf_atom_5e6e15c8("Title.Details", 40) + 40)
end

local function fn4(p)
	if flag then
		return
	end

	if p == nil then
		__wf_atom_ec43d06e(mMovie, "Title", 0, { 12 }, { 0 }, 0.3)
		return
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Picker" .. p, 0)
	mMovie:__wf_atom_e57658c2("Title", 0, __wf_atom_5e6e15c8)
	__wf_atom_ec43d06e(mMovie, "Title", 0, { 12 }, { 100 }, 0.3)
	fn3(
		Localize("/SF/Language/Quests/" .. "OrengallPupName" .. p, false),
		Localize("/SF/Language/Quests/" .. "OrengallPupFlavor" .. p, false)
	)
end

local function fn5()
	mMovie:__wf_atom_2dedec1a("_root", 13, true)
	__wf_atom_ec43d06e(mMovie, "Title", 0, { 12 }, { 100 }, 0.3)
	mMovie:__wf_atom_e57658c2("Title.Name", 12, 0)
	mMovie:__wf_atom_e57658c2("Title.Details", 12, 100)
	mMovie:__wf_atom_2dedec1a("Picker1", 13, false)
	mMovie:__wf_atom_2dedec1a("Picker2", 13, false)
	mMovie:__wf_atom_2dedec1a("Picker3", 13, false)
	mMovie:__wf_atom_e57658c2("Title.LeftLeaf", 12, 0)
	mMovie:__wf_atom_e57658c2("Title.RightLeaf", 12, 0)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Picker" .. 2, 0)
	mMovie:__wf_atom_e57658c2("Title", 0, __wf_atom_5e6e15c8)
	mMovie:__wf_atom_50d60589("Title.Details", 36, Localize("/SF/Language/Quests/WaitingForOtherPlayers", false))
	mMovie:__wf_atom_e57658c2("Title.Backer", 14, mMovie:__wf_atom_5e6e15c8("Title.Details", 40) + 40)
end

local function fn6()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return nil
	end

	local __wf_atom_ed5c034d = __wf_atom_eab484a7:__wf_atom_a4299765():__wf_atom_ed5c034d(1, 0)

	if not __wf_atom_7e8ad928(__wf_atom_ed5c034d.mItemType) then
		for i = 1, #pupSuits do
			if __wf_atom_ed5c034d.mItemType == pupSuits[i] and i <= #v13 then
				return i
			end
		end
	end

	return nil
end

function Initialize()
	module2.RegisterHideHud(true)
	mMovie:__wf_atom_2dedec1a("_root", 13, false)

	if __wf_atom_7e8ad928(__wf_atom_392793db) then
		v11 = gRegion:__wf_atom_2226b35c(Symbol("Prisoner"))
	else
		v11 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Prisoner"))
	end

	v.Inner = module3.ConvertColorNumberToProceduralRGB(2825751)
	v.Edge = module3.ConvertColorNumberToProceduralRGB(1710626)
	v4 = gRegion:__wf_atom_c4f78a8f()
	v5 = v4:CameraControl()
	mMovie:__wf_atom_e57658c2("Title.Name", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Title.Details", 44, _G.UIColor_Tan)
	mMovie:__wf_atom_e57658c2("Title", 12, 0)
	fn(nil)
	mMovie:OverrideMaterial("Darkener", visRangeMaterial)
	local visibilityCenter = module3.GetVisibilityCenter(mMovie, 1080, false)
	local visibilitySize = module3.GetVisibilitySize(mMovie, 500, false)
	local visibilityFadeSize = module3.GetVisibilityFadeSize(mMovie, 40)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
	module3.PlaySound(openSound)

	if not __wf_atom_7e8ad928(loopingMusic) and __wf_atom_7e8ad928(v6) then
		v6 = module3.PlaySound(loopingMusic)
	end

	for i = 1, 3 do
		fn2("Picker" .. i)
		mMovie:__wf_atom_e57658c2("Picker" .. i .. ".Hover", 100, i)
		mMovie:__wf_atom_e57658c2("Picker" .. i .. ".Label", 100, i)
	end
end

function SetupPupSelection(p, p2)
	v3 = WeakResource(p)
	v2 = p2
	v10 = fn6()

	if __wf_atom_7e8ad928(v10) and not _T.CubChoiceTaskInProgressLocal then
		v10 = 1
	end

	if not __wf_atom_7e8ad928(v10) then
		FinishPupSelection()
		return
	end

	mMovie:__wf_atom_2dedec1a("_root", 13, true)
	module2.DissolveIn(mMovie)
end

function Update()
	local v14 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v14)

	if flag and not __wf_atom_7e8ad928(v3) and module.AllPlayersReady(v3, v2) then
		flag = false
		local v15

		if __wf_atom_7e8ad928(__wf_atom_392793db) then
			v15 = gRegion:__wf_atom_0a6a5887(v12[v10])
		else
			v15 = __wf_atom_392793db:__wf_atom_0a6a5887(v12[v10])
		end

		if not __wf_atom_7e8ad928(v15) then
			v15:FirePort("StartPlaying")
		end

		_T.SelectedPupDeco = v11[v10]
		Close(v10)
	end
end

local function fn7(p, p2)
	local v14 = "Picker" .. p

	if p2 then
		__wf_atom_ec43d06e(mMovie, v14 .. ".Label", 0, { 12 }, { 100 }, 0.3)
	else
		__wf_atom_ec43d06e(mMovie, v14 .. ".Label", 0, { 12 }, { 0 }, 0.3)
	end
end

function BannerRollOver(_) end

function BannerRollOut(p)
	fn7(p, false)
	fn4(nil)
	v8 = nil
	v7 = false
end

function BannerClicked(p)
	if v7 and not __wf_atom_7e8ad928(v8) then
		PupPicked(p)
	end
end

function NodeRollOver(p)
	v9 = true
	local v14 = "Picker" .. p
	__wf_atom_ec43d06e(mMovie, v14 .. ".HighlightNode", 0, { 12, 5, 6 }, { 100, 60, 60 }, 0.3)
	fn4(p)
	module3.PlaySound(rolloverSound)
end

function NodeRollOut(p)
	v9 = false
	local v14 = "Picker" .. p
	__wf_atom_ec43d06e(mMovie, v14 .. ".HighlightNode", 0, { 12, 5, 6 }, { 0, 50, 50 }, 0.3)
	fn4(nil)
end

function NodeClicked(p)
	fn(p)
	local name = Localize("/SF/Language/Quests/" .. "OrengallPupName" .. p, false)
	module3.ShowConfirmMessage(
		mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/OrengallPupConfirmation", false, {
			NAME = name
		}),
		"PupPicked"
	)
	module3.PlaySound(confirmationMessageSound)
	v8 = p
	v7 = true
end

function SetColours(object, p, data)
	local colors = object:GetColors(p)
	local v14 = Color(data.tint0)
	colors:SetColor(0, Color(v14.red, v14.green, v14.blue, 112))
	colors:__wf_atom_59cc106e(0, true)
	local v15 = Color(data.tint1)
	colors:SetColor(1, Color(v15.red, v15.green, v15.blue, 112))
	colors:__wf_atom_59cc106e(1, true)
	local v16 = Color(data.tint2)
	colors:SetColor(2, Color(v16.red, v16.green, v16.blue, 112))
	colors:__wf_atom_59cc106e(2, true)
	local v17 = Color(data.tint3)
	colors:SetColor(3, Color(v17.red, v17.green, v17.blue, 112))
	colors:__wf_atom_59cc106e(3, true)
	local v18 = Color(data.tint4)
	colors:SetColor(6, Color(v18.red, v18.green, v18.blue, 112))
	colors:__wf_atom_59cc106e(6, true)
	object:__wf_atom_2754430f(p, colors)
	return object
end

function FinishPupSelection()
	if not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v2)) then
		module.SetLocalPlayerReady(v3, v2, v13[v10])
	end

	if __wf_atom_7e8ad928(v3) or module.AllPlayersReady(v3, v2) then
		local v14

		if __wf_atom_7e8ad928(__wf_atom_392793db) then
			v14 = gRegion:__wf_atom_0a6a5887(v12[v10])
		else
			v14 = __wf_atom_392793db:__wf_atom_0a6a5887(v12[v10])
		end

		if not __wf_atom_7e8ad928(v14) then
			v14:FirePort("StartPlaying")
		end

		_T.SelectedPupDeco = v11[v10]
		Close(v10)
	else
		flag = true
		fn5()
	end
end

function PupPicked(p)
	if tonumber(p) ~= 4 then
		return
	end

	v10 = v8
	module3.PlaySound(pupSelectSound)
	module3.PlaySound(closeSound)

	if not __wf_atom_7e8ad928(v6) then
		v6:Stop(false)
	end

	gGameData:__wf_atom_993aebc4("OnSaveLoadOutComplete")
	FinishPupSelection()
end

function Close(_)
	module2.RegisterHideHud(false)
	module2.DissolveOutAndClose(mMovie)
end

function OnSaveLoadOutComplete(_, _)
	module4.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
	module4.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())
end