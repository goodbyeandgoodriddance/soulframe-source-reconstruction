local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil
local statOwner = nil
local v2 = nil
local v3 = nil
local v4 = ""
local v5 = ""
local v6 = false
local asyncLoader = module2.CreateAsyncLoader()
local contextAction = nil
local v7 = nil
local v8 = 1
local v9 = false
local topMenuOpen = nil
local v10 = 0
local v11 = {}
local mItemType = nil
local v12 = nil
local v13 = { "Marker.LeftBraceClip", "Marker.RightBraceClip" }
local v14 = {}
local v15 = false
local v16 = { Active = false, AttachEntity = nil, Offset = Vector() }
local count = 0
local v17 = nil
local v18 = true
local v19 = __wf_atom_10cd16b2(0, 0.15)
local flag = true
local v20 = nil
local v21 = { LauralLeftX = 0, LauralRightX = 0, IconAidY = 0, CalloutY = 0 }
local v22 = { CapX = 0, FillWidth = 0 }

function Shutdown()
	if not __wf_atom_7e8ad928(v17) then
		gRegion:__wf_atom_dd1e4d10(v17)
		v20 = nil
	end

	asyncLoader:ClearResources()
	_T.GetActiveContextAction = nil
end

local function fn()
	if not __wf_atom_7e8ad928(v17) then
		Effects.__wf_atom_e0419a8d(v17, __wf_atom_8939e086)
		local __wf_atom_f582136d = v17:__wf_atom_f582136d(__wf_atom_fac7b40a)

		for _, v23 in ipairs(__wf_atom_f582136d) do
			v23:Destroy()
		end

		v17:Disable()
		v17 = nil
		v20 = nil
		flag = true
	end
end

local function fn2()
	for i, v23 in ipairs(v13) do
		v14[i] = {
			x = mMovie:__wf_atom_5e6e15c8(v23, 0)
		}
		local v24 = { x = v14[i].x }
		v24.x += module.Ternary(i == 2, 20, -20)
		mMovie:__wf_atom_e57658c2(v23, 0, v24.x)
		mMovie:__wf_atom_e57658c2(v23, 12, 0)
		mMovie:__wf_atom_4c1c1986(v23, "Foreground", 4, -100)
		mMovie:__wf_atom_4c1c1986(v23, "Middle", 4, -100)
		mMovie:__wf_atom_4c1c1986(v23, "BackShadow", 4, 100)
		mMovie:__wf_atom_4c1c1986(v23, "BackShadow", 12, 25)
		mMovie:OverrideMaterial(v23 .. ".Middle", nonDepthTestIconMaterial)
	end

	mMovie:__wf_atom_2dedec1a("Marker.LauralLeft", 13, false)
	mMovie:__wf_atom_2dedec1a("Marker.LauralRight", 13, false)
	mMovie:__wf_atom_2dedec1a("Marker.CalloutBg", 13, false)
	mMovie:__wf_atom_2dedec1a("Marker.IconAid", 13, false)
	mMovie:__wf_atom_2dedec1a("Marker.Instruction", 13, false)
	mMovie:__wf_atom_2dedec1a("Marker.InstructionMiddle", 13, false)
	mMovie:__wf_atom_2dedec1a("Marker.HoldText", 13, false)
	mMovie:__wf_atom_e57658c2("Marker.Instruction", 12, 0)
	mMovie:__wf_atom_e57658c2("Marker.HoldText", 12, 0)
	mMovie:__wf_atom_e57658c2("Marker.Panel", 12, 0)
	mMovie:__wf_atom_e57658c2("Marker.Panel.Foreground", 4, -100)
	mMovie:__wf_atom_e57658c2("Marker.Panel.Middle", 4, -100)
	mMovie:__wf_atom_e57658c2("Marker.Panel.BackShadow", 4, 100)
	mMovie:__wf_atom_e57658c2("Marker.Panel.BackShadow", 12, 25)
	mMovie:__wf_atom_e57658c2("Marker.Circle", 12, 0)
	mMovie:__wf_atom_e57658c2("Marker.Circle.Foreground", 4, -100)
	mMovie:__wf_atom_e57658c2("Marker.Circle.Middle", 4, 100)
	mMovie:__wf_atom_e57658c2("Marker.Circle.Shadow", 12, 0)
	mMovie:__wf_atom_e57658c2("Marker.Panel.LeftBacker", 4, 0)
	mMovie:__wf_atom_e57658c2("Marker.Panel.Extender", 4, 0)
	mMovie:__wf_atom_e57658c2("Marker.Panel.RightBacker", 4, 0)
	mMovie:__wf_atom_50d60589("Marker.Callout", 36, "")
	mMovie:__wf_atom_50d60589("Marker.CalloutMiddle", 36, "")
	mMovie:__wf_atom_e57658c2("Marker.Callout", 4, -100)
	mMovie:__wf_atom_e57658c2("Marker.CalloutMiddle", 4, -100)
	mMovie:__wf_atom_e57658c2("Marker.Instruction", 4, -100)
	mMovie:__wf_atom_e57658c2("Marker.InstructionMiddle", 4, -100)
	mMovie:__wf_atom_e57658c2("Marker.HoldText", 4, -100)
	mMovie:__wf_atom_e57658c2("Marker.CalloutMiddle", 12, 20)
	mMovie:__wf_atom_e57658c2("Marker.InstructionMiddle", 12, 20)
	mMovie:OverrideMaterial("Marker.Panel.Middle.LeftDeco", nonDepthTestIconMaterial)
	mMovie:OverrideMaterial("Marker.Panel.Middle.RightSide", nonDepthTestMaterial)
	mMovie:OverrideMaterial("Marker.InstructionMiddle", nonDepthTestMaterial)
	mMovie:OverrideMaterial("Marker.CalloutMiddle", nonDepthTestMaterial)
	mMovie:OverrideMaterial("Marker.Circle.Middle", nonDepthTestIconMaterial)
	mMovie:__wf_atom_e57658c2("Marker.HoldProgressBar", 12, 0)

	for _, v23 in ipairs({
		"Marker.Panel.Foreground.RightSide",
		"Marker.Panel.Shadow.RightSide",
		"Marker.Panel.BackShadow.RightSide"
	}) do
		mMovie:OverrideMaterial(v23, _G.UIMaterial_Rectangle)
	end
