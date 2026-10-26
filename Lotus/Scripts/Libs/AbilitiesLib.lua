module(..., package.seeall)
local module = require("Lotus.Powersuits.PowersuitAbilities.PVPLib")
local v = WeakResource("/SF/Types/Player/Ghost/SfGhostAvatar")
local v2 = WeakResource("/SF/Types/Player/Ghost/SfSparrowGhostAvatar")
local v3 = WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade")
local v4 = Symbol("EffectsDeco")
local v5 = Type("/Lotus/Fx/PowersuitAbilities/Loki/Cloak")

local function fn(object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_dac308f0 = __wf_atom_e55d02aa:__wf_atom_dac308f0()

		if not __wf_atom_7e8ad928(__wf_atom_dac308f0) then
			return __wf_atom_dac308f0
		end
	end

	return v5
end

local function fn2(object, p)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)
	local v6 = {}

	for i = 1, #__wf_atom_f582136d do
		v6[i] = __wf_atom_f582136d[i]:IsVisible()
	end

	local __wf_atom_59a15398 = object:__wf_atom_59a15398()
	object:__wf_atom_4bf24e79()

	if __wf_atom_59a15398 then
		local __wf_atom_f582136d2 = object:__wf_atom_f582136d(__wf_atom_7e6ed5fa)

		for _, v7 in ipairs(__wf_atom_f582136d2) do
			if v7 ~= object then
				v7:__wf_atom_4bf24e79()
			end
		end
	else
		local v7 = Symbol("ManageVisibilityOnEquipmentChange")
		local v8 = object:Attach(p, EMPTY_SYMBOL)
		local v9 = not __wf_atom_7e8ad928(v8) and v8:IsA(__wf_atom_9578cbaa)

		for i = 1, #__wf_atom_f582136d do
			local v10 = __wf_atom_f582136d[i]

			if __wf_atom_7e8ad928((v10:__wf_atom_b6b760b5())) then
				continue
			end

			local isA = v10:IsA(__wf_atom_56348098)
			local v11 = false

			if isA or v10:__wf_atom_3d96ddcd() and v10:__wf_atom_3d96ddcd():IsA(__wf_atom_56348098) then
				local v12

				if isA then
					v12 = v10:__wf_atom_21ed1a39()
				else
					v12 = v10:__wf_atom_3d96ddcd():__wf_atom_21ed1a39()
				end

				isA = true

				if not __wf_atom_7e8ad928(v12) and v12:__wf_atom_9e6a1e1c() then
					v11 = true
				end
			end

			if not (v10:HasTag(v4) or v11) then
				if v9 and i > 1 then
					v8:__wf_atom_9f26f633(v10, EMPTY_SYMBOL)
				end

				if v10:IsA(__wf_atom_7e6ed5fa) and v10 ~= object then
					v10:__wf_atom_4bf24e79()
				end
			end

			if not isA or v11 then
				continue
			end

			local __wf_atom_bb3e7833 = v10:__wf_atom_bb3e7833(p)

			if not __wf_atom_bb3e7833 then
				if v9 then
					v8:__wf_atom_9f26f633(v10, EMPTY_SYMBOL)
				end

				__wf_atom_bb3e7833 = v10:__wf_atom_bb3e7833(p)
			end

			if not __wf_atom_bb3e7833 then
				continue
			end

			__wf_atom_bb3e7833:__wf_atom_1b57cb83(false)
			__wf_atom_bb3e7833:__wf_atom_b811702e(v7)

			if not v6[i] then
				__wf_atom_bb3e7833:SetVisibility(false, true)
			end
		end
	end
end

