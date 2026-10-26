require("Lotus.Scripts.Libs.AbilitiesLib")
local module = require("SF.Scripts.Libs.PlayerPetLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil

local function fn(p)
	local __wf_atom_3c37bceb = gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(p, 10)

	if __wf_atom_3c37bceb or needsNav then
		return __wf_atom_3c37bceb
	end

	return not __wf_atom_7e8ad928(gRegion:Raycast(p + Vector(0, 5, 0), p - Vector(0, 10, 0), nil, nil, p, true))
end

function Evaluate(object, _)
	if not module.CanSummonPet(object, true) then
		return false
	end

	return (fn(object:GetPosition() + object:__wf_atom_a06d543c() * 4))
end

local function fn2(object, p)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return nil
	end

	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	object:__wf_atom_2f2bada0()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_dd7246c7 = __wf_atom_a96eb2aa:__wf_atom_dd7246c7()
	local v2

	if __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
		v2 = object:__wf_atom_a06d543c()
	else
		v2 = __wf_atom_dd7246c7:__wf_atom_a06d543c()
	end

	if __wf_atom_7e8ad928(p) then
		p = object:__wf_atom_d2b2176d():__wf_atom_f2e7f4a9()
	end

	local v3

	if __wf_atom_7e8ad928(p) then
		v3 = 60
	else
		v3 = 30
	end

	return (__wf_atom_7d789620:__wf_atom_0e0a6fee(
		__wf_atom_a2a18137 + __wf_atom_9341614d(v2, Rotation(v3, 0, 0)) * 2,
		1,
		5
	))
end

function ActivateAbility(object, _)
	if object:__wf_atom_799d95f5() then
		return
	end

	module2.UnequipWeapon(object, true)
	object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v2 = object:Attach(whistleDeco, Symbol("GAME_L1_WEAPON1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object:PlaySound(castSound, false, 0, false)

	if not __wf_atom_7e8ad928(activateAnim) then
		object:__wf_atom_8914dfde("RockSummon", (object:__wf_atom_921c1a5f(activateAnim, false, 4, 1, true)))
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local v3 = not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar)

	if gRegion:IsMaster() then
		if v3 then
			SendPupToNf(__wf_atom_e919fb8e.PlayerWolfAvatar, object)
			__wf_atom_e919fb8e.PlayerWolfAvatar = nil
		else
			local v4 = fn2(object)

			if v4 then
				v = module.SummonPlayerPet(object, v4)
			end
		end

		while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
			if
				object:__wf_atom_c138b19b(activateAnim)
				or object:__wf_atom_3c281634(activateAnim)
				or __wf_atom_7e8ad928(v2)
			then
				Sleep(0)
			else
				gRegion:__wf_atom_dd1e4d10(v2)
				break
			end
		end
	else
		while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
			if
				__wf_atom_7e8ad928(v2)
				or object:__wf_atom_c138b19b(activateAnim)
				or object:__wf_atom_3c281634(activateAnim)
			then
				Sleep(0)
			else
				v2:Destroy()
				break
			end
		end
	end

	if object == gRegion:__wf_atom_c4f78a8f() then
		if v3 then
			__wf_atom_e919fb8e.PlayerWolfAvatar = nil
			return
		end

		local total = 0

		while
			not __wf_atom_7e8ad928(object)
			and not object:IsKilled()
			and __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar)
			and total < 5
		do
			Sleep(0)
			total += __wf_atom_084b3e93()
			__wf_atom_e919fb8e.PlayerWolfAvatar = object:__wf_atom_d2b2176d():__wf_atom_1915cc84()
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
			module.OpenPetStatusMovie()
		end
	end
end

function EMO_START(p, _, _)
	ActivateAbility(p, nil)
end

function PlayerPetSpawned(object)
	object:__wf_atom_92aa9d91():__wf_atom_8d150708(false)
end

function SendPupToNf(instance, _)
	if not gRegion:IsMaster() then
		return
	end

	instance:__wf_atom_921c1a5f(nil, false)
	instance:__wf_atom_cecb2d55(Symbol("WolfCommand"), 4)
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.CineEnt) then
		__wf_atom_e919fb8e.CineEnt:Destroy()
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Ctx) then
		__wf_atom_e919fb8e.Ctx:Destroy()
	end

	__wf_atom_e919fb8e.PupIsDespawning = true

	if not __wf_atom_7e8ad928(despawnFxType) then
		instance:Attach(despawnFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance, 1)
	end

	local __wf_atom_921c1a5f = instance:__wf_atom_921c1a5f(despawnAnim, false, 3, 3, true, 1)
	local total = 0

	while total < __wf_atom_921c1a5f do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	instance:Destroy()
end

function DespawnPlayerPet(instance)
	if not gRegion:IsMaster() then
		return
	end

	Sleep(4)
	local __wf_atom_6115a2e2 = instance:__wf_atom_6115a2e2()
	local v2

	if not __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
		v2 = __wf_atom_6115a2e2:__wf_atom_a96eb2aa()
	end

	local v3

	if not (__wf_atom_7e8ad928(v2) or not v2:__wf_atom_5e8fa1ad()) then
		v3 = v2:__wf_atom_4febbf37()
	end

	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local cineEnt = instance:Attach(pettingCine[__wf_atom_5784a397(1, #pettingCine)], EMPTY_SYMBOL)
	local ctx = instance:Attach(pettingCTX, EMPTY_SYMBOL, Vector(0, 0, 2))
	__wf_atom_e919fb8e.CineEnt = cineEnt
	__wf_atom_e919fb8e.Ctx = ctx
	__wf_atom_e919fb8e.CanPetTable = {}

	while not (__wf_atom_7e8ad928(__wf_atom_6115a2e2) or __wf_atom_6115a2e2:IsKilled()) do
		if __wf_atom_7e8ad928(v3) or v3.mEnergy <= 0 and not __wf_atom_6115a2e2:__wf_atom_799d95f5() then
			Sleep(2)
			break
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Ctx) then
			if instance:__wf_atom_ee4f0cba() >= 5 then
				module.SetCanPet(v2, false, "TooFast")
			elseif instance:__wf_atom_ee4f0cba() < 5 then
				module.SetCanPet(v2, true, "TooFast")
			end

			if __wf_atom_6115a2e2:__wf_atom_799d95f5() then
				module.SetCanPet(v2, false, "InNightfold")
			elseif not __wf_atom_6115a2e2:__wf_atom_799d95f5() then
				module.SetCanPet(v2, true, "InNightfold")
			end
		end

		Sleep(0)
	end

	local __wf_atom_e919fb8e2 = instance:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e2.CineEnt) then
		__wf_atom_e919fb8e2.CineEnt:Destroy()
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e2.Ctx) then
		__wf_atom_e919fb8e2.Ctx:Destroy()
	end

	if not __wf_atom_7e8ad928(despawnFxType) then
		instance:Attach(despawnFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance, 1)
	end

	local __wf_atom_921c1a5f = instance:__wf_atom_921c1a5f(despawnAnim, false, 3, 3, true, 1)
	local total = 0

	while total < __wf_atom_921c1a5f do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	instance:Destroy()
end

function PetDestroyed(object)
	module.SetPetResting(object:__wf_atom_7a83e9e6(), true)
end