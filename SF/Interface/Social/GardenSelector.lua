local module = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module2 = require("Lotus.Interface.StoreItemUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Interface.Libs.UIUtilities")
local module5 = require("EE.Interface.Utilities")
local module6 = require("SF.Scripts.Libs.SparrowLib")
local v = nil
local v2 = { Edge = nil, Inner = nil }
local mVisRangeMaterials = {}
local v3 = nil
local flag = false
local v4 = false
local flag2 = true
local v5 = nil
local flag3 = false
local flag4 = false

local function fn(l)
	local v6 = (l - 1) % #gardenIcons
	return gardenIcons[v6 + 1]
end

local function fn2(p, p2)
	return tonumber(p._id.L) < tonumber(p2._id.L)
end

local function fn3(p, p2)
	local v6 = p % p2

	if v6 > 0 then
		return p + (p2 - v6)
	end

	return p
end

function OnLocations(p, p2)
	if flag4 then
		return
	end

	if v then
		v.mSpinner:SetActive(false)
	end

	if not p then
		return
	end

	v:RemoveElements(true, true)
	local decoded = cjson.decode(p2)
	local locations = decoded.locations
	local gardens = decoded.gardens
	table.sort(locations, fn2)
	local v6 = {}
	local v7 = 1
	local total = 0
	local total2 = 0

	for i = 1, #locations do
		local location = locations[i]
		location.L = location._id.L
		v6[location.L] = locations[i]
		v7 = math.max(v7, location.L)
		total += location.C
		total2 += 125

		for j = 1, #gardens do
			if gardens[j] == location.L then
				location.Personal = true
			end
		end
	end

	for i = 1, v7 do
		if not v6[i] then
			v6[i] = { L = i, C = 0 }
		end
	end

	for i = #v6 + 1, 20 do
		v6[i] = { L = i, C = 0 }
	end

	if total / total2 > 0.9 then
		v6[#v6 + 1] = {
			L = #v6 + 1,
			C = 0
		}
	end

	local v8 = fn3(#v6, 4) - #v6

	while v8 > 0 do
		v6[#v6 + 1] = {
			L = #v6 + 1,
			C = 0
		}
		v8 -= 1
	end

	for i = 1, #v6 do
		local v9 = v6[i]
		local v10 = { Icon = fn(v9.L), Count = v9.C, Location = v9.L }

		if v9.Personal then
			v10.Equipped = true
		end

		v:AddElement(v10, true)
	end

	v:Redraw(nil, true, true)
end

local function fn4()
	local module7 = require("EE.Interface.Components.ItemGrid")
	local v6 = {
		mAlignment = module5.CENTER_ALIGNED,
		mColumns = 4,
		mRows = 5,
		mVisRangeMaterials = mVisRangeMaterials
	}
	v = module7.Create(getfenv(1), "TopLevelContainer.InstanceContainer", v6)
	mMovie:__wf_atom_e57658c2("TopLevelContainer.InstanceContainer", 12, 100)
	v:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/Social/GardenInstances", true))
	v.mSpinner:SetActive(true)
	v.mEasing = 7
	v.Old_OnDraw = v.OnDraw

	function v.OnDraw(object, data, p)
		object:Old_OnDraw(data, p)

		if data.IsDummy then
			return
		end

		local v7 = data.Count / 125
		local v8 = math.sqrt((__wf_atom_421b01aa(v7, 0, 1)))
		__wf_atom_86cbd68d(mMovie, data.mClipName .. ".IconFlare.duplicateMovieClip", "IconFlareB", -1)
		local v9 = data.mClipName .. ".IconFlareB"
		mMovie:OverrideMaterial(v9, energyFillMaterial)
		local v10 = math.max(1, 114 * v8)
		mMovie:__wf_atom_e57658c2(v9, 14, 114)
		mMovie:__wf_atom_e57658c2(v9, 1, __wf_atom_104bfe98(57, 0, v8))
		mMovie:__wf_atom_e57658c2(v9, 15, v10)
		mMovie:__wf_atom_e57658c2(v9, 12, 75)
		mMovie:__wf_atom_e57658c2(v9, 11, _G.UIColor_Blue)
		__wf_atom_86cbd68d(mMovie, data.mClipName .. ".IconFlare.swapDepths", 25)
		__wf_atom_86cbd68d(mMovie, data.mClipName .. ".Icon.swapDepths", 50)
		local v11 = data.mClipName .. ".InstanceCount"

		if data.Location and not mMovie:__wf_atom_253d7085(v11) then
			__wf_atom_86cbd68d(mMovie, data.mClipName .. ".Count.duplicateMovieClip", "InstanceCount", 119)
			mMovie:__wf_atom_933bbce0(v11 .. ".Background", moteIndexTexture, mVisRangeMaterials[2])
			mMovie:OverrideMaterial(v11 .. ".Text", mVisRangeMaterials[1])
			mMovie:__wf_atom_4c1c1986(data.mClipName, "InstanceCount.Background", 14, 40)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "InstanceCount.Background", 15, 32)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "InstanceCount.Background", 0, 32)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "InstanceCount.Text", 44, _G.UIColor_Yellow)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "InstanceCount", 0, 30)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "InstanceCount", 1, -25)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "InstanceCount.Background", 11, _G.UIColor_White)
		end

		mMovie:__wf_atom_48bd5a59(v11, "Text", 36, (tostring(data.Location)))
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".InstanceCount.Text", 40)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "InstanceCount.Text", 0, -25 - (20 - __wf_atom_5e6e15c8) / 2)
	end

	function v.mOnSelectedCallback(p)
		if not (p.Unselectable or flag) then
			_T.GardenLocationIDQueue = p.Location
			_T.SubvertTopMenu = mMovie:__wf_atom_6d61d595()
			v4 = true
			flag = true
			v.mSpinner:SetActive(true)
			gGameRules:__wf_atom_efb96bf3(Symbol("Eternium"), "Eternium", p.Location)
			gRegion:__wf_atom_0a6a5887(Symbol("SkySparrow")):__wf_atom_921c1a5f(sparrowAnim, false)
			gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(1, 0.5)
		end
	end