local function fn3(instance, p)
	local isA = instance:IsA(__wf_atom_7e6ed5fa)
	local v6 = false

	if isA then
		instance:__wf_atom_404d062c()
		v6 = instance:__wf_atom_59a15398() and true or false
	elseif instance:IsA(__wf_atom_43e0c427) then
		local __wf_atom_6009c8ed = instance:__wf_atom_6009c8ed()
		v6 = not __wf_atom_7e8ad928(__wf_atom_6009c8ed) and __wf_atom_6009c8ed:__wf_atom_59a15398() and true or false
	end

	if v6 then
		local __wf_atom_f582136d = instance:__wf_atom_f582136d(__wf_atom_7e6ed5fa)

		for _, v7 in ipairs(__wf_atom_f582136d) do
			if v7 ~= instance then
				v7:__wf_atom_404d062c()
			end
		end
	else
		local __wf_atom_f582136d = instance:__wf_atom_f582136d(__wf_atom_7e616794)

		for i = 1, #__wf_atom_f582136d do
			local v7 = __wf_atom_f582136d[i]

			if __wf_atom_7e8ad928((v7:__wf_atom_b6b760b5())) or v7:HasTag(v4) then
				continue
			end

			local __wf_atom_bb3e7833 = v7:__wf_atom_bb3e7833(p)

			if not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or isA or __wf_atom_bb3e7833:IsVisible()) then
				v7:SetVisibility(false, true)
			end

			if v7:IsA(__wf_atom_7e6ed5fa) and v7 ~= instance then
				v7:__wf_atom_404d062c()
			end
		end

		local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(p)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function ApplyInvisibility(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	fn2(object, fn(object))

	if p then
		ApplyInvisibility(object:__wf_atom_d2b2176d():__wf_atom_1915cc84())
	end
end

function RemoveInvisibility(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	fn3(object, fn(object))

	if not __wf_atom_7e8ad928(object:__wf_atom_f51f1faa()) then
		fn3(object:__wf_atom_f51f1faa(), fn(object))
	end

	if p then
		RemoveInvisibility(object:__wf_atom_d2b2176d():__wf_atom_1915cc84())
	end
end

function totemForceCalc(instance, _, object)
	local attribute = instance:GetAttribute(0)
	local attribute2 = instance:GetAttribute(1)
	local attribute3 = instance:GetAttribute(2)
	local v6 = 1
	local v7 = __wf_atom_7e8ad928(object) and 100 or object:__wf_atom_c05c3cf5(object:__wf_atom_f298d802())

	if v7 > 90 then
		return v6
	end

	if v7 == 9 then
		attribute *= 20
	elseif v7 == 10 then
		attribute2 *= 20
	elseif v7 == 11 then
		attribute3 *= 20
	end

	return math.min(2, (attribute + attribute2 + attribute3) / 1000) + 1
end

function magikForceCalc(instance, _, p)
	local attribute = instance:GetAttribute(0)
	local attribute2 = instance:GetAttribute(1)
	local attribute3 = instance:GetAttribute(2)
	local __wf_atom_e55d02aa = instance:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local v6 = __wf_atom_7e8ad928(p) and 100 or __wf_atom_e55d02aa:__wf_atom_e8008ec5(p)

		if __wf_atom_e55d02aa:__wf_atom_87a16e10() < v6 then
			attribute *= 2
			attribute2 *= 2
			attribute3 *= 2
		elseif v6 == 1 then
			attribute *= 20
		elseif v6 == 2 then
			attribute2 *= 20
		elseif v6 == 3 then
			attribute3 *= 20
		end
	end

	return math.min(2, (attribute + attribute2 + attribute3) / 1000) + 1
end

function magikEnergyCalc(instance, _, object)
	local v6 = math.max(0.1, 1 - instance:GetAttribute(1) * 15 / 1000)
	object:__wf_atom_6e77b6d9(Resource(object:__wf_atom_1bb5b1ff()):__wf_atom_de7e7709() * v6)
	return v6
end

local function fn4(object, object2, p, p2, p3, p4, p5, p6, p7, p8)
	if __wf_atom_7e8ad928(object) then
		return 0
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return 0
	end

	local v6 = module.IsFightingGame() and true or p4
	local __wf_atom_2a745663 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_2a745663(
		1,
		31,
		object:__wf_atom_1bb5b1ff(),
		object
	)

	if module.IsPvpEnabled() and p7 ~= nil then
		__wf_atom_2a745663 *= p7
	end

	if p8 ~= nil and p8 < __wf_atom_2a745663 then
		__wf_atom_2a745663 = p8
	end

	__wf_atom_6009c8ed:__wf_atom_33b8b73f(nil, false, 0, 0, false, false)
	local v7 = __wf_atom_7e8ad928(object2) and 0 or object2:__wf_atom_9b304b6e() or 0
	local v8

	if __wf_atom_2a745663 > 0 and __wf_atom_2a745663 ~= 1 then
		v8 = v7 + __wf_atom_6009c8ed:__wf_atom_9b5dcd3b(object2, p, p2, p3, v6, __wf_atom_2a745663)
	else
		v8 = v7 + __wf_atom_6009c8ed:__wf_atom_9b5dcd3b(object2, p, p2, p3, v6)
	end

	if p5 then
		local cameraControl = __wf_atom_6009c8ed:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			cameraControl:__wf_atom_f1ad4efa(p5, p6)
		end
	end

	return v8
end

function PlayAnim(p, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	return fn4(p, p2, p3, p4, p5, p6, p7, p8, p9, p10)
end

function SuspendUntilEvent(object, object2, p, p2)
	if not (p2 > 0) or p == nil or p == "" then
		return true
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:__wf_atom_8914dfde(p, p2)
	end

	return not __wf_atom_7e8ad928(__wf_atom_6009c8ed)
		and __wf_atom_6009c8ed:__wf_atom_c138b19b(object2)
		and object2:__wf_atom_091354f5(Symbol(p)) < 1
end

function PlayAnimAndSuspendUntilEvent(p, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11)
	local v6 = fn4(p, p2, p4, p5, p6, p7, p8, p9, p10, p11)
	return SuspendUntilEvent(p, p2, p3, v6)
end

local function fn5(object, p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(object) then
		return 0
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return 0
	end

	local v6 = module.IsFightingGame() and true or p5
	local __wf_atom_2a745663 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_2a745663(
		1,
		31,
		object:__wf_atom_1bb5b1ff(),
		object
	)

	if __wf_atom_2a745663 > 0 and __wf_atom_2a745663 ~= 1 then
		return __wf_atom_6009c8ed:__wf_atom_33b8b73f(p, p2, p3, p4, v6, false, __wf_atom_2a745663)
	end

	return __wf_atom_6009c8ed:__wf_atom_33b8b73f(p, p2, p3, p4, v6, false)
end

function PlayUpperBodyAnim(p, p2, p3, p4, p5, p6)
	return fn5(p, p2, p3, p4, p5, p6)
end

function PlayUpperBodyAnimAndSuspendUntilEvent(object, object2, p, p2, p3, p4, p5)
	local v6 = fn5(object, object2, p2, p3, p4, p5)

	if not (v6 > 0) or p == nil or p == "" then
		return true
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:__wf_atom_8914dfde(p, v6)
	end

	return not __wf_atom_7e8ad928(__wf_atom_6009c8ed)
		and __wf_atom_6009c8ed:__wf_atom_c138b19b(object2)
		and object2:__wf_atom_091354f5(Symbol(p)) < 1
end

local function fn6(value)
	if type(value) == "string" then
		return value
	end

	if __wf_atom_7e8ad928(value) then
		return nil
	end

	local name = value:__wf_atom_1bb5b1ff():GetName()
	local __wf_atom_3371f607 = value:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		name ..= "_" .. __wf_atom_3371f607:__wf_atom_1bb5b1ff():GetName()
	end

	return name
end

function SetAbilityStats(p, p2, p3)
	if not p then
		return
	end

	local v6 = fn6(p2)

	if not v6 then
		return
	end

	if not _T.abilityStats then
		_T.abilityStats = {}
	end

	for k, abilityStat in pairs(_T.abilityStats) do
		if k ~= p then
			continue
		end

		abilityStat[v6] = p3
		return
	end

	_T.abilityStats[p] = { [v6] = p3 }
end

local function fn7(p, p2, p3)
	if not p then
		return nil
	end

	for k, abilityStat in pairs(_T.abilityStats) do
		if k ~= p then
			continue
		end

		local v6 = fn6(p2)

		if not v6 then
			break
		end

		local v7 = abilityStat[v6]

		if p3 then
			abilityStat[v6] = nil
		end

		return v7
	end

	return nil
end

function GetAbilityStats(p, p2, p3)
	return fn7(p, p2, p3)
end

function WaitForAbilityStats(p, p2, p3, p4)
	if not p then
		return nil
	end

	while p3 > 0 do
		local v6 = fn7(p, p2, p4)

		if v6 then
			return v6
		end

		Sleep(0)
		p3 -= __wf_atom_084b3e93()
	end

	return nil
end

function ClearAbilityStats(p, p2)
	if p then
		for k, abilityStat in pairs(_T.abilityStats) do
			if k ~= p then
				continue
			end

			local v6 = fn6(p2)

			if not v6 then
				break
			end

			abilityStat[v6] = nil
			return
		end
	end
end

local function fn8(p, object, name, p2)
	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if type(name) ~= "string" then
		name = name:__wf_atom_1bb5b1ff():GetName()
	end

	if p2 then
		if not _T[p] then
			_T[p] = {}
		end

		if not _T[p][__wf_atom_18aa6e58] then
			_T[p][__wf_atom_18aa6e58] = {}
		end

		_T[p][__wf_atom_18aa6e58][name] = true
		return p2
	else
		local v6 = _T[p] and _T[p][__wf_atom_18aa6e58]

		if not v6 then
			return p2
		end

		v6[name] = nil

		if next(v6) then
			return true
		else
			_T[p][__wf_atom_18aa6e58] = nil
		end

		return p2
	end
end

function EnableWeaponFiring(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local v6 = not fn8("Abilities_FiringDisabled", object, p, not p2)
	object:__wf_atom_d2b2176d():EnableWeaponFiring(v6)
	return v6
end

function EnableWeaponSlot(object, name, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if type(name) ~= "string" then
		name = name:__wf_atom_1bb5b1ff():GetName()
	end

	local v6 = not fn8("Abilities_WeaponDisabled" .. "_SLOT_" .. p2 + 1, object, name, not p)

	if not gRegion:IsMaster() or object:__wf_atom_d2b2176d():__wf_atom_d93821d0(p2) ~= v6 then
		return v6
	end

	if v6 then
		object:__wf_atom_d2b2176d():__wf_atom_ec33d862(p2)
		return v6
	end

	object:__wf_atom_d2b2176d():__wf_atom_e704ac94(p2)
	return v6
end

function GetWeaponMote(instance)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_2fc5c2e8) then
		for i = 0, instance:__wf_atom_06f3cb74() - 1 do
			local __wf_atom_b9a1f18c = instance:__wf_atom_b9a1f18c(i)

			if not __wf_atom_7e8ad928(__wf_atom_b9a1f18c) and __wf_atom_b9a1f18c:IsA(v3) then
				return __wf_atom_b9a1f18c
			end
		end
	end

	return nil
end

function GetWeaponMoteAbility(p)
	local v6 = GetWeaponMote(p)

	if __wf_atom_7e8ad928(v6) then
		return nil
	end

	for i = 1, v6:__wf_atom_06f3cb74() do
		local __wf_atom_b9a1f18c = v6:__wf_atom_b9a1f18c(i - 1)

		if __wf_atom_b9a1f18c:__wf_atom_b810064e() == 1 then
			return __wf_atom_b9a1f18c:__wf_atom_7da6362c()
		end
	end

	return nil
end

function GetPassiveSlotPolarity(object)
	local __wf_atom_d21cd30a = object:__wf_atom_d21cd30a()
	local slottedWeaponModIndex = nil

	if __wf_atom_7e8ad928(__wf_atom_d21cd30a) then
		if not (__wf_atom_7e8ad928(_T.WeaponToUpgrade) or _T.MoteSelectOpen) then
			__wf_atom_d21cd30a = Resource(_T.WeaponToUpgrade.Type)
			slottedWeaponModIndex = _T.SlottedWeaponModIndex
		end
	else
		slottedWeaponModIndex = object:__wf_atom_4670dd48()
	end

	if __wf_atom_7e8ad928(__wf_atom_d21cd30a) or __wf_atom_7e8ad928(slottedWeaponModIndex) then
		return nil
	end

	local __wf_atom_6ec6b781 = __wf_atom_d21cd30a:__wf_atom_6ec6b781()

	if slottedWeaponModIndex < #__wf_atom_6ec6b781 then
		return __wf_atom_6ec6b781[slottedWeaponModIndex + 1]
	end

	local v6 = slottedWeaponModIndex - #__wf_atom_6ec6b781
	local v7 = GetWeaponMote(__wf_atom_d21cd30a)

	if not __wf_atom_7e8ad928(v7) then
		local __wf_atom_74981ccd = v7:__wf_atom_74981ccd()

		if v6 < #__wf_atom_74981ccd then
			return __wf_atom_74981ccd[v6 + 1]
		end
	end

	return nil
end

function UpgradeMatchesSlotPolarity(object)
	local v6 = GetPassiveSlotPolarity(object)
	local __wf_atom_c05c3cf5 = object:__wf_atom_c05c3cf5(object:__wf_atom_f298d802())

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(__wf_atom_c05c3cf5) then
		return false
	end

	if v6 == 12 or v6 == 0 or __wf_atom_c05c3cf5 == 12 or __wf_atom_c05c3cf5 == 0 then
		return true
	end

	if
		v6 == __wf_atom_c05c3cf5
		or (__wf_atom_c05c3cf5 == 9 and v6 == 1 or __wf_atom_c05c3cf5 == 10 and v6 == 2 or __wf_atom_c05c3cf5 == 11 and v6 == 3)
	then
		return true
	end

	return false
end

function Fear(object, p, p2)
	if gRegion:IsMaster() then
		local __wf_atom_4169cd15 = object:__wf_atom_4169cd15()

		if __wf_atom_4169cd15 < 5 then
			object:__wf_atom_2f3f52aa(__wf_atom_4169cd15 + 1)
		end

		local v6 = Symbol("CASTREACT")
		local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
		local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_a2a18137, 0, p)

		for _, v7 in ipairs(all) do
			if
				v7:__wf_atom_129d1aba(object)
				or v7:IsKilled()
				or v7:__wf_atom_bedb4e3f()
				or not v7:IsA(__wf_atom_9e85eea2)
			then
				continue
			end

			if v7:__wf_atom_7b82e9e1(6) or v7:__wf_atom_7b82e9e1(12) then
				continue
			end

			local __wf_atom_30e3d82b = v7:__wf_atom_30e3d82b()

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or not __wf_atom_30e3d82b:__wf_atom_04ea4887() then
				continue
			end

			if not (v7:__wf_atom_fc8d8e90() or v7:__wf_atom_464a4772()) then
				v7:__wf_atom_58c8ffec(v6, false, 4, 1, false, __wf_atom_5784a397(0, v7:__wf_atom_1ba2008d(v6)))
			end

			if not p2 or v7:__wf_atom_464a4772() then
				continue
			end

			v7:__wf_atom_986f733d(Symbol("SoulSteal"), 0.5)
			local getfenv = getfenv(2)
			getfenv.SoulStealRemove = SoulStealRemove
			v7:__wf_atom_8a035cd5(Symbol("SoulStealRemove"), false)
		end
	end
end

function ApplyBestoneFrozenSolid(instance, p, p2, p3)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_4ebf67cb) or instance:IsFrozenSolid() then
		return false
	end

	local __wf_atom_7470861b = instance:__wf_atom_7470861b()

	if not __wf_atom_7e8ad928(p) then
		instance:Attach(p, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance)
	end

	if not __wf_atom_7e8ad928(p2) then
		instance:Attach(p2, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	while not instance:IsFrozenSolid() do
		instance:__wf_atom_a0a49499(1, __wf_atom_084b3e93() / 0.25)
		Sleep(0)
	end

	instance:__wf_atom_0fab63d3(false)
	instance:__wf_atom_d2b2176d():__wf_atom_28cf035c()
	instance:__wf_atom_d2b2176d():__wf_atom_d5651846()
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("BestonePhysicalDmg"), 21, 6, p3)
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("BestoneElementalDmg"), 25, 6, p3)
	return true
end

function RemoveBestoneFrozenSolid(instance, className, className2, p)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_4ebf67cb) then
		return false
	end

	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_63396172(Symbol("BestonePhysicalDmg"))
	__wf_atom_7470861b:__wf_atom_63396172(Symbol("BestoneElementalDmg"))

	for _, v6 in ipairs(instance:__wf_atom_be0bea4a()) do
		if v6:IsA(className) or v6:IsA(className2) then
			v6:Destroy()
		end
	end

	if instance:IsKilled() then
		return true
	end

	instance:__wf_atom_d70bf41b(4)
	instance:__wf_atom_0fab63d3(true)

	if not gRegion:IsMaster() then
		return true
	end

	if p then
		local damageData = Engine.DamageData()
		damageData:__wf_atom_d6f4d914(16, true)
		damageData:__wf_atom_12cf5317(instance:__wf_atom_7470861b():__wf_atom_55597fe3():__wf_atom_ac07a537())
		instance:__wf_atom_649bf33e(damageData)
	end

	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	if not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_04ea4887()) then
		__wf_atom_30e3d82b:__wf_atom_30b587a4()
	end

	return true
