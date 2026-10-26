module(..., package.seeall)
local module = require("Lotus.Interface.ModularWeaponUtilities")
local v = WeakResource("/Lotus/Types/Vehicles/Hoverboard/HoverboardSuit")

local function fn(p) -- 3 equivalent calls inferred from this helper
	return p ~= 4
end

function ProcessColorSlot(p)
	return fn(p) -- inferred equivalent call
end

local function fn2(object, p) -- 5 equivalent calls inferred from this helper
	if not p or p == "" then
		return
	end

	local v2 = tonumber(p, 16)

	if v2 == 0 or __wf_atom_7e8ad928(object) or object:Size() < v2 then
		return
	else
		return object:GetStoreItemById(v2)
	end
end

function GetStoreItemFromLink(value)
	if __wf_atom_7e8ad928(gGameRules) then
		return
	end

	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

	if __wf_atom_7e8ad928(__wf_atom_964056fd) then
		return
	end

	local v2 = string.find(value, "|")

	if not v2 then
		return
	end

	local v3 = string.find(value, "|", v2 + 1)

	if not v3 then
		return
	end

	return fn2(__wf_atom_964056fd, string.sub(value, v2 + 1, v3 - 1))
end

local function fn3(object, mItem, p, p2, p3)
	local mItemType = mItem.mItemType
	local v2

	if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(object) then
		v2 = ""
	else
		local __wf_atom_dcd9f6f8 = object:__wf_atom_dcd9f6f8(mItemType)
		v2 = __wf_atom_dcd9f6f8 == 0 and "" or string.format("%X", __wf_atom_dcd9f6f8)
	end

	if v2 == "" then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v3 = p .. "-" .. (__wf_atom_7e8ad928(__wf_atom_18a5d83b) and "" or __wf_atom_18a5d83b:__wf_atom_a67dc305()) .. "|" .. v2 .. "|"

	if not (#mItem.mModularParts > 0) then
		return v3 .. p2 .. p3
	end

	local mModularParts = mItem.mModularParts

	for i = 1, #mModularParts do
		local mModularPart = mModularParts[i]
		local v4

		if __wf_atom_7e8ad928(mModularPart) or __wf_atom_7e8ad928(object) then
			v4 = ""
		else
			local __wf_atom_dcd9f6f8 = object:__wf_atom_dcd9f6f8(mModularPart)
			v4 = __wf_atom_dcd9f6f8 == 0 and "" or string.format("%X", __wf_atom_dcd9f6f8)
		end

		v3 ..= v4 .. "|"
	end

	return v3 .. p2 .. p3
end

function ConstructAppearanceLink(p, p2, p3)
	if __wf_atom_7e8ad928(gGameRules) then
		return
	end

	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

	if __wf_atom_7e8ad928(__wf_atom_964056fd) then
		return
	end

	local mItem = p.mItem
	local v2 = not __wf_atom_7e8ad928(mItem.mItemType) and mItem.mItemType:IsA(v)
	local __wf_atom_eb82ab1f = mItem:__wf_atom_eb82ab1f(0)
	local v3 = fn3(__wf_atom_964056fd, mItem, "FF", p2, p3)

	if not v3 then
		return
	end

	local v4 = v3 .. "|" .. (__wf_atom_eb82ab1f.mAllowUglyMode and 1 or 0)

	for i = 0, 8 - 1 do
		if not v2 then
			continue
		end

		v4 ..= "|"
		local __wf_atom_d78fd481 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(i)

		if __wf_atom_7e8ad928(__wf_atom_d78fd481.mItemType) then
			continue
		end

		local mItemType = __wf_atom_d78fd481.mItemType
		local v5

		if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(__wf_atom_964056fd) then
			v5 = ""
		else
			local __wf_atom_dcd9f6f8 = __wf_atom_964056fd:__wf_atom_dcd9f6f8(mItemType)
			v5 = __wf_atom_dcd9f6f8 == 0 and "" or string.format("%X", __wf_atom_dcd9f6f8)
		end

		v4 ..= v5
	end

	for i = 0, 4 do
		if not fn(i) then -- inferred equivalent call
			continue
		end

		v4 ..= "|"
		local colors = __wf_atom_eb82ab1f:GetColors(i)

		for j = 0, 8 - 1 do
			if colors:Initialized(j) then
				v4 ..= string.format("%06X", colors:GetColor(j):__wf_atom_dcecedb0())
			else
				v4 ..= "nnnnnn"
			end
		end
	end

	return v4
end

function ConstructModLink(p, p2, p3)
	if __wf_atom_7e8ad928(gGameRules) then
		return
	end

	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

	if __wf_atom_7e8ad928(__wf_atom_964056fd) then
		return
	end

	local mItem = p.mItem
	local v2 = fn3(__wf_atom_964056fd, mItem, "MOD", p2, p3)

	if not v2 then
		return
	end

	local v3 = (v2 .. "|" .. string.format("%X", mItem.mFeatures)) .. "|"
	local __wf_atom_6ec6b781 = mItem:__wf_atom_6ec6b781()

	for _, v4 in ipairs(__wf_atom_6ec6b781) do
		v3 ..= v4
	end

	local mAttachedUpgrades = p.mAttachedUpgrades
	local v4 = v3 .. "|" .. string.format("%X", #mAttachedUpgrades)

	for _, mAttachedUpgrade in ipairs(mAttachedUpgrades) do
		local mItemType = mAttachedUpgrade.mItemType
		local v5

		if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(__wf_atom_964056fd) then
			v5 = ""
		else
			local __wf_atom_dcd9f6f8 = __wf_atom_964056fd:__wf_atom_dcd9f6f8(mItemType)
			v5 = __wf_atom_dcd9f6f8 == 0 and "" or string.format("%X", __wf_atom_dcd9f6f8)
		end

		v4 ..= "|" .. v5 .. ":"

		if __wf_atom_7e8ad928(mAttachedUpgrade.mItemType) then
			continue
		end

		local mUpgradeFingerprint = mAttachedUpgrade.mUpgradeFingerprint
		local lvl

		if mAttachedUpgrade.mItemType:IsA(__wf_atom_16cdad3a) then
			lvl = mAttachedUpgrade.mInstance:__wf_atom_312189f0(mUpgradeFingerprint)
		else
			local decoded = cjson.decode(mUpgradeFingerprint)
			lvl = decoded and decoded.lvl or ""
		end

		v4 ..= lvl
	end

	local v5 = p2 == 2
	local __wf_atom_6bcdbb1d = p.mItem:__wf_atom_6bcdbb1d(0, v5)

	if __wf_atom_7e8ad928(__wf_atom_6bcdbb1d.mAbility) then
		return v4
	end

	local mAbility = __wf_atom_6bcdbb1d.mAbility
	local v6

	if __wf_atom_7e8ad928(mAbility) or __wf_atom_7e8ad928(__wf_atom_964056fd) then
		v6 = ""
	else
		local __wf_atom_dcd9f6f8 = __wf_atom_964056fd:__wf_atom_dcd9f6f8(mAbility)
		v6 = __wf_atom_dcd9f6f8 == 0 and "" or string.format("%X", __wf_atom_dcd9f6f8)
	end

	return v4 .. "|" .. v6 .. ":" .. string.format("%X", __wf_atom_6bcdbb1d.mIndex)
end

function ConstructLinkPostReceive(value, value2)
	local v2 = string.find(value, "|")

	if not v2 then
		return value
	end

	return string.sub(value, 1, v2) .. (value2 or "") .. "|" .. string.sub(value, v2 + 1)
end

local v2 = nil

local function fn4(value, p, p2)
	local v3 = p .. "-"

	if string.sub(value, 1, v3:len()) ~= v3 then
		return false
	end

	local v4 = string.find(value, "|")

	if not v4 then
		return false
	end

	local v5 = string.sub(value, v3:len() + 1, v4 - 1)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if v5 ~= (__wf_atom_7e8ad928(__wf_atom_18a5d83b) and "" or __wf_atom_18a5d83b:__wf_atom_a67dc305()) then
		return false, "/Lotus/Language/Menu/OldLink"
	end

	if p2 then
		return true, v4
	end

	v2 = {}
	local v6 = string.find(value, "|", v4 + 1)

	if not v6 then
		return false
	end

	v2.mSender = string.sub(value, v4 + 1, v6 - 1)

	if __wf_atom_7e8ad928(gGameRules) then
		return false
	end

	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

	if __wf_atom_7e8ad928(__wf_atom_964056fd) then
		return false
	end

	local v7 = string.find(value, "|", v6 + 1)

	if not v7 then
		return false
	end

	local v8 = string.sub(value, v6 + 1, v7 - 1)
	v2.mStoreItem = fn2(__wf_atom_964056fd, v8) -- inferred equivalent call

	if not v2.mStoreItem then
		return false
	end

	v2.mItemType = v2.mStoreItem:GetItem()

	if __wf_atom_7e8ad928(v2.mItemType) then
		return false
	end

	v2.mIsHoverboard = v2.mItemType:IsA(v)
	v2.mIsPet = v2.mItemType:IsA(__wf_atom_202871eb)
	local v9 = string.find(value, "|", v7 + 1)

	if not v9 then
		return false
	end

	v2.mModularParts = {}
	local _, v10 = module.GetModularType(v2.mItemType)

	if v10 then
		for _ = 1, v10 do
			local v11 = fn2(__wf_atom_964056fd, string.sub(value, v7 + 1, v9 - 1)) -- inferred equivalent call

			if not __wf_atom_7e8ad928(v11) then
				local item = v11:GetItem()

				if not __wf_atom_7e8ad928(item) then
					table.insert(v2.mModularParts, item)
				end
			end

			local v12 = string.find(value, "|", v9 + 1)

			if not v12 then
				return false
			end

			v7 = v9
			v9 = v12
		end
	end

	local v11 = string.sub(value, v7 + 1, v9 - 1)

	if v11:len() ~= 2 then
		return false
	end

	v2.mLoadOutType = tonumber((string.sub(v11, 1, 1)))
	v2.mLoadOutSlot = tonumber((string.sub(v11, 2, 2)))

	if v2.mLoadOutType and v2.mLoadOutSlot then
		return true, v9
	end

	return false
end

function VerifyAppearanceLink(value, p)
	local v3, v4 = fn4(value, "FF", p)

	if not v3 then
		return false, v4
	end

	if p then
		return true
	end

	local v5 = string.find(value, "|", v4 + 1)

	if not v5 then
		return false
	end

	local v6 = string.sub(value, v4 + 1, v5 - 1)

	if v6:len() ~= 1 then
		return false
	end

	v2.mUglyMode = v6 ~= "0"
	v2.mSkins = {}
	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

	for i = 0, 8 - 1 do
		local mStoreItem, item

		if v2.mIsHoverboard then
			local v7 = string.find(value, "|", v5 + 1)

			if not v7 then
				return false
			end

			mStoreItem = fn2(__wf_atom_964056fd, string.sub(value, v5 + 1, v7 - 1)) -- inferred equivalent call
			item = mStoreItem and mStoreItem:GetItem()
			v5 = v7
		end

		v2.mSkins[i] = { mStoreItem = mStoreItem, mItemType = item }
	end

	v2.mColours = {}

	for i = 0, 5 do
		if not fn(i) then -- inferred equivalent call
			continue
		end

		local v7 = string.find(value, "|", v5 + 1) or value:len() + 1
		local customizationColorPalette = SF.CustomizationColorPalette()
		local v8 = string.sub(value, v5 + 1, v7 - 1)

		if v8:len() == 6 * 8 then
			for j = 0, 8 - 1 do
				local v9 = string.sub(v8, 1 + 6 * j, 6 * (j + 1))

				if v9 == "nnnnnn" then
					continue
				end

				local v10 = tonumber(v9, 16)

				if not v10 then
					return false
				end

				customizationColorPalette:SetColor(j, Color(v10))
				customizationColorPalette:__wf_atom_59cc106e(j, true)
			end
		end

		v2.mColours[i] = { mRawPalette = customizationColorPalette }
		v5 = v7
	end

	return true, v2
end

function VerifyModLink(value, p)
	local v3, v4 = fn4(value, "MOD", p)

	if not v3 then
		return false, v4
	end

	if p then
		return true
	end

	local v5 = string.find(value, "|", v4 + 1)

	if not v5 then
		return false
	end

	v2.mFeatures = {}
	local v6 = tonumber(string.sub(value, v4 + 1, v5 - 1), 16)

	if not v6 then
		return false
	end

	while v6 > 0 do
		v2.mFeatures[#v2.mFeatures] = v6 % 2
		v6 = math.floor(v6 / 2)
	end

	local v7 = value:len()
	local v8 = string.find(value, "|", v5 + 1) or v7 + 1
	v2.mPolarities = {}
	local v9 = string.sub(value, v5 + 1, v8 - 1)

	for i = 1, v9:len() do
		local v10 = tonumber((string.sub(v9, i, i)))

		if not v10 then
			return false
		end

		v2.mPolarities[i] = v10
	end

	local v10 = string.find(value, "|", v8 + 1) or v7 + 1
	local v11 = tonumber(string.sub(value, v8 + 1, v10 - 1), 16)

	if not v11 then
		return false
	end

	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
	v2.mMods = {}

	for i = 1, v11 do
		if v7 <= v10 then
			return false
		end

		local v12 = string.find(value, "|", v10 + 1) or v7 + 1
		local v13 = string.find(value, ":", v10 + 1)

		if not v13 then
			return false
		end

		local mStoreItem = fn2(__wf_atom_964056fd, string.sub(value, v10 + 1, v13 - 1)) -- inferred equivalent call

		if not (__wf_atom_7e8ad928(mStoreItem) or __wf_atom_7e8ad928(mStoreItem:GetItem())) then
			local mRawFingerprint = not (v13 < v7) and "" or string.sub(value, v13 + 1, v12 - 1)
			v2.mMods[i] = {
				mStoreItem = mStoreItem,
				mItemType = mStoreItem:GetItem(),
				mRawFingerprint = mRawFingerprint
			}
		end

		v10 = v12
	end

	local v12 = string.find(value, "|", v10 + 1) or v7 + 1
	local v13 = string.find(value, ":", v10 + 1)

	if not v13 then
		return true, v2
	end

	local v14 = fn2(__wf_atom_964056fd, string.sub(value, v10 + 1, v13 - 1)) -- inferred equivalent call

	if __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(v14:GetItem()) then
		return true, v2
	end

	local mIndex = tonumber(string.sub(value, v13 + 1, v12 - 1), 16)

	if not mIndex then
		return false
	end

	v2.mAbilityOverride = { mIndex = mIndex, mAbility = v14:GetItem() }
	return true, v2
end