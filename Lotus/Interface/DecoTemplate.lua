local v = nil
local v2 = 0
local v3 = nil
local v4 = false
local mPulseBG = nil
local v5 = Symbol("CloakHDR")
local v6 = Symbol("CloakVector")
local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("EE.Interface.AnchorMgr")
local v7 = Resource("/Lotus/StoreItems/Types/StoreItems/SlotItems/DecorationTemplateSlotItem")
local v8 = nil
local v9 = nil
local flag = false
local v10 = true
local v11 = nil
local v12 = {}
local v13 = 0
local v14 = nil
local v15 = false
local v16 = true
local flag2 = false
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = { Loader = nil, Pass = 1 }
local v27 = Symbol("Cloak")
local v28 = Symbol("GAME_C1_HEAD1")

function IsInputBlocked()
	return v10
end

local function fn(object, data, data2)
	object:SetMaterialParam(v6, data2.x, data2.y, data2.z, 1)
	object:SetMaterialParam(v5, data.red / 255, data.green / 255, data.blue / 255, 1)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

	for i = 1, #__wf_atom_f582136d do
		__wf_atom_f582136d[i]:SetMaterialParam(v5, data.red / 255, data.green / 255, data.blue / 255, 1)
		__wf_atom_f582136d[i]:SetMaterialParam(v6, data2.x, data2.y, data2.z, 1)
	end
end

local function fn2(object, object2, p)
	local v29 = Color(47, 175, 209, 255)
	local v30 = Vector()

	if __wf_atom_7e8ad928(object) then
		if not __wf_atom_7e8ad928(object2) then
			v30 = object2:__wf_atom_1c374cc9(v28)
		end
	else
		v30 = object:__wf_atom_1c374cc9(v28)
	end

	if not __wf_atom_7e8ad928(object) then
		fn(object, v29, v30)
	end

	if not __wf_atom_7e8ad928(object2) then
		fn(object2, v29, v30)
	end

	if p then
		object2:SetVisibility(false)
	else
		__wf_atom_ec43d06e(mMovie, "Title", 0, { function(p2)
				if not __wf_atom_7e8ad928(object) then
					object:__wf_atom_a763aa1a(1 - p2)
					object:SetMaterialParam(v27, 1 - p2)
				end

				if not __wf_atom_7e8ad928(object2) then
					object2:__wf_atom_a763aa1a(p2)
					object2:SetMaterialParam(v27, p2)
				end
			end }, { 1 }, 0.75, 0, function()
			if not __wf_atom_7e8ad928(object2) then
				object2:SetVisibility(false)
			end
		end)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_a763aa1a(0)
		object:SetMaterialParam(v27, 0)
		object:SetVisibility(true)
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_a763aa1a(1)
		object2:SetMaterialParam(v27, 1)
	end
end

local function fn3()
	if not __wf_atom_7e8ad928(gGameData) then
		gGameData:__wf_atom_db805641("OnFetchDecoTemplates")
	end
end

local function fn4()
	if __wf_atom_7e8ad928(__wf_atom_392793db) then
		return
	end

	local v29 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Kubrow2"))[1]
	local position = Vector(0, 2, 0)
	local v30 = Rotation(0, 90, 0)

	if not __wf_atom_7e8ad928(v29) then
		position = v29:GetPosition()
		v30 = v29:__wf_atom_dc309f8a()
	end

	local __wf_atom_ed00321d = v11:__wf_atom_ed00321d()

	if not __wf_atom_7e8ad928(__wf_atom_ed00321d) then
		for i = #v12 + 1, #__wf_atom_ed00321d do
			local v31 = __wf_atom_ed00321d[i]
			local v32

			if not __wf_atom_7e8ad928(v31:__wf_atom_1bb5b1ff()) then
				v32 = __wf_atom_392793db:CreateEntity(v31:__wf_atom_1bb5b1ff(), position, v30)

				if not __wf_atom_7e8ad928(v32) then
					v31:__wf_atom_dcaedf35(v32)
					v32:Teleport(position, v30)
					v32:__wf_atom_ee6dbcd7(1, 1, 0.75)
					v32:__wf_atom_a763aa1a(1)
				end
			end

			table.insert(v12, v32)
		end
	end
