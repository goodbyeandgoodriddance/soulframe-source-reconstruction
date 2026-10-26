module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("Lotus.Interface.UIUtilities")
local module5 = require("Lotus.Interface.UIStyleUtilities")

function IsInitiated(object)
	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_9be88b01)) then
		local __wf_atom_51dd1b95 = __wf_atom_9be88b01:__wf_atom_51dd1b95((object:__wf_atom_e0f044e1()))

		if not __wf_atom_7e8ad928(__wf_atom_51dd1b95) then
			return __wf_atom_51dd1b95.mInitiated
		end
	end

	return false
end

function InterruptSyndicateTransmission()
	module2.ForceCloseTransmission(false)
end

function UpdateSyndicateTransLoader()
	if
		_T.SyndicateResLoaderPending
		and not __wf_atom_7e8ad928(_T.SyndicateResLoader)
		and _T.SyndicateResLoader:__wf_atom_86399a47()
	then
		_T.SyndicateResLoaderPending = false
		local v = Resource(_T.SyndicateTrans)
		local v2 = not __wf_atom_7e8ad928(__wf_atom_4ec12570) and __wf_atom_4ec12570:__wf_atom_22941262()
		local __wf_atom_fa9e9301 = v:__wf_atom_fa9e9301()
		module2.ClearTransmissionQueue()
		local transmissionSoundInstance = _T.TransmissionSoundInstance

		if not __wf_atom_7e8ad928(transmissionSoundInstance) then
			transmissionSoundInstance:Stop(false)
		end

		if __wf_atom_fa9e9301 ~= v2 then
			module2.ForceCloseTransmission(false)
		end

		module2.CreateHudlessTransmission(v)
		_T.SyndicateTrans = nil
	end
end

local function fn(object, p, p2)
	if object == nil or p == nil then
		return
	end

	local __wf_atom_b4a422ed = object:__wf_atom_b4a422ed(Symbol(p))

	if __wf_atom_7e8ad928(__wf_atom_b4a422ed) and p2 then
		__wf_atom_b4a422ed = object:__wf_atom_b4a422ed(Symbol("Empty"))
	end

	if not __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
		if not __wf_atom_7e8ad928(_T.SimarisSpeaking) then
			print("Interrupt previous simaris dialog")
			_T.SimarisSpeaking:Stop(true)
		end

		if _T.CurrentConversation then
			_T.CurrentConversation:__wf_atom_9265891c(__wf_atom_b4a422ed, nil, false, true)
			return
		end

		_T.SyndicateTrans = __wf_atom_b4a422ed
		_T.SyndicateResLoader = UISys.__wf_atom_c0dbe47c({ __wf_atom_b4a422ed:__wf_atom_5b41f63b() }, true)
		_T.SyndicateResLoaderPending = true
	end
end

function PlaySyndicateTransmission(p, p2, p3)
	fn(p, p2, p3)
end

local function fn2(object, p, object2)
	if object == nil or p == nil then
		return
	end

	local __wf_atom_b4a422ed = object:__wf_atom_b4a422ed(Symbol(p))

	if not __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
		if not __wf_atom_7e8ad928(_T.SimarisSpeaking) then
			print("Interrupt previous simaris dialog")
			_T.SimarisSpeaking:Stop(true)
		end

		object2:__wf_atom_1a73b1c2(__wf_atom_b4a422ed)
	end
end

function PlayMissionStartSyndicateTransmission()
	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

	if not __wf_atom_7e8ad928(__wf_atom_72fc675e) and __wf_atom_72fc675e.syndicateTag:__wf_atom_8598f3a9() then
		local c_str = __wf_atom_72fc675e.syndicateTag:c_str()
		local __wf_atom_3adbb7e9 = __wf_atom_c67f9605:__wf_atom_3adbb7e9()
		local v = nil

		for i = 1, #__wf_atom_3adbb7e9 do
			if __wf_atom_3adbb7e9[i]:__wf_atom_e0f044e1():c_str() ~= c_str then
				continue
			end

			v = __wf_atom_3adbb7e9[i]
			break
		end

		if not __wf_atom_7e8ad928(v) then
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for i = 1, #__wf_atom_ef7900cf do
				fn2(v, "AlertIntro", __wf_atom_ef7900cf[i])
			end
		end
	end
