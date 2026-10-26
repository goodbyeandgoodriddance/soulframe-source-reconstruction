local function fn(position, p) -- 2 equivalent calls inferred from this helper
	return (math.ceil(((p * 12 + position.x) * 34 + position.y) * 56 + position.z))
end

function RandSkelRandMat(object)
	if #meshes ~= 0 then
		local v = 1 + fn(object:GetPosition(), 43.21 + __wf_atom_084b3e93()) % #meshes -- inferred equivalent call
		object:__wf_atom_45cf0e1a(meshes[v], false, false)
	end

	if #mats ~= 0 then
		local v = 1 + fn(object:GetPosition(), 12.34 + __wf_atom_084b3e93()) % #mats -- inferred equivalent call
		object:__wf_atom_a887a262(0, mats[v], false)
	end
end

function FlyAwayFromPlayer(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		return
	end

	local v = position - __wf_atom_7be51ede:GetPosition()
	v.y = 0
	Normalize(v)
	local v2 = position + (v * fleeDistance + Vector(0, fleeHeight, 0))
	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / fleeTime, 0, 1)
		local v4 = __wf_atom_24a82b69(v3)
		__wf_atom_3d96ddcd:SetPosition((__wf_atom_f55d6358(position, v2, v4)))
		Sleep(0)
	end

	if destroyOnFlee then
		__wf_atom_3d96ddcd:Destroy()
	end

	Sleep(fleeResetTime)
	local position2 = __wf_atom_3d96ddcd:GetPosition()
	local v4 = 0

	while v4 < 1 do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() / (fleeTime * 4), 0, 1)
		local v5 = __wf_atom_24a82b69(v4)
		__wf_atom_3d96ddcd:SetPosition((__wf_atom_f55d6358(position2, position, v5)))
		Sleep(0)
	end
end

function BurstFxTrigger(object)
	if not __wf_atom_7e8ad928(burstFxType) then
		if AttachFx then
			object:Attach(burstFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		else
			local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
			gRegion:CreateEntity(burstFxType, __wf_atom_3d96ddcd:GetPosition(), __wf_atom_3d96ddcd:__wf_atom_dc309f8a())
		end
	end
end