end

local function fn5(p, list, p2)
	if p2[p] == nil then
		p2[p] = true
		table.insert(list, p)
	end
end

local function fn6()
	local v29 = {}
	local v30 = {}

	if v26.Pass == 1 then
		for i = 1, 2 do
			local v31 = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("Kubrow" .. tostring(i)))[1]

			if not __wf_atom_7e8ad928(v31) then
				v31:SetVisibility(false)
			end
		end

		local __wf_atom_ed00321d = v11:__wf_atom_ed00321d()

		if not __wf_atom_7e8ad928(__wf_atom_ed00321d) then
			for _, v31 in ipairs(__wf_atom_ed00321d) do
				if not __wf_atom_7e8ad928(v31:__wf_atom_1bb5b1ff()) then
					fn5(v31:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b(), v29, v30)
				end
			end
		end
	end

	v26.Loader = UISys.__wf_atom_c0dbe47c(v29)
end

local function fn7(dioramaRes)
	local level = nil

	if __wf_atom_7e8ad928(dioramaRes) or not dioramaRes:IsA(__wf_atom_663b0d2f) then
		if not __wf_atom_7e8ad928(dioramaRes) then
			level = dioramaRes:GetInfo().level
		end
	else
		level = dioramaRes
	end

	v10 = true

	if level == v3 then
		return
	end

	v3 = level
	v4 = true
	v:LoadDiorama(level)
end

local function fn8(p)
	_T.mPulseBG = mPulseBG

	if mPulseBG == nil then
		return
	end

	local v29 = mPulseBG < 0
	mPulseBG += p * 4

	if v29 and mPulseBG > 0 then
		mPulseBG = 0
		__wf_atom_8e4fda44:__wf_atom_62a19abc()
		v3 = nil
	end

	if mPulseBG > 1 then
		mPulseBG = nil
		mMovie:__wf_atom_0cf0fdbe(0)
	else
		mMovie:__wf_atom_0cf0fdbe(1 - math.abs(mPulseBG))
	end
end

local function fn9(p)
	fn8(p)

	if v4 and v:LoadingComplete() then
		if v2 == 1 and v14 ~= nil and v14:GetHowManyElements() > 0 then
			v4 = false
			v:FinishLoad()
			fn6()
			__wf_atom_ec43d06e(mMovie, "ImprintPanel", 0, { 12 }, { 100 }, 0.15)
		else
			v2 = 1
			mMovie:__wf_atom_0cf0fdbe(v2)
			return
		end
	end

	if not mPulseBG and v2 > 0 then
		v2 = math.max(0, v2 - __wf_atom_fa1258d0() * 1)
		mMovie:__wf_atom_0cf0fdbe(v2)
	end
end

local function fn10()
	v15 = true
	module.RegisterHideHud(false)

	if not __wf_atom_7e8ad928(__wf_atom_392793db) then
		for i = 1, #v12 do
			__wf_atom_392793db:__wf_atom_dd1e4d10(v12[i])
		end

		v12 = nil
	end

	if
		__wf_atom_7e8ad928(v22)
		and __wf_atom_7e8ad928(v24)
		and not (__wf_atom_7e8ad928(v19) or __wf_atom_7e8ad928(_T[v19]))
	then
		_T[v19]()
	end
end

function Shutdown()
	if not v15 then
		fn10()
	end
end

local function fn11()
	v10 = true
	module2.PlaySound(_G.UISound_Close)

	if not v15 then
		fn10()
	end

	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.25, 0, function()
		if v22 and not (__wf_atom_7e8ad928(v21) or __wf_atom_7e8ad928(_T[v21])) then
			if __wf_atom_7e8ad928(_T.DojoMgr) then
				_T[v21](v22)
			else
				_T[v21](v22, v23)
			end
		elseif v24 and not (__wf_atom_7e8ad928(v20) or __wf_atom_7e8ad928(_T[v20])) then
			_T[v20](v24)
		elseif not (__wf_atom_7e8ad928(v17) or __wf_atom_7e8ad928(_T[v17])) then
			_T[v17]()
		end

		_T.DecoTemplatePreviewOpen = false
		mMovie:Close()
	end)