end

function IsSyndicateMissionActive()
	local gGameRules = gGameRules
	local v

	if not __wf_atom_7e8ad928(gGameRules) then
		v = gGameRules:__wf_atom_72fc675e()
	end

	return not (__wf_atom_7e8ad928(v) or not v.syndicateTag:__wf_atom_8598f3a9())
end

function InitializeSyndicateData(syndicate, p)
	p.Syndicate = syndicate

	if not __wf_atom_7e8ad928(syndicate) then
		p.Label = Localize(syndicate:__wf_atom_818ea3a7():c_str(), false)
		p.Description = syndicate:__wf_atom_0da28bec():c_str()
		p.Icon = syndicate:GetIconTexture()
		p.Material = syndicate:__wf_atom_f41c5308()
		p.TextColor = syndicate:__wf_atom_f98de914():__wf_atom_dcecedb0()
		p.BackgroundColor = syndicate:__wf_atom_21ae2ec8():__wf_atom_dcecedb0()
		p.LogoColor = syndicate:__wf_atom_48b50dc0():__wf_atom_dcecedb0()
		p.TextColor = syndicate:__wf_atom_f98de914():__wf_atom_dcecedb0()
		p.BackgroundAlpha = syndicate:__wf_atom_21ae2ec8().alpha / 255 * 100
		p.LogoAlpha = syndicate:__wf_atom_48b50dc0().alpha / 255 * 100
		p.LovedTitle = syndicate:__wf_atom_05e0be09()
	end
end

local function fn3(object, p, p2, p3)
	local v = ""

	if p <= -1 then
		v = object:__wf_atom_8e9ac384("/Lotus/Language/Syndicates/SyndicateEnemy", false)
	elseif p <= 0 then
		v = object:__wf_atom_8e9ac384("/Lotus/Language/Syndicates/SyndicateOpposed", false)
	elseif p > 0 then
		v = object:__wf_atom_8e9ac384("/Lotus/Language/Syndicates/SyndicateAlly", false)
	end

	if not p2 then
		return v
	end

	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(module.Ternary(p > 0, "<INC_ARROW>", "<DEC_ARROW>"), true)

	if p3 then
		local color = module5.GetColor(module.Ternary(p > 0, 11, 12), true)
		__wf_atom_8e9ac384 = "<font color=\"" .. module.ConvertColorNumberToHex(color) .. "\">" .. __wf_atom_8e9ac384 .. "</font>"
	end

	return v .. __wf_atom_8e9ac384 .. math.abs((module.Round(p * 100))) .. "% " .. object:__wf_atom_8e9ac384("<REPUTATION>", true)
end

function GetAlignmentText(p, p2, p3, p4)
	return (fn3(p, p2, p3, p4))
end