end

local function fn3(_)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		__wf_atom_18a5d83b:Settings()
	end

	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(15724527)
	mMovie:__wf_atom_e57658c2("Marker.Callout", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Marker.CalloutMiddle", 11, 14079702)
	mMovie:__wf_atom_e57658c2("Marker.Instruction", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Marker.InstructionMiddle", 11, 14079702)
	mMovie:__wf_atom_e57658c2("Marker.HoldText", 11, 12628355)

	for _, v23 in ipairs({
		"Marker.Panel.Foreground.RightSide",
		"Marker.Panel.Shadow.RightSide",
		"Marker.Panel.BackShadow.RightSide"
	}) do
		mMovie:__wf_atom_1ca72041(
			v23,
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.7
		)
		mMovie:__wf_atom_1ca72041(
			v23,
			"RectEdgeColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			1
		)
	end

	for _, v23 in ipairs({
		"Marker.Panel.Foreground.LeftDeco",
		"Marker.Panel.Shadow.LeftDeco",
		"Marker.Panel.BackShadow.LeftDeco",
		"Marker.LeftBraceClip",
		"Marker.RightBraceClip",
		"Marker.Corona",
		"Marker.Circle"
	}) do
		mMovie:__wf_atom_e57658c2(v23, 11, 15724527)
	end

	mMovie:__wf_atom_e57658c2("Marker.Panel.Middle.RightSide", 11, 15724527)
	mMovie:__wf_atom_e57658c2("Marker.Panel.Middle.LeftDeco", 11, 15724527)
end

local function fn4()
	local v23

	if not __wf_atom_7e8ad928(statOwner) then
		v23 = statOwner:__wf_atom_4dc54686()
	end

	v4 = mMovie:__wf_atom_c7fa5e0c(v5, v23)
	local v24 = not __wf_atom_7e8ad928(contextAction) and contextAction:__wf_atom_eb56af55() > 0
	mMovie:__wf_atom_50d60589("Marker.Callout", 36, v4)
	local v25 = 0 + module.Ternary(v24, 8, 0)
	mMovie:__wf_atom_e57658c2("Marker.LauralLeft", 0, v21.LauralLeftX - v25)
	mMovie:__wf_atom_e57658c2("Marker.LauralRight", 0, v21.LauralRightX + v25)
	mMovie:__wf_atom_e57658c2("Marker.IconAid", 1, v21.IconAidY - 3)
	mMovie:__wf_atom_e57658c2("Marker.Callout", 1, v21.CalloutY + module.Ternary(v24, 10, 0))
end

local function fn5(p)
	local itemInstance = nil
	local v23 = nil

	if statOwner ~= nil then
		local v24 = contextAction

		if __wf_atom_7e8ad928(v24) or not v24:IsA(__wf_atom_9b8ab414) then
			if p ~= contextAction then
				if _T.InfoPopup_Data ~= nil and _T.InfoPopup_Data.ClearWeapon ~= nil then
					_T.InfoPopup_Data.ClearWeapon()
				end

				_T.InfoPopup_Data = nil
			end
		else
			itemInstance = v24:__wf_atom_a21478e7()

			if not __wf_atom_7e8ad928(itemInstance) then
				v23 = itemInstance:__wf_atom_37a29496()
			end
		end
	end

	if not __wf_atom_7e8ad928(contextAction) then
		local v24 = nil

		if __wf_atom_7e8ad928(itemInstance) or not itemInstance:IsA(__wf_atom_be6b4883) then
			if not __wf_atom_7e8ad928(v23) and v23:IsA(__wf_atom_38fa7c70) then
				v24 = v23:__wf_atom_05d4f0ef(statOwner)
			end
		else
			v24 = { itemInstance:__wf_atom_60763aad() }
		end

		if _T.InfoPopup_Data == nil or _T.InfoPopup_Data.ItemInstance == itemInstance then
			if _T.InfoPopup_Data == nil and v24 ~= nil then
				for _, v25 in ipairs(v24) do
					if __wf_atom_7e8ad928(v25.mItemType) then
						continue
					end

					local module3 = require("Lotus.Interface.StoreItemUtilities")
					local v26 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
					local mAspectInstance = v25.mAspectInstance
					local mQuality = v25.mQuality
					local mAspectFingerprint = v25.mAspectFingerprint

					if __wf_atom_72884638("SF.ScaleAspectsWithQuality") and mQuality - 1 > 1 then
						mAspectFingerprint = mAspectInstance:__wf_atom_b36d8955(mQuality - 2, mAspectFingerprint)
					end

					if __wf_atom_7e8ad928(mAspectInstance) then
						continue
					end

					if mItemType == v25.mItemType then
						break
					end

					asyncLoader:AbortLoad("WeaponType")
					mItemType = v25.mItemType
					local pickupItem = v25
					asyncLoader:LoadResource("WeaponType", v25.mItemType, function(p2)
						Resource(p2)

						if v12 ~= mAspectInstance:__wf_atom_1bb5b1ff() then
							v12 = mAspectInstance:__wf_atom_1bb5b1ff()
							asyncLoader:AbortLoad("AspectType")
							asyncLoader:LoadResource("AspectType", v12, function(p3)
								v12 = nil
								mItemType = nil

								if contextAction == nil then
									return
								end

								Resource(p3)
								mAspectInstance:__wf_atom_eaa00d7a(mAspectFingerprint)
								local _mItemType = pickupItem.mItemType
								local storeItemInfo = module3.GetStoreItemInfo(
									mMovie,
									v26:GetStoreItem(pickupItem.mItemType)
								)
								local v27 = {
									{
										mItemType = mAspectInstance:__wf_atom_1bb5b1ff()
									}
								}
								local module4 = require("SF.Interface.Libs.StatsUtil")
								local proxyWeapon, clearWeapon = module4.CreateProxyWeapon(
									nil,
									pickupItem.mItemType,
									0,
									v27,
									{ mAspectFingerprint },
									mQuality,
									nil,
									nil
								)
								local mShiny = pickupItem.mShiny
								proxyWeapon:__wf_atom_e4db3360(mQuality)

								if mShiny ~= nil then
									proxyWeapon:__wf_atom_07d75cec(mShiny)
								end

								storeItemInfo.HideAspects = true
								storeItemInfo.HideBasePage = true
								storeItemInfo.HideLevel = true
								storeItemInfo.InputFilter = statOwner:__wf_atom_4dc54686()
								storeItemInfo.StatWeapon = proxyWeapon
								storeItemInfo.ItemInstance = itemInstance
								storeItemInfo.StatOwner = statOwner
								storeItemInfo.PickupItem = pickupItem
								storeItemInfo.ContextAction = contextAction
								storeItemInfo.IsDismantle = true
								storeItemInfo.ResetCompare = true
								storeItemInfo.PreviewMode = true
								storeItemInfo.ClearWeapon = clearWeapon
								storeItemInfo.DisableCompare = true
								storeItemInfo.WeaponFingerprintForDismantle = mAspectFingerprint

								if not __wf_atom_7e8ad928((statOwner:__wf_atom_d2b2176d())) then
									local __wf_atom_0395f752 = proxyWeapon:__wf_atom_0395f752()
									storeItemInfo.StatCompareWeapon = statOwner:__wf_atom_d2b2176d():__wf_atom_28224c27(__wf_atom_0395f752)
								end

								storeItemInfo.mStatsToOnlyShow = {
									"MeleeSkill",
									"Era",
									"Quality",
									"Aspects"
								}

								if _T.InfoPopup_Data ~= nil and _T.InfoPopup_Data.ClearWeapon ~= nil then
									_T.InfoPopup_Data.ClearWeapon()
								end

								_T.InfoPopup_Data = storeItemInfo

								if _T.ShowItemInfoPopupCursor ~= nil then
									_T.ShowItemInfoPopupCursor(false)
								end
							end)
						end
					end)
					break
				end
			end

			if _T.InfoPopup_Data ~= nil then
				local v25 = mMovie:__wf_atom_5e6e15c8("Marker", 0) - mMovie:__wf_atom_5e6e15c8("Marker", 14) / 2
				local v26 = mMovie:__wf_atom_5e6e15c8("Marker", 1) - mMovie:__wf_atom_5e6e15c8("Marker", 15) / 2
				module2.SetItemInfoPopupRect(mMovie, _T.InfoPopup_Data, v25, v26, 275, 0, true)
			end
		else
			if _T.InfoPopup_Data.ClearWeapon ~= nil then
				_T.InfoPopup_Data.ClearWeapon()
			end

			_T.InfoPopup_Data = nil
		end
	end
end

function Update()
	if not v9 or __wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_084b3e93())

	if __wf_atom_7e8ad928(v) then
		local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()

		if #__wf_atom_e23b2855 > 0 then
			v = __wf_atom_e23b2855[1]
		end

		if __wf_atom_7e8ad928(v) then
			return
		else
			v3 = v:__wf_atom_301e8d97()
		end
	end

	if __wf_atom_7e8ad928(v3) then
		return
	end

	asyncLoader:Update()
	local __wf_atom_50a7d83e = v:__wf_atom_50a7d83e()
	local v23

	if statOwner == __wf_atom_50a7d83e then
		v23 = false
	else
		statOwner = __wf_atom_50a7d83e
		v23 = true
	end

	local v24 = v7 ~= v3:IsVisible()
	v7 = v3:IsVisible()
	local v25 = v24 or topMenuOpen ~= _T.TopMenuOpen
	topMenuOpen = _T.TopMenuOpen
	local v26 = nil
	local v27 = ""

	if
		not __wf_atom_7e8ad928(v3)
		and (not _G.StalkerMode or __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()))
	then
		for i = 1, v3:__wf_atom_54ac71ce() do
			v26 = v3:__wf_atom_e326c578(i - 1)
			v27 = v3:__wf_atom_1295635c(i - 1)
		end
	end

	if __wf_atom_7e8ad928(v26) and not __wf_atom_7e8ad928(contextAction) and count < 1 then
		count += 1
		return
	end

	if not __wf_atom_7e8ad928(v26) then
		count = 0
	end

	local v28 = contextAction

	if v23 or v25 or contextAction ~= v26 then
		contextAction = v26

		if contextAction == nil then
			if _T.InfoPopup_Data ~= nil and _T.InfoPopup_Data.ClearWeapon ~= nil then
				_T.InfoPopup_Data.ClearWeapon()
			end

			_T.InfoPopup_Data = nil
		end

		v16.Active = not __wf_atom_7e8ad928(contextAction) and contextAction:__wf_atom_ebfa5bc0()
		v15 = not __wf_atom_7e8ad928(contextAction) and contextAction:__wf_atom_ede3a0da() and not v16.Active
		local v29 = v3:IsVisible() and not (__wf_atom_7e8ad928(v26) or _T.TopMenuOpen)
		local v30 = string.len(v27) > 0
		local flag2 = false
		local v31 = { "Foreground", "Middle", "Shadow", "BackShadow" }
		local v32 = v6

		if not __wf_atom_7e8ad928(contextAction) then
			local attachEntity = contextAction

			if _T.InSimulacrum and not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_469b1d97) then
				v29 = false
			end

			if not __wf_atom_7e8ad928(reviveActionType) and contextAction:IsA(reviveActionType) then
				attachEntity = contextAction:__wf_atom_bddd20a6()

				if attachEntity == v:__wf_atom_eff0517e() then
					v29 = false
				end
			end

			if not __wf_atom_7e8ad928(finisherActionType) and contextAction:IsA(finisherActionType) then
				attachEntity = contextAction:__wf_atom_6ce58983()
				flag2 = true
			end

			local __wf_atom_d32e11f8 = contextAction:__wf_atom_d32e11f8()
			local __wf_atom_5af98d9c = contextAction:__wf_atom_5af98d9c()
			local __wf_atom_de04f4bc = contextAction:__wf_atom_de04f4bc()

			if not __wf_atom_7e8ad928(__wf_atom_de04f4bc) then
				attachEntity = __wf_atom_de04f4bc
			end

			if v16.Active then
				v16.AttachEntity = attachEntity
				v16.Offset = __wf_atom_d32e11f8
			end

			if not v16.Active then
				mMovie:__wf_atom_e57658c2("Marker", 0, 640)
				mMovie:__wf_atom_e57658c2("Marker", 1, 359.5)
			end

			__wf_atom_d32e11f8.x /= __wf_atom_5af98d9c.x
			__wf_atom_d32e11f8.y /= __wf_atom_5af98d9c.y
			__wf_atom_d32e11f8.z /= __wf_atom_5af98d9c.z
			local v36 = not __wf_atom_7e8ad928(attachEntity)
				and (not attachEntity:IsA(__wf_atom_0f45538d) or attachEntity:__wf_atom_81953aaa())
				and not v16.Active

			if not __wf_atom_7e8ad928(statOwner) and statOwner:__wf_atom_d2b2176d():__wf_atom_84479917() and flag2 then
				v36 = false
			end

			if v36 then
				mMovie:__wf_atom_8a679cf7(
					attachEntity,
					__wf_atom_d32e11f8,
					contextAction:__wf_atom_56ea4c0f(),
					contextAction:__wf_atom_5af98d9c()
				)
			else
				mMovie:__wf_atom_8a679cf7(nil, __wf_atom_28d5d4aa, __wf_atom_80368bb1, Vector(1, 1, 1))
			end

			if contextAction:__wf_atom_f2706bbf() then
				module.PlaySound(onEnterSound, contextAction:GetPosition())
			end

			if v18 ~= v36 then
				v18 = v36
				mMovie:OverrideMaterial("Marker.Callout", module.Ternary(v18, nil, _G.UIMaterial_PlainText))
				mMovie:OverrideMaterial("Marker.Instruction", module.Ternary(v18, nil, _G.UIMaterial_PlainText))
				mMovie:OverrideMaterial("Marker.HoldText", module.Ternary(v18, nil, _G.UIMaterial_PlainText))
				mMovie:OverrideMaterial(
					"Marker.Panel.Foreground.LeftDeco",
					module.Ternary(v18, nil, _G.UIMaterial_Plain)
				)
				mMovie:OverrideMaterial(
					"Marker.Panel.Foreground.RightSide",
					module.Ternary(v18, _G.UIMaterial_Rectangle, _G.UIMaterial_RectangleNoDepth)
				)
			end

			mMovie:__wf_atom_e57658c2(
				"Marker.HoldProgressBar",
				12,
				module.Ternary(contextAction:__wf_atom_eb56af55() > 0, 100, 0)
			)
			mMovie:__wf_atom_e57658c2("Marker.HoldProgressBar.Cap", 0, 0)
			mMovie:__wf_atom_e57658c2("Marker.HoldProgressBar.Fill", 14, 1)
			v19:__wf_atom_4453e49c(0)
			local __wf_atom_2c13a300 = contextAction:__wf_atom_2c13a300(statOwner)
			v6 = __wf_atom_2c13a300 ~= nil
			mMovie:__wf_atom_c90af43a("Marker.IconAid", __wf_atom_2c13a300)
		end

		if v32 ~= v6 then
			local ternary = module.Ternary(v6, 17, 18)
			mMovie:__wf_atom_e57658c2("Marker.Callout", 50, ternary)
			mMovie:__wf_atom_e57658c2("Marker.CalloutMiddle", 50, ternary)
			mMovie:__wf_atom_2dedec1a("Marker.IconAid", 13, v6)
			mMovie:__wf_atom_2dedec1a("Marker.LauralLeft", 13, false)
			mMovie:__wf_atom_2dedec1a("Marker.LauralRight", 13, false)
			mMovie:__wf_atom_2dedec1a("Marker.CalloutBg", 13, v6)
			mMovie:__wf_atom_2dedec1a("Marker.Instruction", 13, not v6 and v30)
			mMovie:__wf_atom_2dedec1a("Marker.InstructionMiddle", 13, not v6 and v30)
			mMovie:__wf_atom_2dedec1a("Marker.HoldText", 13, false)
			mMovie:__wf_atom_2dedec1a("Marker.Panel", 13, not v6 and v30)
			fn3(v6)
		end

		for i, v35 in ipairs(v13) do
			local v36 = { x = v14[i].x }

			if not v29 then
				v36.x += module.Ternary(i == 2, 20, -20)
			end

			__wf_atom_ec43d06e(
				mMovie,
				v35,
				1,
				{ 0, 12 },
				{ v36.x, module.Ternary(v29 and v18 and not v6, 100, 0) },
				0.15
			)
		end

		if v29 then
			mMovie:SetVisible(true)
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v27, false)
			local v36, v37 = string.find(v27, "^<..->")

			if v36 then
				v4 = string.sub(v27, v36, v37)
			elseif flag2 then
				v4 = "<MELEE>"
			elseif __wf_atom_7e8ad928(v26) or v26:__wf_atom_cb51d347() ~= 44 then
				v4 = "<USE>"
			else
				v4 = "<MELEE_HEAVY>"
			end

			local v38 = string.gsub(__wf_atom_8e9ac384, v4 .. " ", "")
			local v39 = string.gsub(v38, v4, "")
			local v40 = string.upper(v39)
			v5 = v4
			fn4()
			mMovie:__wf_atom_50d60589("Marker.Instruction", 36, v40)
			mMovie:__wf_atom_50d60589("Marker.InstructionMiddle", 36, v40)
			local v41 = mMovie:__wf_atom_5e6e15c8("Marker.Instruction", 40) * (mMovie:__wf_atom_5e6e15c8("Marker.Instruction", 5) / 100)

			if v40 == " " then
				v41 -= 14
			end

			__wf_atom_ec43d06e(mMovie, "Marker.Instruction", 2, { 12 }, { 100 }, 0.15, 0.07)
			__wf_atom_ec43d06e(mMovie, "Marker.HoldText", 2, { 12 }, { 100 }, 0.15, 0.07)
			__wf_atom_ec43d06e(mMovie, "Marker.Panel", 2, { 12 }, { 100 }, 0.15, 0.07)

			if not __wf_atom_7e8ad928(contextAction) and contextAction:__wf_atom_eb56af55() > 0 then
				__wf_atom_ec43d06e(mMovie, "Marker.HoldProgressBar", 2, { 12 }, { 100 }, 0.15, 0.07)
			end

			__wf_atom_ec43d06e(mMovie, "Marker.InstructionMiddle", 2, { 12 }, { 20 }, 0.15, 0.07)

			if v18 and not v6 then
				__wf_atom_ec43d06e(mMovie, "Marker.Circle", 2, { 12 }, { 100 }, 0.15, 0.07)
			end

			for _, v42 in ipairs(v31) do
				mMovie:__wf_atom_7f57ab2f("Marker.Panel." .. v42, "LeftDeco", 13, v18)
				__wf_atom_ec43d06e(mMovie, "Marker.Panel." .. v42 .. ".RightSide", 2, { 14 }, { v41 + 34 }, 0.15, 0.07)
			end

			fn()
			local v42 = module.Ternary(v10 == nil, 0, v10) + 1

			if not (__wf_atom_7e8ad928(markerFx[v42]) or __wf_atom_7e8ad928(statOwner) or __wf_atom_7e8ad928(statOwner:CameraControl()) or __wf_atom_7e8ad928(contextAction)) then
				local rootBasedPosition, v43 = module.GetRootBasedPosition(mMovie, "Marker")

				if contextAction:IsA(__wf_atom_a4796624) then
					local v44 = statOwner:EyePosition() + __wf_atom_e97f3142(statOwner:CameraControl():__wf_atom_9d937e7e()) * 1.5
					local __wf_atom_978a47cb = contextAction:__wf_atom_978a47cb(v44)
					__wf_atom_978a47cb.y = __wf_atom_978a47cb.y
					v20 = __wf_atom_978a47cb
				elseif contextAction:__wf_atom_96bf3d55() then
					local __wf_atom_d32e11f8 = contextAction:__wf_atom_d32e11f8()
					v20 = statOwner:EyePosition() + __wf_atom_9341614d(
						__wf_atom_d32e11f8,
						statOwner:CameraControl():__wf_atom_9d937e7e()
					)
				else
					v20 = mMovie:__wf_atom_09e83ac4(rootBasedPosition, v43)
				end
			end

			mMovie:__wf_atom_2dedec1a("Marker.Corona", 13, v18 and not v6)
		else
			if not __wf_atom_7e8ad928(_T.WeaponPickupDetailMovie) then
				_T.WeaponPickupDetailMovie:Close()
				_T.WeaponPickupDetailText = nil
			end

			__wf_atom_ec43d06e(mMovie, "Marker.Instruction", 2, { 12 }, { 0 }, 0.35, 0, function()
				mMovie:SetVisible(false)
			end)
			__wf_atom_ec43d06e(mMovie, "Marker.InstructionMiddle", 2, { 12 }, { 0 }, 0.15)
			__wf_atom_ec43d06e(mMovie, "Marker.HoldText", 2, { 12 }, { 0 }, 0.15)
			__wf_atom_ec43d06e(mMovie, "Marker.Circle", 2, { 12 }, { 0 }, 0.15, 0.07)
			__wf_atom_ec43d06e(mMovie, "Marker.Panel", 2, { 12 }, { 0 }, 0.15, 0.07)
			__wf_atom_ec43d06e(mMovie, "Marker.HoldProgressBar", 2, { 12 }, { 0 }, 0.15, 0.07)

			for _, v36 in ipairs(v31) do
				__wf_atom_ec43d06e(mMovie, "Marker.Panel." .. v36 .. ".RightSide", 2, { 14 }, { 100 }, 0.15, 0.07)
			end

			fn()
		end

		local ternary = module.Ternary(v29, 100, 0)

		for _, v36 in pairs({ "IconAid", "Callout", "LauralLeft", "LauralRight", "CalloutBg" }) do
			local v37

			if v36 == "CalloutBg" or v36 == "IconAid" then
				v37 = math.max(0, ternary - 30)
			else
				v37 = ternary
			end

			__wf_atom_ec43d06e(mMovie, "Marker." .. v36, 2, { 12 }, { v37 }, 0.35)
		end
	end

	if not __wf_atom_7e8ad928(contextAction) then
		local v29 = nil

		if __wf_atom_7e8ad928(v) or not contextAction:IsA(__wf_atom_a4796624) then
			if
				not __wf_atom_7e8ad928(statOwner)
				and contextAction:__wf_atom_96bf3d55()
				and not __wf_atom_7e8ad928(statOwner:CameraControl())
			then
				local __wf_atom_d32e11f8 = contextAction:__wf_atom_d32e11f8()
				v29 = statOwner:EyePosition() + __wf_atom_9341614d(
					__wf_atom_d32e11f8,
					statOwner:CameraControl():__wf_atom_9d937e7e()
				)
			end
		elseif not (__wf_atom_7e8ad928(statOwner) or __wf_atom_7e8ad928(statOwner:CameraControl())) then
			local v30 = statOwner:EyePosition() + __wf_atom_e97f3142(statOwner:CameraControl():__wf_atom_9d937e7e()) * 1.5
			v29 = contextAction:__wf_atom_978a47cb(v30, 0.5)
			v29.y -= 0.1
		end

		if v29 then
			local __wf_atom_5db877cc = contextAction:__wf_atom_5db877cc(v29)
			local __wf_atom_5af98d9c = contextAction:__wf_atom_5af98d9c()
			__wf_atom_5db877cc.x /= __wf_atom_5af98d9c.x
			__wf_atom_5db877cc.y /= __wf_atom_5af98d9c.y
			__wf_atom_5db877cc.z /= __wf_atom_5af98d9c.z
			mMovie:__wf_atom_143db918(__wf_atom_5db877cc)
			v20 = v29
		end

		if contextAction:__wf_atom_eb56af55() > 0 then
			local __wf_atom_9e368823 = v19:__wf_atom_9e368823()
			local v30 = 1 - contextAction:__wf_atom_cd5ba5d4()

			if v30 > 0 then
				v30 = 0.2 + v30 * 0.8

				if __wf_atom_9e368823 <= 0.01 then
					v19:__wf_atom_4453e49c(v30)
				end
			end

			v19.mSmoothTime = module.Ternary(__wf_atom_9e368823 < v30, 0, 0.15)
			v19:__wf_atom_09294a87(v30)
			v19:Update(__wf_atom_fa1258d0())
			mMovie:__wf_atom_e57658c2("Marker.HoldProgressBar.Fill", 14, v22.FillWidth * v19:__wf_atom_9e368823())
			mMovie:__wf_atom_e57658c2("Marker.HoldProgressBar.Cap", 0, v22.CapX * v19:__wf_atom_9e368823())
		end
	end

	if not (__wf_atom_7e8ad928(contextAction) or __wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(statOwner)) then
		local __wf_atom_7b82e9e1 = statOwner:__wf_atom_7b82e9e1(0)

		if v2 ~= __wf_atom_7b82e9e1 then
			v2 = __wf_atom_7b82e9e1
			__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { module.Ternary(v2, 15, 100) }, 0.15)
		end
	end

	if v15 then
		local cameraControl = v:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			mMovie:__wf_atom_1ce5c836()
			local __wf_atom_ad19244e = cameraControl:__wf_atom_ad19244e()
			local __wf_atom_8cdb5ac9 = mMovie:__wf_atom_8cdb5ac9()
			local ternary = module.Ternary(not __wf_atom_7e8ad928(contextAction), contextAction:__wf_atom_39e070da(), 0)

			if ternary > 0 and not __wf_atom_7e8ad928(__wf_atom_8cdb5ac9) then
				local v29 = __wf_atom_ad19244e - __wf_atom_8cdb5ac9:GetPosition()
				v29.y = 0
				Normalize(v29)
				local v30 = v29 * ternary
				local __wf_atom_2f2bada0 = __wf_atom_8cdb5ac9:__wf_atom_2f2bada0()
				local v31 = __wf_atom_9341614d(
					v30,
					Rotation(-__wf_atom_2f2bada0.heading, -__wf_atom_2f2bada0.pitch, -__wf_atom_2f2bada0.bank)
				) + contextAction:__wf_atom_d32e11f8()
				mMovie:__wf_atom_143db918(v31)

				if not __wf_atom_7e8ad928(v20) then
					v20 = contextAction:GetPosition() + v30 + contextAction:__wf_atom_d32e11f8()
				end
			elseif not __wf_atom_7e8ad928(v20) then
				local rootBasedPosition, v29 = module.GetRootBasedPosition(mMovie, "Marker")
				v20 = mMovie:__wf_atom_09e83ac4(rootBasedPosition, v29)
			end

			local __wf_atom_d1ff0128 = mMovie:__wf_atom_d1ff0128()
			local v29 = __wf_atom_ad19244e - mMovie:__wf_atom_1ce5c836()
			v29.y = 0
			Normalize(v29)
			local v30 = math.atan2(v29.z, v29.x)
			local v31 = 360 - (module.ToDeg(v30) + 90 + __wf_atom_d1ff0128.heading)
			mMovie:__wf_atom_e57658c2("Marker", 17, v31 % 360)
		end
	else
		if not __wf_atom_7e8ad928(v20) then
			local rootBasedPosition, v29 = module.GetRootBasedPosition(mMovie, "Marker")
			v20 = mMovie:__wf_atom_09e83ac4(rootBasedPosition, v29)
		end

		if not __wf_atom_7e8ad928(v26) then
			mMovie:__wf_atom_e57658c2("Marker", 17, 0)
		end
	end

	if __wf_atom_7e8ad928(mMovie:__wf_atom_7be51ede()) and not __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) then
		mMovie:__wf_atom_8fcdea81(gRegion:__wf_atom_eab484a7())
	end

	if v16.Active and not __wf_atom_7e8ad928(v16.AttachEntity) then
		local position = v16.AttachEntity:GetPosition()
		local __wf_atom_a06d543c = v16.AttachEntity:__wf_atom_a06d543c()
		local __wf_atom_acb19668 = v16.AttachEntity:__wf_atom_acb19668()
		local v29 = __wf_atom_edfe0d73(__wf_atom_acb19668, __wf_atom_a06d543c)
		local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(position + v29 * v16.Offset.x + __wf_atom_acb19668 * v16.Offset.y + __wf_atom_a06d543c * v16.Offset.z)
		mMovie:__wf_atom_e57658c2("Marker", 0, __wf_atom_74b9a49b.x - 51)
		mMovie:__wf_atom_e57658c2("Marker", 1, __wf_atom_74b9a49b.y)
	end

	if not __wf_atom_7e8ad928(v20) then
		if __wf_atom_7e8ad928(v17) then
			if flag then
				local v29 = module.Ternary(v10 == nil, 0, v10) + 1
				v17 = gRegion:CreateEntity(markerFx[v29], v20, __wf_atom_80368bb1)
				flag = false
			end
		else
			v17:SetPosition(v20)
		end
	end

	fn5(v28)
