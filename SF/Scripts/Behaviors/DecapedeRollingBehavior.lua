local v = Symbol("RollingBehavior")

local function fn(object, p)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if p then
		__wf_atom_d2b2176d:AddUpgrade(20, 0, armourBuff)
		__wf_atom_7470861b:__wf_atom_6cbcca8d(v, 26, 6, 0, 0)
		__wf_atom_7470861b:__wf_atom_77b5f32e(v)
		__wf_atom_7470861b:__wf_atom_180051f1()
		object:__wf_atom_994cbb44(0, v)
		object:__wf_atom_e3a5b02f(false)
	else
		__wf_atom_d2b2176d:RemoveUpgrade(20, 0, armourBuff)
		__wf_atom_7470861b:__wf_atom_a8cf605f(v)
		__wf_atom_7470861b:__wf_atom_9f17ac89(v)
		__wf_atom_7470861b:__wf_atom_180051f1()
		object:__wf_atom_d61b16cd(0, v)
		object:__wf_atom_e3a5b02f(true)
	end
end

function Evaluate(_, _)
	return true
end

function Activate(object, _)
	if not object:__wf_atom_7bcdbf55(rollStartAction) then
		object:__wf_atom_e06358f3(rollStartAction)
	end

	object:__wf_atom_30e3d82b():__wf_atom_899e6ea3(0, 1)
	fn(object, true)
end

function Update(_, _) end

function Deactivate(object, _)
	if object:__wf_atom_7bcdbf55(rollStartAction) then
		object:__wf_atom_e06358f3(rollEndAction)
	end

	object:__wf_atom_30e3d82b():__wf_atom_899e6ea3(0, 0)
	fn(object, false)
end

function RollEnd(object)
	local __wf_atom_15197633 = object:__wf_atom_21ed1a39():__wf_atom_15197633()

	if __wf_atom_15197633:__wf_atom_7bcdbf55(rollStartAction) then
		__wf_atom_15197633:__wf_atom_e06358f3(rollEndAction)
	end
end