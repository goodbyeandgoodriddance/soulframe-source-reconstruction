local v = Symbol("EntratiVialPuddle")
local v2 = Symbol("EnvFireGroundButton")

function CreatePuddle(object)
	local v3 = Vector(0, 0.5, 0)
	local v4 = object:GetPosition() + v3
	local v5 = object:GetPosition() + v3
	local decalSpawner = decalSpawner

	if not gRegion:__wf_atom_2202ffb6():__wf_atom_bd5c14eb(v5, 15, 2, allowedNodeFlags) or v5 == v4 then
		gRegion:__wf_atom_2202ffb6():__wf_atom_bd5c14eb(v5, 15, 5, allowedNodeFlags)
	end

	if not (v5.y < v4.y) then
		return
	end

	local __wf_atom_d5fda8be = object:__wf_atom_d5fda8be((Vector(v4.x, v5.y, v4.z)))

	if __wf_atom_d5fda8be < 1 then
		decalSpawner = decalSpawnerSmall
	end

	Sleep(math.sqrt(__wf_atom_d5fda8be * 2 / 9.8 * fallSpeedMultiplier) + 1 / __wf_atom_5784a397(20, 50))
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v, v5, 0, 10)
	local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(v2, v5, 0, fireExtinguishRange)

	for _, v6 in ipairs(__wf_atom_439c0d29_2) do
		if __wf_atom_7e8ad928(v6) or not v6:IsEnabled() or v6:__wf_atom_b81a6e66() then
			continue
		end

		v6:Activate()
	end

	if #__wf_atom_439c0d29 > 2 and #gRegion:__wf_atom_439c0d29(v, v5, 0, 4) > 0 then
		return
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_e0933a42 = object:__wf_atom_e0933a42()
		local entity = gRegion:CreateEntity(decalSpawner, v5, __wf_atom_80368bb1)

		if not (__wf_atom_7e8ad928(__wf_atom_e0933a42) or __wf_atom_7e8ad928(entity)) then
			entity:__wf_atom_7ebba814(__wf_atom_e0933a42)
		end
	end
end