local function fn4()
	return {
		ALL = { Id = 0, Types = {} },
		SIGIL = {
			Id = 1,
			Types = { __wf_atom_87580f1c }
		},
		MOD = {
			Id = 2,
			Types = { __wf_atom_58a409f1 }
		},
		STRIKE = {
			Id = 3,
			Types = { __wf_atom_451d8d7c }
		},
		GRIP = {
			Id = 4,
			Types = { __wf_atom_320a81ab }
		},
		LINK = { Id = 5, Types = {} },
		ARCANE = { Id = 6, Types = {} },
		AMPS = { Id = 7, Types = {} },
		APPEARANCE = {
			Id = 8,
			Types = { __wf_atom_abf506db }
		},
		WEAPON = { Id = 9, Types = {} },
		CHAMBER = { Id = 10, Types = {} },
		PRIMARY_HANDLE = { Id = 11, Types = {} },
		HANDLE = { Id = 12, Types = {} },
		LOADER = { Id = 13, Types = {} },
		MODEL = { Id = 14, Types = {} },
		CORE = { Id = 15, Types = {} },
		GYRO = { Id = 16, Types = {} },
		BRACKET = { Id = 17, Types = {} },
		BOARD = { Id = 18, Types = {} },
		REACTOR = { Id = 19, Types = {} },
		NOSE = { Id = 20, Types = {} },
		JET = { Id = 21, Types = {} },
		REQUIREMENTS_MET = { Id = 22, Types = {}, ValidateCost = true },
		MISC = { Id = 23, Types = {} },
		RECOVERED = { Id = 24, Types = {} }
	}
end

function GetCategories()
	return (fn4())
end

local function fn5(object, p, p2)
	local color = module5.GetColor(10, true)
	local color2 = module5.GetColor(9, true)
	local color3 = module5.GetColor(12, true)
	local color4 = module5.GetColor(2, true)
	local level = tonumber(p2.Level)
	local v = (level == nil and 0 or level) >= 0
	__wf_atom_86cbd68d(object, p .. ".gotoAndStop", 1)
	__wf_atom_86cbd68d(object, p .. ".gotoAndStop", module.Ternary(v, "Positive", "Negative"))
	object:__wf_atom_4c1c1986(p, "Shadow", 11, 1315613)
	object:__wf_atom_7d7314f1(p .. ".Label.text", module.Ternary(false, "<NEUTRAL_SYNDICATE>", p2.Level))
	object:__wf_atom_4c1c1986(p, "Label", 1, module.Ternary(false, 29, module.Ternary(v, 30, 18)))
	object:__wf_atom_4c1c1986(p, "Label", 44, module.Ternary(v, color, color3))
	object:__wf_atom_4c1c1986(p, "Cap", 11, module.Ternary(v, color, color3))
	object:__wf_atom_4c1c1986(p, "Outline", 11, module.Ternary(v, color2, color3))
	object:__wf_atom_4c1c1986(p, "Fill", 11, color4)
end

function DrawRankIndicator(p, p2, p3)
	fn5(p, p2, p3)
end

