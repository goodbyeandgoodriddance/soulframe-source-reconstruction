local v = 0.1
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		0,
		nil,
		nil,
		26,
		Symbol("HealingToEnergy")
	)
	local magikForceCalc = module.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v = 0.1
	elseif __wf_atom_2a745663 == 2 then
		v = 0.15
	elseif __wf_atom_2a745663 == 3 then
		v = 0.2
	else
		v = 0.25
	end

	v *= magikForceCalc
	return true
end

function AddUpgrade(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local v2 = gRegion:IsMaster() and fn(__wf_atom_6009c8ed)
	local v3 = 0
	local stats = nil

	if v2 then
		local __wf_atom_a96eb2aa = __wf_atom_6009c8ed:__wf_atom_a96eb2aa()

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			stats = __wf_atom_a96eb2aa:GetStats()
		end

		if not __wf_atom_7e8ad928(stats) then
			v3 = stats:__wf_atom_6abce565()
		end
	end

	local v4 = false
	local v5 = 100
	local v6 = nil

	while not __wf_atom_7e8ad928(__wf_atom_6009c8ed) do
		if v2 then
			local __wf_atom_36b4a6e5 = object:__wf_atom_36b4a6e5()

			for _, v7 in ipairs(__wf_atom_36b4a6e5) do
				if __wf_atom_7e8ad928(v7) or not v7:IsActive() or v7:__wf_atom_3371f607() == nil then
					v4 = false
				else
					v6 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(v7))
					v5 = object:__wf_atom_6a5c92a7(v6)
					v4 = true
					break
				end
			end

			local v7 = __wf_atom_7e8ad928(stats) and 0 or stats:__wf_atom_6abce565() or 0

			if v3 ~= v7 and v4 then
				object:__wf_atom_19516b62(v5 * v, v6)
				v3 = v7
			end
		end

		Sleep(0)
	end
end