end

function OnClaimConfirm(p)
	flag4 = true

	if tonumber(p) == 4 then
		_T.SelectPlantCallback(v5.Type)
		mMovie:Close()
	elseif flag3 then
		mMovie:Close()
	end
end

local function fn5()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.titleString = "/SF/Language/Codex/ClaimGardenPlotTitle"
	dialogSettings.locString = "/SF/Language/Codex/ClaimGardenPlot"
	dialogSettings:SetCallback("OnClaimConfirm")
	local module7 = require("EE.Interface.Utilities")
	dialogSettings.icon = v5.Icon:__wf_atom_5b41f63b() .. ",100,100,nil,nil,/Lotus/Fx/Interface/IdentifyResourceFanfare"
	module7.ShowCustomMessage(dialogSettings)
end

local function fn6()
	local __wf_atom_c84817dd = gGameData:GetInventory():__wf_atom_c84817dd()
	local v6 = {}

	for i = 1, #__wf_atom_c84817dd do
		if __wf_atom_c84817dd[i].mItemCount > 0 and __wf_atom_c84817dd[i].mItemType:IsA(plantItemType) then
			table.insert(v6, __wf_atom_c84817dd[i])
		end
	end

	if #v6 == 1 then
		mMovie:__wf_atom_2dedec1a("TopLevelContainer.InstanceContainer", 13, false)
		v5 = module2.GetItemTypeInfo(mMovie, Resource(v6[1].mItemType), nil, nil)
		flag3 = true
		fn5()
	else
		module5.PlaySound(gardenMenuOpenSound)
		local module7 = require("EE.Interface.Components.ItemGrid")
		local v7 = {
			mAlignment = module5.CENTER_ALIGNED,
			mColumns = __wf_atom_421b01aa(#v6, 1, 4),
			mRows = 1
		}
		v = module7.Create(getfenv(1), "TopLevelContainer.InstanceContainer", v7)
		mMovie:__wf_atom_e57658c2("TopLevelContainer.InstanceContainer", 12, 100)
		v:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/Social/GardenChoosePlant", true))
		v.mSpinner:SetActive(false)
		v.mEasing = 7

		function v.OnDraw(_, _, _) end

		function v.mOnSelectedCallback(p)
			if not (p.Unselectable or flag) then
				v5 = p
				fn5()
			end
		end

		for i = 1, #v6 do
			local itemTypeInfo = module2.GetItemTypeInfo(mMovie, Resource(v6[i].mItemType), nil, nil)

			if not itemTypeInfo then
				continue
			end

			itemTypeInfo.Count = v6[i].mItemCount
			itemTypeInfo.ShowCount = true
			v:AddElement(itemTypeInfo, true)
		end

		v:Redraw(nil, true, true)
	end
end

local function fn7(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SkyCameraSpot"))
	__wf_atom_0a6a5887:__wf_atom_802e6d6a(99999.9)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		object:CameraControl():__wf_atom_fd14c463(0)
		object:CameraControl():SetCameraSpot(__wf_atom_0a6a5887, 0)
		_T.HasDailyTribute = true
	end
end

function DissolveOut(object)
	local v6 = object:GetPosition() + Vector(0, 10, 0) + __wf_atom_e97f3142(object:__wf_atom_4e50d390()) * 10
	module.DissolveOut(object, v6, nil, attachFx)
	DecrementGardenFade()
end

function DissolveIn(object)
	while IsFading() do
		Sleep(0)
	end

	Sleep(0)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GardenCameraSpot"))
	object:CameraControl():__wf_atom_fd14c463(0)
	object:CameraControl():SetCameraSpot(__wf_atom_0a6a5887, 0)
	Sleep(0)
	object:CameraControl():__wf_atom_fd14c463(2)
	object:CameraControl():SetCameraSpot(nil, 1)
	local v6 = object:GetPosition() + Vector(0, 10, 0) + __wf_atom_e97f3142(object:__wf_atom_4e50d390()) * 10
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(attachFx)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
	end

	module.DissolveIn(object, v6, nil, attachFx)
end

function FadeToSparrow(object)
	_T.GardenFade = 2
	object:__wf_atom_8a035cd5(Symbol("DissolveOut"), false)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	__wf_atom_8ad59546:__wf_atom_f92e3acc(1, 1 / 3)
	Sleep(3)
	fn7(object)
	__wf_atom_8ad59546:__wf_atom_f92e3acc(0, 1)
	DecrementGardenFade()
end

function DecrementGardenFade()
	if _T.GardenFade == nil then
		return
	end

	_T.GardenFade = _T.GardenFade - 1

	if _T.GardenFade <= 0 then
		_T.GardenFade = nil
	end
end

function IsFading()
	return _T.GardenFade ~= nil
end

function InitializeGardens()
	fn4()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if _T.SubvertTopMenu then
		if not IsFading() then
			__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("FadeToSparrow"), false)
		end

		_T.SubvertTopMenu = false
		mMovie:__wf_atom_e57658c2("_root", 12, 0)
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.5, 3)
	else
		fn7(__wf_atom_c4f78a8f)
		module3.DissolveIn(mMovie)
	end

	gGameData:__wf_atom_8a6dbe4f("OnLocations")
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SkySparrow"))

	if __wf_atom_0a6a5887 ~= nil then
		module6.ApplySparrowCustomizationToDeco(__wf_atom_c4f78a8f, __wf_atom_0a6a5887)
	end

	__wf_atom_0a6a5887:SetVisibility(true, true)
	local v6 = {}
	table.insert(v6, {
		Label = "/SF/Language/Social/GardenExit",
		CallBack = RequestExit,
		CallOut = "MENU_CANCEL"
	})

	if not (__wf_atom_7e8ad928(_T.SetButtons) or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		_T.SetButtons(_T.BackgroundMovie, v6, getfenv(1))
	end
end

function CloseMovie()
	flag4 = true
	mMovie:Close()
end

function InitializePlants()
	fn6()
	local v6 = {}
	table.insert(v6, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = CloseMovie,
		CallOut = "MENU_CANCEL"
	})

	if not (__wf_atom_7e8ad928(_T.SetButtons) or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		_T.SetButtons(_T.BackgroundMovie, v6, getfenv(1))
	end
end

function Initialize()
	module3.RegisterHideHudSelective(true)
	module4.SetChatVisible(false)
	table.insert(mVisRangeMaterials, _G.UIMaterial_VerticalVisibilityRangeText)
	table.insert(mVisRangeMaterials, _G.UIMaterial_VerticalVisibilityRange)
	table.insert(mVisRangeMaterials, energyFillMaterial)
	v2.Inner = module5.ConvertColorNumberToProceduralRGB(2825751)
	v2.Edge = module5.ConvertColorNumberToProceduralRGB(1710626)
	local module7 = require("Lotus.Interface.Libs.TimerMgr")
	v3 = module7.CreateTimerMgr()

	if not _T.SelectPlantCallback then
		InitializeGardens()
		return
	end

	InitializePlants()
	flag2 = false
end

function Shutdown()
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	_T.SelectPlantCallback = nil
	module4.SetChatVisible(true)
	module3.RegisterHideHudSelective(false)

	if not flag2 then
		_T.SetButtons(_T.BackgroundMovie)
		return
	end

	_T.gToolTip = nil
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:CameraControl():__wf_atom_fd14c463(0)
		__wf_atom_c4f78a8f:CameraControl():SetCameraSpot(nil, 0)
		__wf_atom_c4f78a8f:__wf_atom_921c1a5f(arrivalAnim, false)
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
	end

	gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 1)
	gRegion:__wf_atom_0a6a5887(Symbol("SkySparrow")):SetVisibility(false, true)
	_T.SetButtons(_T.BackgroundMovie)