end

function ApplyRagdollLift(instance, p, p2, data, p3, p4)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_4ebf67cb) then
		return false
	end

	if not instance:__wf_atom_7470861b():__wf_atom_3c3be7d2(instance, Engine.DamageData()) then
		return false
	end

	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local bbLiftInstigatorAvatar = __wf_atom_e919fb8e.bbLiftInstigatorAvatar

	if
		__wf_atom_7e8ad928(instance)
		or __wf_atom_7e8ad928(bbLiftInstigatorAvatar)
		or __wf_atom_e919fb8e.bbRagdollLifted
	then
		return false
	end

	local v6 = Symbol("BlockingBehavior")
	local v7 = Symbol("POST_DEATH_ABILITY_ACTIVE")
	__wf_atom_e919fb8e.bbRagdollLifted = true
	local v8 = nil

	if
		not __wf_atom_7e8ad928(instance:__wf_atom_3d96ddcd())
		and instance:__wf_atom_3d96ddcd():IsA(__wf_atom_47cae841)
	then
		instance = instance:__wf_atom_3d96ddcd()
	end

	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("LiftPhysicalDmg"), 21, 6, p2)
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("LiftElementalDmg"), 25, 6, p2)
	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_4e4078ea(true)
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v6, bbLiftInstigatorAvatar, 1)
	end

	local v9 = instance:__wf_atom_ee03557f() - instance:GetPosition()
	local v10 = v9.x > 1.5 or v9.z > 1.5
	local position = instance:GetPosition()
	gRegion:Raycast(position + Vector(0, 2, 0), position - Vector(0, 2, 0), nil, nil, position, true)
	local v11 = nil
	local v12 = nil

	if v10 and not __wf_atom_7e8ad928(data.liftPoolLargeFxType) then
		v11 = gRegion:CreateEntity(data.liftPoolLargeFxType, position, __wf_atom_80368bb1, bbLiftInstigatorAvatar)
	elseif not (v10 or __wf_atom_7e8ad928(data.liftPoolFxType)) then
		v11 = gRegion:CreateEntity(data.liftPoolFxType, position, __wf_atom_80368bb1, bbLiftInstigatorAvatar)
	end

	if not __wf_atom_7e8ad928(data.liftAttachFxType) then
		v12 = instance:Attach(data.liftAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	instance:__wf_atom_d2b2176d():__wf_atom_3c88d02d(p, 101, 2, 0)

	if not __wf_atom_7e8ad928(p3) then
		instance:__wf_atom_8914dfde("Ragdoll", instance:__wf_atom_921c1a5f(p3, false, 3, 1, true))
	end

	local __wf_atom_07e250ed = instance:__wf_atom_7470861b():__wf_atom_07e250ed(instance, true)
	instance:__wf_atom_7470861b():__wf_atom_f756036f(false)
	instance:__wf_atom_80db4712(11, 0)
	instance:__wf_atom_5047e0ed(false)
	instance:SetDisableMovement(true)

	if instance:IsA(__wf_atom_7e6ed5fa) and instance:__wf_atom_52077f7a(v7) then
		instance:SetBlackboardBool(v7, false)
		instance:__wf_atom_ec1735df()
	end

	if gRegion:IsMaster() then
		local __wf_atom_fec6bb4d = __wf_atom_07e250ed:__wf_atom_fec6bb4d(1)

		if not __wf_atom_7e8ad928(__wf_atom_fec6bb4d) then
			v8 = gRegion:__wf_atom_7ab56047(p4)
			v8:SetAnchor(0, instance:__wf_atom_1c374cc9(Symbol("GAME_C1_HIP1")))
			v8:__wf_atom_7d7cae54(1, __wf_atom_fec6bb4d)
		end
	end

	if not __wf_atom_7e8ad928(instance) then
		__wf_atom_07e250ed:SetDisableGravity(true)
	end

	local total = 0

	while total < p and not (__wf_atom_7e8ad928(instance) or instance:IsKilled()) do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:Destroy()
	end

	if not __wf_atom_7e8ad928(v12) then
		v12:Destroy()
	end

	if not __wf_atom_7e8ad928(v8) then
		gRegion:__wf_atom_dd1e4d10(v8)
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_4e4078ea(false)
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v6)
	end

	__wf_atom_e919fb8e.bbRagdollLifted = false

	if not __wf_atom_7e8ad928(__wf_atom_07e250ed) then
		__wf_atom_07e250ed:SetDisableGravity(false)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:__wf_atom_7470861b():__wf_atom_f756036f(true)
		instance:__wf_atom_5047e0ed(true)
		instance:SetDisableMovement(false)
	end

	if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
		__wf_atom_7470861b:__wf_atom_63396172(Symbol("BestonePhysicalDmg"))
		__wf_atom_7470861b:__wf_atom_63396172(Symbol("BestoneElementalDmg"))
	end

	return true
