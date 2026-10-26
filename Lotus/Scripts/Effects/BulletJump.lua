local module = require("Lotus.Scripts.Effects.EffectsColorUtilities")
local v = WeakResource("/Lotus/Fx/Gameplay/Movement/BulletJumpTrailA")
local v2 = {
	Symbol("GAME_L1_LEG2"),
	Symbol("GAME_R1_LEG2"),
	Symbol("GAME_L1_ARM2"),
	Symbol("GAME_R1_ARM2"),
	Symbol("GAME_C1_SPINE1"),
	Symbol("GAME_C1_SPINE2"),
	Symbol("GAME_C1_HEAD1")
}
local v3 = {
	WeakResource("/EE/Types/Game/Avatar"),
	WeakResource("/EE/Types/Engine/HitProxy"),
	WeakResource("/EE/Types/Physics/Ragdoll"),
	WeakResource("/EE/Types/Game/PickUp")
}

function BulletJumpEffects(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if
		__wf_atom_7e8ad928(__wf_atom_f7e7be53)
		or not (__wf_atom_f7e7be53:IsA(__wf_atom_7e6ed5fa) and __wf_atom_f7e7be53:__wf_atom_8efce136())
	then
		return
	end

	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local postProcessBias = __wf_atom_8ad59546.postProcessBias
	local total = 0

	while total < 1 do
		if __wf_atom_7e8ad928(__wf_atom_8ad59546) then
			return
		end

		total += __wf_atom_084b3e93()
		postProcessBias.radialBlurStrength = (1 - math.abs(math.pow(total, 0.3) * 2 - 1)) * 0.75
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
		postProcessBias.radialBlurStrength = 0
	end
end

function BulletJumpEffectsDisabled(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	for _ = 1, #v2 do

	end

	local __wf_atom_d0069154 = __wf_atom_3d96ddcd:__wf_atom_d0069154()
	Rotation()
	local entity = gRegion:CreateEntity(
		ringParticleType,
		__wf_atom_d0069154,
		__wf_atom_3d96ddcd:__wf_atom_2f2bada0(),
		__wf_atom_3d96ddcd
	)
	Sleep(0)

	while not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(__wf_atom_3d96ddcd)) do
		local __wf_atom_d0069154_2 = __wf_atom_3d96ddcd:__wf_atom_d0069154()
		__wf_atom_d0069154 = __wf_atom_f55d6358(__wf_atom_d0069154, __wf_atom_d0069154_2, 0.3)
		local v4 = __wf_atom_fa8d0177(__wf_atom_d0069154, __wf_atom_d0069154_2)
		local v5 = math.min(20, __wf_atom_3d96ddcd:__wf_atom_ee4f0cba())
		entity:__wf_atom_7ec722f0(v5 * 0.5, v5 * 0.8)
		entity:__wf_atom_2f54f673(v5 * 3, v5 * 6, false)
		entity:SetPosition(__wf_atom_d0069154)
		entity:__wf_atom_9b788a35(v4)
		Sleep(0)
	end
end

local function fn(data)
	local v4 = Vector(data.x + math.random(-6, 6), data.y - math.random(-6, 6), data.z + math.random(-6, 6))
	local v5 = Vector()
	local v6 = 0

	while v6 < 2 do
		if gRegion:__wf_atom_c20d246a(data, v4, v3, nil, v5) then
			v6 = 5
		else
			v6 += 1
			v4 = Vector(data.x + math.random(-5, 5), data.y + math.random(-5, 5), data.z + math.random(-5, 5))
		end
	end

	return v5
end

function ElectricalAttach(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local particleQuality = module.ParticleQuality()

	if particleQuality == 0 or __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local v4 = 0.6
	local v5 = 0.05
	local total = 1

	while v4 > 0 and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		if v5 < total then
			local v6 = v2[math.random(1, #v2)]
			local v7 = fn(__wf_atom_3d96ddcd:__wf_atom_1c374cc9(v6))

			if v7 ~= __wf_atom_28d5d4aa then
				local v8 = __wf_atom_3d96ddcd:Attach(
					beamType,
					v6,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_3d96ddcd
				)

				if not __wf_atom_7e8ad928(v8) then
					v8:__wf_atom_a64eca67(v7)
					gRegion:CreateEntity(beamEndPointType, v7, __wf_atom_80368bb1)
				end
			end

			v5 = Random(0.08, 0.12) / particleQuality
			total = 0
		end

		Sleep(0)
		v4 -= __wf_atom_084b3e93()
		total += __wf_atom_084b3e93()
	end
end

function ElectricalHop(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if module.ParticleQuality() == 0 or __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_f5bac0e4 = object:__wf_atom_f5bac0e4()
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v4 = __wf_atom_3d96ddcd:Attach(
		beamType,
		__wf_atom_f5bac0e4,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		__wf_atom_3d96ddcd
	)

	if not __wf_atom_7e8ad928(v4) then
		v4:__wf_atom_a64eca67(__wf_atom_a2a18137)
	end
end

function IceAttach(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if module.ParticleQuality() == 0 or __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local v4 = __wf_atom_3d96ddcd:__wf_atom_a2a18137() - Vector(0, 0.2, 0)
	local __wf_atom_74d951b0 = __wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_74d951b0()
	local v5 = __wf_atom_fa8d0177(v4, __wf_atom_74d951b0)
	v5.pitch -= 114

	if v5.pitch < -180 then
		v5.pitch += 360
	end

	local v6 = v4 - __wf_atom_74d951b0
	Normalize(v6)
	local v7 = Vector(v6.x * 0.2, v6.y * 0.2, v6.z * 0.2)
	gRegion:CreateEntity(iceDecoType, v4 + v7, v5)
	__wf_atom_3d96ddcd:Attach(localOnlyDecoType, Symbol("GAME_C1_HIP1"))
end

function FireAttach(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local particleQuality = module.ParticleQuality()

	if particleQuality == 0 or __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local v4 = 0.8
	local v5 = 0.05
	local total = 1

	while v4 > 0 and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		if v5 < total then
			local v6 = fn(__wf_atom_3d96ddcd:__wf_atom_1c374cc9(v2[math.random(1, #v2)]))

			if v6 ~= __wf_atom_28d5d4aa then
				gRegion:CreateEntity(
					firePointEffect,
					v6,
					__wf_atom_fa8d0177(v6, __wf_atom_3d96ddcd:__wf_atom_d0069154())
				)
			end

			v5 = Random(0.05, 0.08) / particleQuality
			total = 0
		end

		local v6 = 0.8 - v4

		if v6 < 0.25 then
			local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(v)

			for i = 1, #__wf_atom_f582136d do
				__wf_atom_f582136d[i]:SetMaterialParam(SF.__wf_atom_f35beb09, v6 * 8)
				__wf_atom_f582136d[i]:SetMaterialParam(SF.__wf_atom_473a1df0, v6 * 3.2 + 0.2)
			end
		end

		Sleep(0)
		v4 -= __wf_atom_084b3e93()
		total += __wf_atom_084b3e93()
	end
end