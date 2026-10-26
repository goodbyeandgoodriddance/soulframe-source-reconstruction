local flag = false
local v = nil
local v2 = nil

function Evaluate(object, _)
	if flag or __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_04ea4887() then
		return false
	end

	if __wf_atom_7e8ad928(v2) then
		local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

		if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
			v2 = __wf_atom_9fb9a1d6:__wf_atom_e14d8a8c()
		end
	end

	if __wf_atom_7e8ad928(v) then
		v = object:__wf_atom_bb3e7833(torchDecoAttachmentType)
	end

	if __wf_atom_7e8ad928(v) then
		flag = true
		return false
	end

	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	local v3 = validNightTimeRangePM:Contains(__wf_atom_cb3427c9) or validNightTimeRangeAM:Contains(__wf_atom_cb3427c9)

	if v:IsVisible() == v3 then
		return
	else
		return true
	end
end

function Activate(object, _)
	if __wf_atom_7e8ad928(v) then
		return false
	end

	local flag2 = false
	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	local v3 = validNightTimeRangePM:Contains(__wf_atom_cb3427c9) or validNightTimeRangeAM:Contains(__wf_atom_cb3427c9)

	if not __wf_atom_7e8ad928(object) then
		if v3 and not __wf_atom_7e8ad928(v2) then
			object:GiveItem(v2, true)
			flag2 = true
		elseif not __wf_atom_7e8ad928(daytimeWeapon) then
			object:GiveItem(daytimeWeapon, true)
			flag2 = true
		end
	end

	if flag2 then
		object:__wf_atom_8914dfde(torchWaitForAnimEvent, 2)
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_de53c96e()
	end

	if __wf_atom_7e8ad928(v) then
		return false
	end

	v:SetVisibility(v3, true)
	return true
end

function Deactivate(_, _) end