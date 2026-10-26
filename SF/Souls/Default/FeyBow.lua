local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(_, _)
	return 0
end

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

local function fn(object)
	if not object:__wf_atom_4417a5d4() then
		return false
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_d2b2176d:__wf_atom_a028fd97(0) ~= 0 then
		return false
	end

	local state = __wf_atom_28224c27:GetState()

	if state ~= 0 and state ~= 15 and state ~= 7 then
		return false
	end

	if __wf_atom_d2b2176d:__wf_atom_8c72e763() == 2 then
		__wf_atom_d2b2176d:__wf_atom_76425737()
	end

	__wf_atom_28224c27:SetBehavior(0)
	__wf_atom_d2b2176d:__wf_atom_d3dcb68a(true, 0)
	return true
end

function PulseFX(p)
	local postProcessBias = gRegion:__wf_atom_8ad59546().postProcessBias
	local v = 0

	while v < 1 and not __wf_atom_7e8ad928(p) do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() * 2, 0, 1)
		local v2 = 1 - math.abs(v * 2 - 1)
		postProcessBias.radialBlurStrength = 4 * __wf_atom_24a82b69(v2)
		postProcessBias:__wf_atom_2bd5152a(0, 0, 0, v * 2)
		Sleep(0)
	end
end

function PulseDownFX(p)
	local postProcessBias = gRegion:__wf_atom_8ad59546().postProcessBias
	local v = 0

	while v < 1 and not __wf_atom_7e8ad928(p) do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() * 2, 0, 1)
		postProcessBias:__wf_atom_2bd5152a(0, 0, 0, (1 - v) * 2)
		Sleep(0)
	end
end

function RadialHit(p, instance)
	if instance:IsMaster() and instance:IsA(__wf_atom_4ebf67cb) and not instance:__wf_atom_4402f880(p) then
		if not _T.FeyHitEntities then
			_T.FeyHitEntities = {}
		end

		table.insert(_T.FeyHitEntities, instance)
		instance:__wf_atom_986f733d(Symbol("FeyHit"), 0.5)
	end
end

function ClearRadialHits(p)
	Sleep(3)
	__wf_atom_7e8ad928(p)

	if _T.FeyHitEntities then
		for i = 1, #_T.FeyHitEntities do
			local feyHitEntity = _T.FeyHitEntities[i]

			if not __wf_atom_7e8ad928(feyHitEntity) then
				feyHitEntity:__wf_atom_558ce619(Symbol("FeyHit"))
			end
		end
	end
end

local function fn2(object, p)
	local v = false
	local v2 = 6
	local v3 = nil
	return {
		Update = function()
			local v4 = 1
			local v5 = 1
			local __wf_atom_59cb39a4 = object:__wf_atom_59cb39a4()

			if __wf_atom_59cb39a4 then
				if v2 < 6 and object:__wf_atom_92aa9d91():__wf_atom_3911136e() and v2 > 0 then
					local v6 = math.pow(v2 / 6, 6)
					v4 = __wf_atom_104bfe98(1, 0.3, 1 - v6)
					v5 = math.max(0, 1 - math.pow((6 - v2) / 6, 0.25))
					object:__wf_atom_1ae4d42d((math.max(0.001, v5 * 6.5)))

					if __wf_atom_59cb39a4 then
						object:__wf_atom_30483d98()
						object:MotionControl():__wf_atom_4bb21efc(Vector(0, v6 * 6.5, 0))
					end
				end

				v2 = math.max(0, v2 - __wf_atom_084b3e93())
			else
				v2 = 6
			end

			if object:__wf_atom_4417a5d4() then
				object:__wf_atom_84dbc46b(v4)
				object:MotionControl():__wf_atom_5ab9523f(v5)
			end

			if v4 == 1 and not __wf_atom_7e8ad928(v3) then
				v3:Destroy()
			elseif v4 < 1 and __wf_atom_7e8ad928(v3) and not __wf_atom_7e8ad928(gravMultiOnFx) then
				v3 = object:Attach(gravMultiOnFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, p)
			end

			if v or not (__wf_atom_59cb39a4 and v4 < 1) then
				if not __wf_atom_59cb39a4 then
					v = false
				end
			else
				object:PlaySound(gravMultiOnIntialSound, false)
				object:Attach(gravBurstFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, p)
				v = true
			end
		end,
		Reset = function()
			module.EnableWeaponSlot(object, "Idol", false, 0)
			object:__wf_atom_84dbc46b(1)
			object:MotionControl():__wf_atom_5ab9523f(1)

			if not __wf_atom_7e8ad928(gravMultiOnFx) then
				local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(gravMultiOnFx)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			end
		end
	}
end

function ActivateAbility(object, object2, _, _)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local v = nil

	while not object2:IsKilled() do
		v = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

		if not __wf_atom_7e8ad928(v) then
			break
		end

		Sleep(0)
	end

	local v2 = 0.36

	while v2 > 0 and not (__wf_atom_7e8ad928(object2) or object2:IsKilled()) do
		v2 -= __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	if radialBoff then
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.stabilityDamage = 100
		radialDamageData.radius = 8
		radialDamageData:__wf_atom_6b472125(object2)
		radialDamageData:__wf_atom_34a8a27a(object)
		radialDamageData:__wf_atom_98d98d81(object2:__wf_atom_d0069154())
		radialDamageData:__wf_atom_12cf5317(400)
		radialDamageData:__wf_atom_d6f4d914(31, true)
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData.hitType = 3
		radialDamageData:__wf_atom_a8149853(Symbol("RadialHit"))
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		object2:Attach(aoeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		local entity = gRegion:CreateEntity(
			aoeRadiusDecoType,
			radialDamageData:__wf_atom_e5d0bedf(),
			__wf_atom_80368bb1
		)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetMeshScale(radialDamageData.radius)
		end
	end

	object:__wf_atom_6a4cf64f()
	local __wf_atom_e8008ec5 = object:__wf_atom_e8008ec5(mOwner)
	gRegion:IsMaster()
	local __wf_atom_4417a5d4 = object2:__wf_atom_4417a5d4()
	module.EnableWeaponSlot(object2, "Idol", true, 0)
	local v3 = false

	while not (object2:IsKilled() or __wf_atom_7e8ad928(v)) do
		if __wf_atom_4417a5d4 then
			if object:__wf_atom_1177eb5d(__wf_atom_e8008ec5) then
				v3 = v3 or fn(object2)
			elseif v3 then
				__wf_atom_d2b2176d:__wf_atom_d3dcb68a(false, 0)

				if v:__wf_atom_dedeec57() and not __wf_atom_d2b2176d:__wf_atom_d155ac2b() then
					__wf_atom_d2b2176d:__wf_atom_28cf035c()
				end

				v3 = v:__wf_atom_dedeec57()
			end
		end

		Sleep(0)
	end
end

function DeactivateAbility(p, object, _, _)
	if object:__wf_atom_4417a5d4() then
		object:__wf_atom_8a035cd5(Symbol("PulseDownFX"), false)
	end

	fn2(object, p):Reset()
end