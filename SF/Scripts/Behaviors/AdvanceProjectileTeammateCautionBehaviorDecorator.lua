local function fn(object, p)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(p) then
		return true
	end

	local __wf_atom_a07433fe = __wf_atom_35a10d3c:__wf_atom_a07433fe()

	if
		__wf_atom_7e8ad928(__wf_atom_a07433fe)
		or not __wf_atom_a07433fe:IsA(__wf_atom_ed85f483)
		or __wf_atom_a07433fe:__wf_atom_69525515() ~= advancedProjectileIndex
	then
		return true
	end

	if not allowSelfNearEnemy and object:__wf_atom_9af7625d(p) < nearbyDistance * nearbyDistance then
		return false
	end

	local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()
	local count = 0

	for i = 1, #__wf_atom_694c2c5b do
		if not (__wf_atom_694c2c5b[i] ~= object and __wf_atom_694c2c5b[i]:__wf_atom_9af7625d(p) < nearbyDistance * nearbyDistance) then
			continue
		end

		count += 1

		if maximumTeammatesAllowedNearEnemy < count then
			return false
		end
	end

	return true
end

function Evaluate(p, p2)
	return (fn(p, p2))
end

function Activate(_, _) end

function Update(p, p2)
	if fn(p, p2) then
		return
	else
		return true
	end
end

function Deactivate(_, _) end