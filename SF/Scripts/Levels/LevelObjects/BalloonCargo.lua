Vector(1, 1, 1)
Vector(5, 5, 5)
local v = Symbol("BalloonCrateSpawn")
local flag = false
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
require("SF.Scripts.Libs.SparrowLib")
local module3 = require("Lotus.Scripts.Libs.AudioLib")
local v2 = {
	CREATED = 0,
	IDLE = 1,
	ACTIVATED = 2,
	ASCENDING = 3,
	ASCENDED = 4,
	LOOTING = 5,
	INTERCEPTED = 6,
	DESTROY = 7
}

local function fn(instance)
	local position

	if not __wf_atom_7e8ad928(instance) then
		position = instance:GetPosition()
	end

	local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(position, 5, 5)
	local y

	if __wf_atom_7e8ad928(__wf_atom_0e0a6fee) or __wf_atom_0e0a6fee == position then
		y = position.y
		print(tostring("Balloon Cargo Object: ") .. "No nav found nearby. Balloon was snapped to " .. tostring(balloonHeightOverNavOffset) .. " above its spawn point instead. Check nav and placement.")
	else
		y = __wf_atom_0e0a6fee.y
		print(tostring("Balloon Cargo Object: ") .. "Balloon is snapped to " .. tostring(balloonHeightOverNavOffset) .. "elevation above nav.")
	end

	instance:Teleport(Vector(position.x, y + balloonHeightOverNavOffset, position.z), instance:__wf_atom_dc309f8a())

	if not (__wf_atom_7e8ad928(chainFxType) or __wf_atom_7e8ad928(chainAttachment)) then
		local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(chainAttachment)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			local v3 = instance:Attach(chainFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance)

			if not __wf_atom_7e8ad928(v3) then
				v3:__wf_atom_b2394158(__wf_atom_bb3e7833, EMPTY_SYMBOL)
			end
		end
	end

	if not __wf_atom_7e8ad928(platformDeco) then
		gRegion:CreateEntity(platformDeco, position, __wf_atom_80368bb1)
	end

	Sleep(0)
	local nearestTagged = gRegion:FindNearestTagged(v, position)

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:FirePort("Disable")
	end

	instance:__wf_atom_0e990c03(v2.IDLE)
end

local function fn2(instance)
	local v3 = __wf_atom_7e8ad928(instance) and {} or instance:__wf_atom_f582136d(chainAttachment)
	Sleep(0)

	if #v3 > 0 then
		instance:__wf_atom_0e990c03(v2.IDLE)
		return
	end

	instance:__wf_atom_0e990c03(v2.ASCENDING)

	if not __wf_atom_7e8ad928(finalChainDetachSound) then
		instance:PlaySound(finalChainDetachSound, false)
	end

	if not __wf_atom_7e8ad928(objectiveFailedSound) then
		instance:PlaySound(objectiveFailedSound, false)
		module3.EnableTaggedSequencers(Symbol("BalloonAscendingCreak"), true)
	end
end