end

function SetTrigger(mTrigger)
	_T.mTrigger = mTrigger
	return true
end

local function fn12()
	if not __wf_atom_7e8ad928(v12[v13]) then
		fn2(nil, v12[v13], false)
	end

	_T.SetButtons(mMovie, nil)

	if v3 then
		v3 = nil
		mPulseBG = -1
		fn8(__wf_atom_084b3e93())
		__wf_atom_8e4fda44:__wf_atom_62a19abc()
	end

	fn11()
end

function TransitionOut()
	fn12()
end

local function fn13(p)
	module2.PlaySound(_G.UISound_Select)
	local v29 = v12[v13]
	v13 = p
	fn2(v12[v13], v29, false)
end

function ShowImprint(p)
	fn13(p)
end

local function fn14()
	if not __wf_atom_7e8ad928(v11) then
		local __wf_atom_ed00321d = v11:__wf_atom_ed00321d()

		if __wf_atom_7e8ad928(__wf_atom_ed00321d) then
			v10 = false
			v25:SetActive(false)

			if flag2 then
				flag2 = false
			else
				module2.ShowMessage(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplatesEmpty", false),
					"Close"
				)
			end
		else
			for i = v14:GetHowManyElements() + 1, #__wf_atom_ed00321d do
				local v29 = __wf_atom_ed00321d[i]
				local v30 = { id = v29:__wf_atom_854e0028(), name = v29:GetName() }
				v14:AddElement({ ImprintId = i, id = v30.id, LocTag = v30.name, Name = v30.name }, true)
			end
		end

		v14:Redraw(nil, true, true)
		v14:RepositionElements()
	end
end

local function fn15()
	if __wf_atom_7e8ad928(v14) or v14.mFocusedMenuElement == nil or v14.mFocusedMenuElement.Id > #v12 then
		return
	end

	local __wf_atom_ed00321d = v11:__wf_atom_ed00321d()

	if __wf_atom_7e8ad928(__wf_atom_ed00321d) or v14.mFocusedMenuElement.Id > #v12 then
		return
	end

	if not __wf_atom_7e8ad928(gGameData) then
		v22 = __wf_atom_ed00321d[v14.mFocusedMenuElement.Id]

		if __wf_atom_7e8ad928(_T.DojoMgr) then
			if not __wf_atom_7e8ad928(mMovie) then
				mMovie:Execute("QueueDecoPurchase", "")
			end
		else
			local mFocusedMenuElement = v14.mFocusedMenuElement
			v23 = {
				StoreItem = nil,
				Count = mFocusedMenuElement.Count,
				IsVault = mFocusedMenuElement.VaultDeco,
				IsGroupedDeco = true,
				Name = mFocusedMenuElement.Name
			}
			fn12()
		end
	end
end

function OnQueueDecoPurchase(p, p2)
	if p and not __wf_atom_7e8ad928(p2) then
		local decoded = cjson.decode(p2)

		if next(decoded) == nil then
			fn12()
			return
		end

		v23 = nil
		v22 = nil
		local v29 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplateMissingParts", false) .. "\n"

		for k, v30 in pairs(decoded) do
			v29 ..= k

			if v30 > 1 then
				v29 ..= " (x" .. v30 .. ")\n"
			end
		end

		module2.ShowMessage(v29)
	else
		module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplateMissingParts", false) .. "\n" .. p2)
		v23 = nil
		v22 = nil
	end
end

