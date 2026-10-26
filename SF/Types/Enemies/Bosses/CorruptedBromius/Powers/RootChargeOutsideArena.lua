require("Lotus.Scripts.Libs.AbilitiesLib")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = {
	{ tag = Symbol("PunctInvulnerable"), dmgType = 1 },
	{ tag = Symbol("ImpactInvulnerable"), dmgType = 0 },
	{ tag = Symbol("SlashInvulnerable"), dmgType = 2 }
}
local v2 = nil

local function fn(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v2) then
		return __wf_atom_28d5d4aa
	end

	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local __wf_atom_9a1e4ed3 = object:__wf_atom_9a1e4ed3()
	local entity

	if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		entity = __wf_atom_9a1e4ed3.entity
	end

	if __wf_atom_7e8ad928(entity) then
		if not __wf_atom_7e8ad928(object:__wf_atom_50a7d83e()) then
			__wf_atom_28d5d4aa = v2:__wf_atom_0e0a6fee(object:__wf_atom_50a7d83e():GetPosition())
		end

		return __wf_atom_28d5d4aa
	else
		local v3 = math.rad((__wf_atom_5784a397(-30, 30)))
		local cameraControl = entity:CameraControl()

		if __wf_atom_7e8ad928(cameraControl) then
			if __wf_atom_7e8ad928(object:__wf_atom_50a7d83e()) then
				return __wf_atom_28d5d4aa
			end

			return (v2:__wf_atom_0e0a6fee(object:__wf_atom_50a7d83e():GetPosition()))
		else
			local __wf_atom_9d937e7e = cameraControl:__wf_atom_9d937e7e()
			local v4 = __wf_atom_9341614d(
				Vector(
					buttSlamTestEndPosToTargetDistance * math.sin(v3),
					0,
					buttSlamTestEndPosToTargetDistance * math.cos(v3)
				),
				__wf_atom_9d937e7e
			) + entity:GetPosition()
			__wf_atom_28d5d4aa = v2:__wf_atom_0e0a6fee(v4)

			if not showDebug then
				return __wf_atom_28d5d4aa
			end

			gRegion:__wf_atom_5b35a0c8(__wf_atom_28d5d4aa + Vector(0, 0.2, 0), debugColour, "Butt Slam End pos", 1, 5)
			gRegion:__wf_atom_b5c21154(__wf_atom_28d5d4aa, 1, debugColour, Rotation(0, 90, 0), 5)
			return __wf_atom_28d5d4aa
		end
	end
end

function DissolveIn(object, dissolveInTime2)
	if dissolveInTime2 == nil then
		dissolveInTime2 = dissolveInTime
	end

	local v3 = dissolveInTime2

	while dissolveInTime2 > 0 do
		dissolveInTime2 -= __wf_atom_084b3e93()
		object:__wf_atom_68f2c268((__wf_atom_421b01aa(dissolveInTime2 / v3, 0, 1)))
		Sleep(0)
	end
end

function DissolveOut(object, dissolveOutTime2)
	if dissolveOutTime2 == nil then
		dissolveOutTime2 = dissolveOutTime
	end

	local total = 0

	while total < dissolveOutTime2 do
		total += __wf_atom_084b3e93()
		object:__wf_atom_68f2c268((__wf_atom_421b01aa(total / dissolveOutTime2, 0, 1)))
		Sleep(0)
	end
end