local function fn3(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if unequipInstant then
		__wf_atom_d2b2176d:Unequip(0, 2)
		return
	end

	__wf_atom_d2b2176d:Unequip(0, 0)

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
		Sleep(0)
	end
end

local function fn4(object, p)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_55597fe3 = object:__wf_atom_7470861b():__wf_atom_55597fe3()
		local v3

		if not __wf_atom_7e8ad928(__wf_atom_55597fe3) then
			v3 = __wf_atom_55597fe3:__wf_atom_679ed446()

			if __wf_atom_7e8ad928(v3) then
				v3 = object
			end
		end

		local v4 = nil

		if __wf_atom_7e8ad928(v4) then
			v4 = Engine.DamageData()
			v4:__wf_atom_d6f4d914(p, true)
			v4:__wf_atom_7498285f(0, 1)
			v4:__wf_atom_812165c6(0)
			v4:__wf_atom_6b472125(v3)
			v4:__wf_atom_34a8a27a(v3)
		end

		object:__wf_atom_649bf33e(v4)
	end
end

function BalloonReleaseForced(object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_0e990c03(v2.ASCENDING)
	end
end

function LootBalloon(object, object2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	object2:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
	local v3 = nil
	local v4 = nil

	if gRegion:IsMaster() and unequipWeapon then
		fn3(object2)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_c4f78a8f == object2 then
		object2:__wf_atom_aeb02c14(blockMovementInputFilter)
		v3 = __wf_atom_c4f78a8f:CameraControl()
		v4 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_7369b1a2)

		if not __wf_atom_7e8ad928(v4) then
			v3:SetCameraSpot(v4, 1)
		end
	end

	local total = 0
	local flag2 = false
	object2:__wf_atom_921c1a5f(playerLootBalloonStartAnim, true, 3, 1, true)

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_921c1a5f(playerLootBalloonLoopAnim, false, 3, 2, false)
	end

	while total < 5 do
		if flag then
			fn4(object2, 0)
			object2:__wf_atom_921c1a5f(nil, false)
			object:Enable()
			break
		elseif total >= 3 then
			flag2 = true
			break
		else
			Sleep(0)
			total += __wf_atom_084b3e93()
		end
	end

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_cf966a74(blockMovementInputFilter)
	end

	if flag2 then
		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_3d96ddcd:__wf_atom_0e990c03(v2.LOOTING)
		end

		if not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_921c1a5f(playerLootBalloonEndAnim, true, 3, 1, false)
		end

		if not (__wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v3)) then
			local __wf_atom_1b3db7e0 = v3:__wf_atom_1b3db7e0()
			v3:__wf_atom_fd14c463(2)
			v3:SetCameraSpot(nil, 0.3)
			v3:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
		end
	elseif not __wf_atom_7e8ad928(v4) then
		v3:SetCameraSpot(nil, 0.25)
	end
end

local function fn5(instance, _) -- 1 equivalent call inferred from this helper
	if not __wf_atom_7e8ad928(instance) then
		local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(__wf_atom_3ae8d73b)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:FirePort("Destroy")
		end

		instance:Disable()
	end
end

function BalloonRelease(instance, object)
	local v3 = { START = 1, LOOP = 2, END = 3 }
	local start = v3.START
	local flag2 = true

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
	end

	local v4 = nil
	local total = 0
	local flag3 = false
	local v5 = false

	while not __wf_atom_7e8ad928(object) do
		if flag2 then
			local enemyReleaseBalloonStartAnim2

			if start == v3.START then
				enemyReleaseBalloonStartAnim2 = enemyReleaseBalloonStartAnim
			elseif start == v3.LOOP then
				enemyReleaseBalloonStartAnim2 = enemyReleaseBalloonLoopAnim
				flag3 = true
			else
				if start ~= v3.END then
					v5 = true
					break
				end

				enemyReleaseBalloonStartAnim2 = enemyReleaseBalloonEndAnim
				fn5(instance) -- inferred equivalent call
			end

			if not __wf_atom_7e8ad928(object) then
				if flag3 then
					object:__wf_atom_9b5dcd3b(enemyReleaseBalloonStartAnim2, false, 3, 2, false)
					v4 = 3
					flag3 = false
				else
					object:__wf_atom_9b5dcd3b(enemyReleaseBalloonStartAnim2, false, 3, 1, false)
					v4 = enemyReleaseBalloonStartAnim2:__wf_atom_8bb4ded3()
				end
			end

			flag2 = false
		end

		if flag then
			fn4(object, 19)

			if __wf_atom_7e8ad928(instance) then
				break
			end

			instance:Enable()
			break
		else
			if not flag2 then
				Sleep(0)
				total += __wf_atom_084b3e93()
			end

			if v4 <= total then
				start += 1
				flag2 = true
				total = 0
			end
		end
	end

	if v5 and not __wf_atom_7e8ad928(instance) then
		local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			__wf_atom_3d96ddcd:__wf_atom_0e990c03(v2.ACTIVATED)
		end

		instance:Destroy()
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(Symbol("UseAction"))
		end
	end
end

local function fn6(instance)
	local position = instance:GetPosition()
	local __wf_atom_dc309f8a = instance:__wf_atom_dc309f8a()

	if not __wf_atom_7e8ad928(lanternsSetFreeEffect) then
		gRegion:CreateEntity(lanternsSetFreeEffect, position, __wf_atom_dc309f8a)
	end

	Sleep(2)

	if not __wf_atom_7e8ad928(instance) then
		instance:__wf_atom_0e990c03(v2.INTERCEPTED)
	end
end

local function fn7(object)
	if randomFlightChance <= 0 then
		return
	end

	local v3 = Vector(50, 200, 50)
	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local v4 = position + v3
	local v5 = Distance(position, v4) / 5
	local total = 0
	Vector(0, 0, 0)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(WeakResource("/SF/Objects/GameplayProps/Lantern/BalloonCrateAppendLanternEffectDeco"))
	local __wf_atom_c6f1f83d = __wf_atom_bb3e7833:__wf_atom_c6f1f83d()

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(chainAttachment)
		local __wf_atom_bb3e7833_3 = object:__wf_atom_bb3e7833(chainFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
			__wf_atom_bb3e7833_2:Destroy()
		end

		if not (__wf_atom_7e8ad928(chainFxType) or __wf_atom_7e8ad928(__wf_atom_bb3e7833_3)) then
			__wf_atom_bb3e7833_3:Destroy()
		end
	end

	while
		not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(__wf_atom_bb3e7833)
		and total <= v5
		and __wf_atom_c6f1f83d <= __wf_atom_bb3e7833:__wf_atom_c6f1f83d()
	do
		local v6 = (total / v5) ^ 2
		object:Teleport(__wf_atom_f55d6358(position, v4, v6), __wf_atom_dc309f8a)
		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	if v5 <= total then
		object:__wf_atom_0e990c03(v2.ASCENDED)

		if not __wf_atom_7e8ad928(object) then
			gRegion:__wf_atom_dd1e4d10(object)
		end
	end
end

function Balloon(instance)
	module.WaitForPlayer()
	local v3 = nil
	local position = nil
	local v4 = nil
	instance:__wf_atom_5b41f63b()
	local v5

	if randomFlightChance > 0 then
		v5 = __wf_atom_5784a397(3, 15)
	end

	local total = 0

	while not __wf_atom_7e8ad928(instance) do
		v3 = instance:__wf_atom_f2317dfd()

		if v3 == v2.CREATED then
			if forceNavOffset then
				fn(instance)
			end
		elseif v3 == v2.IDLE then
			if randomFlightChance > 0 then
				if v5 < total then
					instance:__wf_atom_0e990c03(v2.ASCENDING)
				else
					total += __wf_atom_084b3e93()
				end
			end
		elseif v3 == v2.ACTIVATED then
			fn2(instance)
		elseif v3 == v2.ASCENDING then
			fn7(instance)
		else
			if v3 == v2.ASCENDED then
				break
			end

			if v3 == v2.LOOTING then
				fn6(instance)
			elseif v3 == v2.INTERCEPTED then
				break
			end
		end

		Sleep(0)
	end

	if v3 == v2.INTERCEPTED and not __wf_atom_7e8ad928(instance) and isObjective then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local v6 = WeakResource("/SF/Types/Game/Encounters/Ode/Objectives/BalloonObjectiveEncounter")
		local v7 = { (__wf_atom_7d789620:__wf_atom_610f689a(WeakResource(v6))) }
		local hint = module2.GetHintWithRegisteredObject(v7, instance)

		if not __wf_atom_7e8ad928(hint) then
			while instance:__wf_atom_f2317dfd() ~= v2.DESTROY and hint:__wf_atom_4026dfb5() ~= 0 do
				Sleep(0)
			end
		end
	end

	if not __wf_atom_7e8ad928(instance) then
		position = instance:GetPosition()
		v4 = instance:__wf_atom_dc309f8a()
		instance:Destroy()
		local nearestTagged = gRegion:FindNearestTagged(v, position)

		if not __wf_atom_7e8ad928(nearestTagged) then
			nearestTagged:FirePort("Enable")
		end
	end

	if v3 == v2.INTERCEPTED then
		Sleep(0)
		gRegion:CreateEntity(physicsCrate, position, v4)

		if not __wf_atom_7e8ad928(balloonReleaseSound) then
			instance:PlaySound(balloonReleaseSound, false)
		end
	end
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	flag = true
	object:__wf_atom_3ede53b4(Symbol("InteruptDamage"))
end

function OnLanternDestroyed(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_6a50bd07) then
		__wf_atom_3d96ddcd:__wf_atom_0e990c03(v2.INTERCEPTED)
	end
end

function LanternSetFree(p)
	fn7(p, 5)
end