function QueueDecoPurchase()
	if not (__wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(gGameRules)) then
		local __wf_atom_ed00321d = v11:__wf_atom_ed00321d()

		if __wf_atom_7e8ad928(__wf_atom_ed00321d) then
			return
		end

		if #__wf_atom_ed00321d >= v14.mFocusedMenuElement.Id then
			v22 = __wf_atom_ed00321d[v14.mFocusedMenuElement.Id]

			if not __wf_atom_7e8ad928(v22) then
				local shipDecoRoom, _, v29 = module.GetShipDecoRoom()
				gGameRules:__wf_atom_9254e7e6(shipDecoRoom, v29, v22, "OnQueueDecoPurchase")
			end
		end
	end
end

function OnDeleteDecoTemplate(p, _)
	if p and not (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(v11)) then
		__wf_atom_392793db:__wf_atom_dd1e4d10(v12[v14.mFocusedMenuElement.Id])
		v14:RemoveElementById(v14.mFocusedMenuElement.Id, true, true)
		v12[v14.mFocusedMenuElement.Id] = nil
		v14.mFocusedMenuElement = nil

		if __wf_atom_7e8ad928((v11:__wf_atom_5e0f1518(v24))) then
			module2.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplatesEmpty", false),
				"TransitionOut"
			)
		else
			v14:Redraw(nil, true, true)
			v14:RepositionElements()
		end
	end

	v24 = nil
end

function DeleteDecoTemplateConfirm(p)
	if tonumber(p) == 4 then
		gGameData:__wf_atom_c4498642(v24, "OnDeleteDecoTemplate")
	end
end

function DeleteDeco()
	if
		__wf_atom_7e8ad928(v11)
		or __wf_atom_7e8ad928(v14)
		or v14.mFocusedMenuElement == nil
		or v14.mFocusedMenuElement.Id > #v12
	then
		return
	end

	local __wf_atom_ed00321d = v11:__wf_atom_ed00321d()

	if __wf_atom_7e8ad928(__wf_atom_ed00321d) or v14.mFocusedMenuElement.Id > #__wf_atom_ed00321d then
		return
	end

	v24 = __wf_atom_ed00321d[v14.mFocusedMenuElement.Id]:__wf_atom_854e0028()
	module2.ShowMessage(
		mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplateConfirmDelete", false),
		"DeleteDecoTemplateConfirm",
		1
	)
end

local function fn16(value)
	if value == nil or value == "" then
		module2.ShowMessage("/Lotus/Language/Menu/Loadout_InvalidName", "TransitionOut")
		return false
	end

	local v29 = module2.Alphanumeric() .. module2.Punctuation() .. " "

	if __wf_atom_d9227398() then
		v29 ..= module2.ValidChinese()
	end

	local v30 = __wf_atom_932a80f8(value, v29)

	if v30 > 0 then
		module2.ShowMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(value, v30, v30),
			"TransitionOut"
		)
		return false
	end

	if string.len(value) > 24 then
		module2.ShowMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_TooLong", false),
			"TransitionOut"
		)
		return false
	end

	local v31 = __wf_atom_bb4529ac(value)

	if __wf_atom_f8f86fc5(v31, 1) == v31 then
		return true, v31
	end

	module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Generic_Name_CENSORED", false), "TransitionOut")
	return false
end

local function fn17(p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local v29, _ = fn16(p)

	if v29 and not __wf_atom_7e8ad928(_T.DecoTemplateRoot) then
		_T.decoTemplate = gGameData:__wf_atom_6dd6e51a(_T.DecoTemplateRoot, p)
		gGameData:__wf_atom_305cbfef(_T.decoTemplate, "OnUploadDecoTemplate")
	end
end

function NameDecoTemplate(p, _, p2)
	if not __wf_atom_7e8ad928(p2) and tonumber(p2) == 4 then
		fn17(p)
	end
end

function OSKNameDecoTemplate(p, p2)
	if not p then
		fn17(p2)
	end
end

function OnUploadDecoTemplate(p, p2)
	if not __wf_atom_7e8ad928(v11) then
		if p then
			local decoded = cjson.decode(p2)

			if __wf_atom_7e8ad928(decoded.error) then
				if not __wf_atom_7e8ad928(decoded["$oid"]) then
					v11:__wf_atom_df00d10a(decoded["$oid"])
					fn4()
					fn14()
				end
			else
				v11:__wf_atom_76e26628()

				if decoded.error == 1 then
					module2.ShowMessage(
						mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplateOutOfSlots", false),
						"TransitionOut"
					)
				elseif decoded.error == 2 then
					module2.ShowMessage(
						mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplateSlotsFull", false),
						"TransitionOut"
					)
				else
					module2.ShowMessage(
						mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplateUploadError", false),
						"TransitionOut"
					)
				end
			end
		else
			v11:__wf_atom_76e26628()
			module2.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplateUploadError", false),
				"TransitionOut"
			)
		end
	end
