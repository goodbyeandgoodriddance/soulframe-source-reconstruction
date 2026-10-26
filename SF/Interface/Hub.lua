local v = nil
local module = require("EE.Interface.Utilities")
require("SF.Interface.Libs.UIUtilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.LotusNetworkUtilities")
local module4 = require("Lotus.Interface.StoreItemUtilities")
require("Lotus.Interface.CardUtilitiesRedux")
local module5 = require("Lotus.Interface.WorldStateUtilities")
local module6 = require("Lotus.Interface.UIStyleUtilities")
require("Lotus.Scripts.Libs.QuestLib")
local module7 = require("SF.Interface.Libs.ItemUtil")
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = ""
local hubLocationDesc = ""
local v8 = nil
local v9 = Symbol()
local v10 = 0
local v11 = nil
local v12 = false
local v13 = false
local v14 = false
local v15 = 50
local v16 = nil
local v17 = nil
local v18 = 0
local v19 = nil
local gameCamera = nil
local v20 = nil
local v21 = nil
local v22 = Range(0, 0)
local v23 = false
local v24 = nil
local from = nil
local from2 = nil
local v25 = false
local v26 = {}
local v27 = { host = nil, player = nil, loadoutDirty = false }
local flag = false
local v28 = 0
local total = 0
local v29 = nil
local v30 = {
	[0] = Symbol("DefaultSpawn"),
	[1] = Symbol("NavigationSpawn"),
	[2] = Symbol("ConclaveSpawn"),
	[3] = Symbol("LibrarySpawn"),
	[4] = Symbol("ChallengeSpawn"),
	[5] = Symbol("SimulacrumSpawn"),
	[6] = Symbol("TradeSpawn"),
	[10] = Symbol("SudaRoomSpawn"),
	[11] = Symbol("PerrinRoomSpawn"),
	[12] = Symbol("LokaRoomSpawn"),
	[13] = Symbol("VeilRoomSpawn"),
	[14] = Symbol("ArbitersRoomSpawn"),
	[15] = Symbol("MeridianRoomSpawn"),
	[16] = Symbol("OstronSpawn"),
	[17] = Symbol("QuillsSpawn"),
	[18] = Symbol("SolarisSpawn"),
	[19] = Symbol("VentKidsSpawn"),
	[20] = Symbol("VoxSpawn"),
	[21] = Symbol("EntratiSpawn"),
	[22] = Symbol("NecraloidSpawn"),
	[23] = Symbol("PrimeVaultTraderSpawn")
}
local _ = {
	Symbol("DarvoDecoration"),
	Symbol("DarvoObjectiveMarker"),
	Symbol("DarvoStoreAction"),
	Symbol("DarvoGreetingTrigger"),
	Symbol("DarvoStoreConsoleTrigger")
}
local v31 = { switchItemTime = 4, fadeTime = 0.5 }
local v32 = {
	maxDistance = 8,
	minDistance = 1.5,
	switchItemTime = 4,
	fadeTime = 0.5,
	displayScale = 50
}
local v34 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
local v35 = {
	FinalizeTrade = nil,
	InTradeZone = nil,
	tradeZoneTimerId = nil,
	TimerCheckInTradeZone = nil,
	tradingZone = "Concourse"
}
local v36 = {}
local v37 = 0
local v38 = WeakResource("/Lotus/Types/Friendly/Tenno/FriendlyTennoAvatar")
local v39 = WeakResource("/Lotus/Types/Player/TennoAvatarArsenal")
local v40 = WeakResource("/SF/Types/Game/BaseCosmeticEnhancer")
local v41 = nil
local v42 = nil
local v43 = true
local v44 = {}
local v45 = {}
local v46 = {}
local v47 = nil
local v48 = {}
local v49 = Type()
local v50 = Type()
local v51 = Type()
local v52 = Vector(0.5, -0.1, -1.3)
local v53 = Vector(0, 1.5, 0)
local fn
local fn2
local v54 = Symbol("HubIgnoreNearCull")

local function fn3(value)
	mMovie:__wf_atom_2dedec1a("LocationPopup.Faction", 13, true)
	print((type(value)))

	if type(value) ~= "string" then
		value = value:c_str()
	end

	if string.find("/SF/Language/Locations/ChampionHubName", value) then
		mMovie:__wf_atom_c90af43a("LocationPopup.Faction", factionIcons[1])
	elseif string.find("/SF/Language/Locations/FeyHubName", value) then
		mMovie:__wf_atom_c90af43a("LocationPopup.Faction", factionIcons[2])
	elseif string.find("/SF/Language/Locations/SilentRoseEnclave", value) then
		mMovie:__wf_atom_c90af43a("LocationPopup.Faction", factionIcons[3])
	else
		mMovie:__wf_atom_2dedec1a("LocationPopup.Faction", 13, false)
	end
end

local function fn4()
	if
		not __wf_atom_7e8ad928(gGameRules)
		and (gGameRules:__wf_atom_af3bd666() or gGameRules:IsA(__wf_atom_dd9a0bb8) or gGameRules:IsA(__wf_atom_311a7128))
	then
		_T.HubChannel = gMatchingService:__wf_atom_58c4b875()
	end
end

function OnArbiterConnect()
	fn4()
end

local function fn5(forcedFlying, p)
	local v55 = not __wf_atom_7e8ad928(p) and { p } or gRegion:FindAll(__wf_atom_7e6ed5fa)
	local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()

	for _, v56 in pairs(v55) do
		local __wf_atom_2586e47b = __wf_atom_9c7c90fb:__wf_atom_2586e47b((gGameRules:__wf_atom_70f5d0a5(v56)))

		if __wf_atom_2586e47b == "" then
			continue
		end

		print("SetForcedFlying " .. tostring(forcedFlying) .. " for " .. __wf_atom_2586e47b)

		if forcedFlying then
			v56:__wf_atom_4f204bbf(v49)

			if v56:__wf_atom_8efce136() then
				v56:__wf_atom_b70f5867(v51)
			end

			v56:__wf_atom_8c85e8aa(v50)
			v56:__wf_atom_92aa9d91():__wf_atom_17c1c30f()
			v56:SetPosture(0)
		else
			v56:__wf_atom_4f204bbf(nil)

			if v56:MotionControl():IsA(v51) then
				v56:MotionControl():__wf_atom_a0ba632f(false)
			end

			v56:__wf_atom_b70f5867(nil)
			v56:__wf_atom_8c85e8aa(nil)
			v56:__wf_atom_e4e146d5(Symbol("Tenno"))
			v56:__wf_atom_9373d0eb(29, false)
		end
	end

	_T.ForcedFlying = forcedFlying
end

_T.SetForcedFlying = fn5

local function fn6()
	v26 = {}
	local all = gRegion:FindAll(__wf_atom_7e6ed5fa)
	local v55 = not __wf_atom_7e8ad928(gGameRules)
	local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()

	for _, avatar in ipairs(all) do
		if avatar:IsA(v39) or avatar:HasTag(v54) then
			continue
		end

		local v57 = #v26 + 1
		v26[v57] = { Avatar = avatar }

		if not v55 then
			continue
		end

		v26[v57].account = gGameRules:__wf_atom_70f5d0a5(avatar)

		if v26[v57].account == "" or __wf_atom_7e8ad928(__wf_atom_9c7c90fb) then
			continue
		end

		v26[v57].playerName = __wf_atom_9c7c90fb:__wf_atom_2586e47b(v26[v57].account)
		v26[v57].loadoutLoaded = __wf_atom_9c7c90fb:__wf_atom_3179c2db(v26[v57].playerName)
	end
end

function UpdateAvatarList()
	fn6()
end

function Shutdown()
	_T.ChangeHubVisCounter = nil
	_T.HubChannel = nil

	if not __wf_atom_7e8ad928(bardLocalMixer) then
		bardLocalMixer:__wf_atom_c2a0827a(0)
	end

	if not __wf_atom_7e8ad928(bardPositionalMixer) then
		bardPositionalMixer:__wf_atom_d43688f3(Range(0, 0))
		bardPositionalMixer:__wf_atom_c2a0827a(0)
	end

	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			fn2(__wf_atom_c4f78a8f, true)
		end
	end

	gMatchingService:__wf_atom_a8847956(Symbol("Hub"))
	gMatchingService:__wf_atom_bad3c162(Symbol("Hub"))

	if _G.PendingHubBroadcastRewards and not __wf_atom_7e8ad928(gGameData) then
		local v55 = ""

		for i = 1, #_G.PendingHubBroadcastRewards do
			v55 ..= _G.PendingHubBroadcastRewards[i]

			if i < #_G.PendingHubBroadcastRewards then
				v55 ..= ","
			end
		end

		gGameData:__wf_atom_c9bb8504(Symbol(v55))
		_G.PendingHubBroadcastRewards = nil
	end

	if _T.HubBroadcastLog and not _T.LoggedHubReward then
		__wf_atom_21342f4a:SetEvent(Symbol("HUB_BROADCAST"), v7 .. "_" .. _T.HubBroadcastLog)
	end

	for i, v55 in ipairs(v45) do
		local v56 = _T["InfoPopup_Data" .. tostring(i + 100)]

		if v56 ~= nil and v56.ClearWeapon ~= nil then
			v56.ClearWeapon()
			v56.ClearWeapon = nil
		end

		_T["InfoPopup_Data" .. tostring(i + 100)] = nil

		if not __wf_atom_7e8ad928(v55) then
			v55:Close()
		end
	end
end

local v55 = {}
local v56 = 1
local v57 = nil
local v58 = nil

local function fn7()
	v57 = mMovie:__wf_atom_5e6e15c8("ThankYou1", 0)
	v58 = mMovie:__wf_atom_5e6e15c8("ThankYou1", 1)
	mMovie:__wf_atom_e57658c2("ThankYou1", 12, 0)
	mMovie:__wf_atom_50d60589("ThankYou1.Name", 36, "")
	mMovie:__wf_atom_c90af43a("ThankYou1.Icon", thankYouTexture)
	table.insert(v55, "ThankYou1")
end

local function fn8()
	if #v55 > 0 then
		local v59 = v55[1]
		table.remove(v55, 1)
		return v59
	else
		v56 += 1
		local v59 = "ThankYou" .. v56
		__wf_atom_86cbd68d(mMovie, "ThankYou1.duplicateMovieClip", v59, v56 + 5500)
		mMovie:__wf_atom_c90af43a(v59 .. ".Icon", thankYouTexture)
		return v59
	end
end

local function fn9(__wf_atom_2586e47b)
	local v59 = fn8()
	local v60 = v57 + 200
	local v61 = v58 + Random(-150, 50)
	mMovie:__wf_atom_48bd5a59(v59, "Name", 36, __wf_atom_2586e47b)
	Random(0, 3)
	__wf_atom_ec43d06e(mMovie, v59, 0, { function(p)
			local v62

			if p < 0.1 then
				v62 = math.pow(p / 0.1, 0.5)
			else
				v62 = 1 - (p - 0.1) * 0.25
			end

			mMovie:__wf_atom_e57658c2(v59, 5, v62 * 70)
			mMovie:__wf_atom_e57658c2(v59, 6, v62 * 70)
			local ternary = module.Ternary(p > 0.5, (1 - (p - 0.5) / 0.5) * 100, 100)
			mMovie:__wf_atom_e57658c2(v59, 12, ternary)
			mMovie:__wf_atom_e57658c2(v59, 0, v57 + 200 - math.pow(p, 2) * 1000)
			mMovie:__wf_atom_e57658c2(v59, 1, v61)
		end }, { 1 }, 4, 0, function()
		table.insert(v55, v59)
	end)
	module.PlaySound(thankYouSound)
	module.CreateScreenParticles(mMovie, thankYouFx, v60, v61)
end

function Initialize()
	function _T.ChangeHubVisCounter(p)
		total += p

		if total < 0 then
			print("mVisCounter was incorrectly modified!")
			total = 0
		end
	end

	_T.UpdateAvatarList = fn6
	mMovie:__wf_atom_2dedec1a("Msg", 13, false)
	mMovie:__wf_atom_e57658c2("LocationPopup", 12, 0)
	mMovie:__wf_atom_e57658c2("LocationPopup", 1, 90)
	local module8 = require("EE.Interface.Components.Grid")
	v16 = module8.CreateGrid(mMovie, "FakeClip", nil, 1, 1)
	v16.mPadding = 8
	v16.mColumnSeparation = 112
	v16.mRowSeparation = 112
	v16.mShowLabels = true
	v16.mVisRangeMaterials = {}
	v16.mVisRangeMaterials.Icon = tradingIconMaterial
	v16.mVisRangeMaterials.Text = _G.UIMaterial_DepthTestText
	v16.SkipDefaultMaterials = true
	module6.GetColor(2, true)
	module6.GetColor(6, true)
	module6.GetColor(9, true)
	local color = module6.GetColor(10, true)
	mMovie:OverrideMaterial("LocationPopup.TitleLines", titleBgMaterial)
	mMovie:__wf_atom_e57658c2("LocationPopup.TitleLines.Backer", 12, 70)
	mMovie:__wf_atom_e57658c2("Reticle", 12, 0)
	mMovie:__wf_atom_e57658c2("LocationPopup.Location", 44, color)
	mMovie:__wf_atom_e57658c2("LocationPopup.SubLocation", 44, _G.UIColor_White)
	v28 = mMovie:__wf_atom_5e6e15c8("LocationPopup.Location", 1)
	local module9 = require("Lotus.Interface.Libs.TimerMgr")
	v = module9.CreateTimerMgr()
	v23 = module.IsUGCRestricted()
	local movie = __wf_atom_8e4fda44:FindMovie(endOfMatchMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("ReturnedToShip", "")
	end

	v37 = mMovie:__wf_atom_5e6e15c8("Msg.Name", 1)

	if not (__wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) or __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01())) then
		v19 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	end

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	if gGameRules:__wf_atom_af3bd666() then
		gGameRules:__wf_atom_c88ae023():__wf_atom_577a0eaf(
			"OnTradeRequestAccepted",
			"OnTradeRequestDeclined",
			"OnTradeSession",
			"OnTradeBuddyDestroyed"
		)
	end

	gameCamera = gRegion:GetGameCamera()
	local v59 = gGameRules:__wf_atom_af3bd666() and gMatchingService:__wf_atom_a676a953()
	v15 = module.Ternary(gGameRules:__wf_atom_af3bd666() or v59, 15, 40)
	v22 = Range(bardPositionalMixerAttenMin, bardPositionalMixerAttenMax)

	if _T.HubSkipEoM then
		v25 = false
		_T.HubSkipEoM = nil
	end

	v43 = gMatchingService:__wf_atom_1b24a1bb()
	print("Hub initialize: squad host=" .. tostring(v43))
	local v60 = gGameRules:__wf_atom_72fc675e().location == module2.OROKIN_TOWER_NODE_TAG

	if v60 and v43 then
		print("Entrati: " .. tostring(v60))
		local rotatingMissionSeed = module3.GetRotatingMissionSeed(360)
		gMatchingService:SetSquadMissionSeed(__wf_atom_3e61816b(rotatingMissionSeed))
	end

	v47 = module.ConvertColorNumberToHex(_G.UIColor_Yellow)
	fn7()
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 100)
	titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
end

local function fn10(p, p2, p3, p4, p5)
	local v59 = p2 .. p3

	if not mMovie:__wf_atom_253d7085(v59) then
		if p5 then
			__wf_atom_86cbd68d(mMovie, p .. ".createEmptyMovieClip", v59, p3 + p4)
		else
			__wf_atom_86cbd68d(mMovie, p .. ".duplicateMovieClip", v59, p3 + p4)
		end
	end

	mMovie:__wf_atom_48bd5a59(v59, "Message", 46, "bottom")
	return v59
end

local function fn11(p, p2)
	local v59

	if p2.badgeInfo.enabled and p2.badgeInfo.items then
		v59 = p2.badgeInfo.items[p2.badgeInfo.activeItemIndex]
	end

	local v60

	if v59 == nil then
		v60 = false
	else
		v60 = not p2.hidden
	end

	mMovie:__wf_atom_7f57ab2f(p, "Badge", 13, v60)

	if not v60 then
		return
	end

	local v61 = p .. ".Badge"
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v59.Label, false)
	mMovie:__wf_atom_50d60589(v61 .. ".Label", 36, __wf_atom_8e9ac384)
	mMovie:__wf_atom_c90af43a(v61 .. ".Icon", medalTextures[v59.IconIndex])
	local count = #p2.badgeInfo.items

	if count > 1 then
		if p2.badgeInfo.switchItemTimer ~= nil then
			v:RemoveTimer(p2.badgeInfo.switchItemTimer)
		end

		p2.badgeInfo.switchItemTimer = v:AddTimer(v31.switchItemTime, function()
			__wf_atom_ec43d06e(mMovie, v61, 8, { 12 }, { 0 }, v31.fadeTime, 0, function()
				p2.badgeInfo.switchItemTimer = nil
				p2.badgeInfo.activeItemIndex = p2.badgeInfo.activeItemIndex + 1

				if count < p2.badgeInfo.activeItemIndex then
					p2.badgeInfo.activeItemIndex = 1
				end

				p2.badgeInfo.touched = false
				__wf_atom_ec43d06e(mMovie, v61, 8, { 12 }, { 100 }, v31.fadeTime, 0.1)
			end)
		end)
	end
end

