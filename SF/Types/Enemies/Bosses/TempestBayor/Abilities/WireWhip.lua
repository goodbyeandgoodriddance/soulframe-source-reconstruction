require("Lotus.Scripts.Libs.AbilitiesLib")
Symbol("Reposition_Air_Pos")
Symbol("Reposition_Ground_Pos")
local v = Symbol("RopeCut")
local v2 = Symbol("GAME_C1_SPINE1")

function NPCEvaluateAbility(_, _)
	return 1
end

local function fn(object) -- 3 equivalent calls inferred from this helper
	return "BayorWireWhip" .. object:__wf_atom_5b41f63b()
end

local function fn2(instance, entity, p)
	local beam = nil
	local __wf_atom_1c374cc9 = instance:__wf_atom_1c374cc9(HAND_BONE_SYMBOL)
	local v3 = fn(instance) -- inferred equivalent call
	_T[v3] = {}
	local v4

	if not __wf_atom_7e8ad928(entity) then
		v4 = entity:__wf_atom_1c374cc9(v2)
	end

	_T[v3].target = entity
	local v5 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, v4)
	local entity2 = gRegion:CreateEntity(projType, __wf_atom_1c374cc9, v5)
	instance:__wf_atom_921c1a5f(pullAnim, false, 2, 1, false)

	if not __wf_atom_7e8ad928(entity2) then
		_T[v3].proj = entity2
		beam = gRegion:CreateEntity(beamType, entity2:__wf_atom_a2a18137(), __wf_atom_80368bb1, p)

		if not __wf_atom_7e8ad928(beam) then
			_T[v3].beam = beam
			entity2:AttachEntity(beam, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	Vector()

	if not __wf_atom_7e8ad928(beam) then
		beam:__wf_atom_a64eca67(__wf_atom_1c374cc9)
	end

	if not __wf_atom_7e8ad928(entity2) then
		entity2:__wf_atom_8fcdea81(instance)
		entity2:SetTarget(entity)
	end
end

function ActivateAbility(p, instance, entity, _)
	if __wf_atom_7e8ad928(instance) or instance:HasTag(v) then
		return
	end

	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
	end

	if __wf_atom_7e8ad928(entity) then
		if
			__wf_atom_7e8ad928(instance:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3())
			or __wf_atom_7e8ad928(instance:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity)
		then
			return
		else
			entity = instance:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
		end
	end

	fn2(instance, entity, p)

	if gRegion:IsMaster() then
		local v3 = 1

		while v3 > 0 do
			Sleep(0)
			v3 -= __wf_atom_084b3e93()
		end

		local v4 = fn(instance) -- inferred equivalent call

		if __wf_atom_7e8ad928(_T[v4]) then
			return
		end

		if not __wf_atom_7e8ad928(_T[v4].proj) then
			_T[v4].proj:Destroy()
		end

		if not __wf_atom_7e8ad928(_T[v4].beam) then
			_T[v4].beam:Destroy()
			instance:PlaySound(soundDetach, false, 0, true)
		end
	end
end

function OnEmbed(object, p)
	local __wf_atom_e55d02aa = object:__wf_atom_7be51ede():__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local secondaryScriptArgs = SF.SecondaryScriptArgs(true)

	if __wf_atom_7e8ad928(p) then
		__wf_atom_e55d02aa:ActivateSecondaryScript(abilityType, Symbol("OnHitGround"), secondaryScriptArgs)
		return
	end

	secondaryScriptArgs:__wf_atom_a17e41c6(p)
	__wf_atom_e55d02aa:ActivateSecondaryScript(abilityType, Symbol("OnHitPlayer"), secondaryScriptArgs)
end

function OnHitPlayer(object, _, object2)
	local damageData = Engine.DamageData()
	damageData.baseAmount = 30
	damageData.stabilityDamage = 50
	damageData:__wf_atom_7498285f(5, 1)
	damageData:__wf_atom_d6f4d914(5, true)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local v3 = fn(__wf_atom_6009c8ed) -- inferred equivalent call

	if __wf_atom_7e8ad928(_T[v3]) then
		return
	end

	local beam = _T[v3].beam
	local target = _T[v3].target
	local v4

	if not __wf_atom_7e8ad928(hitFX) then
		v4 = object2:Attach(hitFX, Symbol("GAME_C1_SPINE2"), __wf_atom_28d5d4aa)
	end

	if not __wf_atom_7e8ad928(beam) then
		beam:Destroy()
	end

	local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(beamType, HAND_BONE_SYMBOL)
	_T[v3].beam = __wf_atom_7ccf4243

	if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
		__wf_atom_7ccf4243:__wf_atom_a64eca67((target:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE2"))))
	end

	target:__wf_atom_649bf33e(damageData)
	target:__wf_atom_921c1a5f(onEmbedAnim, true, 4, 1, true)
	__wf_atom_6009c8ed:__wf_atom_921c1a5f(pullAnim, false, 2, 1, false)

	if not __wf_atom_7e8ad928(object2) then
		object2:PlaySound(slideSound, false, 0, true)
	end

	local motionControl = __wf_atom_6009c8ed:MotionControl()
	local v5 = 2.5
	local v6 = false

	while not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) do
		if not (__wf_atom_7e8ad928(__wf_atom_7ccf4243) or __wf_atom_7e8ad928(target)) then
			__wf_atom_7ccf4243:__wf_atom_a64eca67((target:__wf_atom_1c374cc9(v2)))
		end

		if not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(__wf_atom_6009c8ed)) then
			if not __wf_atom_7e8ad928(motionControl) then
				local v7 = __wf_atom_6009c8ed:GetPosition() - target:GetPosition()
				Normalize(v7)
				motionControl:__wf_atom_0d3a9295(100)
				motionControl:__wf_atom_2b8da3d2(Vector() - v7 * 50)
			end

			if not v6 and v5 < 2.5 and not __wf_atom_7e8ad928(VictimStruggleAnim) then
				target:__wf_atom_921c1a5f(VictimStruggleAnim, false, 2, 2, true)
				v6 = true
			end

			if __wf_atom_6009c8ed:__wf_atom_8a6b8fc3(target) < 2.5 or v5 < 0 then
				break
			end
		end

		Sleep(0)
		v5 -= __wf_atom_084b3e93()
	end

	if not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(motionControl)) then
		motionControl:__wf_atom_2b8da3d2(Vector())
		motionControl:__wf_atom_48af5046()
		motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
	end

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:PlaySound(soundDetach, false, 0, true)
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	if not (__wf_atom_7e8ad928(VictimStruggleAnim) or __wf_atom_7e8ad928(object2)) then
		target:__wf_atom_921c1a5f(nil, false, 3, 2, true)
	end

	if not __wf_atom_7e8ad928(_T[v3].beam) then
		_T[v3].beam:Destroy()
	end
end