end

function PreventEnergyGain(object, p)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

		if p then
			if __wf_atom_7e8ad928(_T.preventEnergyGain) then
				_T.preventEnergyGain = {}
			end

			if __wf_atom_7e8ad928(_T.preventEnergyGain[__wf_atom_18aa6e58]) then
				_T.preventEnergyGain[__wf_atom_18aa6e58] = 1
			else
				_T.preventEnergyGain[__wf_atom_18aa6e58] = _T.preventEnergyGain[__wf_atom_18aa6e58] + 1
			end
		elseif not (__wf_atom_7e8ad928(_T.preventEnergyGain) or __wf_atom_7e8ad928(_T.preventEnergyGain[__wf_atom_18aa6e58])) then
			_T.preventEnergyGain[__wf_atom_18aa6e58] = _T.preventEnergyGain[__wf_atom_18aa6e58] - 1

			if _T.preventEnergyGain[__wf_atom_18aa6e58] <= 0 then
				_T.preventEnergyGain[__wf_atom_18aa6e58] = nil
			end
		end
	end
end

function EnergyGainPrevented(object)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(_T.preventEnergyGain)) then
		local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

		if _T.preventEnergyGain[__wf_atom_18aa6e58] ~= nil then
			return _T.preventEnergyGain[__wf_atom_18aa6e58] > 0
		end
	end

	return false
