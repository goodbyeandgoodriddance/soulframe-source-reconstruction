local function fn(object) -- 2 equivalent calls inferred from this helper
	object:__wf_atom_d3db11f4(true)
	object:__wf_atom_5294be44(false, false, true, true)
end

function JoinSwords(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	fn(__wf_atom_21ed1a39) -- inferred equivalent call
end

local function fn2(object) -- 2 equivalent calls inferred from this helper
	object:__wf_atom_d3db11f4(false)
	object:__wf_atom_5294be44(true, true, false, false)
end

function SeparateSwords(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	fn2(__wf_atom_21ed1a39) -- inferred equivalent call
end

function OnOwnerSet(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	while __wf_atom_7e8ad928(__wf_atom_6009c8ed) and not __wf_atom_7e8ad928(object) do
		__wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(object) then
		return
	end

	if
		__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_28224c27(5) ~= object
		and __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_28224c27(1) ~= object
	then
		return
	end

	local flag = false

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(object)) do
		local __wf_atom_75a0566d = object:__wf_atom_75a0566d()
		local v = not __wf_atom_7e8ad928(__wf_atom_75a0566d) and __wf_atom_75a0566d:__wf_atom_f824cfe6() == 8

		if v and overrideThrowAttachBone ~= EMPTY_SYMBOL then
			if not flag then
				object:__wf_atom_f56282e6(1, 2, overrideThrowAttachBone)
				flag = true
			end
		elseif flag then
			object:__wf_atom_f56282e6(1, 2, normalAttachBone)
			flag = false
		end

		if not v and not object:__wf_atom_c5d04cb3() and object:GetState() ~= 15 and object:GetState() ~= 16 then
			local v2 = object:__wf_atom_3e33d5dd() == 0

			if v2 and __wf_atom_6009c8ed and __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_0cc2386b(0) ~= 0 then
				v2 = false
			end

			local __wf_atom_0f63032d = object:__wf_atom_0f63032d()

			if __wf_atom_0f63032d or v2 then
				if __wf_atom_0f63032d and v2 then
					fn2(object) -- inferred equivalent call
				end
			else
				fn(object) -- inferred equivalent call
			end
		end

		Sleep(0)
	end
end