local function fn12(p)
	local name = p.name
	local v59

	if v44[name] == nil then
		if #v46 > 0 then
			v59 = v46[#v46]
			table.remove(v46, #v46)
		else
			v59 = #v45 + 100 + 1
		end
	else
		v59 = v44[name]
	end

	if v44[name] ~= nil and not __wf_atom_7e8ad928(v45[v59 - 100]) then
		return v59, v45[v59 - 100]
	end

	if __wf_atom_7e8ad928(v45[v59 - 100]) then
		v45[v59 - 100] = mMovie:PushChildMovie(itemPreviewMovie)
	end

	v44[name] = v59
	v45[v59 - 100]:Execute("OverrideItemInfoData", (tostring(v59)))
	return v59, v45[v59 - 100]
end

local function fn13(p, p2, p3)
	local text = ""
	local items = p2.itemInfo.items
	local v60 = p2.itemInfo.itemsCached ~= nil

	if not v60 then
		p2.itemInfo.itemsCached = {}
	end

	local count = 0
	local v61 = ""

	for i, item in ipairs(items) do
		v61 = i == 1 and "\r" or v61
		local v62 = WeakResource(item.itemType)
		local item2 = nil

		if v60 then
			if p2.itemInfo.itemsCached[i] then
				local v63 = p2.itemInfo.itemsCached[i]

				if
					not v63.initialized
					and (__wf_atom_7e8ad928(v63.resLoader) or v63.resLoader:__wf_atom_86399a47())
				then
					v63.initialized = true
					v63.item = {
						itemRes = Resource(v62),
						storeItemRes = module.Ternary(item.storeItem == nil, nil, Resource(item.storeItem)),
						element = nil
					}

					if item.upgradeFingerprint then
						v63.item.upgradeFingerprint = item.upgradeFingerprint
					end

					v63.resLoader = nil
				end

				item2 = v63.item
			end
		else
			local v63 = {}

			if not __wf_atom_7e8ad928(v62) then
				table.insert(v63, v62:__wf_atom_5b41f63b())
			end

			if item.storeItem ~= nil then
				table.insert(v63, item.storeItem)
			end

			local resLoader

			if #v63 > 0 then
				resLoader = UISys.__wf_atom_c0dbe47c(v63)
			end

			table.insert(p2.itemInfo.itemsCached, {
				initialized = false,
				resLoader = resLoader,
				item = nil
			})
		end

		if __wf_atom_7e8ad928(item2) then
			continue
		end

		count += 1
		local localizeTag = nil

		if item2.element == nil then
			if not __wf_atom_7e8ad928(item2.itemRes) then
				item2.itemRes:IsA(v40)
				localizeTag = item2.itemRes:__wf_atom_014a76a2():c_str()
			end
		else
			local _isArcane = item2.element.IsArcane
			localizeTag = item2.element.localizeTag
		end

		local v63

		if item.name == nil then
			v63 = mMovie:__wf_atom_8e9ac384(localizeTag, true)
		elseif localizeTag == nil then
			v63 = mMovie:__wf_atom_8e9ac384(item.name, true)
		else
			v63 = mMovie:__wf_atom_8e9ac384(localizeTag, true, { NAME = item.name })
		end

		if i == p2.itemInfo.activeItemIndex + 1 then
			if v47 ~= nil then
				v63 = "<font color=\"" .. v47 .. "\">" .. v63 .. "</font>"
			end

			local storeItemRes = item2.storeItemRes

			if __wf_atom_7e8ad928(storeItemRes) then
				storeItemRes = v34:GetStoreItem(v62)
			end

			local storeItemInfo = module4.GetStoreItemInfo(
				mMovie,
				storeItemRes,
				{ GameData = gGameData },
				nil,
				nil,
				true
			)
			storeItemInfo.mClipName = p .. ".Items.Display"
			module7.Initialize(mMovie, storeItemInfo.mClipName, storeItemInfo, v16)
			module7.Update(mMovie, storeItemInfo.mClipName, storeItemInfo, v16)
			storeItemInfo.IgnoreInput = true
			storeItemInfo.PreviewMode = true
			storeItemInfo.ManualCloseHandled = true
			storeItemInfo.HideAspects = true
			storeItemInfo.HideLevel = true

			if storeItemInfo.Type:IsA(__wf_atom_77e05d3b) then
				storeItemInfo.HideBasePage = true
				storeItemInfo.RawItem = item

				if storeItemInfo.RawItem.mUpgradeType ~= nil then
					storeItemInfo.RawItem.mUpgradeType = WeakResource(storeItemInfo.RawItem.mUpgradeType)
				end

				if storeItemInfo.RawItem.mItemId ~= nil and type(storeItemInfo.RawItem.mItemId) == "string" then
					storeItemInfo.RawItem.mItemId = MongoId(storeItemInfo.RawItem.mItemId)
				end

				local module8 = require("SF.Interface.Libs.StatsUtil")
				local weaponElementUpgradesAndFingerprints, v64 = module8.GetWeaponElementUpgradesAndFingerprints(storeItemInfo)
				local v65 = __wf_atom_7e8ad928(storeItemInfo.RawItem) and 0 or storeItemInfo.RawItem.mQuality
				local proxyWeapon, clearWeapon = module8.CreateProxyWeapon(
					nil,
					storeItemInfo.Type,
					0,
					weaponElementUpgradesAndFingerprints,
					v64,
					v65,
					item.mItemId,
					nil
				)
				storeItemInfo.StatWeapon = proxyWeapon
				storeItemInfo.ClearWeapon = clearWeapon
				storeItemInfo.mStatsToOnlyShow = { "MeleeSkill", "Era", "Quality", "Aspects" }
			elseif storeItemInfo.Type:IsA(__wf_atom_abf506db) then
				storeItemInfo.HideBasePage = true
			end

			local v64, v65 = fn12(p2)
			local v66 = _T["InfoPopup_Data" .. tostring(v64)]

			if v66 ~= nil and v66.ClearWeapon ~= nil then
				v66.ClearWeapon()
				v66.ClearWeapon = nil
			end

			_T["InfoPopup_Data" .. tostring(v64)] = storeItemInfo
			v65:SetVisible(false)
		end

		text = v63 .. v61 .. text
	end

	mMovie:__wf_atom_7f57ab2f(p, "Items", 13, count > 0)
	p2.itemInfo.text = text
	mMovie:__wf_atom_50d60589(p .. ".Items.NameList", 36, "<p><font >" .. text .. "</font></p>")
	mMovie:__wf_atom_48bd5a59(p, "Items.NameList", 45, "left")
	mMovie:__wf_atom_e57658c2(p .. ".Items.NameList", 44, _G.UIColor_Beige)

	if #p2.itemInfo.items > 1 then
		if p2.itemInfo.switchItemTimer ~= nil then
			v:RemoveTimer(p2.itemInfo.switchItemTimer)
		end

		p2.itemInfo.switchItemTimer = v:AddTimer(v32.switchItemTime, function()
			__wf_atom_ec43d06e(mMovie, p .. ".Items.Display", 8, { 12 }, { 0 }, v32.fadeTime, 0, function()
				p2.itemInfo.switchItemTimer = nil
				p2.itemInfo.activeItemIndex = (p2.itemInfo.activeItemIndex + 1) % #p2.itemInfo.items
				p2.itemInfo.touched = false
				__wf_atom_ec43d06e(mMovie, p .. ".Items.Display", 8, { 12 }, { 100 }, v32.fadeTime, 0.1)
			end)

			if not __wf_atom_7e8ad928(p3) then
				__wf_atom_ec43d06e(p3, "Popup", 8, { 12 }, { 0 }, v32.fadeTime, 0)
			end
		end)
	end
end

local function fn14(p)
	if p.itemInfo.itemsCached == nil then
		return false
	end

	local items = p.itemInfo.items

	for i, _ in ipairs(items) do
		if not p.itemInfo.itemsCached[i] then
			continue
		end

		local v59 = p.itemInfo.itemsCached[i]

		if not (v59.initialized or __wf_atom_7e8ad928(v59.resLoader)) then
			return true
		end
	end

	return false
end

local function fn15(p)
	local name = p.name
	local ternary = module.Ternary(p.statusIcon, mMovie:__wf_atom_8e9ac384(p.statusIcon, true), "")
	local v59 = string.find(name, "|")
	local v60, v61

	if v59 then
		v60 = string.sub(name, v59 + 1, -1)
		v61 = string.sub(name, 1, v59 - 1)
	else
		v61 = name
		v60 = ""
	end

	local v62 = ternary .. v61

	if v3[name] then
		local v64 = v2[v3[name]]

		if mMovie:__wf_atom_387f260e(v64 .. ".Name", 36) == v62 then
			return v3[name]
		end

		mMovie:__wf_atom_48bd5a59(v64, "Name", 36, v62)
		mMovie:__wf_atom_4c1c1986(v64, "NameDarkener", 14, mMovie:__wf_atom_5e6e15c8(v64 .. ".Name", 40) + 100)
		mMovie:__wf_atom_48bd5a59(v64, "Clan", 36, v60)
		local v65 = v37

		if not v59 then
			v65 += mMovie:__wf_atom_5e6e15c8(v64 .. ".Clan", 41)
		end

		mMovie:__wf_atom_4c1c1986(v64, "Name", 1, v65)
		mMovie:__wf_atom_4c1c1986(v64, "NameDarkener", 1, v65)
		return v3[name]
	else
		local v63

		if #v4 >= 1 then
			v63 = v4[#v4]
			table.remove(v4, #v4)
		else
			v63 = #v2 + 1
			v2[v63] = fn10("Msg", "Msg", v63, 1000)
		end

		v3[name] = v63
		local v64 = v2[v63]

		if Engine.__wf_atom_578fc9dd() then
			mMovie:__wf_atom_48bd5a59(v64, "Name", 49, "Arial Unicode MS")
			mMovie:__wf_atom_48bd5a59(v64, "Clan", 49, "Arial Unicode MS")
		end

		mMovie:__wf_atom_50d60589(v64 .. ".Name", 36, v62)
		mMovie:__wf_atom_4c1c1986(v64, "NameDarkener", 14, mMovie:__wf_atom_5e6e15c8(v64 .. ".Name", 40) + 100)
		mMovie:__wf_atom_50d60589(v64 .. ".Clan", 36, v60)
		mMovie:__wf_atom_2dedec1a(v64, 13, true)
		local v65 = v37

		if not v59 then
			v65 += mMovie:__wf_atom_5e6e15c8(v64 .. ".Clan", 41)
		end

		mMovie:__wf_atom_4c1c1986(v64, "Name", 1, v65)
		mMovie:__wf_atom_4c1c1986(v64, "NameDarkener", 1, v65)
		mMovie:__wf_atom_4c1c1986(v64, "NameDarkener", 12, 50)
		return v63
	end
end

local function fn16(p, avatar)
	if p == "(kneels)" then
		avatar:__wf_atom_e06358f3(Symbol("Kneel"))
	elseif p == "(stands)" then
		avatar:__wf_atom_e06358f3(Symbol("IDLE"))
	elseif p == "(casts)" then
		avatar:__wf_atom_e06358f3(Symbol("EmberCast"))
	end
end

local function fn17()
	_T.OpenScreen("MissionStats", nil, true)
	_T.missionStatsPending = false

	if v24 ~= nil then
		v:RemoveTimer(v24)
	end
end

local function fn18()
	if __wf_atom_7e8ad928(v19) then
		_T.missionStatsPending = false
		return false
	end

	if v19:__wf_atom_62656485() then
		return true
	end

	local v59 = #v19:__wf_atom_8ba10f50() > 0
	local __wf_atom_a4359d36 = v19:__wf_atom_a4359d36()
	local v60

	if __wf_atom_7e8ad928(__wf_atom_a4359d36) then
		v60 = false
	else
		v60 = __wf_atom_a4359d36.missionType == 10
	end

	if not v59 or v60 then
		return false
	end

	if v59 and not v60 and _T.GoToScreen ~= nil then
		_T.missionStatsPending = true
		v24 = v:AddTimer(0.25, fn17)
		return false
	end

	return true
end

local v59 = 1
local rad = module.ToRad(90)
local v60 = Vector(0, 0.3, 0)
local v61 = math.cos(rad * 0.5)
local v62 = Vector()
local v63 = Vector()
local v64 = Vector()

local function fn19()
	local eyePosition = v20:EyePosition()
	local position = gameCamera:GetPosition()
	local v65 = __wf_atom_e97f3142(v20:__wf_atom_4e50d390())
	local count = 0

	for i = v59, #v6 do
		v59 = i
		count += 1

		if count > 25 then
			break
		end

		if v59 >= #v6 then
			v59 = 1
		end

		local v66 = v5[v6[i]]

		if __wf_atom_7e8ad928(v66) then
			v59 = 1
			break
		end

		local avatar = v66.avatar

		if not v66.Previous then
			v66.Previous = {}
		end

		if __wf_atom_7e8ad928(avatar) then
			local v67 = v3[v66.name]
			mMovie:__wf_atom_2dedec1a(v2[v67], 13, false)
			table.insert(v4, v67)
			v3[v66.name] = nil
			local v68, v69 = fn12(v66)
			local v70 = _T["InfoPopup_Data" .. tostring(v68)]

			if v70 ~= nil and v70.ClearWeapon ~= nil then
				v70.ClearWeapon()
				v70.ClearWeapon = nil
			end

			_T["InfoPopup_Data" .. tostring(v68)] = nil
			v44[v66.name] = nil
			table.insert(v46, v68)
			v69:SetVisible(false)
			v5[v6[i]] = nil
			table.remove(v6, i)
			v59 = 1
			break
		else
			local v67 = avatar == v20
			local v68 = true
			local v69

			if not v67 then
				avatar:__wf_atom_c5f1c61a(v62)
				VectorAdd(v62, v62, v53)
				__wf_atom_c37ab6c1(v62, v62, position)
				Normalize(v62)
				v69 = Dot(v62, v65)

				if v69 < v61 then
					v68 = false
				end
			end

			local v70, v71 = fn12(v66)
			local scaleInterp = 1

			if v68 and _T.HubTeleportOldPos == nil and not _T.HubTeleportAllActive then
				local nameOff = v66.nameOff
				local _name = v66.name
				local avatarText = v66.avatarText
				local snap = false
				local v75 = v2[fn15(v66)]
				avatar:__wf_atom_43a8b171(v63, v60)

				if v67 then
					if not v66.touched then
						mMovie:__wf_atom_7f57ab2f(v75, "Name", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "NameDarkener", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Clan", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Arrow", 13, false)
						mMovie:__wf_atom_e57658c2(v75, 11, 11390463)
						mMovie:__wf_atom_7f57ab2f(v75, "Items", 13, false)
					end

					if not v66.badgeInfo.touched then
						fn11(v75, v66)
						v66.badgeInfo.touched = true
					end

					snap = true
				else
					if v66.hidden and v66.hidden ~= v66.Previous.hidden then
						mMovie:__wf_atom_2dedec1a(v75, 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Name", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "NameDarkener", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Clan", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Arrow", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Message", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Bubble", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Items", 13, false)
						mMovie:__wf_atom_7f57ab2f(v75, "Badge", 13, false)
						v71:__wf_atom_2dedec1a("Popup", 13, false)
					else
						local v76 = Distance(v63, eyePosition)
						local v77 = math.max(v76, 0)
						scaleInterp = 1 - __wf_atom_421b01aa(v77 / v15, 0, 1)

						if not v66.touched then
							mMovie:__wf_atom_e57658c2(v75, 11, 16777215)
							mMovie:__wf_atom_7f57ab2f(v75, "Name", 13, true)
							mMovie:__wf_atom_7f57ab2f(v75, "NameDarkener", 13, true)
							mMovie:__wf_atom_7f57ab2f(v75, "Clan", 13, not v23)
							mMovie:__wf_atom_7f57ab2f(v75, "Arrow", 13, true)
						end

						if not v66.itemInfo.touched then
							mMovie:__wf_atom_7f57ab2f(v75, "Items", 13, v66.itemInfo.enabled)
							v71:__wf_atom_2dedec1a("Popup", 13, v66.itemInfo.enabled)
						end

						if not v66.badgeInfo.touched then
							mMovie:__wf_atom_7f57ab2f(v75, "Badge", 13, v66.badgeInfo.enabled)
						end

						if
							v66.Previous.scaleInterp == nil
							or math.abs(scaleInterp - v66.Previous.scaleInterp) > 0.0001
						then
							local v78 = __wf_atom_104bfe98(10, 100, scaleInterp)
							mMovie:__wf_atom_e57658c2(v75, 5, v78)
							mMovie:__wf_atom_e57658c2(v75, 6, v78)
							v66.Previous.scaleInterp = scaleInterp
						end

						local v78 = __wf_atom_104bfe98(10, 70, scaleInterp)
						v71:__wf_atom_e57658c2("Popup", 5, v78)
						v71:__wf_atom_e57658c2("Popup", 6, v78)

						if not v66.badgeInfo.touched then
							fn11(v75, v66)
						end

						if v66.itemInfo.enabled then
							if not v66.itemInfo.touched or fn14(v66) then
								fn13(v75, v66, v71)
								v71:__wf_atom_2dedec1a("Popup", 13, true)
							end

							local v79 = (math.max(v32.minDistance, (math.min(v76, v32.maxDistance))) - v32.minDistance) / (v32.maxDistance - v32.minDistance)
							local itemsAlpha = __wf_atom_104bfe98(0, 1 - v79, (math.pow(v69, 5)))
							mMovie:__wf_atom_4c1c1986(v75, "Items", 1, mMovie:__wf_atom_5e6e15c8(v75 .. ".Name", 1))
							mMovie:__wf_atom_4c1c1986(
								v75,
								"Items.NameList",
								1,
								mMovie:__wf_atom_5e6e15c8(v75 .. ".Items.Display", 1) + 60 - mMovie:__wf_atom_5e6e15c8(v75 .. ".Items.NameList", 41)
							)

							if itemsAlpha ~= v66.Previous.itemsAlpha then
								mMovie:__wf_atom_4c1c1986(v75, "Items", 5, v78)
								mMovie:__wf_atom_4c1c1986(v75, "Items", 6, v78)
								mMovie:__wf_atom_4c1c1986(v75, "Items", 12, __wf_atom_104bfe98(0, 100, itemsAlpha))
								v66.Previous.itemsAlpha = itemsAlpha
							end

							if v71:IsVisible() then
								v71:__wf_atom_e57658c2("_root", 12, __wf_atom_104bfe98(0, 85, itemsAlpha))
							end
						end

						v66.itemInfo.touched = true
						v66.badgeInfo.touched = true
						snap = module.Ternary(v76 > 0, false, true)

						if v66.snap ~= snap or not v66.touched then
							v66.snap = snap
							mMovie:__wf_atom_7f57ab2f(v75, "Message", 13, snap)
						end
					end

					v66.Previous.hidden = v66.hidden
				end

				v66.touched = true
				local v76 = string.sub(avatarText, nameOff + 1)
				mMovie:__wf_atom_e57658c2(v75, 12, scaleInterp * scaleInterp * 100)

				if mMovie:__wf_atom_387f260e(v75 .. ".Message", 36) ~= v76 then
					fn16(v76, avatar)

					if v76 == "" then
						if v66.Previous.msgVisible == nil or v66.Previous.msgVisible then
							mMovie:__wf_atom_4c1c1986(v75, "Message", 12, 0)
							mMovie:__wf_atom_4c1c1986(v75, "Bubble", 12, 0)
							v66.Previous.msgVisible = false
						end
					else
						if not v66.Previous.msgVisible then
							mMovie:__wf_atom_4c1c1986(v75, "Message", 12, 100)
							mMovie:__wf_atom_4c1c1986(v75, "Bubble", 12, 100)
							v66.Previous.msgVisible = true
						end

						module.AnimateTyping(mMovie, nil, v75 .. ".Message", v76, function()
							__wf_atom_ec43d06e(mMovie, v75 .. ".Message", 0, { 12 }, { 0 }, 0.35, 5)
							__wf_atom_ec43d06e(mMovie, v75 .. ".Bubble", 0, { 12 }, { 0 }, 0.35, 5)
						end, 0.25)
						mMovie:__wf_atom_4c1c1986(
							v75,
							"Bubble",
							0,
							-14 - mMovie:__wf_atom_5e6e15c8(v75 .. ".Message", 40) * 0.5
						)
						mMovie:__wf_atom_4c1c1986(
							v75,
							"Bubble",
							1,
							-44 - mMovie:__wf_atom_5e6e15c8(v75 .. ".Message", 41)
						)
						__wf_atom_ec43d06e(mMovie, v75 .. ".Bubble", 0, { function(p)
								local v77 = math.sin(p * 3.141592653589793 * 2)
								mMovie:__wf_atom_4c1c1986(v75, "Bubble", 5, math.abs(v77) * 15 + 85)
								mMovie:__wf_atom_4c1c1986(v75, "Bubble", 6, math.abs(v77) * 15 + 85)
							end }, { 1 }, 0.5)
					end
				end

				mMovie:__wf_atom_5c42898a(v64, v63, true, snap)
				mMovie:__wf_atom_e57658c2(v75, 0, v64.x)
				mMovie:__wf_atom_e57658c2(v75, 1, v64.y)
				mMovie:__wf_atom_2dedec1a(v75, 13, v64.z < 1)
				local v77 = _T["InfoPopup_Data" .. tostring(v70)]

				if v77 ~= nil then
					v77.CustomPopupPosition = {
						x = (mMovie:__wf_atom_cfc41e35(v75, "Items.Display", 2) - scaleInterp * 32) * v71:__wf_atom_97cd8326() / mMovie:__wf_atom_97cd8326(),
						y = (mMovie:__wf_atom_cfc41e35(v75, "Items.Display", 3) + scaleInterp * 52) * v71:__wf_atom_54eeda24() / mMovie:__wf_atom_54eeda24()
					}
					v71:__wf_atom_e57658c2("Popup", 0, v77.CustomPopupPosition.x)
					v71:__wf_atom_e57658c2("Popup", 1, v77.CustomPopupPosition.y)

					if v64.z >= 1 then
						v71:__wf_atom_e57658c2("_root", 12, 0)
					end
				end
			else
				local v73 = v3[v66.name]
				mMovie:__wf_atom_2dedec1a(v2[v73], 13, false)
				v71:__wf_atom_2dedec1a("Popup", 13, false)
			end
		end
	end
end

local function fn20(p)
	p.badgeInfo.items = {}
	p.badgeInfo.activeItemIndex = 1
	local name = p.name
	local v65 = string.find(p.name, "|")

	if v65 then
		name = string.sub(p.name, 1, v65 - 1)
	end

	if _G.Scenario and _G.Scenario.Medalists and _G.Scenario.Medalists[name] then
		for _, iconIndex in pairs(_G.Scenario.Medalists[name]) do
			table.insert(p.badgeInfo.items, { IconIndex = iconIndex, Label = "" })
		end
	end
end

function ClearRegattaGame()
	v29 = nil
	from2 = nil
end

function RefreshLeaderBoards()
	for i = 1, #v26 do
		v26[i].forceRefreshBadge = true
	end
end

local function fn21(object)
	if gGameRules:IsA(__wf_atom_589d05aa) then
		if not gGameRules:__wf_atom_af3bd666() then
			return
		end
	elseif not gGameRules:IsA(__wf_atom_e714d8ac) then
		return
	end

	local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()

	for i = 1, #v26 do
		local v65 = v26[i]
		local avatar = v65.Avatar

		if __wf_atom_7e8ad928(avatar) or avatar:IsA(sentinelAvatarType) then
			continue
		end

		if v65.pos == nil then
			v65.pos = Vector()
		end

		avatar:__wf_atom_c5f1c61a(v65.pos)

		if object:__wf_atom_8a6b8fc3(avatar) <= 50 then
			if avatar:IsA(v38) then
				v65.t = avatar:__wf_atom_818ea3a7()
			else
				v65.t = gGameRules:__wf_atom_28274998(avatar)
			end

			v65.playerStatusIcon = gGameRules:__wf_atom_cba669bb(avatar)
			v65.playerDisplayingItems = gGameRules:__wf_atom_af3bd666()
				and avatar:__wf_atom_7b686578()
				and avatar:__wf_atom_1cb10548()
			v65.playerDisplayingBadges = _G.Scenario ~= nil
			v65.playerHidden = gGameRules:__wf_atom_5a12aa12(avatar)
			v65.nameOff = string.find(v65.t, ":")

			if v65.nameOff and v65.nameOff > 1 then
				local name = string.sub(v65.t, 1, v65.nameOff - 1)

				if v5[name] == nil then
					local v67 = {
						statusIcon = v65.playerStatusIcon,
						name = name,
						nameOff = v65.nameOff,
						avatar = avatar,
						avatarText = v65.t,
						touched = false,
						snap = false,
						itemInfo = {
							enabled = v65.playerDisplayingItems,
							text = "",
							switchItemTimer = nil,
							activeItemIndex = 0,
							items = nil,
							touched = false
						},
						badgeInfo = {
							enabled = gMatchingService:__wf_atom_a676a953(),
							items = nil,
							switchItemTimer = nil,
							activeItemIndex = 1,
							touched = false
						},
						hidden = v65.playerHidden
					}

					if v65.playerDisplayingItems then
						v67.itemInfo.items = {}
						local __wf_atom_7489018f = avatar:__wf_atom_7489018f()

						for j = 1, #__wf_atom_7489018f do
							local decoded = cjson.decode(__wf_atom_7489018f[j])
							table.insert(v67.itemInfo.items, decoded)
						end
					end

					if v65.playerDisplayingBadges then
						fn20(v67)
					end

					v5[name] = v67
					table.insert(v6, name)
				elseif v5[name].hidden == v65.playerHidden then
					if v5[name].statusIcon == v65.playerStatusIcon then
						if v5[name].itemInfo.enabled == v65.playerDisplayingItems then
							if v5[name].badgeInfo.enabled ~= v65.playerDisplayingBadges or v65.forceRefreshBadge then
								v5[name].badgeInfo.enabled = v65.playerDisplayingBadges
								v5[name].badgeInfo.touched = false
								v65.forceRefreshBadge = nil

								if v65.playerDisplayingBadges then
									fn20(v5[name])
								else
									v5[name].badgeInfo.items = nil
								end
							end
						else
							v5[name].itemInfo.enabled = v65.playerDisplayingItems
							v5[name].itemInfo.touched = false

							if v65.playerDisplayingItems then
								v5[name].itemInfo.items = {}
								local __wf_atom_7489018f = avatar:__wf_atom_7489018f()

								for j = 1, #__wf_atom_7489018f do
									local decoded = cjson.decode(__wf_atom_7489018f[j])
									table.insert(v5[name].itemInfo.items, decoded)
								end

								v5[name].itemInfo.activeItemIndex = 0
								v5[name].itemInfo.itemsCached = nil
							else
								v5[name].itemInfo.items = nil
								v5[name].itemInfo.itemsCached = nil
							end
						end
					else
						v5[name].statusIcon = v65.playerStatusIcon
					end
				else
					v5[name].hidden = v65.playerHidden
					v5[name].touched = false
				end
			end
		end

		if v65.playerName and not (v65.loadoutLoaded or __wf_atom_7e8ad928(__wf_atom_9c7c90fb)) then
			v65.loadoutLoaded = __wf_atom_9c7c90fb:__wf_atom_3179c2db(v65.playerName)

			if v65.loadoutLoaded then
				local _hubShowRoomActive = _T.HubShowRoomActive

				if _T.ForcedFlying then
					fn5(true, avatar)
				end
			end
		end

		if not _T.ForcedFlying or _T.HubTeleportAllActive or not v65.loadoutLoaded then
			continue
		end

		local __wf_atom_6c2fc5cb = avatar:__wf_atom_6c2fc5cb()

		if __wf_atom_7e8ad928(__wf_atom_6c2fc5cb) or __wf_atom_6c2fc5cb:IsA(v49) then
			continue
		end

		print(v65.playerName .. " should be flying, but isn't! Forcing now")
		fn5(true, avatar)
	end

	fn19()
end

local function fn22(object)
	local __wf_atom_e800787c = object:__wf_atom_e800787c()

	if __wf_atom_7e8ad928(__wf_atom_e800787c) or v12 or _T.HubTeleportOldPos ~= nil or _T.HubTeleportAllActive then
		return
	end

	if __wf_atom_e800787c ~= v8 then
		v8 = __wf_atom_e800787c
		local __wf_atom_a840ea95 = v8:__wf_atom_a840ea95()

		if __wf_atom_a840ea95 ~= v9 then
			v9 = __wf_atom_a840ea95
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(tostring(v9), false)

			if __wf_atom_8e9ac384 == "" then
				return
			end

			v12 = true
			mMovie:__wf_atom_e57658c2("LocationPopup", 12, 100)
			mMovie:__wf_atom_50d60589("LocationPopup.SubLocation", 36, __wf_atom_8e9ac384)
			local v66 = (v10 == nil or v10 == "") and 1 or v10 + 1
			mMovie:__wf_atom_50d60589("LocationPopup.Location", 36, hubLocationDesc .. " " .. v66)
			mMovie:__wf_atom_e57658c2(
				"LocationPopup.Location",
				1,
				v28 + module.Ternary(__wf_atom_8e9ac384 == "", 13, 0)
			)
			fn3(v9)
			titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, 0)
			titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, 0)
			mMovie:__wf_atom_e57658c2("LocationPopup.SubLocation", 12, 0)
			mMovie:__wf_atom_e57658c2("LocationPopup.Location", 12, 0)
			mMovie:__wf_atom_e57658c2("LocationPopup.TitleLines", 12, 0)
			mMovie:__wf_atom_e57658c2("LocationPopup.Faction", 12, 0)
			__wf_atom_ec43d06e(mMovie, "LocationPopup.TitleLines", 8, {
				function(p)
					local visibilitySize = module.GetVisibilitySize(mMovie, 200 * p)
					local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 100 * p)
					titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
					titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
				end,
				12
			}, { 1, 100 }, 0.5, 0, function()
				__wf_atom_ec43d06e(mMovie, "LocationPopup.SubLocation", 8, { 12 }, { 100 }, 1)
				__wf_atom_ec43d06e(mMovie, "LocationPopup.Faction", 8, { 12 }, { 100 }, 1)
				v:AddTimer(5, function()
					__wf_atom_ec43d06e(mMovie, "LocationPopup", 8, { 12 }, { 0 }, 1, 0, function()
						titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, 0)
						titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, 0)
						v12 = false
					end)
				end)
			end)
		end
	end
