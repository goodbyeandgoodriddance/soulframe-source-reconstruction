local module = require("SF.Scripts.Libs.RaycastLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
local minValue = 0.85
local maxValue = 0.05
local v = Range(0.5, 0.8)
local v2 = WeakResource("/SF/Scripts/Npc/SubbossRednightResourceSpawn.lua")
local v3 = {}
local entities = {}
local v4 = nil

local function fn(groundPos)
	local v5 = mushroomSpawn - 1
	local v6 = 360 / v5

	for i = 1, v5 do
		local v7 = i * v6 + __wf_atom_5784a397(-variation, variation)
		local v8 = spawnDistanceFromInstigator.minValue + math.random() * (spawnDistanceFromInstigator.maxValue - spawnDistanceFromInstigator.minValue)
		local v9 = groundPos + __wf_atom_9341614d(Vector(v8, 0, 0), Rotation(v7, 0, 0))
		local __wf_atom_0e0a6fee = v4:__wf_atom_0e0a6fee(v9)
		local groundPos2 = module.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
		table.insert(v3, i, groundPos2)
	end

	table.insert(v3, mushroomSpawn, groundPos)
end

function easeOutElastic(p)
	if p == 0 then
		return 0
	elseif p == 1 then
		return 1
	end

	return math.pow(2, -10 * p) * math.sin((p * 10 - 0.75) * 2.0943951023931953) + 1
end

function GrowShroom(instance)
	local v5 = not instance:IsA(__wf_atom_8d0b7f88) and 0.9 or Random(v.minValue, v.maxValue)
	instance:SetMeshScale(0.01)
	local total = 0

	while total < v5 and not __wf_atom_7e8ad928(instance) do
		total += __wf_atom_084b3e93() * scaleSpeed
		instance:SetMeshScale(easeOutElastic(total) * v5, true)
		Sleep(0)
	end
end

function DissolveOutRagdoll(instance)
	local v5

	if instance:IsA(__wf_atom_67c46eba) then
		v5 = instance:__wf_atom_f51f1faa()

		while __wf_atom_7e8ad928(v5) do
			v5 = instance:__wf_atom_f51f1faa()
			Sleep(0)
		end
	elseif instance:IsA(__wf_atom_43e0c427) then
		v5 = instance
	else
		return
	end

	Sleep(postDeathDelay)

	if not __wf_atom_7e8ad928(v5) then
		local v6 = 0

		while not __wf_atom_7e8ad928(v5) and v6 < 1 do
			v6 = __wf_atom_421b01aa(v6 + __wf_atom_084b3e93() * 0.2, 0, 1)
			v5:__wf_atom_68f2c268(__wf_atom_421b01aa(v6 * 10, 0, 1))
			Sleep(0)
		end
	end
end

function SinkCorpse(object)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v5 = __wf_atom_a2a18137 - Vector(0, 1, 0)
	Sleep(0)
	local total = 0

	while not __wf_atom_7e8ad928(object) and total <= sinkBodyDuration do
		total += __wf_atom_084b3e93()
		local v6 = total / sinkBodyDuration
		object:Teleport(__wf_atom_f55d6358(__wf_atom_a2a18137, v5, __wf_atom_24a82b69(v6)))
		Sleep(0)
	end
end

function OnSubBossDeath(instance)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	if instance:IsA(__wf_atom_43e0c427) then
		if not __wf_atom_7e8ad928(instance:__wf_atom_6009c8ed()) then
			instance = instance:__wf_atom_6009c8ed()
		end
	else
		instance:__wf_atom_7470861b():__wf_atom_f756036f(false)
	end

	if shouldSinkBody then
		instance:__wf_atom_8a035cd5(Symbol("SinkCorpse"), false)
	end

	local __wf_atom_a2a18137 = instance:__wf_atom_a2a18137()
	v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_0e0a6fee = v4:__wf_atom_0e0a6fee(__wf_atom_a2a18137)
	local groundPos = module.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
	local v5

	if not __wf_atom_7e8ad928(hiddenHelperDecoType) then
		v5 = gRegion:CreateEntity(
			hiddenHelperDecoType,
			Vector(groundPos.x, groundPos.y + 0.1, groundPos.z),
			__wf_atom_80368bb1,
			nil,
			nil
		)
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:__wf_atom_8a035cd5(Symbol("SpawnShroomRing"), false)
	end
end

function SpawnShroomRing(object)
	v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if __wf_atom_7e8ad928(object) then
		return
	end

	Sleep(spawnDelay)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local __wf_atom_0e0a6fee = v4:__wf_atom_0e0a6fee(__wf_atom_a2a18137)
	local groundPos = module.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
	fn(groundPos)
	Sleep(0.2)

	for k, v5 in pairs(v3) do
		if k == mushroomSpawn then
			local entity = gRegion:CreateEntity(
				mushroomPickup,
				Vector(groundPos.x, groundPos.y + 0.1, groundPos.z),
				__wf_atom_80368bb1,
				nil,
				nil
			)
			entity:__wf_atom_51009507(Resource(v2), Symbol("GrowShroom"), false)
			entity:PlaySound(mushroomFinalSpawnSound, false, 1, false)

			if __wf_atom_7e8ad928(mushroomPickupFX) then
				break
			end

			entity:Attach(mushroomPickupFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			break
		else
			local v6 = __wf_atom_fa8d0177(v5, groundPos)
			local v7 = mushroomDeco[__wf_atom_5784a397(1, #mushroomDeco)]
			local entity = gRegion:CreateEntity(v7, v5, v6, nil, nil)
			entity:PlaySound(mushroomSpawnSound, false, 1, false)
			entity:__wf_atom_51009507(Resource(v2), Symbol("GrowShroom"), false)
			table.insert(entities, entity)
			local v8 = k / #v3
			local v9 = __wf_atom_24a82b69(v8)
			local v10 = __wf_atom_104bfe98(minValue, maxValue, v9)
			Sleep(v10)
		end
	end

	if not __wf_atom_7e8ad928(object) then
		gRegion:__wf_atom_dd1e4d10(object)
	end
end

function SpawnRing(object, data)
	mushroomDeco = data.deco
	mushroomSpawn = data.spawn
	spawnDelay = data.delay or 1.5
	variation = data.variation or 1.5
	spawnDistanceFromInstigator = data.spawnDistanceFromInstigator or Range(2, 4)
	minValue = data.waitRange.minValue or 1
	maxValue = data.waitRange.maxValue or 3
	mushroomPickup = data.pickUp
	shouldSinkBody = data.sink or false
	mushroomPickupFX = data.pickupFX
	mushroomSpawnSound = data.spawnSound
	mushroomFinalSpawnSound = data.finalSound
	hiddenHelperDecoType = Type("/SF/Types/Gameplay/SFHiddenDeco")
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local entity = gRegion:CreateEntity(
		hiddenHelperDecoType,
		Vector(__wf_atom_a2a18137.x, __wf_atom_a2a18137.y + 0.1, __wf_atom_a2a18137.z),
		__wf_atom_80368bb1,
		nil,
		nil
	)
	SpawnShroomRing(entity)
end