end

local function fn18(p, p2)
	if not p then
		print("error: " .. p2)
	end
end

local function fn19()
	local v29 = {}

	if not __wf_atom_7e8ad928(v7) then
		local isXPLocked, _ = module.IsXPLocked(v7)
		local v30, v31

		if isXPLocked then
			v31 = "/Lotus/Language/Menu/Item_CannotPurchaseXPLocked"
		else
			v31 = "/Lotus/Language/Menu/Global_BuyItem"
		end

		local v32 = __wf_atom_c67f9605:__wf_atom_6d03a710()
			and "/Lotus/Language/Menu/DetailedPurchase_NewBuild_Short"
			or v31

		if __wf_atom_7e8ad928(nil) and not __wf_atom_7e8ad928(gGameRules) then
			gGameRules:__wf_atom_964056fd()
			v11:GetInventory()
		end

		local __wf_atom_ee4fa4fd = v7:__wf_atom_ee4fa4fd(0)
		local __wf_atom_8c904c63 = v7:__wf_atom_8c904c63(0)
		local _ = __wf_atom_ee4fa4fd > 0

		if __wf_atom_8c904c63 > 0 then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v32, true)

			if Engine.IsPlayingWithController() then
				__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<MENU_SELECT>", true) .. " " .. __wf_atom_8e9ac384
			end

			local function fn20(p, p2)
				fn18(p, p2)
			end

			table.insert(v29, {
				Label = mMovie:__wf_atom_8e9ac384(__wf_atom_8e9ac384, false),
				CallBack = function()
					_T.BuyItem(v7, fn20, 1)
				end,
				CallOut = ""
			})
		end
	end

	if v16 and not __wf_atom_7e8ad928(v14) and v14.mFocusedMenuElement ~= nil then
		table.insert(v29, {
			Label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplateDelete", false),
			CallBack = function()
				mMovie:Execute("DeleteDeco", "")
			end,
			CallOut = ""
		})
		table.insert(v29, {
			Label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DecoTemplatePlace", false),
			CallBack = fn15,
			CallOut = "MENU_SELECT"
		})
	end

	table.insert(v29, {
		Label = "/Lotus/Language/Menu/Exit",
		CallBack = fn12,
		CallOut = "MENU_CANCEL"
	})
	_T.SetButtons(mMovie, v29, getfenv(1))
end

function EntryFocused(p)
	if not __wf_atom_7e8ad928(v14) then
		v14:FocusElementById((tonumber(p)))
	end
end

function EntryUnfocused(p)
	if not __wf_atom_7e8ad928(v14) then
		v14:UnfocusElementById((tonumber(p)))
	end
end

function EntryPressed(p)
	if not (v10 or __wf_atom_7e8ad928(v14)) then
		v14:SelectElementById((tonumber(p)))
	end
end

function Update()
	if not flag or __wf_atom_7e8ad928(mMovie) then
		return
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:Update(__wf_atom_fa1258d0())
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v14.mScrollBar) then
		v14.mScrollBar:Update(__wf_atom_fa1258d0())
	end

	if not __wf_atom_7e8ad928(v26.Loader) and v26.Loader:__wf_atom_86399a47() then
		v26.Loader = nil

		if v26.Pass == 1 then
			v26.Pass = 2
			fn6()
		else
			fn4()
			v10 = false
			v25:SetActive(false)
			v14:SelectElement(1)
		end
	end

	fn9(__wf_atom_084b3e93())
