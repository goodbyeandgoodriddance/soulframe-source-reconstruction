local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.OdeCipher")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local v = {}
local flag = false
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = nil
local v8 = {}
local v9 = false
local v10 = {}

function PlantAcornAnimation(object, object2)
	if _T.SelectPlantCallback then
		return
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.acornPlantAnim = acornPlantAnim
	__wf_atom_e919fb8e.plot = object:__wf_atom_3d96ddcd():__wf_atom_18aa6e58()
	_T.SelectPlantCallback = ClaimPlotWithItem
	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(gardenSelectorMovie, "")
end

function GrowPlant(object)
	local v11 = object:__wf_atom_c082fc3d() * 0.75
	object:SetMeshScale(0.001)
	Sleep(2)
	table.insert(v6, object:__wf_atom_3d96ddcd():Attach(plantGrowVFX, EMPTY_SYMBOL, Vector(0, 0.5, 0)))
	local v12 = 0

	while v12 < 1 and not __wf_atom_7e8ad928(object) do
		v12 = __wf_atom_421b01aa(v12 + __wf_atom_084b3e93() * 0.2, 0, 1)
		local v13 = __wf_atom_24a82b69(v12)
		object:SetMeshScale(__wf_atom_104bfe98(0.001, v11, v13))
		Sleep(0)
	end
end

local function fn(data, _, p)
	local v11 = v[data.P]

	if __wf_atom_7e8ad928(v11) then
		print("Can't plant!")
	elseif data.I then
		local __wf_atom_f090d983 = Resource(data.I):__wf_atom_f090d983(0, 0)
		local v12 = __wf_atom_63c7031a(data.N .. data.P)
		local v13 = __wf_atom_0f9a3221(v12, -180, 180)
		local v14 = __wf_atom_0f9a3221(v12, -10, 10)
		local __wf_atom_f582136d = v11:__wf_atom_f582136d(__wf_atom_7e616794)

		if not __wf_atom_7e8ad928(__wf_atom_f582136d[2]) then
			__wf_atom_f582136d[2]:SetVisibility(false, true)
			table.insert(v5, __wf_atom_f582136d[2])
		end

		local v15 = v11:Attach(__wf_atom_f090d983.mType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, Rotation(v13, v14, 0))
		local __wf_atom_c082fc3d = v15:__wf_atom_c082fc3d()
		v15:SetMeshScale(__wf_atom_0f9a3221(v12, __wf_atom_c082fc3d * 0.9, __wf_atom_c082fc3d * 1.1))

		if p then
			v15:__wf_atom_8a035cd5(Symbol("GrowPlant"), false)
		end

		table.insert(v2, v15)
		local __wf_atom_f582136d2 = v11:__wf_atom_f582136d(plantTriggerType)

		if __wf_atom_f582136d2[1] then
			__wf_atom_f582136d2[1]:Disable()
			table.insert(v3, __wf_atom_f582136d2[1])
		end

		local __wf_atom_f582136d3 = v11:__wf_atom_f582136d(uiTriggerType)

		if __wf_atom_f582136d3[1] then
			local v16 = __wf_atom_f582136d3[1]
			v16:Start()
			table.insert(v4, v16)
		end
	end
end

local function fn2(object)
	local __wf_atom_e0c3cbeb = object:__wf_atom_e0c3cbeb(Engine.__wf_atom_578fc9dd())
	local v11 = string.gsub(__wf_atom_e0c3cbeb, " ", "/")
	local v12 = StringSplit("/", v11)
	local _, day, month, year = module2.ConvertDateToGame(v12[4], v12[2], v12[1], v12[3])
	return (Localize("/SF/Language/Codex/ClaimedTimeStamp", {
		DAY = day,
		MONTH = month,
		YEAR = year
	}))
end

