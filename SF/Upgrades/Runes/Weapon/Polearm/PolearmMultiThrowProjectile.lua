function OnProjectileContact(object, instance)
	if not __wf_atom_7e8ad928(instance) then
		instance:IsA(__wf_atom_4ebf67cb)
	end

	local __wf_atom_f7f6708f = object:__wf_atom_f7f6708f()

	if not __wf_atom_7e8ad928(instance) then
		local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowHits) then
			__wf_atom_e919fb8e.PolearmMultiThrowHits = {}
		end

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f]) then
			__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f] = {}
		end

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].lastHitTime) then
			__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].numHits = 0
		end

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].lastHitTime) then
			__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].lastHitTime = Time()
		elseif Time() - __wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].lastHitTime >= 10 then
			__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].numHits = 0
		end

		__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].lastHitTime = Time()
		__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].numHits = __wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].numHits + 1
	end
end

function CanContactWithProjectile(object, instance)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb) then
		local __wf_atom_f7f6708f = object:__wf_atom_f7f6708f()
		local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

		if
			not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowHits)
			and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f])
			and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].numHits)
			and __wf_atom_e919fb8e.PolearmMultiThrowHits[__wf_atom_f7f6708f].numHits >= 5
		then
			return false
		end
	end

	return true
end