end

function onViewportSizeChanged(_, _)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 100)
	titleBgMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
end

local function fn23(object)
	if not __wf_atom_7e8ad928(_T.VoidTraderDeco) and not v14 and object:__wf_atom_8a6b8fc3(_T.VoidTraderDeco) <= 25 then
		v14 = true

		if not __wf_atom_7e8ad928(_T.VoidTraderEnterTransmission) then
			_T.VoidTraderEnterTransmission()
		end
	end
end

local v65 = nil

function Rejected(_) end

local v66 = ""
local gGameRules2 = nil

local function fn24()
	if __wf_atom_7e8ad928(v20) then
		return
	end

	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_af3bd666() then
		gGameRules2 = nil
		return
	end

	if gGameRules2 ~= gGameRules then
		gGameRules2 = gGameRules

		if gGameRules:__wf_atom_af3bd666() then
			gMatchingService:__wf_atom_9ad738f8("Hub", "OnRelayP2PData")
		end
	end

	if _T.gPendingDuel ~= nil and _T.gPendingDuel.Waiting and v18 <= 0 then
		v18 = 10
	end

	if v18 > 0 then
		v18 -= __wf_atom_fa1258d0()

		if _T.gPendingDuel == nil or _T.gPendingDuel.OpponentId == nil then
			v18 = 0
		elseif v18 <= 0 then
			v18 = 0
			local encoded = cjson.encode({ hubGame = "duel", state = "cancel" })
			gMatchingService:__wf_atom_6ff767a1(_T.gPendingDuel.OpponentId, encoded)
			_T.gPendingDuel = nil
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
			module.ShowMessage("/Lotus/Language/Dojo/DuelSessionCancelled", "Rejected")
		end
	end

	local __wf_atom_28274998 = gGameRules:__wf_atom_28274998(v20)

	if v66 == __wf_atom_28274998 then
		return
	end

	v66 = __wf_atom_28274998
	local v67 = string.find(__wf_atom_28274998, ":")

	if not v67 then
		return
	end

	if string.sub(__wf_atom_28274998, v67 + 1) == "invitego" then
		local __wf_atom_f2e7f4a9 = v20:__wf_atom_d2b2176d():__wf_atom_f2e7f4a9()

		if not __wf_atom_7e8ad928(__wf_atom_f2e7f4a9) then
			local __wf_atom_70f5d0a5 = gGameRules:__wf_atom_70f5d0a5(__wf_atom_f2e7f4a9)

			if __wf_atom_70f5d0a5 ~= "" and __wf_atom_70f5d0a5 ~= "" then
				v65 = { hubGame = "go", state = "invite" }
				local encoded = cjson.encode(v65)
				gMatchingService:__wf_atom_6ff767a1(__wf_atom_70f5d0a5, encoded)
			end
		end
	end
end

function ConfirmStartDuel(p)
	if _T.gPendingDuel == nil or _T.gPendingDuel.OpponentId == nil then
		return
	end

	local v67 = { hubGame = "duel", state = "reject" }
	local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(_T.gPendingDuel.OpponentId)

	if tonumber(p) == 4 and not (__wf_atom_7e8ad928(_T.SquadOverlay) or __wf_atom_7e8ad928(__wf_atom_d68faea4)) then
		v67.state = "accept"
		local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(dojoDuelActionType, __wf_atom_d68faea4:GetPosition(), 25)
		local componentParams = _T.DojoMgr:BuildComponentParams(__wf_atom_e2db08ce)
		_T.gPendingDuel.RoomId = componentParams.id
		_T.SquadOverlay:Execute("InitiateDojoDuel", "")
	end

	local encoded = cjson.encode(v67)
	gMatchingService:__wf_atom_6ff767a1(_T.gPendingDuel.OpponentId, encoded)
end

local function fn25(decoded)
	local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(decoded.from)

	if __wf_atom_7e8ad928(__wf_atom_d68faea4) then
		return
	end

	if decoded.msg.hubGame == "duel" then
		if decoded.msg.state == "invite" then
			_T.gPendingDuel = { OpponentId = decoded.from }
			v17 = module.ShowYesOrNoMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DuelSessionConfirm", false, {
					OPPONENT = __wf_atom_d68faea4:__wf_atom_818ea3a7()
				}),
				"ConfirmStartDuel"
			)
		elseif decoded.msg.state == "accept" then
			if not __wf_atom_7e8ad928(_T.SquadOverlay) then
				_T.SquadOverlay:Execute("SearchForDojoDuel", "")
			end
		elseif decoded.msg.state == "reject" then
			_T.gPendingDuel = nil
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
			module.ShowMessage("/Lotus/Language/Dojo/DuelSessionCancelled", "Rejected")
		elseif decoded.msg.state == "cancel" then
			if not __wf_atom_7e8ad928(v17) then
				v17:Execute("TransitionOut", "")
			end

			_T.gPendingDuel = nil
			module.ShowMessage("/Lotus/Language/Dojo/DuelSessionCancelled", "Rejected")
		end
	end
end

function OnHubData(p, p2)
	if p then
		local __wf_atom_ade7f08f = gRegion:__wf_atom_ade7f08f()
		__wf_atom_ade7f08f.level = hubProcLevel
		local __wf_atom_cb49ad09 = _T.DojoMgr.mDojo:__wf_atom_cb49ad09(p2, __wf_atom_ade7f08f)

		if not __wf_atom_7e8ad928(__wf_atom_cb49ad09) then
			_T.DojoMgr.mJsonProcLevelHelper:__wf_atom_c752491a(-1, __wf_atom_cb49ad09, "")
		end
	else
		print("Tried to get node data but it failed!")
	end
end

local function fn26(decoded)
	local v67 = Resource(decoded.msg.anim)
	local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(decoded.from)

	if __wf_atom_7e8ad928(v67) and v67 ~= nil then
		v67 = nil
	end

	if not __wf_atom_7e8ad928(__wf_atom_d68faea4) then
		__wf_atom_d68faea4:__wf_atom_9b5dcd3b(
			v67,
			decoded.msg.wait,
			decoded.msg.movementMode,
			decoded.msg.playStyle,
			decoded.msg.blocking
		)
	end
end

local function fn27(decoded)
	local id = decoded.msg.id
	local particle = decoded.msg.particle
	local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(decoded.from)

	if not __wf_atom_7e8ad928(__wf_atom_d68faea4) and particle ~= "" then
		particle = Resource(particle)
	end

	if __wf_atom_7e8ad928(__wf_atom_d68faea4) or __wf_atom_7e8ad928(particle) or particle == "" then
		if not __wf_atom_7e8ad928(v36[id]) then
			v36[id]:Destroy()
		end

		v36[id] = nil
	else
		local attachString = decoded.msg.attachString or ""
		local targetPos = decoded.msg.targetPos
		v36[id] = __wf_atom_d68faea4:Attach(particle, Symbol(attachString))

		if targetPos then
			v36[id]:__wf_atom_a64eca67(Vector(targetPos.x, targetPos.y, targetPos.z))
		end
	end
end

function DoYouWantToPlayRegatta(p)
	if p ~= 4 and p ~= 5 then
		return
	end

	if p == 4 then
		local __wf_atom_2586e47b = gMatchingService:__wf_atom_9c7c90fb():__wf_atom_2586e47b(from)
		local v67 = {
			minigame = "ur",
			type = 0,
			value = gRegion:__wf_atom_eab484a7():__wf_atom_6be84646()
		}
		local encoded = cjson.encode(v67)
		gMatchingService:__wf_atom_6ff767a1(from, encoded)
		local v68 = WeakResource("/SF/Interface/Minigames/Ur.swf")
		local __wf_atom_8b74c30b = __wf_atom_8e4fda44:__wf_atom_8b74c30b(v68)

		if not __wf_atom_7e8ad928(__wf_atom_8b74c30b) then
			from2 = from
			__wf_atom_8b74c30b:__wf_atom_f62a8704("ProcessHudMessage", {
				0,
				from,
				"",
				__wf_atom_2586e47b
			})
		end

		from = nil
		gRegion:__wf_atom_c4f78a8f():__wf_atom_84b48bf2(3)
		local v69 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
		gGameRules:SendControlMessage(v69)
	else
		from = nil
		gRegion:__wf_atom_c4f78a8f():__wf_atom_84b48bf2(1)
		local v67 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
		gGameRules:SendControlMessage(v67)
	end
end

local function fn28(decoded) -- 1 equivalent call inferred from this helper
	print("Text is: " .. decoded.msg.text)
end

local function fn29(decoded) -- 1 equivalent call inferred from this helper
	local v67 = Resource(decoded.msg.emote)
	local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(decoded.from)

	if not __wf_atom_7e8ad928(__wf_atom_d68faea4) then
		__wf_atom_d68faea4:__wf_atom_7ab15c94(v67)
	end
end

local function fn30(decoded) -- 1 equivalent call inferred from this helper
	local enteringNightFold = decoded.msg.enteringNightFold
	local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(decoded.from)

	if not __wf_atom_7e8ad928(__wf_atom_d68faea4) and __wf_atom_d68faea4:IsA(__wf_atom_94cc9c18) then
		__wf_atom_d68faea4:__wf_atom_d3c21b7d(enteringNightFold)
	end
end