end

local function fn20()
	local module4 = require("EE.Interface.Components.List")
	v14 = module4.CreateList(mMovie, "ImprintPanel.Item1")
	v14:SetCallbacks("MenuItemSelected", "MenuItemFocused", "MenuItemUnfocused", "MenuItemPressed")
	v14.mForcedVerticalSeparation = 160
	v14.mVisibleElements = 5
	v14:AttachScrollBar("ImprintPanel.ScrollBar", -17)
	v14:EnableSmoothScroll()
	v14.mWrapAroundNavigation = false

	function v14.mElementDrawCallback(data)
		local v29

		if v14.mFocusedMenuElement == nil then
			v29 = false
		else
			v29 = v14.mFocusedMenuElement.Id == data.Id
		end

		mMovie:__wf_atom_48bd5a59(data.mClipName, "NameTag.Label", 46, "bottom")
		mMovie:__wf_atom_7d7314f1(data.mClipName .. ".NameTag.Label.text", data.LocTag, {
			NAME = module2.Ternary(data.Name == "", nil, string.upper(data.Name))
		})
		mMovie:__wf_atom_4c1c1986(
			data.mClipName,
			"NameTag.Bg",
			15,
			mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".NameTag.Label", 41) + 14
		)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "NameTag.Label", 44, _G.UIColor_Black)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 12, module2.Ternary(v29, 50, 20))
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Image", 13, false)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "KubrowTypeIcon", 13, false)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "KubrowGenderIcon", 13, false)
		local v30

		if v14:GetFocusedElement() == nil then
			v30 = false
		else
			v30 = v14:GetFocusedElement().Id == data.Id
		end

		mMovie:__wf_atom_4c1c1986(data.mClipName, "Outline", 12, module2.Ternary(v30, 90, 15))
		mMovie:__wf_atom_4c1c1986(
			data.mClipName,
			"Outline",
			11,
			module2.Ternary(v30, _G.UIColor_Yellow, _G.UIColor_White)
		)
		mMovie:__wf_atom_4c1c1986(
			data.mClipName,
			"NameTag.Bg",
			11,
			module2.Ternary(v30, _G.UIColor_Yellow, _G.UIColor_White)
		)
	end

	function v14.mOnFocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		module2.PlaySound(_G.UISound_Focus)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "NameTag.Bg", 11, _G.UIColor_Yellow)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Outline", 12, 90)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Outline", 11, _G.UIColor_Yellow)
	end

	function v14.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_4c1c1986(p.mClipName, "NameTag.Bg", 11, _G.UIColor_White)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Outline", 12, 15)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Outline", 11, _G.UIColor_White)
	end

	function v14.mOnSelectedCallback(mFocusedMenuElement)
		if v14.mFocusedMenuElement ~= nil and v14.mFocusedMenuElement.mClipName ~= nil then
			if v14.mFocusedMenuElement.Id == mFocusedMenuElement.Id then
				local v29 = Time()

				if v16 and (Engine.IsPlayingWithController() or v29 - v14.mPressTime < 0.5) then
					v14.mPressTime = 0
					fn15()
				end

				v14.mPressTime = Time()
				return
			else
				mMovie:__wf_atom_4c1c1986(v14.mFocusedMenuElement.mClipName, "Bg", 12, 20)
			end
		end

		v14.mPressTime = Time()
		local v29 = v16
		v14.mFocusedMenuElement = mFocusedMenuElement

		if v29 then
			fn19()
		end

		if mFocusedMenuElement.mClipName ~= nil then
			mMovie:__wf_atom_4c1c1986(mFocusedMenuElement.mClipName, "Bg", 12, 50)
		end

		fn13(mFocusedMenuElement.Id)
		module2.PlaySound(_G.UISound_Select)
	end

	function v14.mOnPressedCallback(_)
		module2.PlaySound(_G.UISound_Select)
	end

	function v14:RepositionElements()
		mMovie:__wf_atom_e57658c2(
			"ImprintPanel.BottomCap",
			1,
			math.min(self:GetHowManyElements(), self:GetHowManyVisibleElements()) * self.mForcedVerticalSeparation + 12
		)
	end

	v14._ImprintMenu_CalculateX = v14.CalculateX

	function v14.CalculateX(object, p)
		local imprintMenu_CalculateX = object:_ImprintMenu_CalculateX(p)

		if object:GetHowManyElements() <= object.mVisibleElements then
			imprintMenu_CalculateX += 10
		end

		return imprintMenu_CalculateX
	end
