local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function RandomizeHintsToLargePortals()
	module.WaitForLevel()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("EncounterHintWp"))
	local v = Symbol("LargeCavePortalWp")
	local exitWaypoint = module.GetExitWaypoint()
	local v2 = __wf_atom_7e8ad928(exitWaypoint) and 9999 or __wf_atom_7d789620:__wf_atom_5e5adb53(exitWaypoint)
	local v3 = {}

	for i = #__wf_atom_2226b35c, 1, -1 do
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v, __wf_atom_2226b35c[i]:GetPosition(), 0, 5)

		if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			continue
		end

		local __wf_atom_31c6f706 = __wf_atom_f738b4af:__wf_atom_31c6f706()

		if
			__wf_atom_7e8ad928(__wf_atom_31c6f706[1])
			or not __wf_atom_7d789620:__wf_atom_0e0a6fee(__wf_atom_f738b4af:GetPosition(), 1, 5)
		then
			continue
		end

		if not __wf_atom_7d789620:__wf_atom_0e0a6fee(__wf_atom_31c6f706[1]:GetPosition(), 1, 5) then
			continue
		end

		local __wf_atom_5e5adb53 = __wf_atom_7d789620:__wf_atom_5e5adb53(__wf_atom_2226b35c[i])

		if not (__wf_atom_5e5adb53 < v2) then
			continue
		end

		if __wf_atom_7e8ad928(v3[__wf_atom_5e5adb53]) then
			v3[__wf_atom_5e5adb53] = {}
		end

		table.insert(v3[__wf_atom_5e5adb53], __wf_atom_2226b35c[i])
	end

	if #__wf_atom_2226b35c == 0 then
		return
	end

	local v4 = WeakResource("/SF/Types/Game/Encounters/Ode/Hints/GladesCombatSmall")
	local all = gRegion:FindAll(__wf_atom_f806fd7a)

	for _, v5 in ipairs(all) do
		if not (v5:IsA(v4) and math.random() < 0.5 and v5:__wf_atom_4026dfb5() == 0) then
			continue
		end

		local v6 = false

		for _, v7 in ipairs(all) do
			if not (v7 ~= v5 and v7:__wf_atom_1c8f7b2d(v5) <= 25) then
				continue
			end

			v6 = true
			break
		end

		if v6 then
			continue
		end

		local v7 = v3[__wf_atom_7d789620:__wf_atom_5e5adb53(v5)]

		if __wf_atom_7e8ad928(v7) or not (#v7 > 0) then
			continue
		end

		local v8 = __wf_atom_5784a397(1, #v7)
		v5:__wf_atom_c53e1842(v7[v8]:GetPosition())
		table.remove(v7, v8)
		print("Moved " .. v5:__wf_atom_5b41f63b())
	end
end