end

function Update()
	local v6 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v6)

	if not __wf_atom_7e8ad928(v3) then
		v3:Update(v6)
	end

	if v4 and not _T.GardenLocationIDQueue then
		v4 = false
		flag4 = true
		mMovie:Close()
	end
end

function Close()
	ForceClose()
end

function ConfirmExit(p)
	if tonumber(p) ~= 4 then
		return
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_94b3a9e1(true)
	end

	flag = true
	flag4 = true
	gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(1, 1)
	v3:AddTimer(1, function()
		if gMatchingService:__wf_atom_1b24a1bb() then
			local levelArgs = Engine.OpenLevelArgs()
			levelArgs.level = WeakResource("/SF/Levels/Procs/MidrathProc")
			levelArgs.menuMovie = __wf_atom_c67f9605:__wf_atom_cf8a801d()
			levelArgs.gameRules = gClient:__wf_atom_2aee259b()
			levelArgs.restartLevel = false
			levelArgs.migrateServer = true
			levelArgs.hostingMultiplayer = not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
			levelArgs.loadToLobby = false
			levelArgs.loadFromLobby = true
			levelArgs.hostingMultiplayer = false
			Engine.OpenLevel(levelArgs)
		else
			Engine.Disconnect(true)
		end

		mMovie:Close()
	end)
end

function RequestExit()
	if flag then
		return
	end

	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = "/SF/Language/Social/GardenExitConfirm"
	dialogSettings.titleString = "/SF/Language/Social/GardenExitTitle"
	dialogSettings:SetCallback(ConfirmExit)
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

function ForceClose()
	flag4 = true
	module3.DissolveOutAndClose(mMovie)
end

function onKeyDown_MENU_CANCEL()
	if flag2 then
		RequestExit()
	else
		CloseMovie()
	end
end