end

function OnFetchDecoTemplates(_, _)
	fn14()
end

local function fn21()
	if __wf_atom_7e8ad928(v14) then
	end
end

function Initialize(_)
	if flag then
		return
	end

	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v9 = module4.CreateTimerMgr()
	_T.DecoTemplatePreviewOpen = true
	module.RegisterHideHud(true)
	v8 = module3.Create(mMovie)
	v8:Register(mMovie, "ImprintPanel", { v8.ANCHOR_H_RIGHT, v8.ANCHOR_V_CENTRE })
	v8:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())

	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		v11 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	end

	fn19()
	module2.PlaySound(_G.UISound_Open)

	if v == nil then
		local module5 = require("Lotus.Interface.Libs.DioramaLoader")
		v = module5.CreateDioramaLoader(mMovie)
	end

	mMovie:__wf_atom_7d7314f1("Title.text", "")
	local module5 = require("Lotus.Interface.Components.ThemedSpinner")
	v25 = module5.Create(mMovie, "Spinner")
	v25:SetActive(true)
	mMovie:__wf_atom_e57658c2("ImprintPanel", 12, 0)
	fn20()
	fn3()
	fn21()
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 100 }, 0.25)
	flag = true
	mMovie:__wf_atom_0cf0fdbe(0)

	if not __wf_atom_7e8ad928(dioramaRes) then
		fn7(dioramaRes)
	end
end

function SetSavingNewTemplate()
	flag2 = true
end

function Close()
	fn11()
end

function onKeyDown_HIDE_PAUSE_MENU()
	if not v10 and _T.DecoTemplatePreviewOpen then
		fn11()
	end

	return false
end

function onKeyDown_MENU_SELECT()
	if not v10 and v16 then
		fn15()
	end
end

function onViewportSizeChanged(p, p2)
	fn21()

	if not __wf_atom_7e8ad928(v8) then
		v8:Update(p, p2)
	end
end

function RollOver()
	module2.PlaySound(_G.UISound_Focus)
end

function MenuItemFocused(p)
	if not __wf_atom_7e8ad928(v14) then
		v14:FocusElementById((tonumber(p)))
	end
end

function MenuItemUnfocused(p)
	if not __wf_atom_7e8ad928(v14) then
		v14:UnfocusElementById((tonumber(p)))
	end
end

function MenuItemSelected(p)
	if not (v10 or __wf_atom_7e8ad928(v14)) then
		v14:SelectElementById(tonumber(p), true)
	end
end

function MenuItemPressed(p)
	if not (v10 or __wf_atom_7e8ad928(v14)) then
		v14:PressedElementById((tonumber(p)))
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if v14 ~= nil then
		local mScrollBar = v14.mScrollBar

		if not (v10 or __wf_atom_7e8ad928(mScrollBar)) then
			mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
		end
	end
end

function SetSelectionMode(p)
	v16 = p == "true"
	fn19()
end

function SetCallback(p)
	v17 = p
end

function SetElementsFunction(p)
	v18 = p
end

function SetOnTransitionOutFunction(p)
	v19 = p
end

function SetOnPlaceDecoTemplateFunction(p)
	v21 = p
end

function SetOnDeleteDecoTemplateFunction(p)
	v20 = p
end

function SetTitle(p)
	mMovie:__wf_atom_7d7314f1("Title.text", p)
end