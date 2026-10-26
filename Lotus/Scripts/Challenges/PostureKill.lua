function CheckPreconditions()
	return not gGameRules:__wf_atom_72fc675e().archwingRequired
end

local function fn(p) -- 2 equivalent calls inferred from this helper
	return p == 20 or p == 21 or p == 22
end

local function fn2(object, object2)
	local __wf_atom_50a7d83e = object2:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		return false
	end

	if useModifiers then
		for i = 1, #requiredModifiers do
			if requiredModifiers[i] == 14 then
				if not (__wf_atom_50a7d83e:__wf_atom_bedb4e3f() or __wf_atom_50a7d83e:__wf_atom_7b82e9e1(requiredModifiers[i])) then
					return false
				end
			elseif not __wf_atom_50a7d83e:__wf_atom_7b82e9e1(requiredModifiers[i]) then
				return false
			end
		end

		if not usePosture then
			return true
		end
	end

	if usePosture then
		local __wf_atom_08998754 = __wf_atom_50a7d83e:__wf_atom_08998754()

		if __wf_atom_08998754 == requiredPosture then
			return true
		end

		if __wf_atom_7e8ad928(object) or requiredPosture ~= 5 then
			if fn(requiredPosture) then -- inferred equivalent call
				if fn(__wf_atom_08998754) then -- inferred equivalent call
					return true
				end

				for i = 1, #requiredModifiers do
					if __wf_atom_50a7d83e:__wf_atom_7b82e9e1(requiredModifiers[i]) then
						return true
					end
				end
			end
		else
			local __wf_atom_3371f607 = object:__wf_atom_3371f607()

			if
				not __wf_atom_7e8ad928(__wf_atom_3371f607)
				and __wf_atom_3371f607:IsA(__wf_atom_9df43583)
				and __wf_atom_3371f607:__wf_atom_e5141e5b()
				and __wf_atom_3371f607:__wf_atom_e761d707() == requiredAttackAction
			then
				return true
			end
		end

		return false
	else
		if __wf_atom_7e8ad928(object) or requiredAttackAction ~= 67 then
			return false
		end

		local __wf_atom_3371f607 = object:__wf_atom_3371f607()

		if __wf_atom_7e8ad928(__wf_atom_3371f607) then
			if not __wf_atom_7e8ad928(finisherType) then
				local __wf_atom_c98157ce = object:__wf_atom_c98157ce()

				if
					not __wf_atom_7e8ad928(__wf_atom_c98157ce)
					and __wf_atom_c98157ce:IsA(finisherType)
					and __wf_atom_50a7d83e:__wf_atom_611b620c()
				then
					return true
				end
			end
		else
			if
				__wf_atom_3371f607:IsA(__wf_atom_9df43583)
				and __wf_atom_3371f607:__wf_atom_e5141e5b()
				and (__wf_atom_3371f607:__wf_atom_e761d707() == requiredAttackAction or __wf_atom_50a7d83e:__wf_atom_611b620c())
			then
				return true
			end

			if
				not __wf_atom_7e8ad928(finisherType)
				and __wf_atom_3371f607:IsA(finisherType)
				and __wf_atom_50a7d83e:__wf_atom_611b620c()
			then
				return true
			end
		end

		return false
	end
end

function MatchAttackEvent(object, p)
	return not __wf_atom_7e8ad928((object:__wf_atom_6ce58983())) and fn2(object, p)
end

function MatchTagEvent(p, _)
	return (fn2(nil, p))
end

function MatchItemEvent(p, _)
	return (fn2(nil, p))
end