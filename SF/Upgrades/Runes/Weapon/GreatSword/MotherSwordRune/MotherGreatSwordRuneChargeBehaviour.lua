function InitializeOnHitScript(object, object2)
	object:__wf_atom_b4529799(Symbol("MotherRuneOnHit"), "OnMeleeHit")
	local v = nil

	while __wf_atom_7e8ad928(v) do
		v = object2:__wf_atom_66088189(1, 0)
		Sleep(0)
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_0395f752 = object2:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbMotherRuneCharging) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbMotherRuneCharging = true
		local __wf_atom_e919fb8e_2 = v:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e_2.bbMotherRuneFxType = activeFxType
		v:__wf_atom_8a035cd5(Symbol("MonitorRuneCharge"), false)
	end
end

function OnMeleeHit(object)
	if gRegion:IsMaster() then
		local __wf_atom_3371f607 = object:__wf_atom_9d766292():__wf_atom_483e7ddc():__wf_atom_3371f607()

		if not __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_3371f607:IsA(__wf_atom_77e05d3b) then
			local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
			local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

			if
				__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
				or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
				or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbMotherRuneActive)
				or not __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].bbMotherRuneActive
			then
				object:__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_19516b62(7, suitEnergyTarget)
			end
		end
	end
end

function MonitorRuneCharge(object)
	local __wf_atom_95e72410 = object:GetCreator():__wf_atom_95e72410()

	if __wf_atom_7e8ad928(__wf_atom_95e72410) then
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_95e72410:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_6a5c92a7 = __wf_atom_e55d02aa:__wf_atom_6a5c92a7(4)
	local v = false
	local v2 = nil

	while not (__wf_atom_7e8ad928(__wf_atom_95e72410) or __wf_atom_95e72410:IsKilled()) do
		local __wf_atom_f3044fe0 = __wf_atom_e55d02aa:__wf_atom_f3044fe0(4)

		if __wf_atom_6a5c92a7 <= __wf_atom_f3044fe0 and not v then
			v = true

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbMotherRuneFxType) then
				v2 = object:Attach(
					__wf_atom_e919fb8e.bbMotherRuneFxType,
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1
				)
			end
		elseif __wf_atom_f3044fe0 < __wf_atom_6a5c92a7 and v then
			v = false

			if not __wf_atom_7e8ad928(v2) then
				v2:Destroy()
			end
		end

		Sleep(0.1)
	end
end