function CreateFavorsMovie(object, p, isReward, data, p2, isSupplyDropItem)
	local v = nil

	if __wf_atom_7e8ad928(p) then
		return v
	end

	local v2 = p2 == nil and "" or p2
	_T.VendorOverlayMode = true
	local v3

	if __wf_atom_7e8ad928(object) then
		v3 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(p)
	else
		v3 = object:PushChildMovie(p)
	end

	if __wf_atom_7e8ad928(v3) then
		return v3
	end

	if isReward then
		v3:Execute("SetMustBuyToExitTag", "/Lotus/Language/Syndicates/Favors_MustRedeemBeforeExiting")
	end

	local v4 = fn4()
	local __wf_atom_e0f044e1 = data.Syndicate:__wf_atom_e0f044e1()
	local v5 = __wf_atom_e0f044e1 == Symbol("CetusSyndicate")
	local v6 = __wf_atom_e0f044e1 == Symbol("QuillsSyndicate")
	local v7 = __wf_atom_e0f044e1 == Symbol("SolarisSyndicate")
	local v8 = __wf_atom_e0f044e1 == Symbol("VoxSyndicate")
	local favorCategories

	if v5 or v6 or v7 or v8 then
		favorCategories = {
			ALL = v4.ALL.Id,
			ARCANE = v4.ARCANE.Id,
			AMPS = v4.AMPS.Id,
			APPEARANCE = v4.APPEARANCE.Id,
			MISC = v4.MISC.Id
		}
		local syndicateFavorsTag = _T.SyndicateFavorsTag
		local v9 = syndicateFavorsTag == Symbol("Weaponsmith")
		local v10 = syndicateFavorsTag == Symbol("MoaVendor")

		if v9 then
			if v7 then
				favorCategories.CHAMBER = v4.CHAMBER.Id
				favorCategories.HANDLE = v4.HANDLE.Id
				favorCategories.PRIMARY_HANDLE = v4.PRIMARY_HANDLE.Id
				favorCategories.LOADER = v4.LOADER.Id
			else
				favorCategories.STRIKE = v4.STRIKE.Id
				favorCategories.GRIP = v4.GRIP.Id
				favorCategories.LINK = v4.LINK.Id
			end
		elseif v10 then
			favorCategories.MODEL = v4.MODEL.Id
			favorCategories.CORE = v4.CORE.Id
			favorCategories.GYRO = v4.GYRO.Id
			favorCategories.BRACKET = v4.BRACKET.Id
		end
	elseif _T.SyndicateFavorsTag == Symbol("SupplyDrop") then
		favorCategories = { ALL = v4.ALL.Id }
	else
		favorCategories = {
			ALL = v4.ALL.Id,
			SIGIL = v4.SIGIL.Id,
			MOD = v4.MOD.Id,
			MISC = v4.MISC.Id,
			RECOVERED = v4.RECOVERED.Id
		}

		if __wf_atom_e0f044e1 == Symbol("VentKidsSyndicate") then
			favorCategories.BOARD = v4.BOARD.Id
			favorCategories.REACTOR = v4.REACTOR.Id
			favorCategories.NOSE = v4.NOSE.Id
			favorCategories.JET = v4.JET.Id
		end
	end

	_T.FavorCategories = favorCategories
	v3:Execute("SetVendorCategories", "FavorCategories")
	local __wf_atom_07c7a1cc = data.Syndicate:__wf_atom_07c7a1cc()
	v3:Execute("LoadVendorManifest", __wf_atom_07c7a1cc:__wf_atom_5b41f63b())

	function _T.GetFavorsInfo()
		local v9 = {}
		local mTitle = string.upper(Localize(tostring(data.Syndicate:__wf_atom_818ea3a7()), nil))
		local v10 = Resource(__wf_atom_07c7a1cc)
		local v11

		if isSupplyDropItem then
			v11 = v10:__wf_atom_7bd4cfba(data.Syndicate)
		else
			v11 = v10:__wf_atom_960591dd(data.Syndicate)
		end

		if __wf_atom_7e8ad928(_T.CurrentConversation) then
			v9.mTitle = mTitle
		else
			v9.mTitle = Localize(_T.CurrentConversation.mSpeakerName, nil)
		end

		if isSupplyDropItem then
			v9.mSubTitle = Localize("/Lotus/Language/Syndicates/Supply_SubTitle", false)
		else
			v9.mSubTitle = Localize(
				"/Lotus/Language/Syndicates/" .. module.Ternary(isReward, "Favors_RewardSubTitle", "Favors_SubTitle"),
				false
			)
		end

		v9.mItemList = {}
		v9.mSyndicateTag = __wf_atom_e0f044e1

		if not __wf_atom_7e8ad928((module3.GetInventoryControl())) then
			v9.mInventoryList = {}

			for _, v12 in data.Syndicate:__wf_atom_eccf784f() do
				if not (v12.mTag == EMPTY_SYMBOL or v12.mTag == __wf_atom_e0f044e1) then
					continue
				end

				local v13 = {
					Type = v12.mItemType,
					SpecialPrice = v12.mStanding,
					SpecialPriceIconTag = "<REPUTATION>",
					PriceLabelType = module4.LABEL_TYPE_REPUTATION,
					SpecialPriceName = "/Lotus/Language/Syndicates/Favors_Reputation"
				}
				table.insert(v9.mInventoryList, v13)
			end
		end

		local requiredLevel = 0

		for i = 1, #v11 do
			local v12 = v11[i]

			if not (isReward or not v12.availabilityTag:__wf_atom_8598f3a9() or v12.availabilityTag == _T.SyndicateFavorsTag) then
				continue
			end

			if __wf_atom_7e8ad928(v12.storeItem) then
				print("ERROR: Missing storeitem for favor " .. tostring(i) .. " in level " .. tostring(v12.requiredLevel))
			elseif isSupplyDropItem and __wf_atom_7e8ad928(v12.itemType) then
				print("ERROR: Missing itemType for SupplyDrop " .. tostring(i) .. " in level " .. tostring(v12.requiredLevel))
			elseif not isReward or data.Level == v12.requiredLevel and v12.availableAsFreeFavor then
				local v13 = ""

				for _, v14 in pairs(data.Syndicate:__wf_atom_c14d1e89()) do
					if v14.level ~= v12.requiredLevel then
						continue
					end

					v13 = v14.titleLoc:c_str()
					break
				end

				local item = v12.storeItem:GetItem()

				if v12.storeItem:IsPackage() then
					item = v12.storeItem
				end

				local categories = {}

				if not __wf_atom_7e8ad928(item) then
					local v14

					if v12.storeItem:IsA(__wf_atom_bf37f5ca) then
						v14 = v12.storeItem:__wf_atom_c5566ef8()
					else
						v14 = item
					end

					if not __wf_atom_7e8ad928(v14) then
						local flag = false

						for k, favorCategory in pairs(_T.FavorCategories) do
							for _, className in ipairs(v4[k].Types) do
								if not v14:IsA(className) then
									continue
								end

								table.insert(categories, favorCategory)
								flag = true
								break
							end

							if flag then
								break
							end
						end

						if not flag then
							table.insert(categories, _T.FavorCategories.MISC)
						end
					end

					if v12.questReward then
						table.insert(categories, _T.FavorCategories.RECOVERED)
					end

					table.insert(categories, _T.FavorCategories.ALL)
				end

				local ternary = module.Ternary(isSupplyDropItem, v12, nil)

				if requiredLevel < v12.requiredLevel then
					requiredLevel = v12.requiredLevel
				end

				table.insert(v9.mItemList, {
					Item = item,
					Categories = categories,
					StoreItem = v12.storeItem,
					SyndLevel = v12.requiredLevel,
					Locked = data.Level < v12.requiredLevel,
					LockedText = Localize("/Lotus/Language/Syndicates/Favors_LevelLocked", {
						TITLE = string.upper(Localize(v13, nil))
					}),
					SpecialPrice = v12.standingCost,
					SpecialPriceBgColor = 5030911,
					SpecialPriceIconTag = "<REPUTATION>",
					PriceLabelType = module4.LABEL_TYPE_REPUTATION,
					SpecialPriceName = "/Lotus/Language/Syndicates/Favors_Reputation",
					RegularPrice = v12.creditsCost,
					PremiumPrice = 0,
					IsReward = isReward,
					IsSupplyDropItem = isSupplyDropItem,
					SupplyDropItem = ternary,
					DefaultOrder = i
				})
			end
		end

		if not isReward then
			for i = 1, requiredLevel do
				local v12 = {
					Header = true,
					Name = object:__wf_atom_8e9ac384("/SF/Language/Progression/Rank", true, {
						NUMBER = i
					}),
					SyndLevel = i
				}
				table.insert(v9.mItemList, v12)
			end
		end

		local mItemList = v9.mItemList
		table.sort(mItemList, function(a, b)
			if a.SyndLevel == b.SyndLevel then
				return a.Header
			end

			return a.SyndLevel < b.SyndLevel
		end)
		return v9
	end

	v3:Execute("SetVendorInfoFunction", "GetFavorsInfo")

	function _T.UpdateInfoPanel(object2, p3)
		if not p3 then
			__wf_atom_86cbd68d(object2, "InfoPanel.gotoAndStop", "Faction")

			if data ~= nil then
				local color = module5.GetColor(9, true)
				local color2 = module5.GetColor(6, true)
				local convertColorNumberToHex = module.ConvertColorNumberToHex(color2)
				module5.GetColor(1, true)
				local convertColorNumberToHex2 = module.ConvertColorNumberToHex(color)
				local color3 = module5.GetColor(1, true)
				local color4 = module5.GetColor(2, true)
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "SmallLogo", 11, data.LogoColor)
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "SmallLogo", 12, data.LogoAlpha)
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "MediumLogo", 12, 3)
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "LargeLogo", 12, 3)
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "Highlight", 11, color4)
				object2:__wf_atom_7d7314f1("InfoPanel.Banner.Description.text", data.Description)
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "Description", 44, color2)
				fn5(object2, "InfoPanel.Banner.Rank", data)
				object2:__wf_atom_7f57ab2f("InfoPanel.Banner", "CurrentRank", 52, true)
				object2:__wf_atom_48bd5a59("InfoPanel.Banner", "CurrentRank", 46, "bottom")
				object2:__wf_atom_7d7314f1("InfoPanel.Banner.CurrentRank.text", data.CurrentTitle)
				local v9 = data.Level >= 0
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "CurrentRank", 1, -340 + module.Ternary(v9, 0, -12))
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "CurrentRank", 44, color)
				object2:__wf_atom_50d60589(
					"InfoPanel.Banner.RepIndicator.Reputation",
					36,
					"<p><font size=\"26\" color=\"" .. convertColorNumberToHex .. "\">" .. object2:__wf_atom_8e9ac384("<REPUTATION>", true) .. " " .. module.FormatNumber(data.Reputation) .. "</font><font size=\"26\" color=\"" .. convertColorNumberToHex2 .. "\">/" .. module.FormatNumber(data.ReputationRequired) .. "</font></p>"
				)
				local module6 = require("Lotus.Interface.Components.ThemedProgressBar")
				local v10 = module6.Create(
					object2,
					"InfoPanel.Banner.RepIndicator.Progress",
					402,
					{ (math.abs(data.Reputation / data.ReputationRequired)) },
					nil,
					1
				)
				v10.mHeight = 7
				v10.mBgInnerAlpha = 0.9
				v10.mFillEdgeAlpha = 0
				v10.mEdgePadding = 0
				v10.mBgEdgeColor = 9
				v10:Redraw()
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "Bg", 11, data.BackgroundColor)
				object2:__wf_atom_4c1c1986("InfoPanel.Banner", "Bg", 12, 70)

				if not __wf_atom_7e8ad928(data.Icon) then
					object2:__wf_atom_c90af43a("InfoPanel.Banner.LargeLogo", data.Icon)
					object2:__wf_atom_c90af43a("InfoPanel.Banner.MediumLogo", data.Icon)
					object2:__wf_atom_c90af43a("InfoPanel.Banner.SmallLogo", data.Icon)
				end

				local __wf_atom_27217f21 = data.Syndicate:__wf_atom_27217f21()

				for i = 1, 3 do
					local v11 = "InfoPanel.Banner" .. ".Ally" .. tostring(4 - i)
					local v12 = i <= #__wf_atom_27217f21
					object2:__wf_atom_2dedec1a(v11, 13, v12)

					if not v12 then
						continue
					end

					local v13 = Resource(__wf_atom_27217f21[i].other:__wf_atom_5b41f63b())

					if __wf_atom_7e8ad928(v13) then
						continue
					end

					object2:__wf_atom_c90af43a(v11 .. ".Icon", v13:GetIconTexture())
					object2:__wf_atom_4c1c1986(v11, "Icon", 11, color3)
					object2:__wf_atom_7d7314f1(v11 .. ".Name.text", v13:__wf_atom_818ea3a7():c_str())
					object2:__wf_atom_4c1c1986(v11, "Name", 44, color2)
					object2:__wf_atom_48bd5a59(v11, "Status", 36, (fn3(object2, __wf_atom_27217f21[i].multiplier)))
					object2:__wf_atom_4c1c1986(v11, "Status", 44, color3)
					local ternary = module.Ternary(__wf_atom_27217f21[i].multiplier > 0, 180, 0)
					local __wf_atom_5e6e15c8 = object2:__wf_atom_5e6e15c8(v11 .. ".Status", 0)
					local v14 = object2:__wf_atom_5e6e15c8(v11 .. ".Status", 40) + 5
					local __wf_atom_5e6e15c8_2 = object2:__wf_atom_5e6e15c8(v11 .. ".Arrow", 14)
					object2:__wf_atom_4c1c1986(v11, "Arrow", 16, ternary)
					object2:__wf_atom_4c1c1986(v11, "Arrow", 11, color3)
					object2:__wf_atom_4c1c1986(v11, "Arrow", 0, __wf_atom_5e6e15c8 + v14 + __wf_atom_5e6e15c8_2 / 2)
					object2:__wf_atom_48bd5a59(
						v11,
						"Rep",
						36,
						math.abs((module.Round(__wf_atom_27217f21[i].multiplier * 100))) .. "% " .. object2:__wf_atom_8e9ac384("<REPUTATION>", true)
					)
					object2:__wf_atom_7f57ab2f(v11, "Rep", 89, true)
					object2:__wf_atom_4c1c1986(v11, "Rep", 44, color3)
					object2:__wf_atom_4c1c1986(v11, "Rep", 0, __wf_atom_5e6e15c8 + v14 + __wf_atom_5e6e15c8_2 + 7)
				end
			end
		end
	end

	v3:Execute("SetInfoPanelUpdateFunction", "UpdateInfoPanel")

	function _T.BuyVendorItem(data2, p3, mQuantity)
		if __wf_atom_7e8ad928(data2) then
			LogBug("Attempted to purchase nil faction item")
			return
		end

		if data2.IsSupplyDropItem then
			_T.PurchasedSupplyDrop = data2.SupplyDropItem
		end

		local purchaseParams = SF.PurchaseParams()
		purchaseParams.mSource = 2
		purchaseParams.mStoreItem = data2.StoreItem

		if data2.Seed then
			purchaseParams.mSeed = data2.Seed
		end

		purchaseParams.mQuantity = mQuantity
		purchaseParams.mSyndicateTag = data.Syndicate:__wf_atom_e0f044e1()
		purchaseParams.mUseFreeFavor = module.Ternary(isReward, true, false)
		purchaseParams.mIsSupplyDrop = module.Ternary(data2.IsSupplyDropItem, true, false)
		purchaseParams.mSkipConfirm = false
		_T.DoPurchase(purchaseParams, p3)
	end

	v3:Execute("SetBuyItemFunction", "BuyVendorItem")
	_T.SyndStoreMadePurchase = false

	function _T.OnBuyVendorItem()
		if isReward then
			v3:Execute("TransitionOut", "")
			gGameRules:__wf_atom_411c9025(false)
		else
			_T.SyndStoreMadePurchase = true
			fn(data.Syndicate, "RepStorePurchase" .. v2)
			v3:Execute("RefreshInfoPanel", "")
		end
	end

	v3:Execute("SetOnBuyItemFunction", "OnBuyVendorItem")

	function _T.OnCloseFunction()
		if not isReward then
			if _T.SyndStoreMadePurchase then
				fn(data.Syndicate, "RepStoreExitSale" .. v2)
			else
				fn(data.Syndicate, "RepStoreExitNoSale" .. v2)
			end
		end
	end

	v3:Execute("SetOnCloseFunction", "OnCloseFunction")
	return v3
