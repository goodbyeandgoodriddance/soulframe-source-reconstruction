local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local bbForcedHusk = nil

function Evaluate(object, _)
	local __wf_atom_6f4c1c1b = object:__wf_atom_6f4c1c1b()

	if __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) then
		return true
	end

	if __wf_atom_6f4c1c1b:__wf_atom_bedb4e3f() or __wf_atom_6f4c1c1b:IsKilled() then
		return false
	end
end

local function fn(object)
	local __wf_atom_6f4c1c1b = object:__wf_atom_6f4c1c1b()

	if not __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) then
		bbForcedHusk = __wf_atom_6f4c1c1b
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbForcedHusk) then
		bbForcedHusk = __wf_atom_e919fb8e.bbForcedHusk
		return
	end

	print("WARNING - Mockery Spirit: " .. object:__wf_atom_30e3d82b():GetName() .. " does not have an assigned husk, which generally shouldn't happen.")

	while __wf_atom_7e8ad928(bbForcedHusk) do
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			huskTag,
			object:__wf_atom_a2a18137(),
			searchRadius.minValue,
			searchRadius.maxValue
		)
		local v = -1

		for _, v2 in ipairs(__wf_atom_439c0d29) do
			local __wf_atom_e919fb8e2 = v2:__wf_atom_e919fb8e()

			if
				not __wf_atom_7e8ad928(__wf_atom_e919fb8e2.bbReservedSpirit)
				and __wf_atom_e919fb8e2.bbReservedSpirit == object:__wf_atom_30e3d82b()
			then
				bbForcedHusk = v2
				return
			end

			if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e2.bbReservedSpirit) and module.IsInTable(
				object:__wf_atom_30e3d82b():__wf_atom_1bb5b1ff(),
				__wf_atom_e919fb8e2.bbMockerySpiritAgentTypes
			)) then
				continue
			end

			local v3 = Distance(v2:GetPosition(), object:GetPosition())

			if not (v3 < v or v < 0) then
				continue
			end

			bbForcedHusk = v2
			v = v3
		end

		if not __wf_atom_7e8ad928(bbForcedHusk) then
			break
		end

		Sleep(0.25)
		print("WARNING - Mockery Spirit: " .. object:__wf_atom_30e3d82b():GetName() .. " couldn't find any husks in its search radius, which generally shouldn't happen.")
	end
end

local function fn2(object)
	if __wf_atom_7e8ad928(bbForcedHusk) then
		return
	end

	local __wf_atom_a2a18137 = bbForcedHusk:__wf_atom_a2a18137()

	if useDesiredScriptedPosition then
		object:__wf_atom_b783ff91(__wf_atom_a2a18137, bbForcedHusk:__wf_atom_2f2bada0().heading)
	else
		object:__wf_atom_ab26d234(__wf_atom_a2a18137, true, true, false)
	end

	return true
end

function Activate(object, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	object:SetBlackboardBool(Symbol("FoundHusk"), false)

	while true do
		if
			__wf_atom_7e8ad928(bbForcedHusk)
			or bbForcedHusk:HasTag(Symbol("CLAIMED"))
			or not (__wf_atom_30e3d82b:__wf_atom_46292900() and __wf_atom_30e3d82b:__wf_atom_d932d88f())
		then
			__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
			bbForcedHusk = nil
			fn(object)
			fn2(__wf_atom_30e3d82b)
			Sleep(1)
		end

		Sleep(0)
	end
end