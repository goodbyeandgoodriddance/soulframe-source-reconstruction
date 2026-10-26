function OnActivate(object, instance)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_9e85eea2) then
		return
	end

	if not __wf_atom_3d96ddcd:__wf_atom_4221009f() then
		if instance:__wf_atom_631bafa1() and instance:IsA(__wf_atom_c0fefb76) then
			instance:__wf_atom_92aa9d91():__wf_atom_17c1c30f()
			instance:__wf_atom_a460875f(false)
			Sleep(0)
		end

		if instance:__wf_atom_535d5cbb() then
			__wf_atom_3d96ddcd:Attach(flightEffects, EMPTY_SYMBOL)
		end

		local __wf_atom_4e50d390 = instance:__wf_atom_4e50d390()
		__wf_atom_3d96ddcd:__wf_atom_972fb5d9(instance)

		if __wf_atom_3d96ddcd:IsA(horseAvatar) then
			__wf_atom_3d96ddcd:__wf_atom_51075230(__wf_atom_4e50d390)
		end

		if setPlayerTeam then
			local __wf_atom_a96eb2aa = __wf_atom_3d96ddcd:__wf_atom_a96eb2aa()

			if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				local v = Symbol(__wf_atom_a96eb2aa:__wf_atom_6be84646())
				__wf_atom_3d96ddcd:__wf_atom_30e3d82b():__wf_atom_01fe1115(v)
			end
		end
	end
end

function OnRecall(object, object2)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	if not __wf_atom_3d96ddcd:__wf_atom_4221009f() then
		if object2:__wf_atom_535d5cbb() then
			__wf_atom_3d96ddcd:Attach(flightEffects, EMPTY_SYMBOL)
		end

		__wf_atom_3d96ddcd:__wf_atom_972fb5d9(object2, false, false, true)
	end
end

function OnHijack(object, p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(object) or not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_4221009f = __wf_atom_3d96ddcd:__wf_atom_4221009f()

	if __wf_atom_4221009f and not __wf_atom_4221009f:__wf_atom_535d5cbb() then
		__wf_atom_3d96ddcd:__wf_atom_4b3eadfb(p, __wf_atom_4221009f)
	end
end