function OnRelayP2PData(_, p)
	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_af3bd666() then
		return
	end

	local decoded = cjson.decode(p)

	if not decoded.msg then
		print("Hub::OnRelayP2PData: " .. p)
	elseif decoded.msg.text ~= nil then
		fn28(decoded) -- inferred equivalent call
	elseif decoded.msg.emote == nil then
		if decoded.msg.actionSpec == nil then
			if decoded.msg.hubGame ~= nil then
				fn25(decoded)
			elseif decoded.msg.minigame == nil then
				if decoded.msg.anim ~= nil then
					fn26(decoded)
				elseif decoded.msg.particle ~= nil then
					fn27(decoded)
				elseif decoded.msg.broadcast == true then
					_T.HubBroadcastMsg = module.CopyTable(decoded)
					gRegion:__wf_atom_c4f78a8f():__wf_atom_8a035cd5(Symbol("OnHubBroadcast"), false)
				elseif decoded.msg.bless == true then
					_T.HubBlessingMsg = module.CopyTable(decoded)
					_T.PendingHubBlessing = true
				elseif decoded.msg.thank == true then
					_T.HubThankYouMsg = module.CopyTable(decoded)
					_T.PendingHubThankYou = true
				elseif decoded.msg.enteringNightFold == nil then
					if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_1316e0c2) then
						if decoded.msg.guildSync == nil then
							if decoded.msg.dojoMsgType ~= nil then
								if decoded.msg.dojoMsgType == 0 then
									gGameRules:__wf_atom_364a3909(decoded.msg.id, decoded.msg.op, decoded.msg.u)
								elseif decoded.msg.dojoMsgType == 1 then
									gGameRules:__wf_atom_76d59709(
										decoded.msg.n,
										decoded.msg.a,
										decoded.msg.f,
										decoded.msg.u
									)
								elseif decoded.msg.dojoMsgType == 2 then
									gGameRules:__wf_atom_9f93aaf2(decoded.msg.t)
								elseif decoded.msg.dojoMsgType == 3 then
									gGameRules:__wf_atom_7e5ce6f0(decoded.msg.g, decoded.msg.a)
								elseif decoded.msg.dojoMsgType == 4 then
									gGameRules:__wf_atom_d45e7f6d(decoded.msg.n)

									if decoded.msg.c ~= nil then
										gGameRules:__wf_atom_420f6744(decoded.msg.c, decoded.msg.d)
									end
								end
							end
						else
							if decoded.msg.dirtyComponents ~= nil then
								gGameRules:__wf_atom_cfaceb5a(decoded.msg.dirtyComponents, decoded.msg.u)
							end

							gGameRules:__wf_atom_80e1c8d8()
						end
					end
				else
					fn30(decoded) -- inferred equivalent call
				end
			elseif decoded.msg.minigame == "ur" then
				if __wf_atom_7e8ad928(decoded.msg.regattagamerequest) or decoded.msg.regattagamerequest ~= 1 then
					local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
					local __wf_atom_70f5d0a5 = gGameRules:__wf_atom_70f5d0a5(__wf_atom_c4f78a8f)

					if not __wf_atom_c4f78a8f:__wf_atom_4417a5d4() or __wf_atom_70f5d0a5 ~= decoded.to then
						return
					end

					if __wf_atom_7e8ad928(v29) then
						local v67 = WeakResource("/SF/Interface/Minigames/Ur.swf")
						v29 = __wf_atom_8e4fda44:FindMovie(v67)

						if __wf_atom_7e8ad928(v29) then
							v29 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(v67)
							gRegion:__wf_atom_c4f78a8f():__wf_atom_84b48bf2(3)
							local v68 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
							gGameRules:SendControlMessage(v68)
						end
					end

					if not __wf_atom_7e8ad928(v29) then
						from2 = decoded.from
						v29:__wf_atom_f62a8704("ProcessHudMessage", {
							decoded.msg.type,
							decoded.from,
							decoded.to,
							decoded.msg.value
						})
					end
				elseif gRegion:__wf_atom_c4f78a8f():__wf_atom_143cdd78() == 1 and __wf_atom_7e8ad928(from) then
					from = decoded.from
					gGameRules:__wf_atom_d68faea4(decoded.from)
					gRegion:__wf_atom_c4f78a8f():__wf_atom_84b48bf2(2)
					local v67 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
					gGameRules:SendControlMessage(v67)
					module.ShowYesOrNoMessage(
						"Do you want to play Regatta with " .. decoded.msg.value,
						"DoYouWantToPlayRegatta"
					)
				end
			end
		elseif not __wf_atom_7e8ad928(gGameRules) then
			gGameRules:__wf_atom_19e9b266(p)
		end
	else
		fn29(decoded) -- inferred equivalent call
	end
end

fn2 = function(object, p)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa())) then
		local __wf_atom_cca6e0bc = object:__wf_atom_a96eb2aa():__wf_atom_cca6e0bc()

		if not __wf_atom_7e8ad928(__wf_atom_cca6e0bc) then
			__wf_atom_cca6e0bc:__wf_atom_625c9edc(p)
			__wf_atom_cca6e0bc:__wf_atom_0ba8cbd8(p)
		end
	end
end

function ActiveQuestLoaded(p, _)
	print("Hub.lua - active quest loaded: " .. tostring(p))

	if not p then
		_T.ActiveQuestLoaded = false
		return
	end

	_T.ActiveQuestLoaded = true
	module2.UpdateQuests()
end

local function fn31()
	if
		gGameRules:__wf_atom_72fc675e().location == module2.OROKIN_TOWER_NODE_TAG
		and gMatchingService:__wf_atom_1b24a1bb()
		and not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
		and gMatchingService:__wf_atom_34367673() == __wf_atom_3e61816b(0)
	then
		local rotatingMissionSeed = module3.GetRotatingMissionSeed(360)
		gMatchingService:SetSquadMissionSeed(__wf_atom_3e61816b(rotatingMissionSeed))
	end
end

local function fn32(p) -- 9 equivalent calls inferred from this helper
	__wf_atom_f2daf912(p)
	print(p)
end

local function fn33(p, p2)
	if p then
		if not _T.QueuedSendHubBlessing then
			print("HubBlessing: _T.QueuedSendHubBlessing nil!")
			return
		end

		print("HubBlessing: successfully sent. Now broadcasting " .. _T.QueuedSendHubBlessing.type .. " to relay")
		local v67 = { bless = true, tag = _T.QueuedSendHubBlessing.type }
		local encoded = cjson.encode(v67)
		gMatchingService:__wf_atom_6ff767a1("all", encoded)
		_T.HubBlessingMsg = {
			from = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3(),
			msg = module.CopyTable(v67)
		}
		_T.PendingHubBlessing = true
		_T.QueuedSendHubBlessing = nil
	else
		fn32("Hub::SendHubBlessing failed: " .. p2) -- inferred equivalent call
	end
end

local v67 = false
local v68 = false

function Update()
	if __wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(gGameRules) then
		return
	end

	if __wf_atom_7e8ad928(gameCamera) then
		gameCamera = gRegion:GetGameCamera()
	end

	local uiMode = module2.GetUIMode()

	if uiMode == module2.UI_MODE_IN_SPACE_HUB or uiMode == module2.UI_MODE_IN_DOJO then
		if not __wf_atom_7e8ad928(bardLocalMixer) then
			bardLocalMixer:__wf_atom_c2a0827a(bardLocalMixerGain)
		end

		if not __wf_atom_7e8ad928(bardPositionalMixer) then
			bardPositionalMixer:__wf_atom_d43688f3(v22)
			bardPositionalMixer:__wf_atom_c2a0827a(bardPositionalMixerGain)
		end
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v) then
		v:Update(__wf_atom_fa1258d0())
	end

	if __wf_atom_7e8ad928(v21) then
		if __wf_atom_7e8ad928(v20) then
			v20 = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(v20) then
				v21 = v20:__wf_atom_a96eb2aa()
				mMovie:__wf_atom_8fcdea81(v21)
			end
		end
	else
		v20 = module2.GetPlayerAvatar(v21, v20)
	end

	if
		not __wf_atom_7e8ad928(v20)
		and not gClient:__wf_atom_449cc668()
		and __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())
	then
		fn21(v20)
		fn22(v20)
		fn23(v20)
		module2.UpdateMailbox(v)

		if not v67 then
			fn2(v20, false)

			if not _T.QuestOverridesShipConsoles then
				module2.UpdateUIConsoleTriggers(true)
			end

			local movie = __wf_atom_8e4fda44:FindMovie(backgroundMovie)

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("RegisterWorldStateCallback", "true")
			end

			gMatchingService:__wf_atom_27e16961()
			fn6()

			if _T.TennoLiveStartDate and _T.gDoomsdayTimeRemaining and _T.gDoomsdayTimeRemaining < 0 then
				local _ = _T.gDoomsdayTimeRemaining >= -3600
			end

			v67 = true
		end

		if not v68 and _T.gHubOpenCinStarted and not __wf_atom_7e8ad928(gGameData) then
			v68 = true
			print("RequestingResource for active quest")

			if __wf_atom_7e8ad928(gGameData:GetInventory():GetActiveQuest()) then
				_T.ActiveQuestLoaded = true
			else
				gGameRules:RequestResource(
					gGameData:GetInventory():GetActiveQuest():__wf_atom_5b41f63b(),
					"ActiveQuestLoaded"
				)
			end
		end
	end

	local topMenuOpen = _T.TopMenuOpen
		or not __wf_atom_7e8ad928(__wf_atom_392793db)
		or gClient:__wf_atom_449cc668()
		or _T.ArsenalOpen
		or _T.ArsenalUpgradeOpen
		or _T.ModScreenOpen
		or _T.UIInputEnabled

	if not topMenuOpen then
		if total > 0 then
			topMenuOpen = true
		else
			topMenuOpen = not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())

			if not topMenuOpen then
				if _T.HideHud == nil then
					topMenuOpen = false
				else
					topMenuOpen = _T.HideHud > 0
				end
			end
		end
	end

	if topMenuOpen ~= v13 then
		v13 = topMenuOpen
		mMovie:__wf_atom_2dedec1a("_root", 13, not topMenuOpen)
	end

	fn24()
	fn31()

	if v25 then
		v25 = fn18()
	end

	if
		v43
		and not __wf_atom_7e8ad928(v21)
		and gGameRules:__wf_atom_dc0a2fe6()
		and not gMatchingService:__wf_atom_1b24a1bb()
		and gMatchingService:__wf_atom_8b3e33a6() > 1
	then
		print("Squad host state changed")
		v43 = false
		v21:__wf_atom_5b8fbfa0()
	end

	if v67 and _T.TennoLiveStartDate then
		local gDoomsdayTimeRemaining = _T.gDoomsdayTimeRemaining
		_T.gDoomsdayTimeRemaining = Engine.__wf_atom_db2b0cee(_T.TennoLiveStartDate)

		if gDoomsdayTimeRemaining > 0 then
			local _ = _T.gDoomsdayTimeRemaining <= 0
		end
	end

	if _T.QueuedSendHubBlessing and not _T.QueuedSendHubBlessing.sent then
		print("HubBlessing: actually sending " .. _T.QueuedSendHubBlessing.type)
		_T.QueuedSendHubBlessing.sent = true
		gGameData:SendHubBlessing(v48.boosters["bless" .. _T.QueuedSendHubBlessing.type], fn33)
	end

	if _T.PendingHubBlessing and not __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) then
		print("HubBlessing: running child script")
		_T.PendingHubBlessing = false
		gRegion:__wf_atom_c4f78a8f():__wf_atom_8a035cd5(Symbol("OnHubBlessing"), false)
	end

	if _T.PendingHubThankYou and not __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) then
		_T.PendingHubThankYou = false
		gRegion:__wf_atom_c4f78a8f():__wf_atom_8a035cd5(Symbol("OnHubThankYou"), false)
	end
end

function SetLocation(value, hubLocationIndex, p)
	v7 = value
	hubLocationDesc = value
	v10 = hubLocationIndex
	hubLocationDesc = ""

	if hubLocationDesc == "" and _T.DojoMgr and not __wf_atom_7e8ad928(_T.DojoMgr.mGameRules) then
		hubLocationDesc = _T.DojoMgr.mGameRules:__wf_atom_84083b39()
	end

	_T.HubLocationDesc = hubLocationDesc
	_T.HubLocationIndex = hubLocationIndex

	if not p and not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_af3bd666() then
		gMatchingService:__wf_atom_9ad738f8("Hub", "OnRelayP2PData")
	end

	if _T.OnReturnToHubCallbacks then
		for _, onReturnToHubCallback in pairs(_T.OnReturnToHubCallbacks) do
			if onReturnToHubCallback and type(onReturnToHubCallback) == "function" then
				onReturnToHubCallback()
			end
		end

		_T.OnReturnToHubCallbacks = nil
	end

	local v69 = string.find(value, "TennoCon")
	local v70 = string.find(value, "DevStream")

	if (v69 or v70) and not Engine.__wf_atom_578fc9dd() then
		if v69 then
			_T.TennoLiveStartDate = MongoDateTime()
			_T.TennoLiveStartDate.sec = module5.GetWorldStateOverride("tl21date", "1626555600")
		elseif _G.CachedGoalInfo and _G.CachedGoalInfo[value] then
			_T.TennoLiveStartDate = _G.CachedGoalInfo[value].mAltActivation:Copy()
		end

		_T.TennoConHubActive = true
		_T.gDoomsdayFaction = 3

		if _T.TennoLiveStartDate then
			_T.gDoomsdayTimeRemaining = Engine.__wf_atom_db2b0cee(_T.TennoLiveStartDate)
		else
			_T.gDoomsdayTimeRemaining = 0
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("AnnihilationCountdown"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Enable()
		end

		if not string.find(tostring(gGameRules:__wf_atom_72fc675e().levelOverride:__wf_atom_5b41f63b()), "Hydroid") then
			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("RhinoStatue"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
				__wf_atom_0a6a5887_2:SetVisibility(false, true)
				__wf_atom_0a6a5887_2:__wf_atom_0ed81088(false)
				local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("RhinoStatueAttachment"))

				if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
					for _, v71 in pairs(__wf_atom_2226b35c) do
						v71:SetVisibility(false, true)
						v71:__wf_atom_0ed81088(false)
					end
				end

				local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("RhinoBV"))

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
					__wf_atom_0a6a5887_3:__wf_atom_0ed81088(false)
				end
			end
		end

		local v71 = value == "TennoConBHUB6" or v70
		local v72 = Symbol("ExitHub")
		local v73 = Symbol("KneelAction")
		local all = gRegion:FindAll(__wf_atom_0f45538d)

		for _, v74 in pairs(all) do
			local __wf_atom_db682341 = v74:__wf_atom_db682341()

			if v71 and __wf_atom_db682341 ~= v72 or __wf_atom_db682341 == v73 then
				gRegion:__wf_atom_dd1e4d10(v74)
			end
		end
	end

	if
		v7 == tostring(module2.OROKIN_TOWER_NODE_TAG)
		and _G.CachedGoalInfo
		and _G.CachedGoalInfo[v7]
		and string.find(tostring(_G.CachedGoalInfo[v7].mTag), "Halloween") ~= nil
	then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("HalloweenDecos"))

		for _, v71 in ipairs(__wf_atom_2226b35c) do
			v71:SetVisibility(true, true)
		end
	end

	fn3(value)
end