local function fn3()
	local __wf_atom_c84817dd = gGameData:GetInventory():__wf_atom_c84817dd()
	v9 = false

	for i = 1, #__wf_atom_c84817dd do
		if not (__wf_atom_c84817dd[i].mItemCount > 0 and __wf_atom_c84817dd[i].mItemType:IsA(plantItemType)) then
			continue
		end

		v9 = true
		break
	end

	if not v9 then
		for _, v11 in v do
			local __wf_atom_f582136d = v11:__wf_atom_f582136d(plantTriggerType)

			if not (__wf_atom_f582136d[1] and __wf_atom_f582136d[1]:IsEnabled()) then
				continue
			end

			__wf_atom_f582136d[1]:Disable()
			table.insert(v3, __wf_atom_f582136d[1])
		end
	end
end

function OnClaimPlot(p, _)
	if p then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()
		local plot = __wf_atom_e919fb8e.plot
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local __wf_atom_e75653c3 = __wf_atom_18a5d83b:__wf_atom_e75653c3()
		local date

		if v7:IsA(cursedPlantItemType) then
			local _, day, month, year = module2.ConvertDateToGame(0, 25, 11, 25)
			date = Localize("/SF/Language/Codex/ClaimedTimeStamp", {
				DAY = day,
				MONTH = month,
				YEAR = year
			})
		else
			local v11 = MongoDateTime()
			v11.sec = string.format("%u", gGameRules:__wf_atom_93691ff2())
			date = fn2(v11)
		end

		local v11 = {
			P = plot,
			I = v7,
			U = __wf_atom_e75653c3,
			N = __wf_atom_18a5d83b:__wf_atom_6be84646(),
			date = date
		}
		table.insert(_T.GardenClaimedPlots, v11)
		fn(v11, __wf_atom_e75653c3, true)
		SendRelayPlantMessage(v11)
		__wf_atom_e919fb8e.plot = nil
		v7 = nil
		module3.PlayLocalTransmission(empressTransmissionSet, Symbol("RandomEterniumGarden"), __wf_atom_c4f78a8f)
		fn3()
	else
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 0
		dialogSettings.locString = "/SF/Language/Social/GardenPlantFailed"
		dialogSettings.titleString = "/SF/Language/Social/GardenPlantFailedTitle"
		gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
		gRegion:__wf_atom_c4f78a8f():__wf_atom_921c1a5f(nil, false)
	end
end

function ClaimPlotWithItem(claimPlotWithItem)
	_T.ClaimPlotWithItem = claimPlotWithItem
	_T.SelectPlantCallback = nil
end

function CheckDispatchClaimPlot()
	if not _T.ClaimPlotWithItem then
		return
	end

	local claimPlotWithItem = _T.ClaimPlotWithItem
	_T.ClaimPlotWithItem = nil
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()
	local gardenLocationID = _T.GardenLocationID
	local plot = __wf_atom_e919fb8e.plot
	v7 = claimPlotWithItem
	gGameData:__wf_atom_7dff1300(gardenLocationID, plot, claimPlotWithItem, "OnClaimPlot")
	__wf_atom_c4f78a8f:__wf_atom_921c1a5f(__wf_atom_e919fb8e.acornPlantAnim, true, 3)
end

function OnPlotsReturned(p, p2)
	flag = false

	if not p then
		return
	end

	_T.GardenClaimedPlots = cjson.decode(p2)
end

local function fn4()
	for i = 1, #v2 do
		gRegion:__wf_atom_dd1e4d10(v2[i])
	end

	v2 = {}

	for i = 1, #v3 do
		v3[i]:Enable()
	end

	v3 = {}

	for i = 1, #v4 do
		v4[i]:__wf_atom_2dc6c98a(false)
		v4[i]:__wf_atom_2dc6c98a(true)
	end

	v4 = {}

	for i = 1, #v5 do
		v5[i]:SetVisibility(true, true)
	end

	v5 = {}

	for i = 1, #v6 do
		gRegion:__wf_atom_dd1e4d10(v6[i])
	end

	v6 = {}
end

