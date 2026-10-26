module(..., package.seeall)

local function fn(object)
	if object == nil then
		return nil
	end

	object:Start()

	repeat
		Sleep(0)
	until object:__wf_atom_2ddd6354()

	return object:__wf_atom_5802ff81()
end

function GetPosition(object)
	object:__wf_atom_ce415137(1)
	local v = fn(object)

	if #v == 0 then
		return nil
	end

	return v[1]
end

function GetPositions(p, object)
	object:__wf_atom_ce415137(p)
	return fn(object)
end

function GetRandomPosition(object, value)
	object:__wf_atom_ce415137(value or 10)
	local v = fn(object)

	if #v == 0 then
		return nil
	end

	return v[__wf_atom_5784a397(1, #v)]
end