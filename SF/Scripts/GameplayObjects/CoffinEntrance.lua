local v = false

local function fn(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Unequip(0, 0)

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
		Sleep(0)
	end
end

function CoffinEntrance(_) end

function OpenCrypt(_, object)
	if gRegion:IsMaster() then
		fn(object)
	end

	local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(startAnim, false, 4, 1, false)
	local _ = startAnim:__wf_atom_091354f5(Symbol("Unlocked")) * __wf_atom_921c1a5f
	local v2 = startAnim:__wf_atom_091354f5(Symbol("StartMover")) * __wf_atom_921c1a5f

	if not __wf_atom_7e8ad928(moverOpen) then
		local total = 0

		while total < v2 do
			Sleep(0)
			total += __wf_atom_084b3e93()
		end

		if not __wf_atom_7e8ad928(moverOpen) then
			moverOpen:__wf_atom_0eb78444()
		end
	end
end