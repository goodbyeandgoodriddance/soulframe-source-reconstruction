local v = nil
local position = nil

function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_88d6f7ef() <= 1 then
		return false
	end

	if v == nil then
		v = object:__wf_atom_0b8838a5()
	end

	if v or not object:__wf_atom_0b8838a5() or position ~= nil and object:__wf_atom_a5304c35(position) < 3 then
		return false
	end

	position = object:GetPosition()

	if gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(position, 0.2) then
		return true
	end

	return false
end

function Activate(object, _)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	local __wf_atom_28ce676a = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(
		object:GetPosition(),
		maxDistanceAwayToCheck,
		maxDistanceAwayToCheck.maxValue / 5
	)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_ce415137(1)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_0f52bdf4(object:GetPosition(), maxDistanceAwayToCheck, -1, 1, 1, 0, false)
	__wf_atom_28ce676a:Start()
	local v2 = 5

	while not __wf_atom_28ce676a:__wf_atom_2ddd6354() and v2 > 0 do
		Sleep(0)
		v2 -= __wf_atom_084b3e93()

		if v2 <= 0 then
			return false
		end
	end

	local v3 = nil

	if __wf_atom_28ce676a:__wf_atom_2ddd6354() then
		local __wf_atom_5802ff81 = __wf_atom_28ce676a:__wf_atom_5802ff81()

		if #__wf_atom_5802ff81 > 0 then
			v3 = __wf_atom_5802ff81[1]
		end
	end

	if v3 == nil then
		return false
	end

	__wf_atom_30e3d82b:StartMoving(v3, 0, true, 1, 0.25, false)

	while not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_46292900() do
		Sleep(0.1)
	end

	position = v3
	return true
end

function Update(_, _) end

function Deactivate(_, _) end