local module = require("SF.Scripts.Libs.RaycastLib")
local v = {}
local entities = {}
local v2 = nil

local function fn(groundPos)
	local v3 = mushroomSpawn - 1
	local minValue = spawnDistanceFromInstigator.minValue
	local maxValue = spawnDistanceFromInstigator.maxValue

	for i = 1, v3 do
		local v4 = math.random() * 2 * 3.141592653589793
		local v5 = math.random() * (maxValue - minValue) + minValue
		local v6 = math.cos(v4) * v5
		local v7 = math.sin(v4) * v5
		local v8 = groundPos + Vector(v6, 0, v7)
		local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v8)
		local groundPos2 = module.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
		table.insert(v, i, groundPos2)
	end

	table.insert(v, mushroomSpawn, groundPos)
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
	local total = 0
	local pickupScale2

	if instance:IsA(__wf_atom_8d0b7f88) then
		pickupScale2 = Random(shroomRandomScaleRange.minValue, shroomRandomScaleRange.maxValue)
	else
		pickupScale2 = pickupScale
	end

	instance:SetMeshScale(0.01)

	while total < pickupScale2 and not __wf_atom_7e8ad928(instance) do
		total += __wf_atom_084b3e93() * scaleSpeed
		instance:SetMeshScale(easeOutElastic(total) * pickupScale2, true)
		Sleep(0)
	end
end

function SpawnShroomRing(object)
	v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	Sleep(spawnDelay)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(__wf_atom_a2a18137)
	local groundPos = module.GetGroundPos(__wf_atom_0e0a6fee, nil, Vector(0, -5, 0), nil, __wf_atom_28d5d4aa)
	fn(groundPos)
	Sleep(0.2)

	for k, v3 in pairs(v) do
		if k == mushroomSpawn then
			local entity = gRegion:CreateEntity(
				mushroomPickup,
				Vector(groundPos.x, groundPos.y + 0.1, groundPos.z),
				__wf_atom_80368bb1,
				nil,
				nil
			)
			entity:__wf_atom_8a035cd5(Symbol("GrowShroom"), false)
			entity:PlaySound(mushroomFinalSpawnSound, false, 1, false)

			if __wf_atom_7e8ad928(mushroomPickupFX) then
				break
			end

			entity:Attach(mushroomPickupFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			break
		else
			local v4 = __wf_atom_fa8d0177(v3, groundPos)
			local v5 = mushroomDeco[__wf_atom_5784a397(1, #mushroomDeco)]
			local entity = gRegion:CreateEntity(v5, v3, v4, nil, nil)
			entity:PlaySound(mushroomSpawnSound, false, 1, false)
			entity:__wf_atom_8a035cd5(Symbol("GrowShroom"), false)
			table.insert(entities, entity)
			local v6 = k / #v
			local v7 = __wf_atom_24a82b69(v6)
			local v8 = __wf_atom_104bfe98(0.85, 0.05, v7)
			Sleep(v8)
		end
	end
end