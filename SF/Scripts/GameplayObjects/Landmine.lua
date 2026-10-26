function OdeProximityMineDamage(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	__wf_atom_3d96ddcd:Attach(threatGlowAttachment, EMPTY_SYMBOL)
	__wf_atom_3d96ddcd:Attach(threatSoundAttachment, EMPTY_SYMBOL)
	__wf_atom_3d96ddcd:__wf_atom_a887a262(grineerMineMatSlot, grineerMineActiveMaterial)
	local position = __wf_atom_3d96ddcd:GetPosition()
	local v = position + Vector(0, 1, 0)
	local __wf_atom_dc309f8a = __wf_atom_3d96ddcd:__wf_atom_dc309f8a()
	local v2 = __wf_atom_d919c2d7(
		__wf_atom_dc309f8a,
		Rotation(__wf_atom_5784a397(-180, 180), __wf_atom_5784a397(-5, 5), __wf_atom_5784a397(-5, 5))
	)
	local _launchClickSound = launchClickSound
	local total = 0
	local v3 = false

	while
		total < grineerMineWarningTime
		and not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(object))
	do
		if object:IsEmpty() and total <= 1 then
			if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				return
			end

			local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(threatGlowAttachment)

			for _, v4 in ipairs(__wf_atom_f582136d) do
				v4:Destroy()
			end

			local __wf_atom_f582136d2 = __wf_atom_3d96ddcd:__wf_atom_f582136d(threatSoundAttachment)

			for _, v4 in ipairs(__wf_atom_f582136d2) do
				v4:Destroy()
			end

			__wf_atom_3d96ddcd:__wf_atom_a887a262(grineerMineMatSlot, grineerMineOffMaterial)
			return
		else
			if total > 1 and grineerMineWarningTime - 0.25 < total then
				if not v3 then
					__wf_atom_3d96ddcd:PlaySound(launchClickSound, false)
					v3 = true
				end

				local v4 = ((total - (grineerMineWarningTime - 0.25)) / 0.25) ^ 0.25
				__wf_atom_3d96ddcd:Teleport(
					__wf_atom_f55d6358(position, v, v4),
					(__wf_atom_9d2f097a(__wf_atom_dc309f8a, v2, v4))
				)
			end

			total += __wf_atom_084b3e93()
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:Destroy()
	end
end

function OdeProximityMine(object)
	object:__wf_atom_8a035cd5(Symbol("GrineerProximityMineDamage"), false)
end