local function fn34()
	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	local location = tostring(__wf_atom_9be88b01:__wf_atom_a4359d36().location)
	local v69 = nil
	local __wf_atom_bc667f6e = __wf_atom_9be88b01:__wf_atom_bc667f6e()
	local v70 = __wf_atom_bc667f6e - 1
	local __wf_atom_af3bd666 = gGameRules:__wf_atom_af3bd666()

	if __wf_atom_af3bd666 and v70 == 0 or not __wf_atom_af3bd666 and __wf_atom_bc667f6e == 6 then
		return 0
	end

	if __wf_atom_bc667f6e == 4 then
		local trainingMissionRank = _G.TrainingMissionRank

		if trainingMissionRank then
			local v71 = Symbol("ChallengeSpawn" .. trainingMissionRank)
			v69 = gRegion:__wf_atom_2226b35c(v71)
		end
	elseif location == "" then
		local __wf_atom_bc667f6e2 = __wf_atom_9be88b01:__wf_atom_bc667f6e()

		if not __wf_atom_7e8ad928(v30[__wf_atom_bc667f6e2]) then
			v69 = gRegion:__wf_atom_2226b35c(v30[__wf_atom_bc667f6e2])
		end
	else
		local v71 = string.lower(location)

		if string.find(v71, "crewbattle") or string.find(v71, "crewshipgenerictunnel") then
			if _T.streaming_prevLevel == nil then
				local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("SummonRailjack"))

				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					__wf_atom_0a6a5887:Skip()
				end

				v69 = gRegion:__wf_atom_2226b35c(Symbol("CrewshipBoardingAction"))
			end
		else
			local v72 = string.find(v71, "pvp") and 2
				or (location == "SolNode801" or location == "SolNode802") and 3
				or 1
			v69 = gRegion:__wf_atom_2226b35c(v30[v72])
		end
	end

	if v69 and #v69 > 0 then
		return v69[__wf_atom_5784a397(1, #v69)]
	end

	return 0
end

function OnSquadLoadoutChanged()
	v27.loadoutDirty = true
end

local function fn35(object)
	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_311a7128) then
		object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(false)
	end

	object:__wf_atom_d2b2176d():EnableWeaponFiring(false)
	object:MotionControl():__wf_atom_99fc7a82(true)
end

function OnOrbiterPlayersChanged()
	flag = true
end

function OnHostShipSynced(p, _)
	if p then
		_T.WaitingForShipSync = false
	end
end

local function fn36(object)
	object:__wf_atom_d2b2176d():__wf_atom_c8700ab5(false)
	object:__wf_atom_d2b2176d():EnableWeaponFiring(false)
	object:MotionControl():__wf_atom_99fc7a82(true)
	local cameraControl = object:CameraControl()
	cameraControl:__wf_atom_25382a0d(0.75, false)
	cameraControl:__wf_atom_25b071f9(v52)
end

local function fn37(object)
	v11 = nil

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	local all = gRegion:FindAll(__wf_atom_6e0c84cf)
	local v69 = {}

	for _, trigger in pairs(all) do
		table.insert(v69, {
			Trigger = trigger,
			Disable = trigger:IsEnabled() and not trigger:__wf_atom_a995e2d2()
		})
	end

	_T.InitializedUiTriggers = false
	local v70 = false

	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(0)
	end

	if gGameRules:__wf_atom_09e81034() then
		local v71 = 2

		while _T.RespawnPlayerForTNW == nil and v71 > 0 do
			Sleep(0)
			v71 -= __wf_atom_084b3e93()
		end

		if v71 <= 0 then
			print("timed out waiting for LisetMainPlayerSpawn")
		end

		if _T.RespawnPlayerForTNW then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			print("waiting for player respawn for TNW")

			while not __wf_atom_7e8ad928(object) and __wf_atom_c4f78a8f ~= object do
				Sleep(0)
			end

			object = __wf_atom_c4f78a8f
		end
	end

	if
		__wf_atom_7e8ad928(object)
		or not (gGameRules:__wf_atom_95862cc1() and (gRegion:IsMaster() or gGameRules:__wf_atom_09e81034()))
	then
		_T.InitializedUiTriggers = nil
		return
	end

	local cameraControl = object:CameraControl()
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	while __wf_atom_7e8ad928(__wf_atom_a96eb2aa) do
		Sleep(0)
		__wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	end

	if gRegion:IsMaster() then
		if gGameRules:__wf_atom_09e81034() then
			gRegion:__wf_atom_d5ede414("OnOrbiterPlayersChanged")
		end

		fn35(object)
	end

	local v71 = not gRegion:IsMaster() and gGameRules:__wf_atom_09e81034()

	if v71 then
		local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

		for i = 1, #__wf_atom_bb46d8b6 do
			local host = __wf_atom_bb46d8b6[i]

			if not host.isHost then
				continue
			end

			v27.host = host
			_T.WaitingForShipSync = true
			__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_30429067(
				"OnHostShipSynced",
				host.onlineId
			)
		end

		if not __wf_atom_7e8ad928(v27.host) then
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

			if __wf_atom_3c8e1a7a ~= nil then
				for i = 1, #__wf_atom_3c8e1a7a do
					local player = __wf_atom_3c8e1a7a[i]

					if __wf_atom_7e8ad928(player) or v27.host.playerId ~= player:__wf_atom_ef151cfd() then
						continue
					end

					v27.player = player
					v27.loadoutDirty = true
					gMatchingService:__wf_atom_e6083394(Symbol("PlayerShip"), "OnSquadLoadoutChanged")
				end
			end
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OptionsDisplayChange"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Disable()
		end

		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("LotusHelmetAction"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:Disable()
		end
	else
		_T.WaitingForShipSync = false
	end

	while not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(object)) do
		if flag then
			flag = false
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

			for i = 1, #__wf_atom_3c8e1a7a do
				local v72 = __wf_atom_3c8e1a7a[i]

				if v72:IsLocal() then
					continue
				end

				if __wf_atom_7e8ad928(v72:__wf_atom_50a7d83e()) then
					flag = true
					break
				else
					fn35(v72:__wf_atom_50a7d83e())
					v72:__wf_atom_52887b01(v72:__wf_atom_50a7d83e())
				end
			end
		end

		if not __wf_atom_7e8ad928(object) then
			cameraControl = object:CameraControl()

			while
				__wf_atom_a96eb2aa:__wf_atom_50a7d83e() == object
				and (__wf_atom_7e8ad928(cameraControl) or cameraControl:__wf_atom_c8c5ba0a())
			do
				Sleep(0)
				cameraControl = object:CameraControl()
			end
		end

		if
			not _T.DisableShipFOVScaling
			and not __wf_atom_7e8ad928(cameraControl)
			and __wf_atom_a96eb2aa:__wf_atom_50a7d83e() == object
			and not _T.ForcedFlying
		then
			cameraControl:__wf_atom_25382a0d(0.75, false)
			cameraControl:__wf_atom_25b071f9(v52)
		end

		if #v41 > 0 and not __wf_atom_7e8ad928(v42) and v42:__wf_atom_86399a47() and not _T.HasDailyTribute then
			local v72 = v41[1]

			if v72.Delay > 0 then
				v72.Delay -= __wf_atom_084b3e93()
			else
				module2.CreateHudlessTransmission(Resource(v72.Transmission))
				table.remove(v41, 1)
			end
		end

		if v71 and v27.loadoutDirty then
			local mShipInterior = v27.player:__wf_atom_a4299765().mShipInterior
			local all2 = gRegion:FindAll(__wf_atom_1e218e76)

			for i = 1, #all2 do
				local __wf_atom_e800787c = all2[i]:__wf_atom_e800787c()

				if (__wf_atom_7e8ad928(__wf_atom_e800787c) and 1 or __wf_atom_e800787c:__wf_atom_dd89d98c()) ~= 261 then
					all2[i]:__wf_atom_81175384(mShipInterior)
				end
			end

			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("RampMover"))

			if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
				local v72 = WeakResource("/Lotus/Scripts/Effects/LisetEffects.lua")
				__wf_atom_2226b35c[1]:__wf_atom_51009507(Resource(v72), Symbol("EntityColorButNoFlicker"), false)
			end

			v27.loadoutDirty = false
		end

		if not _T.InitializedUiTriggers and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
			while _T.syncingInventory == nil do
				Sleep(0)
			end

			print("Initializing UI triggers")

			if not (v71 or v70) then
				for i = 1, #v69 do
					if v69[i].Disable then
						v69[i].Trigger:Disable()
					end
				end

				v70 = true
			end

			while _T.syncingInventory == true do
				Sleep(0)
			end

			print("Inventory sync done")

			if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
				_T.BackgroundMovie:Execute("InitializeRegionChallenges", "")
			end

			if not v71 and not _T.QuestOverridesShipConsoles and v70 then
				for i = 1, #v69 do
					if not v69[i].Disable or __wf_atom_7e8ad928(v69[i].Trigger) then
						continue
					end

					v69[i].Trigger:Enable()
				end
			end

			if
				not __wf_atom_7e8ad928(_G.QueuedOrdisTransmission)
				and gGameRules:IsA(__wf_atom_311a7128)
				and gClient:__wf_atom_2ad290b4()
			then
				Sleep(1)
				module2.CreateHudlessTransmission(_G.QueuedOrdisTransmission)
				_G.QueuedOrdisTransmission = nil
			end

			if module2.GetUIMode() == module2.UI_MODE_IN_SPACE_SHIP and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
				__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_0d091b56(
					"OnWorldStateChanged",
					Symbol("PlayerShip"),
					false
				)
				fn()
			end

			if not (v71 or _T.QuestOverridesShipConsoles) then
				module2.UpdateUIConsoleTriggers(true)
			end

			_T.InitializedUiTriggers = true

			if not __wf_atom_7e8ad928(object) then
				cameraControl = object:CameraControl()
			end
		end

		if
			not _T.WaitingForShipSync
			and __wf_atom_7e8ad928(_T.ShipDecos)
			and not __wf_atom_7e8ad928(_T.BackgroundMovie)
		then
			_T.BackgroundMovie:Execute("SetupPlayerShip", "")
		end

		Sleep(0)

		if not __wf_atom_7e8ad928(object) then
			module2.UpdateHeadTracking(object)
		end
	end
end

function PlayerShip(p)
	fn37(p)
end

function FakePlayerShip(p)
	fn36(p)
end

function HubSessionReady()
	print("Hub session ready")
	local location = tostring(gGameRules:__wf_atom_72fc675e().location)
	gMatchingService:SetSquadHostHubLevelName(location .. module2.HUB_TAG)
end

local function fn38()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			return __wf_atom_9be88b01:__wf_atom_bdcb3fb9()
		end
	end

	return _T.MATCHMAKING_OFFLINE_GAMEMODE
end

local v69 = { module2.CETUS_NODE_TAG, module2.FORTUNA_NODE_TAG, module2.OROKIN_TOWER_NODE_TAG }
local v70 = Symbol("OpenCinShort")
local v71 = Symbol("OpenCin")

local function fn39(object)
	if __wf_atom_72884638("Relay.ForceLongCinematic") then
		return v71, true
	end

	local location = gGameRules:__wf_atom_72fc675e().location
	local flag2 = false

	for i = 1, #v69 do
		if location ~= v69[i] then
			continue
		end

		flag2 = true
		break
	end

	if flag2 then
		if object:__wf_atom_7f86fc42(location) then
			return v70, flag2
		else
			object:__wf_atom_c9bb8504(location)
		end
	end

	return v71, flag2
end

function HubShip(p)
	if not (gGameRules:__wf_atom_95862cc1() and gRegion:IsMaster()) then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	local v72 = not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())

	if v72 and gMatchingService:__wf_atom_607c7363() then
		local settings = gMatchingService:__wf_atom_15811761():GetSettings()
		local gameModeIdForNode = module2.BuildGameModeIdForNode(tostring(gGameRules:__wf_atom_72fc675e().location) .. module2.HUB_TAG)
		local __wf_atom_bdcb3fb9 = __wf_atom_9be88b01:__wf_atom_bdcb3fb9()

		if settings.region == 2 or settings.gameModeId ~= gameModeIdForNode then
			if __wf_atom_bdcb3fb9 == _T.MATCHMAKING_QUICKMATCH_GAMEMODE then
				settings.regionId = __wf_atom_18a5d83b:Settings():__wf_atom_7611b6b4().regionId
			else
				settings.regionId = module.Ternary(
					__wf_atom_bdcb3fb9 == _T.MATCHMAKING_INVITE_ONLY_GAMEMODE or __wf_atom_bdcb3fb9 == _T.MATCHMAKING_OFFLINE_GAMEMODE,
					1,
					3
				)
			end

			settings.gameModeId = gameModeIdForNode
			gMatchingService:__wf_atom_c8d901d4(settings, "OnUpdateSessionSettings")
		end
	end

	gMatchingService:__wf_atom_68bba63b(Symbol("Hub"), "OnLeaveSquad")
	gMatchingService:__wf_atom_f008492e(Symbol("Hub"), "OnSquadMemberLeft")
	local gActiveMatchMakingMode = fn38()

	if
		not v72
		and gMatchingService:__wf_atom_1b24a1bb()
		and gActiveMatchMakingMode ~= _T.MATCHMAKING_OFFLINE_GAMEMODE
		and not gMatchingService:IsBlockingTaskPending()
		and gMatchingService:GetState() == 0
	then
		local gameModeIdForNode = module2.BuildGameModeIdForNode(tostring(gGameRules:__wf_atom_72fc675e().location) .. module2.HUB_TAG)
		_T.gActiveMatchMakingMode = gActiveMatchMakingMode
		module3.HostSquadSession("HubSessionReady", gameModeIdForNode)
	end

	local v74 = fn34()

	if gGameRules:__wf_atom_af3bd666() then
		__wf_atom_9be88b01:__wf_atom_3f7ee611(6)
	else
		__wf_atom_9be88b01:__wf_atom_3f7ee611(0)
	end

	if
		_T.streaming_prevLevel ~= nil
		and not __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f())
		and gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():__wf_atom_5d9ae734()
	then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("OrbiterTube"))

		for _, v75 in ipairs(__wf_atom_2226b35c) do
			v75:Enable()
		end

		local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("CommanderMap"))

		for _, v75 in ipairs(__wf_atom_2226b35c2) do
			v75:Enable()
		end
	end

	local v75 = 0
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("FlyIn"))
	local v76

	if #__wf_atom_2226b35c > 0 then
		v76 = __wf_atom_2226b35c[__wf_atom_5784a397(1, #__wf_atom_2226b35c)]
	end

	if not __wf_atom_7e8ad928(v76) and _T.streaming_prevLevel == nil then
		v76:FirePort("StartPlaying")

		if v74 == 0 then
			if __wf_atom_72884638("Server.FastLoad") then
				v76:Skip()
			end

			while v76:__wf_atom_7d4910e4() do
				Sleep(0)
			end
		else
			while not (v76:__wf_atom_7d4910e4() or v76:__wf_atom_e9546dc6()) do
				Sleep(0)
			end

			v76:Skip()
		end
	end

	local v77, v78 = fn39(__wf_atom_9be88b01)
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(v77)

	if #__wf_atom_2226b35c2 > 0 then
		v75 = __wf_atom_5784a397(1, #__wf_atom_2226b35c2)
		v76 = __wf_atom_2226b35c2[v75]
	end

	local flag2

	if v77 == v71 and v78 then
		gGameRules:__wf_atom_da2edbc4(true)
		flag2 = true
	else
		flag2 = false
	end

	if not __wf_atom_7e8ad928(v76) and _T.streaming_prevLevel == nil then
		v76:FirePort("StartPlaying")

		if __wf_atom_72884638("Server.FastLoad") then
			v76:Skip()
		end

		if v74 ~= 0 then
			while not (v76:__wf_atom_7d4910e4() or v76:__wf_atom_e9546dc6()) do
				Sleep(0)
			end

			v76:Skip()
		end
	end

	_T.gHubOpenCinStarted = true
	local __wf_atom_2226b35c3 = gRegion:__wf_atom_2226b35c(Symbol("ExitHub"))

	if v75 > 0 and v75 <= #__wf_atom_2226b35c3 then
		local v79 = __wf_atom_2226b35c3[v75]
		v79:Enable()

		while not v79:IsEnabled() do
			Sleep(0)
			v79:Enable()
		end
	end

	local __wf_atom_2226b35c4 = gRegion:__wf_atom_2226b35c(Symbol("HubStartScript"))

	for i = 1, #__wf_atom_2226b35c4 do
		__wf_atom_2226b35c4[i]:FirePort("Execute")
	end

	while not __wf_atom_7e8ad928(v76) and v76:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	print("Hub: cinematic done")

	if flag2 then
		gGameRules:__wf_atom_da2edbc4(false)
	end

	if v74 ~= 0 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local __wf_atom_dc309f8a = v74:__wf_atom_dc309f8a()
		__wf_atom_dc309f8a.pitch = 0
		__wf_atom_c4f78a8f:Teleport(v74:GetPosition(), __wf_atom_dc309f8a)
		__wf_atom_c4f78a8f:__wf_atom_51075230(__wf_atom_dc309f8a)
	end

	fn37(p)
end

function OpenRadialSolarMap()
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(radialSolarMovie)
	__wf_atom_fa1033ac("HUD.HudVisible", false)
end

local function fn40(mTransmission, list)
	if _T.gQuestMission or _T.TNWLisetMission or _T.TNWCampLevel then
		return
	end

	_G.PlayedEventTransmissions = _G.PlayedEventTransmissions or {}

	if v41 == nil then
		v41 = {}
	end

	local __wf_atom_5b41f63b = mTransmission:__wf_atom_5b41f63b()

	if not module.IsValueInTable(_G.PlayedEventTransmissions, __wf_atom_5b41f63b) then
		table.insert(list, __wf_atom_5b41f63b)
		table.insert(v41, { Transmission = mTransmission, Delay = 4 })
		table.insert(_G.PlayedEventTransmissions, __wf_atom_5b41f63b)
	end
end

fn = function()
	if module2.GetUIMode() == module2.UI_MODE_IN_SPACE_SHIP then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			return
		end

		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			return
		end

		local __wf_atom_92662866 = __wf_atom_9be88b01:__wf_atom_92662866()

		if __wf_atom_7e8ad928(__wf_atom_92662866) then
			return
		end

		if module2.HasCompletedVorsPrize() then
			local v72 = Symbol("PlayerShip")
			local mHubEvents = __wf_atom_92662866.mHubEvents
			local v73 = {}

			for i = 1, #mHubEvents do
				local mHubEvent = mHubEvents[i]

				if __wf_atom_7e8ad928(mHubEvent) or mHubEvent.mNode ~= v72 or not (#mHubEvent.mTransmissions > 0) then
					continue
				end

				local mTransmissions = mHubEvent.mTransmissions
				local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(mHubEvent.mActivation)
				local __wf_atom_db2b0cee2 = Engine.__wf_atom_db2b0cee(mHubEvent.mExpiry)

				if not (__wf_atom_db2b0cee <= 0 and __wf_atom_db2b0cee2 > 0) then
					continue
				end

				local mTransmission = mTransmissions[__wf_atom_5784a397(1, #mTransmissions)]

				if not __wf_atom_7e8ad928(mTransmission) then
					fn40(mTransmission, v73)
				end
			end

			local mGoals = __wf_atom_92662866.mGoals

			for i = 1, #mGoals do
				local mGoal = mGoals[i]
				local mTransmission = mGoal.mTransmission

				if __wf_atom_7e8ad928(mTransmission) then
					continue
				end

				local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(mGoal.mActivation)
				local __wf_atom_db2b0cee2 = Engine.__wf_atom_db2b0cee(mGoal.mExpiry)

				if __wf_atom_db2b0cee <= 0 and __wf_atom_db2b0cee2 > 0 then
					fn40(mTransmission, v73)
				end
			end

			if #v73 > 0 then
				v42 = UISys.__wf_atom_c0dbe47c(v73)
			end
		end
	end
end

function OnWorldStateChanged()
	fn()
end

function OnAvatarTradeStatusChanged(object)
	local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()
	local v72 = Resource("/SF/Types/Input/VendorInputFilter")
	local v73 = Type("/SF/Types/Actions/TradeAction")
	local v74 = Resource("/Lotus/Animations/Tenno/Emotes/Generic/VendorIdle_anim.fbx")
	local v75 = Resource("/Lotus/Types/Items/Emotes/BarterEmote")
	local __wf_atom_8efce136 = object:__wf_atom_8efce136()

	if not __wf_atom_8efce136 and (object:__wf_atom_9cc7b1b4() or not object:__wf_atom_7b686578()) then
		if object:__wf_atom_e4085a0b() then
			__wf_atom_c88ae023:__wf_atom_d9b34293(object)
		elseif __wf_atom_c88ae023:__wf_atom_92bb0c6a() then
			local __wf_atom_7a9a0661 = __wf_atom_c88ae023:__wf_atom_7a9a0661()
			local __wf_atom_70f5d0a5 = gGameRules:__wf_atom_70f5d0a5(object)

			if __wf_atom_7a9a0661.mAccountId == __wf_atom_70f5d0a5 then
				__wf_atom_c88ae023:__wf_atom_0d834f79()
			end
		end
	end

	local v76 = _T.EtherealHubActive and gRegion:IsMaster() and gMatchingService:__wf_atom_8b3e33a6() > 1

	if __wf_atom_8efce136 and not v76 then
		if object:__wf_atom_a586ea4c(v73) then
			local __wf_atom_f582136d = object:__wf_atom_f582136d(v73)

			for i = 1, #__wf_atom_f582136d do
				__wf_atom_f582136d[i]:Destroy()
			end
		end
	elseif object:__wf_atom_7b686578() then
		if not object:__wf_atom_a586ea4c(v73) then
			object:Attach(v73, EMPTY_SYMBOL)
		end
	else
		local __wf_atom_f582136d = object:__wf_atom_f582136d(v73)

		for i = 1, #__wf_atom_f582136d do
			__wf_atom_f582136d[i]:Destroy()
		end
	end

	if __wf_atom_8efce136 then
		if object:__wf_atom_7b686578() then
			object:__wf_atom_aeb02c14(v72)
		else
			object:__wf_atom_cf966a74(v72)
		end
	end

	if object:__wf_atom_9cc7b1b4() then
		if object:__wf_atom_c138b19b(v74) then
			object:__wf_atom_33b8b73f(nil, false)
		end

		object:__wf_atom_7ab15c94(v75)
	elseif object:__wf_atom_7b686578() then
		object:__wf_atom_7ab15c94(nil)
		object:__wf_atom_33b8b73f(v74, false, 2, 2, false, false)
	else
		if object:__wf_atom_c138b19b(v74) then
			object:__wf_atom_33b8b73f(nil, false)
		end

		object:__wf_atom_7ab15c94(nil)
	end
end

function OnAvatarRegattaStatusChanged(object)
	if __wf_atom_7e8ad928(object) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_143cdd78 = object:__wf_atom_143cdd78()
	print("OnAvatarRegattaStatusChanged(" .. object:GetName() .. "): " .. __wf_atom_143cdd78)

	if __wf_atom_143cdd78 == 0 then
		local v72 = gRegion:__wf_atom_c4f78a8f():__wf_atom_143cdd78() == 3
		local __wf_atom_70f5d0a5 = gGameRules:__wf_atom_70f5d0a5(object)

		if not __wf_atom_7e8ad928(v29) and v72 and not __wf_atom_7e8ad928(from2) and from2 == __wf_atom_70f5d0a5 then
			v29:__wf_atom_f62a8704("ProcessHudMessage", { 5, from2, "", "" })
			v29 = nil
			from2 = nil
		end

		local __wf_atom_f582136d = object:__wf_atom_f582136d(regattaContextAction)

		for i = 1, #__wf_atom_f582136d do
			__wf_atom_f582136d[i]:Destroy()
		end

		if object:__wf_atom_c138b19b(regattaSitAndWaitLoop) then
			object:__wf_atom_9b5dcd3b(regattaStandUp, false, 3, 1)
		end
	elseif __wf_atom_143cdd78 == 1 then
		if not object:__wf_atom_a586ea4c(regattaContextAction) then
			object:Attach(regattaContextAction, EMPTY_SYMBOL)
			object:__wf_atom_7ab15c94(nil)
			object:__wf_atom_9b5dcd3b(regattaSitAndWaitLoop, false, 3, 2)
		end
	elseif __wf_atom_143cdd78 == 3 or __wf_atom_143cdd78 == 2 then
		local __wf_atom_f582136d = object:__wf_atom_f582136d(regattaContextAction)

		for i = 1, #__wf_atom_f582136d do
			__wf_atom_f582136d[i]:Destroy()
		end
	end
end

local function fn41(p)
	local playerAvatar = gRegion:GetPlayerAvatar()
	local __wf_atom_7b686578 = playerAvatar:__wf_atom_7b686578()

	if p ~= nil and p == __wf_atom_7b686578 then
		return
	end

	if not __wf_atom_7b686578 then
		local __wf_atom_222a0f6f = gGameRules:__wf_atom_c88ae023():__wf_atom_222a0f6f()

		if __wf_atom_222a0f6f == SF.__wf_atom_77fb2f74 then
			gGameRules:__wf_atom_f996d5df()

			if not __wf_atom_7e8ad928(v) then
				if v35.tradeZoneTimerId ~= nil then
					v:RemoveTimer(v35.tradeZoneTimerId)
				end

				v35.tradeZoneTimerId = v:AddTimer(1, v35.TimerCheckInTradeZone)
			end

			return
		elseif __wf_atom_222a0f6f == SF.__wf_atom_c1ba2aad then
			module.ShowMessage("/Lotus/Language/Dojo/BelowMinRank")
		elseif __wf_atom_222a0f6f == SF.__wf_atom_1e4d9e65 then
			module.ShowMessage("/Lotus/Language/Dojo/NoTradesRemaining")
		elseif __wf_atom_222a0f6f == SF.__wf_atom_26412a41 then
			module.ShowMessage("/Lotus/Language/Dojo/TRADE_ERR_2FA_NOT_ENABLED_ME")
		else
			module.ShowMessage("/Lotus/Language/Dojo/IneligibleForTrading")
		end
	end

	if __wf_atom_7b686578 then
		playerAvatar:__wf_atom_d02c2c68(false)
		gGameRules:OnAvatarTradeStatusChanged(playerAvatar)
		local v72 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
		gGameRules:SendControlMessage(v72)
	end

	if v35.tradeZoneTimerId ~= nil then
		v:RemoveTimer(v35.tradeZoneTimerId)
		v35.tradeZoneTimerId = nil
	end
end

function DisableTrading()
	local v72 = WeakResource("/SF/Interface/ConsumablesOverlay.swf")
	local movie = __wf_atom_8e4fda44:FindMovie(v72)

	if not __wf_atom_7e8ad928(movie) then
		movie:Close()
	end

	local v73 = WeakResource("/SF/Interface/Trade.swf")
	local movie2 = __wf_atom_8e4fda44:FindMovie(v73)

	if not __wf_atom_7e8ad928(movie2) then
		movie2:Close()
	end

	fn41(false)
end

function v35.FinalizeTrade()
	if gGameRules:__wf_atom_c88ae023():__wf_atom_03399a72() then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			__wf_atom_9be88b01:__wf_atom_a45f5d5f()
		end
	end

	local playerAvatar = gRegion:GetPlayerAvatar()
	local __wf_atom_222a0f6f = gGameRules:__wf_atom_c88ae023():__wf_atom_222a0f6f()

	if __wf_atom_222a0f6f ~= SF.__wf_atom_77fb2f74 then
		local v72

		if __wf_atom_222a0f6f == SF.__wf_atom_c1ba2aad then
			v72 = "/Lotus/Language/Dojo/BelowMinRank"
		elseif __wf_atom_222a0f6f == SF.__wf_atom_1e4d9e65 then
			v72 = "/Lotus/Language/Dojo/NoTradesRemaining"
		elseif __wf_atom_222a0f6f == SF.__wf_atom_26412a41 then
			v72 = "/Lotus/Language/Dojo/TRADE_ERR_2FA_NOT_ENABLED_ME"
		else
			v72 = "/Lotus/Language/Dojo/IneligibleForTrading"
		end

		module.ShowMessage(v72)
	end

	if playerAvatar:__wf_atom_9cc7b1b4() then
		playerAvatar:__wf_atom_014225b8(false)
		gGameRules:OnAvatarTradeStatusChanged(playerAvatar)
		local v72 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
		gGameRules:SendControlMessage(v72)
	end
end

function OnTradeSession(p, p2)
	local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()

	if p then
		local playerAvatar = gRegion:GetPlayerAvatar()
		playerAvatar:__wf_atom_014225b8(true)
		gGameRules:OnAvatarTradeStatusChanged(playerAvatar)
		__wf_atom_c88ae023:__wf_atom_32a726ea()
	else
		v35.FinalizeTrade()
		local __wf_atom_7a9a0661 = __wf_atom_c88ae023:__wf_atom_7a9a0661()

		if not __wf_atom_7e8ad928(__wf_atom_7a9a0661.mAccountId) then
			local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(__wf_atom_7a9a0661.mAccountId)

			if not __wf_atom_7e8ad928(__wf_atom_d68faea4) then
				__wf_atom_c88ae023:__wf_atom_d9b34293(__wf_atom_d68faea4)
			end

			local v72

			if p2 == SF.__wf_atom_0ff8faee then
				v72 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeSessionDeniedBusy", false, {
					PLAYER_NAME = __wf_atom_7a9a0661.mDisplayName
				})
			else
				v72 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeSessionDenied", false, {
					PLAYER_NAME = __wf_atom_7a9a0661.mDisplayName
				})
			end

			_T.ShowNotification(v72, "")
		end
	end
end

function OnTradeRequestAccepted(_)
	local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()
	local __wf_atom_7a9a0661 = __wf_atom_c88ae023:__wf_atom_7a9a0661()
	local playerAvatar = gRegion:GetPlayerAvatar()
	playerAvatar:__wf_atom_014225b8(true)
	gGameRules:OnAvatarTradeStatusChanged(playerAvatar)

	if not __wf_atom_7e8ad928(__wf_atom_7a9a0661.mAccountId) then
		local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(__wf_atom_7a9a0661.mAccountId)

		if not __wf_atom_7e8ad928(__wf_atom_d68faea4) then
			__wf_atom_c88ae023:__wf_atom_d9b34293(__wf_atom_d68faea4)
		end
	end
end

function OnTradeRequestDeclined(p)
	local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()
	local __wf_atom_7a9a0661 = __wf_atom_c88ae023:__wf_atom_7a9a0661()

	if not __wf_atom_7e8ad928(__wf_atom_7a9a0661.mAccountId) then
		local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(__wf_atom_7a9a0661.mAccountId)

		if not __wf_atom_7e8ad928(__wf_atom_d68faea4) then
			__wf_atom_c88ae023:__wf_atom_d9b34293(__wf_atom_d68faea4)
		end
	end

	local movie = __wf_atom_8e4fda44:FindMovie(tradingPostMovie)

	if __wf_atom_7e8ad928(movie) then
		_T.ShowNotification(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/UserDeclinedTrade", false, {
				USER = __wf_atom_7a9a0661.mDisplayName
			}),
			""
		)
	else
		movie:Execute("TradeSessionResult", tostring(false) .. "," .. tostring(p))
	end
