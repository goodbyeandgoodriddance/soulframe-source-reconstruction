local v = {
	Resource("/SF/Upgrades/Skins/Head/ChildHeadA"),
	Resource("/SF/Upgrades/Skins/Head/ChildHeadB"),
	Resource("/SF/Upgrades/Skins/Head/ChildHeadC"),
	Resource("/SF/Upgrades/Skins/Head/ChildHeadD"),
	Resource("/SF/Upgrades/Skins/Head/ChildHeadE")
}
local module = require("SF.Scripts.FirstLoginUtils")
local v2 = WeakResource("/SF/Types/Player/EnvoyAvatar")

local function fn()
	local __wf_atom_dcecedb0 = gGameData:GetInventory():__wf_atom_3a61ed37():GetColor(0, 0):__wf_atom_dcecedb0()
	local v3 = 1

	for i, mMotherSkinColor in ipairs(module.mMotherSkinColors) do
		if mMotherSkinColor:__wf_atom_dcecedb0() ~= __wf_atom_dcecedb0 then
			continue
		end

		v3 = i
		break
	end

	local v4 = Resource(v[v3])

	if __wf_atom_7e8ad928(v4) then
		return nil
	end

	local v5

	if __wf_atom_7e8ad928(gGameData) then
		v5 = false
	else
		v5 = gGameData:__wf_atom_8856b776()
	end

	return (v4:__wf_atom_c4774ee9(v5 and 0 or 1, 0))
end

local function fn2(entity)
	if not __wf_atom_7e8ad928(entity) then
		local v3 = fn()

		if not __wf_atom_7e8ad928(v3) then
			entity:__wf_atom_45cf0e1a(v3:__wf_atom_d24efbb2(), false, false)
			v3:__wf_atom_e6329949(1, entity)
		end
	end
end

function DissolveOut(object)
	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() * 0.5, 0, 1)
		object:__wf_atom_68f2c268(v3)
		Sleep(0)
	end

	object:SetVisibility(false, true)
end

function DissolveIn(object)
	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() * 0.5, 0, 1)
		object:__wf_atom_68f2c268(1 - v3)
		Sleep(0)
	end

	object:SetVisibility(true, true)
end

function EnsureAdultAvatar(className, className2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and (__wf_atom_c4f78a8f:IsA(className) or not __wf_atom_c4f78a8f:IsA(className2))
		and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_e919fb8e().lastAssignedAvatar)
	then
		SwapLastAssignedControllableAvatar(true, true, true)
	end
end

