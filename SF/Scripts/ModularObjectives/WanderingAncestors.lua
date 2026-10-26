local module = require("SF.Scripts.Libs.EncounterLib")
require("SF.Scripts.Libs.SparrowLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil
local v2 = nil
local __wf_atom_402b3832s = {}
local v3 = {}
local v4 = {}

local function fn()
	v2 = module.GeneratePointsOfInterest(1, { Symbol("Objective") }, true)

	for _ = 1, numAncestors do
		if #v2 == 0 then
			break
		end

		local commonAncestorType = commonAncestorType
		local v5 = __wf_atom_5784a397(1, #v2)
		local v6 = v2[v5]
		local __wf_atom_402b3832 = v:__wf_atom_402b3832(commonAncestorType, v6, __wf_atom_80368bb1)
		__wf_atom_402b3832:__wf_atom_50a7d83e()
		table.insert(__wf_atom_402b3832s, __wf_atom_402b3832)
		table.insert(v3, nil)
	end
end

local function fn2(position)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	for i = #v2, 1, -1 do
		if not (not __wf_atom_2202ffb6:__wf_atom_e58b162a(position, v2[i], 1) or v:__wf_atom_57856d42(position, v2[i]) > 150) then
			continue
		end

		table.remove(v2, i)
	end

	local v5 = __wf_atom_5784a397(1, #v2)
	return v2[v5]
end

function Main(instance)
	Sleep(3)
	module2.WaitForAiDir()
	print("Wandering ancestors started on " .. instance:__wf_atom_5b41f63b())
	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	fn()

	while #__wf_atom_402b3832s > 0 do
		for i = #__wf_atom_402b3832s, 1, -1 do
			if __wf_atom_7e8ad928(__wf_atom_402b3832s[i]) then
				table.remove(__wf_atom_402b3832s, i)
			else
				local __wf_atom_50a7d83e = __wf_atom_402b3832s[i]:__wf_atom_50a7d83e()

				if __wf_atom_7e8ad928(v3[i]) then
					if __wf_atom_7e8ad928(v4[i]) then
						v4[i] = fn2(__wf_atom_50a7d83e:GetPosition())

						if not __wf_atom_7e8ad928(v4[i]) then
							__wf_atom_402b3832s[i]:__wf_atom_b783ff91(v4[i], 0)
						end
					elseif __wf_atom_50a7d83e:__wf_atom_d5fda8be(v4[i]) <= 2 then
						v4[i] = nil
					end
				end
			end
		end

		Sleep(0)
	end

	print("Ancestor encounter ended")
	instance:Destroy()
end

function AncestorEntityScript(object)
	Sleep(1)
	_T.NeedSoulModeVisUpdate = true
	local __wf_atom_f582136d = object:__wf_atom_f582136d(WeakResource("/EE/Types/Effects/DynamicProjector"))

	for _, v5 in ipairs(__wf_atom_f582136d) do
		v5:__wf_atom_a763aa1a(1)
	end

	object:__wf_atom_a763aa1a(1)
end