end

function OnTradeBuddyDestroyed() end

function OnClosedTradeScreen()
	v35.FinalizeTrade()
end

function v35.InTradeZone(object)
	if module2.GetUIMode() == module2.UI_MODE_IN_DOJO then
		return true
	end

	return not __wf_atom_7e8ad928(object) and not __wf_atom_7e8ad928((object:__wf_atom_e800787c()))
end

function v35.TimerCheckInTradeZone()
	local playerAvatar = gRegion:GetPlayerAvatar()

	if
		gGameRules:IsA(__wf_atom_e714d8ac)
		and not v35.InTradeZone(playerAvatar)
		and playerAvatar:__wf_atom_7b686578()
	then
		fn41(false)
		_T.ShowNotification(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/LeavingVendorMode", false), "")
	end

	v35.tradeZoneTimerId = v:AddTimer(1, v35.TimerCheckInTradeZone)
end

function ToggleVendor(p)
	local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()

	if gGameRules:__wf_atom_af3bd666() then
		local playerAvatar = gRegion:GetPlayerAvatar()
		local v72 = not gGameRules:IsA(__wf_atom_e714d8ac) or v35.InTradeZone(playerAvatar)

		if v72 then
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("NoTrading"))

			for _, v73 in pairs(__wf_atom_2226b35c) do
				if v73:IsA(__wf_atom_8b8e8b22) and v73:IsTouching(playerAvatar) then
					v72 = false
				end
			end
		end

		if not v72 then
			module.ShowMessage("/Lotus/Language/Dojo/OutsideTradeZone")
			return false
		end

		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) and __wf_atom_9be88b01:__wf_atom_3a4ef806() then
				local __wf_atom_93836a4f = __wf_atom_9be88b01:__wf_atom_93836a4f()
				local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(__wf_atom_93836a4f)
				local __wf_atom_1753c679 = __wf_atom_9be88b01:__wf_atom_1753c679()

				if __wf_atom_1753c679 ~= "" then
					__wf_atom_1753c679 = "\r\n\r\n" .. __wf_atom_1753c679
				end

				if __wf_atom_db2b0cee < 31536000 then
					local secondsToFormattedTime = module2.SecondsToFormattedTime(
						mMovie,
						__wf_atom_db2b0cee,
						"HoursOrMinutes"
					)
					module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeBanned", false, {
						TIME = secondsToFormattedTime,
						MESSAGE = __wf_atom_1753c679
					}))
				else
					module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeBannedPermanent", false, {
						MESSAGE = __wf_atom_1753c679
					}))
				end

				return false
			end
		end

		if p == nil then
			if playerAvatar:__wf_atom_7b686578() then
				fn41()
			else
				local __wf_atom_222a0f6f = gGameRules:__wf_atom_c88ae023():__wf_atom_222a0f6f()

				if __wf_atom_222a0f6f == SF.__wf_atom_77fb2f74 then
					__wf_atom_c88ae023:__wf_atom_51581565()
					return true
				end

				if __wf_atom_222a0f6f == SF.__wf_atom_c1ba2aad then
					module.ShowMessage("/Lotus/Language/Dojo/BelowMinRank")
					return
				end

				if __wf_atom_222a0f6f == SF.__wf_atom_1e4d9e65 then
					module.ShowMessage("/Lotus/Language/Dojo/NoTradesRemaining")
					return
				end

				if __wf_atom_222a0f6f == SF.__wf_atom_26412a41 then
					module.ShowMessage("/Lotus/Language/Dojo/TRADE_ERR_2FA_NOT_ENABLED_ME")
				else
					module.ShowMessage("/Lotus/Language/Dojo/IneligibleForTrading")
				end

				return
			end
		else
			local __wf_atom_7b686578 = playerAvatar:__wf_atom_7b686578()
			fn41(p)

			if not p or __wf_atom_7b686578 == p then
				return false
			end

			__wf_atom_c88ae023:__wf_atom_51581565()
			return true
		end
	else
		module.ShowMessage("/Lotus/Language/Dojo/NotInTradeHub")
	end

	return false
end

function OnTrade(p)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if
		__wf_atom_7e8ad928(__wf_atom_eab484a7)
		or gRegion:__wf_atom_c4f78a8f() ~= __wf_atom_eab484a7:GetPlayerAvatar(0)
	then
		return false
	end

	local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()

	if gGameRules:__wf_atom_af3bd666() then
		local all = gRegion:FindAll(__wf_atom_7e6ed5fa)
		local v72 = nil

		for i = 1, #all do
			if all[i]:GetName() ~= p then
				continue
			end

			v72 = all[i]
			break
		end

		if not __wf_atom_7e8ad928(v72) then
			if v72:__wf_atom_7b686578() then
				local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

				if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
					local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

					if not __wf_atom_7e8ad928(__wf_atom_9be88b01) and __wf_atom_9be88b01:__wf_atom_3a4ef806() then
						local __wf_atom_93836a4f = __wf_atom_9be88b01:__wf_atom_93836a4f()
						local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(__wf_atom_93836a4f)
						local __wf_atom_1753c679 = __wf_atom_9be88b01:__wf_atom_1753c679()

						if __wf_atom_1753c679 ~= "" then
							__wf_atom_1753c679 = "\r\n\r\n" .. __wf_atom_1753c679
						end

						if __wf_atom_db2b0cee < 31536000 then
							local secondsToFormattedTime = module2.SecondsToFormattedTime(
								mMovie,
								__wf_atom_db2b0cee,
								"HoursOrMinutes"
							)
							module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/TradeBanned", false, {
								TIME = secondsToFormattedTime,
								MESSAGE = __wf_atom_1753c679
							}))
						else
							module.ShowMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Dojo/TradeBannedPermanent",
								false,
								{ MESSAGE = __wf_atom_1753c679 }
							))
						end

						return false
					end
				end

				local __wf_atom_222a0f6f = gGameRules:__wf_atom_c88ae023():__wf_atom_222a0f6f()

				if __wf_atom_222a0f6f == SF.__wf_atom_77fb2f74 then
					if v72:__wf_atom_e4085a0b() then
						module.ShowMessage("/Lotus/Language/Dojo/AlreadyRequestedTrade")
					elseif v72:__wf_atom_9cc7b1b4() then
						module.ShowMessage("/Lotus/Language/Dojo/BusyTrading")
					else
						local __wf_atom_f9c034fa = gGameRules:__wf_atom_f9c034fa(v72)

						if __wf_atom_f9c034fa:__wf_atom_8598f3a9() then
							__wf_atom_c88ae023:__wf_atom_c388b4f0(__wf_atom_f9c034fa, false)
							__wf_atom_c88ae023:__wf_atom_faecc99e(v72)
						elseif not _T.EtherealHubActive then
							module.ShowMessage("/Lotus/Language/Dojo/BusyTrading")
						end
					end
				elseif __wf_atom_222a0f6f == SF.__wf_atom_c1ba2aad then
					module.ShowMessage("/Lotus/Language/Dojo/BelowMinRank")
				elseif __wf_atom_222a0f6f == SF.__wf_atom_1e4d9e65 then
					module.ShowMessage("/Lotus/Language/Dojo/NoTradesRemaining")
				elseif __wf_atom_222a0f6f == SF.__wf_atom_26412a41 then
					module.ShowMessage("/Lotus/Language/Dojo/TRADE_ERR_2FA_NOT_ENABLED_ME")
				else
					module.ShowMessage("/Lotus/Language/Dojo/IneligibleForTrading")
				end
			else
				module.ShowMessage("/Lotus/Language/Dojo/PlayerNotInTradeMode")
			end

			return false
		end
	else
		module.ShowMessage("/Lotus/Language/Dojo/NotInTradeHub")
	end

	return false
end

function OnPickedDisplayItems()
	fn41()
	local playerAvatar = gRegion:GetPlayerAvatar()
	gGameRules:OnAvatarTradeStatusChanged(playerAvatar)
	local v72 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
	gGameRules:SendControlMessage(v72)
end

function OnUpdateSessionSettings() end

local function fn42()
	if not __wf_atom_7e8ad928(gMatchingService) and gMatchingService:__wf_atom_a676a953() then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_35ea3fce = __wf_atom_18a5d83b:Settings():__wf_atom_35ea3fce()
	local __wf_atom_58c4b875 = gMatchingService:__wf_atom_58c4b875()

	if __wf_atom_58c4b875 == "" then
		return
	end

	local v72 = __wf_atom_58c4b875:find("_")
	local v73 = __wf_atom_58c4b875:len() - __wf_atom_58c4b875:reverse():find("_")
	local lower = __wf_atom_58c4b875:sub(v72 + 1, v73):lower()
	local v74 = lower:find("_")

	if v74 ~= nil then
		lower = lower:sub(v74 + 1)
	end

	local lower2 = __wf_atom_35ea3fce:__wf_atom_8876904e():sub(2):lower()
	local v75 = lower2:find("_")

	if v75 ~= nil then
		lower2 = lower2:sub(v75 + 1)
	end

	if lower ~= lower2 then
		gGameRules:__wf_atom_037fb80a()
	end
end

function OnLeaveSquad()
	fn42()
end

function OnSquadMemberLeft(_)
	if #gMatchingService:__wf_atom_bb46d8b6() <= 1 then
		fn42()
	end
end

function SendHubBroadcast(_, _, _) end

local function fn43(items)
	local v72 = {}

	for _, item in pairs(items) do
		if type(item) == "string" then
			item = WeakResource(item)
		end

		if not __wf_atom_7e8ad928(item) then
			table.insert(v72, item:__wf_atom_5b41f63b())
		end
	end

	if #v72 > 0 then
		local __wf_atom_c0dbe47c = UISys.__wf_atom_c0dbe47c(v72)

		while not (__wf_atom_7e8ad928(__wf_atom_c0dbe47c) or __wf_atom_c0dbe47c:__wf_atom_86399a47()) do
			Sleep(0)
		end
	end
end

local function fn44(p)
	if __wf_atom_7e8ad928(p) then
		fn32("Hub::GiveBroadcastReward rejected. No such reward item.") -- inferred equivalent call
		return false
	else
		local v72 = WeakResource("/Lotus/Interface/SurvivalReward.swf")
		fn43({ v72, p })

		if __wf_atom_7e8ad928((__wf_atom_8e4fda44:__wf_atom_8b74c30b(v72))) or __wf_atom_7e8ad928(_T.DisplayReward) then
			return true
		end

		local v73 = Resource(p)

		if __wf_atom_7e8ad928(v73) then
			return false
		end

		local v74 = {
			itemCount = 1,
			Name = Localize(v73:__wf_atom_014a76a2():c_str(), {})
		}
		_T.DisplayReward(v73, v74)
		return true
	end
end