function DissolveOutTime(object, _, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	DissolveOut(__wf_atom_6009c8ed, p)
end

function DissolveInTime(object, _, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	DissolveIn(__wf_atom_6009c8ed, p)
end

local function fn2(object)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	for _, v3 in pairs(v) do
		__wf_atom_7470861b:__wf_atom_9fba31e6(v3.tag, v3.dmgType, 6, 0)
	end
end

local function fn3(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_7470861b = object:__wf_atom_7470861b()

		for _, v3 in pairs(v) do
			__wf_atom_7470861b:__wf_atom_63396172(v3.tag)
		end
	end
end

local function fn4(object, p, p2, p3, callback)
	local position = object:GetPosition()
	local midpoint = (position + p) / 2
	midpoint.y += 2 * p2
	local total = 0

	while total < p3 do
		local v3

		if callback == nil then
			v3 = total / p3
		else
			v3 = callback(total / p3)
		end

		object:SetPosition(math.pow(1 - v3, 2) * position + (1 - v3) * 2 * v3 * midpoint + math.pow(v3, 2) * p)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	object:SetPosition(p)
end

function NpcEvaluateAbility(_, object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_9a1e4ed3().entity) then
		return 0
	end

	return 1
end

local function fn5(p, p2) -- 2 equivalent calls inferred from this helper
	local v3 = __wf_atom_fa8d0177(p, p2)
	v3.pitch = 0
	v3.bank = 0
	return v3
end

function ActivateAbility(object, object2, _)
	if gRegion:IsMaster() then
		if __wf_atom_7e8ad928(object2) then
			return
		end

		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

		if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			return
		end

		local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

		if __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
			return
		end

		v2 = __wf_atom_2202ffb6:__wf_atom_7d789620()

		if __wf_atom_7e8ad928(v2) then
			return
		end

		local v3 = fn(__wf_atom_30e3d82b)
		local v4 = math.rad((__wf_atom_5784a397(-180, 180)))
		local v5 = Rotation(0, 0, 0)
		local v6 = __wf_atom_9341614d(
			Vector(buttSlamStartDistance * math.sin(v4), 0, buttSlamStartDistance * math.cos(v4)),
			v5
		) + v3
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		module.SetImmunity(object2, true)
		object2:SetDisableGravity(true)
		object2:__wf_atom_d1b42aad(false)
		fn2(object2)

		if showDebug then
			gRegion:__wf_atom_5b35a0c8(v6 + Vector(0, 0.2, 0), debugColour, "Butt Slam Start pos", 1, 5)
			gRegion:__wf_atom_b5c21154(v6, 1, debugColour, Rotation(0, 90, 0), 5)
		end

		object2:__wf_atom_921c1a5f(gooEnterAnim, true, 2, 1, true)
		object2:Attach(gooEnterFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		local secondaryScriptArgs = SF.SecondaryScriptArgs(true)

		if not __wf_atom_7e8ad928(secondaryScriptArgs) then
			secondaryScriptArgs:__wf_atom_079cbbd0(dissolveOutTime)

			if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(mOwner)) then
				object:ActivateSecondaryScript(
					mOwner:__wf_atom_e14d8a8c(),
					Symbol("DissolveOutTime"),
					secondaryScriptArgs
				)
			end
		end

		Sleep(dissolveOutTime)
		local v7 = fn5(v6, v3) -- inferred equivalent call
		object2:Teleport(v6, v7)
		object2:__wf_atom_84d66e8e(v7)
		Sleep(0.1)
		local v8 = fn5(object2:GetPosition(), v3) -- inferred equivalent call
		object2:Teleport(object2:GetPosition(), v8)
		__wf_atom_30e3d82b:__wf_atom_b783ff91(v3)
		Sleep(__wf_atom_5784a397(JumpOutWaitTime.minValue, JumpOutWaitTime.maxValue))
		local v9 = fn(__wf_atom_30e3d82b)
		local entity = gRegion:CreateEntity(slamTelegraphFX, v9 - Vector(0, 0, 0), __wf_atom_80368bb1)
		local __wf_atom_921c1a5f = object2:__wf_atom_921c1a5f(buttSlamAnim, false, 2, 1, true)
		local v10 = buttSlamAnim:__wf_atom_091354f5(Symbol(buttSlamEvent)) * __wf_atom_921c1a5f
		object2:__wf_atom_8914dfde("AnimStart", 1)
		local secondaryScriptArgs2 = SF.SecondaryScriptArgs(true)

		if not __wf_atom_7e8ad928(secondaryScriptArgs2) then
			secondaryScriptArgs2:__wf_atom_079cbbd0(dissolveInTime)

			if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(mOwner)) then
				object:ActivateSecondaryScript(
					mOwner:__wf_atom_e14d8a8c(),
					Symbol("DissolveInTime"),
					secondaryScriptArgs2
				)
			end
		end

		fn4(object2, v9, 0, v10)
		module.SetImmunity(object2, false)

		if not __wf_atom_7e8ad928(slamFX) then
			gRegion:CreateEntity(slamFX, v9, __wf_atom_80368bb1, object2, object2, 1)
		end

		if not __wf_atom_7e8ad928(entity) then
			entity:Destroy()
		end
	else
		object2:__wf_atom_78ad8b9f(128, 1)
		object2:SetDisableGravity(true)
		object2:__wf_atom_d1b42aad(false)

		while not object2:__wf_atom_c138b19b(buttSlamAnim) do
			Sleep(0)
		end

		object2:__wf_atom_8914dfde(buttSlamEvent, 10)
	end
end

function DeactivateAbility(_, object, _, _)
	if gRegion:IsMaster() and not __wf_atom_7e8ad928(object) then
		fn3(object)
		module.SetImmunity(object, false)
	end

	if not __wf_atom_7e8ad928(object) then
		object:SetDisableGravity(false)
		object:__wf_atom_d1b42aad(true)
		object:MotionControl():__wf_atom_3959d938(false)
	end
end