end

function Initialize()
	v = mMovie:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(v) then
		v3 = v:__wf_atom_301e8d97()

		if __wf_atom_7e8ad928(v3) then
			v = nil
		end
	end

	contextAction = nil
	count = 0
	v11[0] = "StopNormal"
	v11[1] = "StopGrineer"
	v11[2] = "StopCorpus"
	v11[3] = "StopTeshin"
	v11[4] = "StopDrifter"
	mMovie:__wf_atom_c90af43a("Marker.LauralLeft", lauralIcon)
	mMovie:__wf_atom_c90af43a("Marker.LauralRight", lauralIcon)
	mMovie:__wf_atom_c90af43a("Marker.CalloutBg", calloutBg)
	mMovie:__wf_atom_50d60589(
		"Marker.HoldText",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Actions/HoldPrompt", false)
	)
	v21.LauralLeftX = mMovie:__wf_atom_5e6e15c8("Marker.LauralLeft", 0)
	v21.LauralRightX = mMovie:__wf_atom_5e6e15c8("Marker.LauralRight", 0)
	v21.IconAidY = mMovie:__wf_atom_5e6e15c8("Marker.IconAid", 1)
	v21.CalloutY = mMovie:__wf_atom_5e6e15c8("Marker.Callout", 1)
	v22.CapX = mMovie:__wf_atom_5e6e15c8("Marker.HoldProgressBar.Cap", 0)
	v22.FillWidth = 253
	fn2()
	v8 = 128 / 89
	mMovie:__wf_atom_2dedec1a("Marker.Corona", 13, false)
	v9 = true

	function _T.GetActiveContextAction()
		return contextAction
	end
end

function OnGamepadTransition(_)
	fn4()
end