local function fn45(value)
	__wf_atom_21342f4a:SetEvent(
		Symbol("HUB_BROADCAST"),
		v7 .. "_" .. value .. "_" .. string.format("%u", gGameRules:__wf_atom_93691ff2())
	)
	_T.LoggedHubReward = true

	if __wf_atom_7e8ad928(nil) then
		fn32("Hub::GiveBroadcastReward rejected. No such reward item.") -- inferred equivalent call
		return false
	else
		local v72 = Symbol(value)

		if
			gGameData:__wf_atom_7f86fc42(v72)
			or _G.PendingHubBroadcastRewards and module.FindInTable(_G.PendingHubBroadcastRewards, value) ~= -1
		then
			fn32("Hub::GiveBroadcastReward rejected. Local player has already received reward.") -- inferred equivalent call
			return false
		else
			if not _G.PendingHubBroadcastRewards then
				_G.PendingHubBroadcastRewards = {}
			end

			table.insert(_G.PendingHubBroadcastRewards, value)
			fn44(nil)
			return true
		end
	end
end

local function fn46(p, p2, p3, p4)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local v72 = Type(p)

	if not __wf_atom_7e8ad928(v72) then
		local __wf_atom_4e50d390 = __wf_atom_c4f78a8f:__wf_atom_4e50d390()
		__wf_atom_4e50d390.pitch = 0
		local v73 = __wf_atom_e97f3142(__wf_atom_4e50d390)

		if not p2 then
			local v74 = __wf_atom_c4f78a8f:GetPosition() + v73 * 2 + Vector(0, 1.5, 0)
			local v75 = Vector(v74.x, v74.y - 100, v74.z)
			local v76 = Vector()

			if gRegion:Raycast(v74, v75, __wf_atom_c4f78a8f, nil, v76) then
				v74 = v76
			end

			p2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v74)
		end

		local v74 = p3 or Rotation(__wf_atom_4e50d390.heading + 180, 0, 0)
		local v75 = WeakResource("/Lotus/Objects/Tenno/Props/Ships/Events/WFRollerFloofDeco")

		if not __wf_atom_7e8ad928(v75) then
			local all = gRegion:FindAll(v75, p2, 0, 1.5)

			if all and #all > 0 then
				for _, v76 in pairs(all) do
					v76:__wf_atom_66d7a6a9(v73 * 10000)
				end
			end
		end

		local entity = gRegion:CreateEntity(v72, p2, v74)

		if not __wf_atom_7e8ad928(entity) then
			if not _T.HubBroadcastSpawnedEntities then
				_T.HubBroadcastSpawnedEntities = {}
			end

			table.insert(_T.HubBroadcastSpawnedEntities, entity)
			entity:__wf_atom_a763aa1a(1)

			if p4 ~= nil then
				entity:SetMeshScale(p4)
			end

			while not __wf_atom_7e8ad928(entity) and entity:__wf_atom_f83a55c6() > 0 do
				entity:__wf_atom_a763aa1a(__wf_atom_421b01aa(
					entity:__wf_atom_f83a55c6() - __wf_atom_fa1258d0() * 2,
					0,
					1
				))
				Sleep(0)
			end

			return entity
		end
	end
end

local function fn47(position, p, list)
	local __wf_atom_df6512ff = gMatchingService:__wf_atom_df6512ff()
	local v72 = {}

	for _, v73 in pairs(__wf_atom_df6512ff) do
		table.insert(v72, v73)
	end

	table.sort(v72, function(a, b)
		return a < b
	end)
	local v73

	if list and #list > 1 then
		v73 = gRegion:__wf_atom_439c0d29(list[1]:__wf_atom_db682341(), position, 0, 100)
		table.sort(v73, function(a, b)
			return Distance(a:GetPosition(), position) < Distance(b:GetPosition(), position)
		end)
	end

	local __wf_atom_6be84646 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646()
	local result = Vector(position.x, position.y, position.z)
	local v74 = Rotation(p.heading, 0, 0)
	local v75 = 0
	local v76 = 0

	for i = 1, #v72 + 0 do
		if v73 then
			local v77 = v73[__wf_atom_421b01aa(i, 1, #v73)]
			position = v77:GetPosition()
			p = v77:__wf_atom_dc309f8a()
		else
			local v77 = math.floor(i / 10)
			v75 = v77 % 2 * 1
			local v78 = (i - 1) % 10

			if v78 ~= 0 then
				v75 = (math.floor((v78 - 1) / 2) + 1) * 2 * module.Ternary(v78 % 2 == 0, 1, -1) + v75
			end

			v76 = v77 * 2
		end

		if v72[i] ~= __wf_atom_6be84646 then
			continue
		end

		result.x = position.x + v75
		result.y = position.y
		result.z = position.z + v76
		v74 = Rotation(p.heading, 0, 0)
		break
	end

	return result, v74
end

function OnHubBroadcast()
	if not _T.HubBroadcastMsg then
		return
	end

	if _T.HubBroadcastMsgId == nil then
		_T.HubBroadcastMsgId = 0
	end

	_T.HubBroadcastMsgId = _T.HubBroadcastMsgId + 1
	_T.HubBroadcastLog = "LOG"

	if _T.HubBroadcastMsg.msg and _T.HubBroadcastMsg.msg.tag then
		_T.HubBroadcastLog = _T.HubBroadcastMsg.msg.tag
	end

	_T.HubBroadcastLog = _T.HubBroadcastLog .. "_" .. string.format("%u", gGameRules:__wf_atom_93691ff2())
	local copyTable = module.CopyTable(_T.HubBroadcastMsg)
	local hubBroadcastMsgId = _T.HubBroadcastMsgId

	while
		__wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f())
		or gClient:__wf_atom_449cc668()
		or not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())
	do
		Sleep(0)
	end

	gGameRules:__wf_atom_5aa33f5c()
	local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

	while true do
		local __wf_atom_04e714d5 = __wf_atom_8e4fda44:__wf_atom_04e714d5()

		if __wf_atom_7e8ad928(__wf_atom_04e714d5) or __wf_atom_04e714d5 == movie then
			break
		end

		Sleep(0)
	end

	if hubBroadcastMsgId < _T.HubBroadcastMsgId then
		return
	end

	local tag = string.lower(copyTable.msg.tag)
	local value = copyTable.msg.value

	if tag == "teleportall" then
		local location = gGameRules:__wf_atom_72fc675e().location

		if
			location == module2.CETUS_NODE_TAG
			or location == module2.FORTUNA_NODE_TAG
			or location == module2.IRON_WAKE_NODE_TAG
		then
			print("OnHubBroadcast: not in space relay, ignoring")
			return
		end

		local v72 = nil
		local v73 = Rotation()
		local flag2 = false
		local teleportAndFadeActive = _T.TeleportAndFadeActive == true

		if value and string.lower(value) == "oldpos" then
			if _T.HubTeleportOldPos and _T.HubTeleportOldRot then
				v72 = Vector(_T.HubTeleportOldPos.x, _T.HubTeleportOldPos.y, _T.HubTeleportOldPos.z)
				v73 = Rotation(_T.HubTeleportOldRot.heading, _T.HubTeleportOldRot.pitch, 0)
				_T.HubTeleportOldPos = nil
				_T.HubTeleportOldRot = nil
			end
		else
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol(value))

			if __wf_atom_7e8ad928(__wf_atom_2226b35c) or not (#__wf_atom_2226b35c > 0) then
				local v74 = "Couldn't find a waypoint for \"" .. value .. "\"\r\nCheck your spelling and try again!"

				if copyTable.from == __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3() then
					module.ShowMessage(v74, "OnHubBroadcastFailed")
				else
					fn32(v74) -- inferred equivalent call
				end
			else
				v72, v73 = fn47(
					__wf_atom_2226b35c[1]:GetPosition(),
					__wf_atom_2226b35c[1]:__wf_atom_dc309f8a(),
					__wf_atom_2226b35c
				)
				flag2 = true
			end
		end

		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

		if v72 then
			local postProcess = gRegion:__wf_atom_8ad59546().postProcess

			while _T.HubTeleportAllActive or postProcess.fade ~= 0 or _T.TeleportAndFadeActive do
				Sleep(0)
				teleportAndFadeActive = teleportAndFadeActive or _T.TeleportAndFadeActive == true
			end

			if flag2 and not _T.HubTeleportOldPos then
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

				if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
					_T.HubTeleportOldPos = __wf_atom_c4f78a8f:GetPosition()
					_T.HubTeleportOldRot = __wf_atom_c4f78a8f:__wf_atom_4e50d390()
				end
			end

			_T.HubTeleportAllActive = true
			local v74 = 0

			while v74 < 1 do
				v74 = __wf_atom_421b01aa(v74 + __wf_atom_fa1258d0() * 3, 0, 1)
				__wf_atom_8ad59546:__wf_atom_47f0b80b(v74)
				teleportAndFadeActive = teleportAndFadeActive or _T.TeleportAndFadeActive == true
				Sleep(0)
			end

			__wf_atom_8ad59546:__wf_atom_47f0b80b(1)
			postProcess.grainBias = 0

			if flag2 then
				if not __wf_atom_7e8ad928(_T.ForceHideMiniMap) then
					_T.ForceHideMiniMap()
				end

				gGameRules:__wf_atom_e2e4b492()

				if not __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) then
					local __wf_atom_330f77f5 = gRegion:__wf_atom_eab484a7():__wf_atom_330f77f5(false)

					if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
						__wf_atom_330f77f5:__wf_atom_e8aae4c8(true)
					end
				end
			end

			local total2 = 0

			while total2 < 0.5 do
				Sleep(0)
				total2 += __wf_atom_fa1258d0()
				teleportAndFadeActive = teleportAndFadeActive or _T.TeleportAndFadeActive == true
			end

			gGameRules:__wf_atom_5aa33f5c()
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_1cfa7bd2()) then
					__wf_atom_c4f78a8f:__wf_atom_7ab15c94(nil)
				end

				__wf_atom_c4f78a8f:Teleport(v72, v73)
				__wf_atom_c4f78a8f:__wf_atom_51075230(v73)
				__wf_atom_c4f78a8f:SetDisableMovement(true)

				if string.find(value, "flying") then
					__wf_atom_c4f78a8f:__wf_atom_51075230(v73)
					fn5(true, nil)
				else
					if _T.ForcedFlying then
						fn5(false, nil)
					end

					__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(flag2)
					__wf_atom_c4f78a8f:__wf_atom_a1ae9e35(module.Ternary(flag2, 0, 1))
				end

				__wf_atom_c4f78a8f:__wf_atom_92aa9d91():__wf_atom_9f4f79f7(not flag2)
				__wf_atom_c4f78a8f:__wf_atom_92aa9d91():__wf_atom_325a7bb0(not flag2)
				__wf_atom_c4f78a8f:__wf_atom_f747bba3(not _T.ForcedFlying)
				__wf_atom_c4f78a8f:__wf_atom_a142b1ea(not _T.ForcedFlying)
				__wf_atom_c4f78a8f:__wf_atom_72a59051()
				gGameRules:__wf_atom_6e1120ec(flag2)
			end

			local total3 = 0

			while total3 < 0.5 do
				Sleep(0)
				total3 += __wf_atom_fa1258d0()
				teleportAndFadeActive = teleportAndFadeActive or _T.TeleportAndFadeActive == true
			end

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:SetDisableMovement(false)
			end

			for _, v75 in pairs(v26) do
				if flag2 then
					gRegion:__wf_atom_242f7e56(v75.Avatar)
					local _avatar = v75.Avatar
				else
					gRegion:__wf_atom_191ff1f7(v75.Avatar)
				end
			end

			for _, hubBroadcastSpawnedEntity in pairs(_T.HubBroadcastSpawnedEntities) do
				if
					__wf_atom_7e8ad928(hubBroadcastSpawnedEntity)
					or not hubBroadcastSpawnedEntity:IsA(__wf_atom_7e6ed5fa)
					or __wf_atom_7e8ad928(hubBroadcastSpawnedEntity:__wf_atom_30e3d82b())
				then
					continue
				end

				if flag2 then
					hubBroadcastSpawnedEntity:__wf_atom_30e3d82b():__wf_atom_b414eabf()
				else
					hubBroadcastSpawnedEntity:__wf_atom_30e3d82b():__wf_atom_9eb5cd6b(
						gRegion:__wf_atom_c4f78a8f(),
						false,
						true,
						false,
						4,
						false
					)
				end
			end

			local v75 = 1

			while v75 > 0 do
				v75 = __wf_atom_421b01aa(v75 - __wf_atom_fa1258d0() * 3, 0, 1)
				__wf_atom_8ad59546:__wf_atom_47f0b80b(v75)
				teleportAndFadeActive = teleportAndFadeActive or _T.TeleportAndFadeActive == true
				Sleep(0)
			end

			__wf_atom_8ad59546:__wf_atom_47f0b80b(0)

			if teleportAndFadeActive then
				while _T.TeleportAndFadeActive do
					Sleep(0)
				end

				if flag2 then
					__wf_atom_c4f78a8f:Teleport(v72, v73)
					__wf_atom_c4f78a8f:__wf_atom_51075230(v73)
				end
			end

			_T.HubTeleportAllActive = nil
		end

		_T.HubShowRoomActive = flag2
		gGameRules:__wf_atom_5aa33f5c()
	elseif tag == "flicker" then
		if not __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) then
			gRegion:__wf_atom_eab484a7():__wf_atom_7b9b8640(0.5)
		end
	elseif tag == "showmessage" then
		local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

		while
			not __wf_atom_7e8ad928(__wf_atom_b56d2aa8)
			and __wf_atom_b56d2aa8:__wf_atom_5e6e15c8("ImpactMessage", 12) > 0
		do
			Sleep(0.1)
		end

		if _T.ShowImpactMessage then
			local v72 = string.gsub(value, "_", " ")
			_T.ShowImpactMessage(v72, 4.5, false, nil, nil, nil, nil, 200)
		end
	elseif tag == "createentity" then
		fn43({ value })
		fn46(value)
	elseif tag == "removeentity" then
		local v72 = WeakResource(value)

		if not __wf_atom_7e8ad928(v72) then
			local all = gRegion:FindAll(v72)

			for _, v73 in pairs(all) do
				gRegion:__wf_atom_dd1e4d10(v73)
			end
		end
	elseif tag == "spawn" then
		fn43({
			value,
			"/Lotus/Animations/Tenno/Menu/KneelToStand_anim.fbx",
			"/Lotus/Fx/PowersuitAbilities/Ninja/NinjaTeleportIn"
		})
		local v72 = Type(value)

		if not __wf_atom_7e8ad928(v72) then
			local v73 = Resource("/Lotus/Animations/Tenno/Menu/KneelToStand_anim.fbx")
			local v74 = Resource("/Lotus/Fx/PowersuitAbilities/Ninja/NinjaTeleportIn")
			local ternary = module.Ternary(string.find(value, "StalkerAgent"), v73, nil)
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			local __wf_atom_4e50d390 = __wf_atom_c4f78a8f:__wf_atom_4e50d390()
			__wf_atom_4e50d390.pitch = 0
			local v75 = __wf_atom_e97f3142(__wf_atom_4e50d390)
			local v76 = __wf_atom_c4f78a8f:GetPosition() + v75 * 2.5 + Vector(0, 1.5, 0)
			local v77 = Vector(v76.x, v76.y - 100, v76.z)
			local v78 = Vector()

			if gRegion:Raycast(v76, v77, __wf_atom_c4f78a8f, nil, v78) then
				v76 = v78
			end

			local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v76)
			local all = gRegion:FindAll(__wf_atom_7e616794, __wf_atom_0e0a6fee, 0, 1.5)
			local v79

			if all and #all > 0 then
				v79 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_c91d5f5b(
					v72,
					all[1],
					2,
					EMPTY_SYMBOL,
					0,
					ternary
				)
			else
				v79 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
					v72,
					__wf_atom_0e0a6fee,
					Rotation(__wf_atom_4e50d390.heading + 180, 0, 0),
					EMPTY_SYMBOL,
					0,
					true,
					0,
					0,
					ternary
				)
			end

			if not __wf_atom_7e8ad928(v79) then
				local __wf_atom_50a7d83e = v79:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					if not __wf_atom_7e8ad928(v74) then
						gRegion:CreateEntity(v74, __wf_atom_50a7d83e:GetPosition(), __wf_atom_80368bb1)
					end

					__wf_atom_50a7d83e:__wf_atom_a763aa1a(1)

					if not _T.HubBroadcastSpawnedEntities then
						_T.HubBroadcastSpawnedEntities = {}
					end

					table.insert(_T.HubBroadcastSpawnedEntities, __wf_atom_50a7d83e)
					__wf_atom_50a7d83e:SetFaction(Symbol("TENNO"))
					v79:__wf_atom_9eb5cd6b(__wf_atom_c4f78a8f, false, true, false, 4, false)
					v79:__wf_atom_b414eabf()

					if string.find(value, "ClemAgent") then
						__wf_atom_50a7d83e:__wf_atom_d2b2176d():Equip(0, 0, 2)
					end

					while not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and __wf_atom_50a7d83e:__wf_atom_f83a55c6() > 0 do
						__wf_atom_50a7d83e:__wf_atom_a763aa1a(__wf_atom_421b01aa(
							__wf_atom_50a7d83e:__wf_atom_f83a55c6() - __wf_atom_fa1258d0() * 2,
							0,
							1
						))
						Sleep(0)
					end
				end
			end
		end
	elseif tag == "despawn" then
		if _T.HubBroadcastSpawnedEntities then
			fn43({ "/Lotus/Fx/PowersuitAbilities/Ninja/NinjaTeleportIn" })
			local v72 = Resource("/Lotus/Fx/PowersuitAbilities/Ninja/NinjaTeleportIn")

			for _, hubBroadcastSpawnedEntity in pairs(_T.HubBroadcastSpawnedEntities) do
				if not __wf_atom_7e8ad928(hubBroadcastSpawnedEntity) then
					gRegion:CreateEntity(v72, hubBroadcastSpawnedEntity:GetPosition(), __wf_atom_80368bb1)
				end

				gRegion:__wf_atom_dd1e4d10(hubBroadcastSpawnedEntity)
			end

			_T.HubBroadcastSpawnedEntities = nil
		end
	elseif tag == "dance" or tag == "agree" or tag == "shrug" or tag == "clap" or tag == "wave" then
		local v72 = 1
		local v73

		if tag == "agree" then
			v73 = "/Lotus/Animations/Tenno/Emotes/Generic/Agree01_anim.fbx"
			v72 = 2
		elseif tag == "shrug" then
			v73 = "/Lotus/Animations/Tenno/Emotes/Generic/Shrug_anim.fbx"
		elseif tag == "clap" then
			v73 = "/Lotus/Animations/Tenno/Emotes/Generic/Clap_anim.fbx"
		elseif tag == "wave" then
			v73 = "/Lotus/Animations/Tenno/Emotes/Generic/Wave_anim.fbx"
		else
			v73 = "/Lotus/Animations/Tenno/Emotes/Generic/Dance/DanceHipSway_anim.fbx"
		end

		fn43({ v73 })
		local v74 = Resource(v73)
		local v75 = value and string.lower(value) == "loop"
		local __wf_atom_7e6ed5fa2 = __wf_atom_7e6ed5fa
		local hubBroadcastSpawnedEntities = nil

		if value == "stalker" then
			__wf_atom_7e6ed5fa2 = WeakResource("/Lotus/Types/Enemies/Stalker/StalkerAvatar")
		elseif value == "clem" then
			__wf_atom_7e6ed5fa2 = WeakResource("/Lotus/Types/Friendly/ClemAvatar")
		elseif value == "npcs" then
			hubBroadcastSpawnedEntities = {}
			__wf_atom_7e6ed5fa2 = nil

			for _, hubBroadcastSpawnedEntity in pairs(_T.HubBroadcastSpawnedEntities) do
				if
					__wf_atom_7e8ad928(hubBroadcastSpawnedEntity)
					or not hubBroadcastSpawnedEntity:IsA(__wf_atom_7e6ed5fa)
				then
					continue
				end

				table.insert(hubBroadcastSpawnedEntities, hubBroadcastSpawnedEntity)
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_7e6ed5fa2) then
			hubBroadcastSpawnedEntities = gRegion:FindAll(__wf_atom_7e6ed5fa2)
		end

		if hubBroadcastSpawnedEntities then
			for _ = 1, v72 do
				for _, v76 in pairs(hubBroadcastSpawnedEntities) do
					if __wf_atom_7e8ad928(v76) then
						continue
					end

					v76:SetDisableMovement(v75)

					if not __wf_atom_7e8ad928(v76:__wf_atom_30e3d82b()) then
						v76:__wf_atom_30e3d82b():__wf_atom_b414eabf()
					end

					v76:__wf_atom_921c1a5f(v74, false, 2, module.Ternary(v75, 2, 1), false)
				end

				if v72 > 1 then
					Sleep(0.5)
				end
			end
		end
	elseif tag == "reward" then
		fn45(value)
	elseif tag == "giveitem" and value then
		fn43({ WeakResource(value) })
		local v72 = Resource(value)

		if not __wf_atom_7e8ad928(v72) then
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				__wf_atom_eab484a7:__wf_atom_36b99b9d(v72, 1)
			end
		end
	elseif tag == "removeitem" and value then
		fn43({ WeakResource(value) })
		local v72 = Resource(value)

		if not __wf_atom_7e8ad928(v72) then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:RemoveItem(v72)

				if v72:IsA(__wf_atom_abf506db) then
					local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

					if not (__wf_atom_7e8ad928(__wf_atom_e55d02aa) or __wf_atom_7e8ad928(__wf_atom_e55d02aa)) then
						for i = 0, __wf_atom_e55d02aa:__wf_atom_06f3cb74() - 1 do
							local __wf_atom_b9a1f18c = __wf_atom_e55d02aa:__wf_atom_b9a1f18c(i)

							if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) or not __wf_atom_b9a1f18c:IsA(v72) then
								continue
							end

							__wf_atom_e55d02aa:RemoveUpgrade(__wf_atom_b9a1f18c)
							gRegion:__wf_atom_dd1e4d10(__wf_atom_b9a1f18c)
						end
					end
				end
			end
		end
	elseif tag == "color" then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()

				if not _T.HubPlayerOldCustomization then
					_T.HubPlayerOldCustomization = __wf_atom_eb82ab1f
				end

				if value and value == "pink" then
					local colors = __wf_atom_eb82ab1f:GetColors(0)
					local v72 = Color(255, 102, 234)

					for i = 0, 4 do
						colors:SetColor(i, v72)
						colors:__wf_atom_59cc106e(i, true)
					end

					__wf_atom_eb82ab1f:__wf_atom_2754430f(0, colors)
					__wf_atom_e55d02aa:SetCustomization(__wf_atom_eb82ab1f)
				elseif _T.HubPlayerOldCustomization then
					__wf_atom_e55d02aa:SetCustomization(_T.HubPlayerOldCustomization)
				end
			end
		end
	elseif tag == "fly" then
		local forcedFlying = value == "undefined" or value == "start"

		if forcedFlying then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				local position = __wf_atom_c4f78a8f:GetPosition()
				position.y += 2
				__wf_atom_c4f78a8f:Teleport(position, __wf_atom_c4f78a8f:__wf_atom_dc309f8a())
			end
		end

		fn5(forcedFlying, nil)
	elseif tag == "flytowaypoint" and value then
		fn5(true, nil)
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			return
		end

		local position = __wf_atom_c4f78a8f:GetPosition()
		local __wf_atom_dc309f8a = __wf_atom_c4f78a8f:__wf_atom_dc309f8a()
		local __wf_atom_4e50d390 = __wf_atom_c4f78a8f:__wf_atom_4e50d390()
		local position2 = nil
		local v72 = nil
		local total2 = 0
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol(value))

		if __wf_atom_7e8ad928(__wf_atom_2226b35c) or not (#__wf_atom_2226b35c > 0) then
			if string.find(value, "_") then
				local v73 = StringSplit("_", value)

				if #v73 >= 3 then
					position2 = Vector(tonumber(v73[1]), tonumber(v73[2]), (tonumber(v73[3])))

					if #v73 >= 6 then
						v72 = Rotation(v73[4], v73[5], v73[6])
					else
						v72 = __wf_atom_dc309f8a
					end
				end
			end
		else
			position2 = __wf_atom_2226b35c[1]:GetPosition()
			v72 = __wf_atom_2226b35c[1]:__wf_atom_dc309f8a()
		end

		local position3, v73

		if position2 and v72 then
			position3, v73 = fn47(position2, v72, __wf_atom_2226b35c)
		else
			position3 = __wf_atom_c4f78a8f:GetPosition()
			v73 = __wf_atom_c4f78a8f:__wf_atom_0e1e5bc9()
		end

		__wf_atom_c4f78a8f:SetDisableMovement(true)

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_1cfa7bd2()) then
			__wf_atom_c4f78a8f:__wf_atom_7ab15c94(nil)
		end

		while total2 < 2 and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
			total2 += __wf_atom_fa1258d0()
			local v74 = __wf_atom_f55d6358(
				position,
				position3,
				__wf_atom_24a82b69(__wf_atom_421b01aa(total2, 0, 2) / 2)
			)
			local v75 = __wf_atom_9d2f097a(
				__wf_atom_dc309f8a,
				v73,
				__wf_atom_24a82b69(__wf_atom_421b01aa(total2, 0, 0.5) / 0.5)
			)
			local v76 = __wf_atom_9d2f097a(
				__wf_atom_4e50d390,
				v73,
				__wf_atom_24a82b69(__wf_atom_421b01aa(total2, 0, 0.5) / 0.5)
			)
			__wf_atom_c4f78a8f:Teleport(v74, v75)
			__wf_atom_c4f78a8f:__wf_atom_51075230(v76)
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:SetDisableMovement(false)
		end
	elseif tag == "dancindarvo" then
		fn43({
			"/Lotus/Types/Friendly/Agents/DarvoDeco",
			"/Lotus/Animations/Tenno/Emotes/Generic/Dance/DanceArsenio_anim.fbx"
		})
		local v72 = StringSplit("_", value)
		local v73, v74

		if #v72 > 1 then
			v73 = Vector(tonumber(v72[1]), tonumber(v72[2]), (tonumber(v72[3])))
			v74 = Rotation(v72[4], v72[5], v72[6])
		end

		local v75 = fn46("/Lotus/Types/Friendly/Agents/DarvoDeco", v73, v74, 25)

		if not __wf_atom_7e8ad928(v75) then
			v75:__wf_atom_921c1a5f(
				Resource("/Lotus/Animations/Tenno/Emotes/Generic/Dance/DanceArsenio_anim.fbx"),
				false,
				true
			)
		end
	elseif tag == "hohoho" then
		local v72 = {
			"/Lotus/Weapons/Tenno/ThrowingWeapons/VariantSnowBalls",
			"/Lotus/Upgrades/Skins/Effects/SnowEphemera"
		}
		local v73 = {
			"/Lotus/Objects/Festivities/Christmas/XmasSnowpile",
			"/Lotus/Objects/Festivities/Christmas/XmasTree"
		}
		fn43({
			WeakResource(v72[1]),
			WeakResource(v72[2]),
			WeakResource(v73[1]),
			WeakResource(v73[2]),
			WeakResource("/Lotus/Sounds/Misc/SleighBells/SleighBellsFadeOutPos"),
			WeakResource("/Lotus/Fx/Weather/SnowAttachNoRaycasting")
		})

		for _, v74 in pairs(v72) do
			local v75 = Resource(v74)

			if __wf_atom_7e8ad928(v75) then
				continue
			end

			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				__wf_atom_eab484a7:__wf_atom_36b99b9d(v75, 1)
			end
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:__wf_atom_c8700ab5(true)
			__wf_atom_d2b2176d:EnableWeaponFiring(true)
			__wf_atom_d2b2176d:__wf_atom_e704ac94(1)
			__wf_atom_d2b2176d:__wf_atom_e704ac94(5)
			__wf_atom_c4f78a8f:Attach(Resource("/Lotus/Fx/Weather/SnowAttachNoRaycasting"), EMPTY_SYMBOL)
			module.PlaySound(
				Resource("/Lotus/Sounds/Misc/SleighBells/SleighBellsFadeOutPos"),
				__wf_atom_c4f78a8f:GetPosition()
			)
		end

		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ChristmasDecorations"))

		for _, v74 in pairs(__wf_atom_2226b35c) do
			v74:SetVisibility(true, true)
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("AnnihilationCountdown"))
		local v74, v75, position, v76

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			position = __wf_atom_0a6a5887:GetPosition()
			position.y -= 2.75
			v74 = Vector(position.x, position.y - 1.5, position.z)
			v75 = 2.5
			v76 = 4
		end

		fn46(v73[1], v74, Rotation(), v75)
		fn46(v73[2], position, Rotation(), v76)
	end
