local v = nil
local flag = false
local v2 = nil
local v3 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}
local v4 = Symbol("WazzardDeath")

function Evaluate(object, _)
	if
		flag
		or __wf_atom_7e8ad928(decoToSpawn) and waypointDestinationTag == EMPTY_SYMBOL
		or __wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928((object:__wf_atom_30e3d82b()))
	then
		return false
	end

	if object:__wf_atom_7470861b():__wf_atom_bedb4e3f() then
		return true
	end

	return false
end

function Activate(object, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	v = nil

	if waypointDestinationTag ~= EMPTY_SYMBOL then
		local position = object:GetPosition()
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(waypointDestinationTag)
		local v5 = -1
		local v6 = 99999999

		for i = 1, #__wf_atom_2226b35c do
			if __wf_atom_7e8ad928(__wf_atom_2226b35c[i]) then
				continue
			end

			if v5 < 0 then
				v6 = __wf_atom_2226b35c[i]:__wf_atom_c215662d(position)
				v5 = i
			else
				local __wf_atom_c215662d = __wf_atom_2226b35c[i]:__wf_atom_c215662d(position)

				if __wf_atom_c215662d < v6 then
					v6 = __wf_atom_c215662d
					v5 = i
				end
			end
		end

		if v5 > 0 then
			v = __wf_atom_2226b35c[v5]
		end
	end

	if __wf_atom_7e8ad928(v) then
		if transformationAnimEvent ~= "" then
			object:__wf_atom_8914dfde(transformationAnimEvent, 3)
		end
	else
		v2 = gRegion:CreateEntity(
			pushTriggerOnDestination,
			v:GetPosition() + pushTriggerOffset,
			v:__wf_atom_dc309f8a(),
			object,
			object,
			1
		)

		if not __wf_atom_7e8ad928(v2) then
			v2:__wf_atom_b811702e(Symbol("WazzardTriggerToRemove"))
		end

		object:__wf_atom_8a035cd5(Symbol("CheckPreDeathAnim"), false)
		local v5 = v:GetPosition() + Vector(0, 1, 0)
		__wf_atom_30e3d82b:StartMoving(v5, 1, true, 1, 0.25, false)
		__wf_atom_30e3d82b:__wf_atom_4e6e77b6(v5, false)
		__wf_atom_30e3d82b:__wf_atom_f3031171()

		while
			not _T.MendicantPreDeathAnimEventHit
			and not __wf_atom_7e8ad928(object)
			and not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
			and __wf_atom_30e3d82b:__wf_atom_46292900()
			and not object:__wf_atom_58dabbc7()
		do
			Sleep(0.1)
		end
	end

	flag = true
end

function CheckPreDeathAnim(object)
	_T.MendicantPreDeathAnimEventHit = false

	if transformationAnimEvent ~= "" then
		object:__wf_atom_8914dfde(transformationAnimEvent, 3)
	end

	_T.MendicantPreDeathAnimEventHit = true
end

function Update(_, _) end

function Deactivate(instance, _)
	if not __wf_atom_7e8ad928(v2) then
		gRegion:__wf_atom_dd1e4d10(v2)
	end

	local position = instance:GetPosition()

	if not __wf_atom_7e8ad928(v) then
		position = v:GetPosition()
		instance:Teleport(position, instance:__wf_atom_dc309f8a())
	end

	_T.MendicantPreDeathAnimEventHit = nil
	local v5 = position + Vector(0, 0.1, 0)
	local v6 = v5 + Vector(0, -5, 0)
	local v7 = Vector()

	if gRegion:__wf_atom_c20d246a(v5, v6, v3, nil, v7) then
		gRegion:CreateEntity(decoToSpawn, v7, instance:__wf_atom_dc309f8a(), nil, nil, 1)
	else
		gRegion:CreateEntity(decoToSpawn, position, instance:__wf_atom_dc309f8a(), nil, nil, 1)
	end

	if not __wf_atom_7e8ad928(v2) then
		gRegion:__wf_atom_dd1e4d10(v2)
	end

	instance:SetVisibility(false, true)

	if destroyAvatar then
		instance:Suicide()

		if not __wf_atom_7e8ad928(instance) then
			instance:Destroy()
		end
	else
		local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()
		instance:__wf_atom_e3a5b02f(false)

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:SetPaused(true, v4)
		end
	end
end