end

function DisablePassives(object)
	while _T.inSeamlessTransition do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(gGameRules) or module.DisablePassives() or _T.ForceDisablePassives then
		return true
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

		if
			__wf_atom_7e8ad928(__wf_atom_6009c8ed)
			or __wf_atom_6009c8ed:__wf_atom_a5040fdf():__wf_atom_80d98203()
			or __wf_atom_6009c8ed:IsA(v)
			or __wf_atom_6009c8ed:IsA(v2)
		then
			return true
		end
	end

	return false
end

function BlockProcs(object, p)
	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if p then
		if _T.blockProcs == nil then
			_T.blockProcs = {}
		end

		if _T.blockProcs[__wf_atom_18aa6e58] == nil then
			_T.blockProcs[__wf_atom_18aa6e58] = 0

			if gRegion:IsMaster() then
				object:__wf_atom_d2b2176d():AddUpgrade(88, 4, 1)
			end
		end

		_T.blockProcs[__wf_atom_18aa6e58] = _T.blockProcs[__wf_atom_18aa6e58] + 1
		object:__wf_atom_7470861b():__wf_atom_b687c22c(0)
	elseif _T.blockProcs ~= nil and _T.blockProcs[__wf_atom_18aa6e58] then
		_T.blockProcs[__wf_atom_18aa6e58] = _T.blockProcs[__wf_atom_18aa6e58] - 1

		if _T.blockProcs[__wf_atom_18aa6e58] == 0 then
			object:__wf_atom_7470861b():__wf_atom_b687c22c(18)

			if gRegion:IsMaster() then
				object:__wf_atom_d2b2176d():RemoveUpgrade(88, 4, 1)
			end

			_T.blockProcs[__wf_atom_18aa6e58] = nil

			if next(_T.blockProcs) == nil then
				_T.blockProcs = nil
			end
		end
	end
end