local function fn5()
	local v11 = __wf_atom_63c7031a("Garden" .. tostring(_T.GardenLocationID))
	local v12 = __wf_atom_421b01aa(#_T.GardenClaimedPlots / 125, 0, 1)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("StateChangeDecoA"))
	local seededShuffleTable = module.SeededShuffleTable(__wf_atom_2226b35c, function(p, p2)
		return (math.floor(__wf_atom_0f9a3221(v11, p, p2) + 0.5))
	end)
	local v13 = #seededShuffleTable * v12 * 1.25

	for i = 1, #seededShuffleTable do
		local v14 = not (v13 < i)
		seededShuffleTable[i]:SetVisibility(v14, true)
	end
end

local function fn6(gardenLocationIDQueue)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	Sleep(1)
	_T.GardenLocationID = gardenLocationIDQueue
	flag = true
	gGameData:__wf_atom_9097244f(gardenLocationIDQueue, "OnPlotsReturned")
	fn4()
	Sleep(0)
	local v11 = {}
	local __wf_atom_c84817dd = gGameData:GetInventory():__wf_atom_c84817dd()
	v9 = false

	for i = 1, #__wf_atom_c84817dd do
		if not (__wf_atom_c84817dd[i].mItemCount > 0 and __wf_atom_c84817dd[i].mItemType:IsA(plantItemType)) then
			continue
		end

		table.insert(v8, __wf_atom_c84817dd[i].mItemType:__wf_atom_5b41f63b())
		table.insert(v11, __wf_atom_c84817dd[i].mItemType:__wf_atom_5b41f63b())
		v9 = true
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("GardenPlots"))

	for i = 1, #__wf_atom_2226b35c do
		local v12 = __wf_atom_2226b35c[i]
		v[__wf_atom_2226b35c[i]:__wf_atom_18aa6e58()] = v12

		if v9 then
			continue
		end

		local __wf_atom_f582136d = v12:__wf_atom_f582136d(plantTriggerType)

		if not __wf_atom_f582136d[1] then
			continue
		end

		__wf_atom_f582136d[1]:Disable()
		table.insert(v3, __wf_atom_f582136d[1])
	end

	while flag do
		Sleep(0)
	end

	local v12 = MongoDateTime()

	for _, gardenClaimedPlot in ipairs(_T.GardenClaimedPlots) do
		if gardenClaimedPlot.I == cursedPlantItemType:__wf_atom_5b41f63b() then
			local _, day, month, year = module2.ConvertDateToGame(0, 25, 11, 25)
			gardenClaimedPlot.date = Localize("/SF/Language/Codex/ClaimedTimeStamp", {
				DAY = day,
				MONTH = month,
				YEAR = year
			})
		else
			v12.sec = MongoId(gardenClaimedPlot._id["$oid"]):__wf_atom_f1a88c30()
			gardenClaimedPlot.date = fn2(v12)
		end

		if not gardenClaimedPlot.I then
			gardenClaimedPlot.I = "/SF/Types/Gameplay/CommunalGarden/FounderSeedCourage"
		end

		if not gardenClaimedPlot.I or v10[gardenClaimedPlot.I] then
			continue
		end

		v10[gardenClaimedPlot.I] = true
		table.insert(v11, gardenClaimedPlot.I)
	end

	if #v11 > 0 then
		local __wf_atom_c0dbe47c = UISys.__wf_atom_c0dbe47c(v11)

		while not __wf_atom_c0dbe47c:__wf_atom_86399a47() do
			Sleep(0)
		end
	end

	for i = 1, #v8 do
		v8[i] = Resource(v8[i])
	end

	local __wf_atom_e75653c3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3()

	for _, gardenClaimedPlot in ipairs(_T.GardenClaimedPlots) do
		fn(gardenClaimedPlot, __wf_atom_e75653c3)
	end

	fn5()
end

function FinishedMovie()
	gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 0.5)
end

