local v = Symbol("Guard")
local v2 = false
local v3 = nil

function OrderInvestigate()
	local position = v3:__wf_atom_20cba70d()
	local __wf_atom_02fe8d73 = v3:__wf_atom_02fe8d73()
	local creator = v3:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local v4 = creator:__wf_atom_6199ef01() or {}
	local __wf_atom_26b04ea9 = creator:__wf_atom_26b04ea9()

	if not __wf_atom_7e8ad928(__wf_atom_26b04ea9) then
		for _, v5 in ipairs(__wf_atom_26b04ea9:__wf_atom_6199ef01()) do
			table.insert(v4, v5)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_02fe8d73) then
		position = __wf_atom_02fe8d73:GetPosition()
	end

	for _, v5 in ipairs(v4) do
		if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5:__wf_atom_50a7d83e()) then
			continue
		end

		if not (v5:__wf_atom_50a7d83e():__wf_atom_d5fda8be(v3:GetPosition()) < investgatePerceptionRange) then
			continue
		end

		v5:__wf_atom_30b587a4()
		gRegion:__wf_atom_2202ffb6():__wf_atom_fdd7548c(v5, 4, 18, position, __wf_atom_02fe8d73, 0, 0, true)
		v5:__wf_atom_42b767a2(v)
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(
		2,
		14,
		position,
		__wf_atom_02fe8d73,
		0,
		investgatePerceptionRange,
		true
	)
	v2 = true
	Sleep(perceptionCooldown)
	v2 = false
end

function OdeAtmosphereGenExplosion(instance)
	if not gRegion:IsMaster() then
		return
	end

	v3 = instance

	if instance:__wf_atom_c6f1f83d() < 230 then
		local v4 = instance:Attach(damagedFx, EMPTY_SYMBOL)

		if instance:__wf_atom_c6f1f83d() <= 0 then
			Sleep(2)
			instance:Destroy()
		else
			if v2 == false then
				instance:__wf_atom_8a035cd5(Symbol("OrderInvestigate"), false)
			end

			Sleep(3)

			if not __wf_atom_7e8ad928(v4) then
				v4:FirePort("Destroy")
			end
		end
	else
		if not __wf_atom_7e8ad928(portForwarder) then
			portForwarder:FirePort("TriggerPort")
		end

		for _, v4 in ipairs(disableAttachWres) do
			local __wf_atom_f582136d = instance:__wf_atom_f582136d(v4)

			for _, v5 in ipairs(__wf_atom_f582136d) do
				v5:Disable()
			end
		end

		for _, v4 in ipairs(fadeAttachWres) do
			local __wf_atom_f582136d = instance:__wf_atom_f582136d(v4)

			for _, v5 in ipairs(__wf_atom_f582136d) do
				v5:PlayTriggeredFade(true)
			end
		end

		instance:SetHealth(250)
	end
end