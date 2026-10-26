local v = {}
local module = require("SF.Scripts.Libs.CommonFunctionsLib")

local function fn(p, p2)
	local flag = false

	for _, v2 in ipairs(v) do
		if p == v2 then
			flag = true
		end
	end

	if flag then
		return flag
	end

	local nearestTagged = gRegion:FindNearestTagged(ignoredZoneTag, p2)

	if
		not __wf_atom_7e8ad928(nearestTagged)
		and gRegion:__wf_atom_ec87469e(nearestTagged:GetPosition()):GetLayerIndex() == p
	then
		table.insert(v, p)
		flag = true
	end

	return flag
end

local function fn2(object) -- 3 equivalent calls inferred from this helper
	local v2

	if not __wf_atom_7e8ad928(object) then
		return (object:GetLayerIndex())
	end

	return v2
end

function ToggleProcWeenies()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(fittingTag)
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(toggleTag)
	local v2 = {}
	local v3 = {}
	local v4 = {}

	for _, door in ipairs(__wf_atom_2226b35c) do
		local position = door:GetPosition()
		local __wf_atom_a06d543c = door:__wf_atom_a06d543c()
		local v5 = position + yOffset + __wf_atom_a06d543c * fwMultiplier
		local v6 = position + yOffset - __wf_atom_a06d543c * fwMultiplier
		local endId = fn2(gRegion:__wf_atom_ec87469e(v5)) -- inferred equivalent call
		local startId = fn2(gRegion:__wf_atom_ec87469e(v6)) -- inferred equivalent call
		local v7 = {}

		if fn(startId, v6) or fn(endId, v5) then
			continue
		end

		v7.door = door
		v7.startId = startId
		v7.endId = endId
		table.insert(v2, v7)
	end

	for _, v5 in ipairs(__wf_atom_2226b35c2) do
		local position = v5:GetPosition()
		local v6 = fn2(gRegion:__wf_atom_ec87469e(position)) -- inferred equivalent call

		if __wf_atom_7e8ad928(v6) then
			continue
		end

		if __wf_atom_7e8ad928(v3[v6]) then
			v3[v6] = {}
		end

		table.insert(v3[v6], v5)
	end

	for _, v5 in ipairs(v2) do
		local v6 = { v5.startId, v5.endId }

		for i, _ in ipairs(v6) do
			local nearestObject = module.NearestObject(
				v5.door:GetPosition(),
				v3[v6[i]],
				weenieMaxRangeFromFitting,
				false,
				true
			)

			if not __wf_atom_7e8ad928(nearestObject) then
				table.insert(v4, v3[v6[i]][nearestObject])
			end
		end
	end

	for _, v5 in ipairs(v4) do
		if not __wf_atom_7e8ad928(v5) then
			v5:FirePort(triggerPortName)
		end
	end
end