function SetupGarden()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		__wf_atom_8ad59546:__wf_atom_47f0b80b(1)
		Sleep(0)
	end

	__wf_atom_c4f78a8f:__wf_atom_aeb02c14(gardenInputFilter)

	if not _T.QuestOverridesShipConsoles then
		_T.QuestOverridesShipConsoles = true
		gRegion:CreateObject(hubGameRules):__wf_atom_84d7865c()
	end

	__wf_atom_c4f78a8f:__wf_atom_d2b2176d():EnableWeaponFiring(false)
	__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(true)
	__wf_atom_c4f78a8f:__wf_atom_d2b2176d():RemoveItem(1, true)
	__wf_atom_c4f78a8f:__wf_atom_d2b2176d():RemoveItem(5, true)
	local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

		for _, v11 in ipairs(__wf_atom_36b4a6e5) do
			v11:SetEnabled(false)
		end

		__wf_atom_e55d02aa:__wf_atom_c31a704b(false, false)
	end

	_T.GardenLocationIDQueue = nil
	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(gardenSelectorMovie, "FinishedMovie")
	gMatchingService:__wf_atom_9ad738f8("CommunalGarden", "OnRelayP2PData")
	gMatchingService:SetSquadHostHubLevelName("Eternium")

	while true do
		if _T.GardenLocationIDQueue then
			fn6(_T.GardenLocationIDQueue)
			_T.GardenLocationIDQueue = nil
		else
			CheckDispatchClaimPlot()
		end

		Sleep(0)
	end
end

function OnRelayP2PData(_, p)
	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_e714d8ac) then
		return
	end

	local decoded = cjson.decode(p)

	if not decoded.msg then
		print("CommunalGarden::OnRelayP2PData: " .. p)
	elseif decoded.msg.plot ~= nil then
		OnRelayCommunalGardenPlanted(decoded)
	end
end

function OnRelayCommunalGardenPlanted(p)
	if _T.GardenClaimedPlots == nil then
		return
	end

	local plot = p.msg.plot

	if plot.P == nil then
		print("Malformed plot message")
		return
	end

	for i = 1, #_T.GardenClaimedPlots do
		if _T.GardenClaimedPlots[i].P == plot.P then
			return
		end
	end

	if not plot.I then
		plot.I = "/SF/Types/Gameplay/CommunalGarden/FounderSeedCourage"
	end

	local v11 = {}

	if plot.I and not v10[plot.I] then
		v10[plot.I] = true
		table.insert(v11, plot.I)
	end

	if #v11 > 0 then
		local v12 = v[plot.P]

		if __wf_atom_7e8ad928(v12) then
			print("Can't plant!")
			return
		end

		local __wf_atom_e919fb8e = v12:__wf_atom_e919fb8e()

		if not __wf_atom_e919fb8e then
			print("Can't get script blackboard!")
			return
		end

		__wf_atom_e919fb8e.resourceLoader = UISys.__wf_atom_c0dbe47c(v11)
		__wf_atom_e919fb8e.plot = plot
		v12:__wf_atom_8a035cd5(Symbol("LoadPlantResources"), false)
	else
		local __wf_atom_e75653c3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3()
		table.insert(_T.GardenClaimedPlots, plot)
		fn(plot, __wf_atom_e75653c3, true)
	end

	if p.from ~= nil and not __wf_atom_7e8ad928(acornPlantAnim) then
		local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(p.from)

		if not __wf_atom_7e8ad928(__wf_atom_d68faea4) then
			__wf_atom_d68faea4:__wf_atom_921c1a5f(acornPlantAnim, false, 3)
		end
	end
end

function LoadPlantResources(object)
	if _T.GardenClaimedPlots == nil then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.resourceLoader) then
		print("No resourceLoader!")
		return
	end

	while not __wf_atom_e919fb8e.resourceLoader:__wf_atom_86399a47() do
		Sleep(0)
	end

	local __wf_atom_e75653c3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3()
	table.insert(_T.GardenClaimedPlots, __wf_atom_e919fb8e.plot)
	fn(__wf_atom_e919fb8e.plot, __wf_atom_e75653c3, true)
end

function SendRelayPlantMessage(plot)
	if not __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) then
		plot.I = tostring(plot.I:__wf_atom_5b41f63b())
		local encoded = cjson.encode({ plot = plot })
		gMatchingService:__wf_atom_6ff767a1("zone", encoded)
	end
end