function EnableImmortality(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local v6 = fn8("Abilities_Immortality", object, p, p2)
	object:__wf_atom_7470861b():__wf_atom_422ff021(v6)
	return v6
end

function SetForceAim(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local v6 = fn8("Abilities_ForceAim", object, p, p2)
	object:__wf_atom_92aa9d91():SetForceAim(v6)
	return v6
end

function EnableAimGlide(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local v6 = fn8("Abilities_AimGlide", object, p, p2)

	if v6 then
		object:__wf_atom_4c3f8902(object:__wf_atom_9f57166e() * 0.35)
		object:__wf_atom_fe384552(Symbol("MELEE_GLIDE_GRAVITY"), 0, -1)
		object:MotionControl():__wf_atom_5ab9523f(0.9)
	else
		object:__wf_atom_67c7c525(Symbol("MELEE_GLIDE_GRAVITY"))
		object:MotionControl():__wf_atom_5ab9523f(1)
	end

	return v6
end

function GetUniqueAbilityId()
	if _T.globalAbilityTimerId == nil then
		_T.globalAbilityTimerId = 1
	else
		_T.globalAbilityTimerId = _T.globalAbilityTimerId % 1000000 + 1
	end

	return _T.globalAbilityTimerId
end

function AIDirTrackAgent(object, p)
	if not gRegion:IsMaster() then
		return nil
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return nil
	end

	if p then
		if _T.aiDirTrackAgent == nil then
			if __wf_atom_30e3d82b:__wf_atom_00073e2b() then
				gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_9a905ffe(__wf_atom_30e3d82b)
			end
		else
			local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

			if _T.aiDirTrackAgent[__wf_atom_18aa6e58] ~= nil then
				_T.aiDirTrackAgent[__wf_atom_18aa6e58] = _T.aiDirTrackAgent[__wf_atom_18aa6e58] - 1

				if _T.aiDirTrackAgent[__wf_atom_18aa6e58] <= 0 then
					gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_9a905ffe(__wf_atom_30e3d82b)
					_T.aiDirTrackAgent[__wf_atom_18aa6e58] = nil
				end
			end

			if next(_T.aiDirTrackAgent) == nil then
				_T.aiDirTrackAgent = nil
			end
		end

		return (__wf_atom_30e3d82b:__wf_atom_00073e2b())
	else
		local __wf_atom_00073e2b = __wf_atom_30e3d82b:__wf_atom_00073e2b()

		if _T.aiDirTrackAgent == nil then
			_T.aiDirTrackAgent = {}
		end

		local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

		if _T.aiDirTrackAgent[__wf_atom_18aa6e58] == nil then
			if __wf_atom_00073e2b then
				_T.aiDirTrackAgent[__wf_atom_18aa6e58] = 1
			else
				_T.aiDirTrackAgent[__wf_atom_18aa6e58] = 0
			end

			gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_d0ef0be2(__wf_atom_30e3d82b)
		end

		_T.aiDirTrackAgent[__wf_atom_18aa6e58] = _T.aiDirTrackAgent[__wf_atom_18aa6e58] + 1
		return __wf_atom_00073e2b
	end
end

local function fn9(object, p, p2)
	local __wf_atom_96c119f5 = object:__wf_atom_7470861b():__wf_atom_96c119f5(0)
	__wf_atom_96c119f5.y -= object:GetHeight() * 0.5
	local v6 = Vector()

	if gRegion:Raycast(__wf_atom_96c119f5, __wf_atom_96c119f5 + p2 * p, object, nil, v6, true, true) then
		return Distance(__wf_atom_96c119f5, v6)
	end

	return 3.4028234663852886e38
end

function SlamToGround(object, p, object2, p2, items)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_a043ba8b = __wf_atom_e55d02aa:__wf_atom_a043ba8b()
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		1,
		31,
		__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
		__wf_atom_e55d02aa
	)
	local v6

	if __wf_atom_7e8ad928(p) then
		v6 = 0
	else
		v6 = fn4(__wf_atom_e55d02aa, p, false, 2, 3, true)

		for k, item in pairs(items) do
			if __wf_atom_7e8ad928(k) then
				continue
			end

			k:__wf_atom_8c960143(item[1])
			k:__wf_atom_de14bbe2(false, false, false, __wf_atom_2a745663)
		end
	end

	local flag = false
	local v7

	if __wf_atom_7e8ad928(object2) then
		v7 = 0
	else
		v7 = object2:__wf_atom_8bb4ded3() * object2:__wf_atom_091354f5(Symbol(p2))

		if __wf_atom_2a745663 > 0 then
			v7 /= __wf_atom_2a745663
		end
	end

	if object:__wf_atom_59cb39a4() then
		local __wf_atom_4417a5d4 = object:__wf_atom_4417a5d4()
		local motionControl = object:MotionControl()
		local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
		__wf_atom_4e50d390.pitch = math.max(__wf_atom_4e50d390.pitch, 40)
		local v8 = __wf_atom_e97f3142(__wf_atom_4e50d390)
		local v9 = Symbol("ABILITY_SLAM")
		local y = object:__wf_atom_a2a18137().y
		local module2 = require("Lotus.Scripts.Libs.EasingLib")
		motionControl:__wf_atom_3a1d0c16(__wf_atom_4e50d390)
		local v10 = 0.4
		local v11 = 0
		local v12 = 15
		local total = 1
		local v13 = 0

		while
			not __wf_atom_7e8ad928(object)
			and not object:IsKilled()
			and not object:__wf_atom_bedb4e3f()
			and object:__wf_atom_59cb39a4()
			and not (__wf_atom_7e8ad928(__wf_atom_a043ba8b) or __wf_atom_a043ba8b:__wf_atom_31446586())
		do
			if v10 then
				v11 = math.min(v11 + __wf_atom_084b3e93(), 0.2)
				v12 = math.min(80, v12 * (1 + module2.inQuad(v11, 0, 25, 0.2) * __wf_atom_084b3e93()))
				v10 -= __wf_atom_084b3e93()
			else
				object:__wf_atom_fe384552(v9, total, -1)
				total += __wf_atom_084b3e93() * 0.3
				v13 = math.min(v13 + __wf_atom_084b3e93(), 0)
				v12 = math.max(0, v12 * (1 - module2.outQuad(v13, 0, 0.7, 0) * __wf_atom_084b3e93()))
			end

			if __wf_atom_4417a5d4 then
				motionControl:__wf_atom_4bb21efc(v8 * v12)
			end

			if v6 <= 0 then
				if flag then
					break
				end

				if not __wf_atom_7e8ad928(object2) then
					local v14 = v12 * v7

					if fn9(object, v14, v8) <= v14 then
						fn4(__wf_atom_e55d02aa, object2, false, 4, 1, true)

						for k, item in pairs(items) do
							if __wf_atom_7e8ad928(k) then
								continue
							end

							k:__wf_atom_8c960143(item[2])
							k:__wf_atom_de14bbe2(false, false, false, __wf_atom_2a745663)
							k:PlayTriggeredFade(false)
						end

						v6 = v7
						flag = true
					end
				end
			end

			Sleep(0)

			if not __wf_atom_7e8ad928(object) then
				local y2 = object:__wf_atom_a2a18137().y

				if v6 <= 0 and y2 == y then
					break
				else
					y = y2
				end
			end

			v6 -= __wf_atom_084b3e93()
		end

		if __wf_atom_4417a5d4 then
			motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
		end

		if not __wf_atom_7e8ad928(__wf_atom_a043ba8b) and __wf_atom_a043ba8b:__wf_atom_31446586() then
			if __wf_atom_4417a5d4 then
				__wf_atom_e55d02aa:DeactivateAbility(__wf_atom_a043ba8b:__wf_atom_1bb5b1ff())
			end

			return false
		end
	end

	if v6 > 0 then
		Sleep(v6)
	end

	if flag or __wf_atom_7e8ad928(object2) then
		return true
	end

	fn4(__wf_atom_e55d02aa, object2, false, 4, 1, true)

	for k, item in pairs(items) do
		if __wf_atom_7e8ad928(k) then
			continue
		end

		k:__wf_atom_8c960143(item[2])
		k:__wf_atom_de14bbe2(false, false, false, __wf_atom_2a745663)
		k:PlayTriggeredFade(false)
	end

	Sleep(v7)
	return true
end

function StopSlamToGround(object, p, p2, list)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_4417a5d4() then
		object:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
	end

	object:__wf_atom_67c7c525(Symbol("ABILITY_SLAM"))
	object:SetDisableGravity(false)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if
		not __wf_atom_7e8ad928(__wf_atom_e55d02aa)
		and not __wf_atom_7e8ad928(p)
		and (object:__wf_atom_3c281634(p) or object:__wf_atom_c138b19b(p, true))
		and not (__wf_atom_7e8ad928(p2) or object:__wf_atom_3c281634(p2) or object:__wf_atom_c138b19b(p2))
	then
		fn4(__wf_atom_e55d02aa, p2, false, 4, 1, true)

		for _, v6 in ipairs(list) do
			if __wf_atom_7e8ad928(v6) then
				continue
			end

			v6:__wf_atom_757502f4()

			if not v6:__wf_atom_04df0605() then
				v6:PlayTriggeredFade(false)
			end
		end
	end
end

function EnableWeaponAttachmentPhysics(object, p)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	for i = 0, 14 - 1 do
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(i)

		if __wf_atom_7e8ad928(__wf_atom_28224c27) then
			continue
		end

		local __wf_atom_66088189 = __wf_atom_28224c27:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_0ed81088(p)
		end

		local __wf_atom_66088189_2 = __wf_atom_28224c27:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			__wf_atom_66088189_2:__wf_atom_0ed81088(p)
		end
	end
end

function NotifyHeal(object, p, p2)
	if p <= 0 or __wf_atom_7e8ad928(object) then
		return
	end

	local flag

	if object:__wf_atom_535d5cbb() then
		flag = true
	else
		object = object:__wf_atom_6f4c1c1b()

		if p2 == true then
			flag = true
		else
			flag = false
		end
	end

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_535d5cbb() then
		local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
		local stats = __wf_atom_a96eb2aa:GetStats()

		if not __wf_atom_7e8ad928(stats) then
			stats:__wf_atom_c1540783(p)
		end

		if flag then
			__wf_atom_539492fe:__wf_atom_8b4524e6(__wf_atom_a96eb2aa, Symbol("HEALED_ABILITY"))
		end
	end
end

function NotifyRuneSuccess(object, object2)
	if not __wf_atom_7e8ad928(object) and not __wf_atom_7e8ad928(object2) and object:__wf_atom_535d5cbb() then
		local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
		__wf_atom_539492fe:__wf_atom_c2038c7a(
			__wf_atom_a96eb2aa,
			Symbol("RUNE_SUCCESS"),
			object2,
			object2:__wf_atom_1bb5b1ff()
		)
	end
end

function GetNextShotBonusesAndMultipliers(object)
	local total = 0
	local total2 = 0
	local result = {}

	if Engine.__wf_atom_41afbe8a() and not __wf_atom_7e8ad928(object) then
		local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

		if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
			local __wf_atom_ba9e83b9 = __wf_atom_6009c8ed:__wf_atom_ba9e83b9(object:__wf_atom_e5141e5b())

			if __wf_atom_ba9e83b9.mAmount > 0 then
				table.insert(result, __wf_atom_ba9e83b9)
			end

			total2 += __wf_atom_6009c8ed:__wf_atom_9abffa21()
			total += __wf_atom_6009c8ed:__wf_atom_4f5a440f(object:__wf_atom_e5141e5b()) - 1
		end

		local __wf_atom_15197633 = object:__wf_atom_15197633()

		if not __wf_atom_7e8ad928(__wf_atom_15197633) and __wf_atom_15197633 ~= __wf_atom_6009c8ed then
			local __wf_atom_ba9e83b9 = __wf_atom_15197633:__wf_atom_ba9e83b9(object:__wf_atom_e5141e5b())

			if __wf_atom_ba9e83b9.mAmount > 0 then
				table.insert(result, __wf_atom_ba9e83b9)
			end

			total2 += __wf_atom_15197633:__wf_atom_9abffa21()
			total += __wf_atom_15197633:__wf_atom_4f5a440f(object:__wf_atom_e5141e5b()) - 1
		end

		local __wf_atom_a516e8a6 = object:__wf_atom_a516e8a6()

		for _, v6 in ipairs(__wf_atom_a516e8a6) do
			if v6.mAmount > 0 then
				table.insert(result, v6)
			end
		end

		total += object:__wf_atom_4f5a440f() - 1
	end

	local upgradedValue = Engine.UpgradedValue(0)
	upgradedValue:__wf_atom_fae96c2e(3, total)
	return upgradedValue, total2, result
end

function IsAbilityOverridden(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	return not __wf_atom_7e8ad928(p.Ability) and (p.Ability:__wf_atom_9218ac85() or p.ForceOverride)
end

function GetStealAbility(instance)
	local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		local __wf_atom_57ad19ea = __wf_atom_bb3e7833:GetInfo():__wf_atom_57ad19ea()

		if not __wf_atom_7e8ad928(__wf_atom_57ad19ea) then
			return __wf_atom_57ad19ea
		end
	end

	if not instance:IsA(__wf_atom_4ebf67cb) then
		return nil
	end

	local __wf_atom_e55d02aa = instance:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return nil
	end

	local __wf_atom_4ca4978e = __wf_atom_e55d02aa:__wf_atom_4ca4978e()

	if not __wf_atom_7e8ad928(__wf_atom_4ca4978e) then
		local __wf_atom_e21e8409 = __wf_atom_e55d02aa:__wf_atom_e21e8409(__wf_atom_4ca4978e)

		if not __wf_atom_7e8ad928(__wf_atom_e21e8409) and __wf_atom_e21e8409:IsEnabled() then
			return __wf_atom_e21e8409
		end
	end

	return nil
end

function InfiniteEnergy()
	local _ = not __wf_atom_7e8ad928(__wf_atom_8e4fda44) and false
	return false
end

function EvaluateUltAbility(_, object)
	return not object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true)
end

function CreatePathHelper(data, data2, p)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v6 = Vector(data.x, data.y, data.z)
	local v7 = Vector(data2.x, data2.y, data2.z)
	gRegion:Raycast(v6 + Vector(0, 1, 0), v6 - Vector(0, 20, 0), nil, nil, v6, true)
	__wf_atom_2202ffb6:__wf_atom_3c37bceb(v6, 25, 0, -25)
	__wf_atom_2202ffb6:__wf_atom_3c37bceb(v7, 25, 0, -25)
	local __wf_atom_73927e88 = __wf_atom_2202ffb6:__wf_atom_73927e88(v6, v7, false)

	if #__wf_atom_73927e88 < 2 then
		__wf_atom_73927e88 = { data, data2 }
	elseif #__wf_atom_73927e88 > 0 and Distance(__wf_atom_73927e88[#__wf_atom_73927e88], data2) > 2 then
		table.insert(__wf_atom_73927e88, data2)
	end

	__wf_atom_73927e88[1] = data

	if #__wf_atom_73927e88 > 2 and Dot(__wf_atom_73927e88[2] - data, __wf_atom_73927e88[3] - data) < 0 then
		table.remove(__wf_atom_73927e88, 2)
	end

	local v8 = {}

	while #__wf_atom_73927e88 >= 3 do
		local v9 = __wf_atom_73927e88[1]
		local v10 = __wf_atom_73927e88[2]
		local v11 = __wf_atom_73927e88[3]
		local v12 = v10 - v9
		local v13 = v11 - v10
		local v14 = Length(v12)
		local v15 = Length(v13)
		local v16 = math.min(v14, v15) / 2
		local v17 = v10 - v12 * (v16 / v14)
		local v18 = v10 + v13 * (v16 / v15)
		local z = v12.z
		local v19 = -v12.x
		v12.x = z
		v12.y = 0
		v12.z = v19
		local z2 = v13.z
		local v20 = -v13.x
		v13.x = z2
		v13.y = 0
		v13.z = v20
		Normalize(v12)
		Normalize(v13)

		if math.abs((Dot(v12, v13))) < 0.99 and Length(v12) > 0 and Length(v13) > 0 then
			local v21 = v17 + v12 * ((v17.z - v18.z) * v13.x - (v17.x - v18.x) * v13.z) / (v12.x * v13.z - v12.z * v13.x)
			v21.y = (v17.y + v18.y) / 2
			local v22 = v17 - v21
			local v23 = v18 - v21
			local v24 = Length(v22)
			local r1 = v22 / v24
			local r2 = v23 / v24
			local theta = __wf_atom_d08b2f29(r1, r2)
			table.insert(v8, { p1 = v9, p2 = v17, d = Distance(v9, v17) })
			table.insert(v8, {
				p1 = v17,
				p2 = v18,
				d = v24 * math.rad(theta),
				r1 = r1,
				r2 = r2,
				r = v24,
				theta = theta,
				c = v21
			})
			table.remove(__wf_atom_73927e88, 1)
			__wf_atom_73927e88[1] = v18
		else
			table.insert(v8, { p1 = v9, p2 = v10, d = Distance(v9, v10) })
			table.insert(v8, { p1 = v10, p2 = v11, d = Distance(v10, v11) })
			table.remove(__wf_atom_73927e88, 1)
			table.remove(__wf_atom_73927e88, 1)
		end
	end

	if #__wf_atom_73927e88 > 1 then
		table.insert(v8, {
			p1 = __wf_atom_73927e88[1],
			p2 = __wf_atom_73927e88[2],
			d = Distance(__wf_atom_73927e88[1], __wf_atom_73927e88[2])
		})
	end

	local v9 = 1
	local v10 = 0
	local v11 = Vector()
	local v12 = __wf_atom_73927e88[1]
	return function(object)
		local v13 = p * __wf_atom_084b3e93()

		while v9 <= #v8 and v13 > 0.00001 do
			local v14 = v8[v9]
			local v15 = math.min(1, v10 + v13 / v14.d)
			v13 -= (v15 - v10) * v14.d
			v10 = v15

			if v14.c then
				data = v14.c + __wf_atom_a1467d4b(v14.r1, v14.r2, v10 * v14.theta) * v14.r
			else
				data = __wf_atom_f55d6358(v14.p1, v14.p2, v10)
			end

			if not (v10 >= 1) then
				continue
			end

			v9 += 1
			v10 = 0
		end

		v11.x = data.x + Noise(Time() * 0.25) * 1.5
		v11.y = data.y + 1 + Noise(Time() * 1) * 0.35
		v11.z = data.z + Noise(Time() * 0.35) * 1.5

		if not __wf_atom_7e8ad928(object) then
			object:SetPosition(v11)
			object:__wf_atom_9b788a35(__wf_atom_fa8d0177(v12, data))
		end

		v12 = data
		return v9 <= #v8
	end
end

function SoulStealRemove(object)
	local v6 = 0

	while not __wf_atom_7e8ad928(object) and v6 < 1 do
		v6 = __wf_atom_421b01aa(v6 + __wf_atom_084b3e93() * 0.5, 0, 1)
		local v7 = __wf_atom_104bfe98(0.5, 1, v6)
		object:__wf_atom_986f733d(Symbol("SoulSteal"), v7)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_558ce619(Symbol("SoulSteal"))
	end
end

function AddCastImmunity(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v6 = Symbol("CASTANIM")
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_1fa97530(7, v6)
	__wf_atom_7470861b:__wf_atom_1fa97530(3, v6)
	__wf_atom_7470861b:__wf_atom_1fa97530(4, v6)
	__wf_atom_7470861b:__wf_atom_1fa97530(5, v6)
	__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 26, 6, 0)
end

function RemoveCastImmunity(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v6 = Symbol("CASTANIM")
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_56b2394e(7, v6)
	__wf_atom_7470861b:__wf_atom_56b2394e(3, v6)
	__wf_atom_7470861b:__wf_atom_56b2394e(4, v6)
	__wf_atom_7470861b:__wf_atom_56b2394e(5, v6)
	__wf_atom_7470861b:__wf_atom_63396172(v6)
end