end

function OnHubBroadcastFailed() end

local function fn48(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("RhinoStatue"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("RhinoStatueAttachment"))
	local v72 = 0

	while v72 < 1 do
		Sleep(0)
		v72 = __wf_atom_421b01aa(v72 + __wf_atom_fa1258d0(), 0, 1)

		if __wf_atom_0a6a5887:__wf_atom_f83a55c6() < 1 then
			__wf_atom_0a6a5887:__wf_atom_a763aa1a(v72)

			if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
				for _, v73 in pairs(__wf_atom_2226b35c) do
					v73:__wf_atom_a763aa1a(v72)
				end
			end
		end

		if not __wf_atom_7e8ad928(_T.BlessingStatueDeco) then
			_T.BlessingStatueDeco:__wf_atom_a763aa1a(v72)
		end
	end

	if not __wf_atom_7e8ad928(_T.BlessingStatueDeco) then
		gRegion:__wf_atom_dd1e4d10(_T.BlessingStatueDeco)
	end

	if __wf_atom_7e8ad928(object) then
		__wf_atom_0a6a5887:__wf_atom_a763aa1a(0)
		__wf_atom_0a6a5887:SetVisibility(true, true)
	else
		__wf_atom_0a6a5887:SetVisibility(false, true)
		_T.BlessingStatueDeco = gRegion:CreateEntity(
			Type(v48.statueAvatarType),
			__wf_atom_0a6a5887:GetPosition(),
			__wf_atom_80368bb1,
			nil
		)

		if __wf_atom_7e8ad928(_T.BlessingStatueDeco) then
			return
		end

		_T.BlessingStatueDeco:__wf_atom_a763aa1a(1)
		local v73 = WeakResource("/SF/Types/Physics/ScarfAttachment")
		local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
		local v74 = {}

		for i = 1, #__wf_atom_f582136d do
			table.insert(v74, __wf_atom_f582136d[i])
		end

		local __wf_atom_f582136d2 = object:__wf_atom_f582136d(__wf_atom_bbe9950b)

		for i = 1, #__wf_atom_f582136d2 do
			table.insert(v74, __wf_atom_f582136d2[i])
		end

		local __wf_atom_f582136d3 = object:__wf_atom_f582136d(__wf_atom_b5e70cef)

		for i = 1, #__wf_atom_f582136d3 do
			table.insert(v74, __wf_atom_f582136d3[i])
		end

		local __wf_atom_f582136d4 = object:__wf_atom_f582136d(v73)

		for i = 1, #__wf_atom_f582136d4 do
			table.insert(v74, __wf_atom_f582136d4[i])
		end

		local v75 = Symbol("BlesserStatue")

		for i = 1, #v74 do
			local v76 = v74[i]
			local __wf_atom_3d96ddcd = v76:__wf_atom_3d96ddcd()

			if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_7e6ed5fa) then
				continue
			end

			local __wf_atom_f5bac0e4 = v76:__wf_atom_f5bac0e4()
			local __wf_atom_fa6a8faf = v76:__wf_atom_fa6a8faf()
			local __wf_atom_45c0553e = v76:__wf_atom_45c0553e()
			local v77 = _T.BlessingStatueDeco:Attach(
				v76,
				__wf_atom_f5bac0e4,
				__wf_atom_fa6a8faf,
				__wf_atom_45c0553e,
				object
			)
			local __wf_atom_f83a55c6 = v76:__wf_atom_f83a55c6()

			if __wf_atom_7e8ad928(v77) then
				continue
			end

			v77:__wf_atom_a763aa1a(__wf_atom_f83a55c6)
			v77:__wf_atom_986f733d(v75, 0)
		end

		local v76 = 3
		local position = _T.BlessingStatueDeco:GetPosition()
		local v77 = tostring(gGameRules:__wf_atom_72fc675e().levelOverride:__wf_atom_5b41f63b())
		local v78

		if string.find(v77, "Hydroid") then
			_T.BlessingStatueDeco:Teleport(Vector(position.x + 1, position.y, position.z - 5), __wf_atom_80368bb1)
			v78 = 8
		else
			v78 = string.find(v77, "HubTwoB") and 8 or v76
		end

		_T.BlessingStatueDeco:__wf_atom_45cf0e1a(object:__wf_atom_b6b760b5(), true, true)
		_T.BlessingStatueDeco:SetMeshScale(v78)
		local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_eb82ab1f():ApplyCustomization(_T.BlessingStatueDeco, false)
		end

		local v79 = Resource(v48.statueAnim)
		_T.BlessingStatueDeco:__wf_atom_921c1a5f(v79, false, true)
		local v80 = 1

		while v80 > 0 do
			Sleep(0)
			v80 = __wf_atom_421b01aa(v80 - __wf_atom_fa1258d0(), 0, 1)

			if not __wf_atom_7e8ad928(_T.BlessingStatueDeco) then
				_T.BlessingStatueDeco:__wf_atom_a763aa1a(v80)
			end
		end
	end
end

local function fn49()
	if not _T.HubBlessingMsg then
		print("HubBlessing: HubBlessingMsg not set!")
		return
	end

	local copyTable = module.CopyTable(_T.HubBlessingMsg)
	local tag = string.lower(copyTable.msg.tag)
	local booster = v48.boosters["bless" .. tag]

	if __wf_atom_7e8ad928(booster) then
		fn32("Hub::_OnHubBlessing rejected. No such reward item.") -- inferred equivalent call
	else
		print("HubBlessing: waiting for resloader")
		fn43({
			v48.blesserFx,
			v48.blesseeFx,
			v48.blessSound,
			v48.rewardsMovie,
			v48.transmission,
			v48.statueAvatarType,
			v48.statueAnim
		})
		local from3 = copyTable.from
		local __wf_atom_2586e47b = gMatchingService:__wf_atom_9c7c90fb():__wf_atom_2586e47b(from3)
		local __wf_atom_d68faea4 = gGameRules:__wf_atom_d68faea4(from3)
		local v72 = Type(v48.blesserFx)
		local v73 = Type(v48.blesseeFx)
		local v74 = Resource(v48.blessSound)
		local v75 = Resource(v48.transmission)
		local storeItem = Resource(booster)
		local item = storeItem:GetItem()
		local v77 = tostring(item:__wf_atom_5b41f63b())
		local __wf_atom_e75653c3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3()
		print("HubBlessing: showing fanfare")
		_T.BlessingPopup_Info = {
			StoreItem = storeItem,
			IsMe = from3 == __wf_atom_e75653c3,
			Blesser = __wf_atom_2586e47b
		}
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(v48.rewardsMovie)
		module.PlaySound(v74)

		if not (__wf_atom_7e8ad928(__wf_atom_d68faea4) or __wf_atom_d68faea4:__wf_atom_a586ea4c(v72)) then
			__wf_atom_d68faea4:Attach(v72, EMPTY_SYMBOL)
		end

		for _, v78 in pairs(v26) do
			if
				__wf_atom_7e8ad928(v78.Avatar)
				or v78.Avatar == __wf_atom_d68faea4
				or v78.account == ""
				or v78.Avatar:__wf_atom_a586ea4c(v73)
			then
				continue
			end

			v78.Avatar:Attach(v73, EMPTY_SYMBOL)
		end

		if not _T.InWorldTransmissionQueue then
			_T.InWorldTransmissionQueue = {}
		end

		table.insert(_T.InWorldTransmissionQueue, v75)
		_T.InWorldTransmissionHubPlayerName = __wf_atom_2586e47b
		_T.InWorldTransmissionDurationOverride = v75:__wf_atom_1e34340d()

		if not _T.HubBlessings then
			_T.HubBlessings = {}
		end

		_T.HubBlessings[v77] = {
			mExpiryDate = gGameRules:__wf_atom_93691ff2() + v48.duration,
			mItemType = Resource(item)
		}

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("RefreshLoadout", "")
		end

		fn48(__wf_atom_d68faea4)
	end
end

function OnHubBlessing()
	fn49()
end

function _T:SendHubBlessing()
	print("HubBlessing: queuing " .. self)

	if gGameData:__wf_atom_a04e4a53() < 30 then
		fn32("Hub::SendHubBlessing insufficient rank") -- inferred equivalent call
	else
		local __wf_atom_eb6cb09b = gGameData:__wf_atom_eb6cb09b()

		if Engine.__wf_atom_db2b0cee(__wf_atom_eb6cb09b) > 0 then
			fn32("Hub::SendHubBlessing blessing rejected -- cooldown active") -- inferred equivalent call
		else
			if not __wf_atom_7e8ad928(v48.boosters["bless" .. self]) then
				_T.QueuedSendHubBlessing = { type = self, sent = false }
				return
			end

			fn32("Hub::SendHubBlessing invalid blessing type") -- inferred equivalent call
		end
	end
end

function _T.SendHubThankYou()
	if
		not (_T.HubBlessingMsg and _T.HubBlessingMsg.from)
		or _T.HubThankYouSendTime and Time() < _T.HubThankYouSendTime + 5
	then
		return false
	end

	_T.HubThankYouSendTime = Time()
	local encoded = cjson.encode({ thank = true })
	gMatchingService:__wf_atom_6ff767a1(_T.HubBlessingMsg.from, encoded)
	return true
end

function OnHubThankYou()
	if not _T.HubThankYouMsg then
		return
	end

	local from3 = module.CopyTable(_T.HubThankYouMsg).from
	fn9(gMatchingService:__wf_atom_9c7c90fb():__wf_atom_2586e47b(from3))
end

function SupportsThemes()
	return true
end