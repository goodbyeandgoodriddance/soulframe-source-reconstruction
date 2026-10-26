local total = 0
local v = 2
local cineEnt = nil

function Evaluate(object, _)
	local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()

	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(__wf_atom_6115a2e2)
		or object:__wf_atom_9af7625d(__wf_atom_6115a2e2) < minPlayerDistance * minPlayerDistance
	then
		return false
	end

	return true
end

function Activate(object, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local _heldItem = __wf_atom_e919fb8e.heldItem
	Sleep(2)

	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_921c1a5f(idleToSit, true, 4, 1, true)
	local currentIndex = __wf_atom_5784a397(1, #SitLoop)
	__wf_atom_e919fb8e.currentIndex = currentIndex
	object:__wf_atom_921c1a5f(SitLoop[currentIndex], false, 4, 2, true)
	total = 0
	v = __wf_atom_5784a397(waitTimeRange.minValue, waitTimeRange.maxValue)
	local v2 = pettingCine[__wf_atom_5784a397(1, #pettingCine)]

	if not (__wf_atom_7e8ad928((object:__wf_atom_bb3e7833(__wf_atom_c9fc989f))) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.CineEnt)) then
		__wf_atom_e919fb8e.CineEnt:Destroy()
	end

	cineEnt = object:Attach(v2, EMPTY_SYMBOL)
	__wf_atom_e919fb8e.CineEnt = cineEnt
	Sleep(0.1)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_ccd337ec = object:__wf_atom_ccd337ec(commandBbSymbol)

	while object:__wf_atom_c138b19b(SitLoop[currentIndex]) and total < v and __wf_atom_ccd337ec ~= cubCommand do
		total += __wf_atom_084b3e93()
		__wf_atom_ccd337ec = object:__wf_atom_ccd337ec(commandBbSymbol)

		if __wf_atom_7e8ad928(cineEnt) or not cineEnt:__wf_atom_7d4910e4() then
			Sleep(0)
		else
			break
		end
	end

	while not __wf_atom_7e8ad928(cineEnt) and cineEnt:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	object:__wf_atom_9b5dcd3b(nil, false)
	Sleep(0)
	object:__wf_atom_921c1a5f(sitToIdle, false, 4, 1, true)
	return true
end

function Update(_, _)
	return true
end

function Deactivate(object, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PupIsDespawning) or not __wf_atom_e919fb8e.PupIsDespawning then
		object:__wf_atom_9b5dcd3b(nil, false)
	end
end