end

function InitializeSyndicateInfo(p, p2)
	local module6 = require("Lotus.Interface.Components.ThemedProgressInfo")
	local v = module6.Create(p, p2 .. ".Progress", "")
	v.mRankClipName = p2 .. ".Rank"
	v.mSkipResize = true
	v.mVerticalTextOffset = 0.15
	v.mBackerEdgeAlpha = 0.3
	v.mToUpper = true
	v.mIconSize = 90
	v.mIconBorderSize = 110
	v.mIconPaddingX = -4
	v.mIconPaddingY = -4
	v.mIconToTextPadding = 106
	v.mBackerIconAlpha = 0.3
	v.mUnfocusedShadeAlpha = 80
	v.mShowIconHighlight = true
	v:SetWidth(500)
	v.mExtendedProgressBar = true
	return v
end

function PopulateSyndicateInfo(object, object2, state)
	if __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.Syndicate) then
		return
	end

	object2.mIconColor = state.Syndicate:__wf_atom_48b50dc0()
	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(state.BackgroundColor)
	object2.mIconBgColor = Color(
		convertColorNumberToProceduralRGB.r * 255 / 1.5,
		convertColorNumberToProceduralRGB.g * 255 / 1.5,
		convertColorNumberToProceduralRGB.b * 255 / 1.5
	)
	object2.mIconBgExtra = state.Icon
	local backgroundIconPos = module2.GetSyndicateBackgroundAlignments()[state.Icon:__wf_atom_5b41f63b()]

	if backgroundIconPos then
		state.BackgroundIconPos = backgroundIconPos
		state.BackgroundIconAlpha = module.Ternary(backgroundIconPos.Alpha ~= nil, backgroundIconPos.Alpha, 5)
	else
		state.BackgroundIconAlpha = 5
	end

	if state.BackgroundIconPos ~= nil then
		object2.mIconBgExtraWidth = state.BackgroundIconPos.Scale / 6
		object2.mIconBgExtraHeight = state.BackgroundIconPos.Scale / 6
		object2.mIconBgExtraOffsetX = state.BackgroundIconPos.X / 2
		object2.mIconBgExtraOffsetY = state.BackgroundIconPos.Y / 2
		object2.mIconBgExtraAlpha = state.BackgroundIconAlpha
	end

	object2:SetIcons(state.Syndicate:GetIconTexture())
	object2:Redraw()
	object2:SetProgress(state.Reputation, state.ReputationRequired, "/Lotus/Language/Syndicates/SyndicateReputation")
	object2:SetText(state.Syndicate:__wf_atom_30fc1c90(state.Level):c_str(), false)
	module5.GetColor(10, true)
	module5.GetColor(9, true)
	module5.GetColor(12, true)
	module5.GetColor(2, true)
	fn5(object, object2.mRankClipName, state)

	if object2.mTextMaterial ~= nil then
		object:OverrideMaterial(object2.mRankClipName .. ".Label", object2.mTextMaterial)
	end

	if object2.mIconMaterial ~= nil then
		object:OverrideMaterial(object2.mRankClipName .. ".Shadow", object2.mIconMaterial)
		object:OverrideMaterial(object2.mRankClipName .. ".Fill", object2.mIconMaterial)
		object:OverrideMaterial(object2.mRankClipName .. ".Outline", object2.mIconMaterial)
		object:OverrideMaterial(object2.mRankClipName .. ".Cap", object2.mIconMaterial)
	end

	object:__wf_atom_e57658c2(object2.mRankClipName, 0, object2.mIconSpace - 93)
	object:__wf_atom_e57658c2(object2.mRankClipName, 1, object2.mHeight / 2 - 50)
end

function GetCustomSpeakerName(list, p)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v = false
	else
		v = __wf_atom_18a5d83b:Settings():__wf_atom_a35494b3()
	end

	if v then
		return list[1]
	end

	if p < #list then
		return list[p]
	end

	return list[#list]
end