function SwitchToChildAvatar(className, p, position, p2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_c4f78a8f:IsA(className) then
		if position == nil then
			position = __wf_atom_c4f78a8f:GetPosition()
		end

		if p2 == nil then
			p2 = __wf_atom_c4f78a8f:__wf_atom_dc309f8a()
		end

		local entity = gRegion:CreateEntity(className, position, p2)
		gRegion:__wf_atom_eab484a7()
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if p then
			__wf_atom_eab484a7:__wf_atom_6c552f4c(0, entity)
		end

		__wf_atom_eab484a7:AssignAvatar(entity)
		local __wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.lastAssignedAvatar = __wf_atom_c4f78a8f
		local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		local weaponCustomization = SF.WeaponCustomization()
		weaponCustomization:__wf_atom_2754430f(0, __wf_atom_e55d02aa:__wf_atom_eb82ab1f():GetColors(0))
		weaponCustomization:ApplyCustomization(entity)
		fn2(entity)
		__wf_atom_c4f78a8f:__wf_atom_68f2c268(1)
		__wf_atom_c4f78a8f:SetVisibility(false, true)
	end
end

function SwapControllableAvatar(lastAssignedAvatar, object, p, p2, p3, p4)
	if __wf_atom_7e8ad928(lastAssignedAvatar) then
		lastAssignedAvatar = gRegion:__wf_atom_c4f78a8f()
	end

	if p4 and not __wf_atom_7e8ad928(lastAssignedAvatar) then
		local position = lastAssignedAvatar:GetPosition()
		local __wf_atom_dc309f8a = lastAssignedAvatar:__wf_atom_dc309f8a()
		object:__wf_atom_9373d0eb(0, true)
		object:Teleport(position, __wf_atom_dc309f8a)
	end

	if lastAssignedAvatar ~= object then
		if p2 then
			object:__wf_atom_68f2c268(0)
			object:SetVisibility(true, true)
		else
			DissolveIn(object)
		end

		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if p3 then
			__wf_atom_eab484a7:__wf_atom_6c552f4c(0, object)
		end

		__wf_atom_eab484a7:AssignAvatar(object, true, true)

		if p then
			if not __wf_atom_7e8ad928(lastAssignedAvatar) then
				lastAssignedAvatar:Destroy()
			end

			object:__wf_atom_dd875cd8(false)
		else
			local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.lastAssignedAvatar = lastAssignedAvatar

			if not __wf_atom_7e8ad928(lastAssignedAvatar) then
				if p2 then
					lastAssignedAvatar:__wf_atom_68f2c268(1)
					lastAssignedAvatar:SetVisibility(false, true)
				else
					DissolveOut(lastAssignedAvatar)
				end

				lastAssignedAvatar:__wf_atom_dd875cd8(true)
			end

			object:__wf_atom_dd875cd8(false)
		end
	end
end

function CreateAndSwapControllableAvatar(className, p, p2, p3, p4)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_c4f78a8f:IsA(className) then
		local position = __wf_atom_c4f78a8f:GetPosition()
		local __wf_atom_dc309f8a = __wf_atom_c4f78a8f:__wf_atom_dc309f8a()
		local entity = gRegion:CreateEntity(className, position, __wf_atom_dc309f8a)
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if p2 then
			entity:__wf_atom_68f2c268(0)
			entity:SetVisibility(true, true)
		else
			DissolveIn(entity)
		end

		if p4 then
			__wf_atom_c4f78a8f:Attach(entity, EMPTY_SYMBOL)
		end

		__wf_atom_eab484a7:AssignAvatar(entity, true, true)

		if p3 then
			__wf_atom_eab484a7:__wf_atom_6c552f4c(0, entity)
		end

		if p then
			local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()

			if __wf_atom_e919fb8e.lastAssignedAvatar ~= nil then
				local __wf_atom_e919fb8e_2 = entity:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e_2.lastAssignedAvatar = __wf_atom_e919fb8e.lastAssignedAvatar
			end

			__wf_atom_c4f78a8f:Destroy()
			entity:__wf_atom_dd875cd8(false)
		else
			local __wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.lastAssignedAvatar = __wf_atom_c4f78a8f

			if p2 then
				__wf_atom_c4f78a8f:SetVisibility(false, true)
			else
				DissolveOut(__wf_atom_c4f78a8f)
			end

			entity:__wf_atom_dd875cd8(false)
			__wf_atom_c4f78a8f:__wf_atom_dd875cd8(true)
		end
	end
end

function SwapLastAssignedControllableAvatar(p, p2, p3, p4)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local lastAssignedAvatar = __wf_atom_c4f78a8f:__wf_atom_e919fb8e().lastAssignedAvatar
	SwapControllableAvatar(__wf_atom_c4f78a8f, lastAssignedAvatar, p, p2, p3, p4)
end

function HasPreviouslyAssignedAvatar(object)
	if object:__wf_atom_e919fb8e().lastAssignedAvatar then
		return true
	end

	return false
end

function ApplyPlayerAttributeDistribution(object, p, data)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if #p <= 0 then
		print("ERROR - Tried to set attributes from player, but they weren't stored from the player.")
	end

	object:__wf_atom_9189c3be(0, p.total * data.courage)
	object:__wf_atom_9189c3be(2, p.total * data.grace)
	object:__wf_atom_9189c3be(1, p.total * data.spirit)
	object:Heal(object, object:GetMaxHealth())
end

function StorePlayerAttribute(instance)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	local v3 = { courage = 0, grace = 0, spirit = 0, total = 0 }

	if #v3 <= 0 then
		v3.courage = instance:GetAttribute(0)
		v3.grace = instance:GetAttribute(2)
		v3.spirit = instance:GetAttribute(1)
		v3.total = v3.courage + v3.grace + v3.spirit
	end

	return v3
end

function ShowAcquiredNotification(mItem, value)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_301e8d97 = __wf_atom_eab484a7:__wf_atom_301e8d97()

	if __wf_atom_7e8ad928(__wf_atom_301e8d97) then
		return
	end

	local levelUpInfo = SF.LevelUpInfo()
	levelUpInfo.mTitle = "/SF/Language/Menu/Acquired"

	if mItem:IsA(__wf_atom_d98e64fe) then
		levelUpInfo.mTitle = "/SF/Language/Menu/PactAcquired"
	end

	levelUpInfo.mItem = mItem
	levelUpInfo.mFingerprint = value or ""
	local __wf_atom_eea5c00e = __wf_atom_301e8d97:__wf_atom_eea5c00e()
	__wf_atom_301e8d97:__wf_atom_dbd98029(true)
	__wf_atom_301e8d97:__wf_atom_258c05b2(levelUpInfo)
	__wf_atom_301e8d97:__wf_atom_dbd98029(__wf_atom_eea5c00e)
end

function GiveAndInitalizeCustomWeaponOrPact(instance, p, p2, p3)
	if not instance:IsA(v2) then
		return
	end

	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local v3

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		v3 = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()
	end

	if p3 then
		for i = 0, 14 - 1 do
			local __wf_atom_97d575cf = __wf_atom_d2b2176d:__wf_atom_97d575cf(i)

			if
				__wf_atom_7e8ad928(__wf_atom_97d575cf)
				or __wf_atom_97d575cf:__wf_atom_ed08f97f()
				or __wf_atom_97d575cf:__wf_atom_1bb5b1ff() == p
				or __wf_atom_97d575cf:__wf_atom_1bb5b1ff() == p2
			then
				continue
			end

			__wf_atom_d2b2176d:RemoveItem(i, true)
		end
	end

	if not (__wf_atom_7e8ad928(p2) or instance:HasItem(p2)) then
		__wf_atom_e55d02aa = gRegion:CreateObject(p2, instance)

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			if not __wf_atom_7e8ad928(v3) then
				__wf_atom_e55d02aa:SetCustomization(v3)
			end

			__wf_atom_d2b2176d:GiveItem(__wf_atom_e55d02aa, true)
			__wf_atom_e55d02aa:__wf_atom_9e7c0c61(0, 4, true)
			__wf_atom_e55d02aa:__wf_atom_9e7c0c61(0, 5, true)
		end
	end

	if not (__wf_atom_7e8ad928(p) or instance:HasItem(p)) then
		instance:GiveItem(p, false)

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_9e3b1284()
		end
	end
end