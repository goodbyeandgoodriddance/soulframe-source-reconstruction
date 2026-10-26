module(..., package.seeall)

local function fn(data)
	local v = math.max(data.red, (math.max(data.green, data.blue)))
	local v2 = v - math.min(data.red, (math.min(data.green, data.blue)))

	if (not (v > 0) and 0 or v2 / v) < 0.2 then
		return 4
	end

	if v == data.red then
		return 3
	end

	if v == data.green then
		return 6
	end

	return 5
end

function GetDamageTypeFromColour(p)
	return (fn(p))
end

function GetDefaultDamageType()
	return 3
end

function ElementType(object, p)
	local v = p == nil and 3 or p

	if __wf_atom_7e8ad928(object) then
		return v
	end

	local colors = object:__wf_atom_eb82ab1f():GetColors(0)

	if not colors:Initialized(4) then
		return v
	end

	local v2

	if __wf_atom_7e8ad928(gGameRules) or gGameRules:IsA(__wf_atom_311a7128) or _T.InSimulacrum then
		v2 = colors.mEmissiveColor0
	else
		v2 = object:__wf_atom_cb025a3b()
	end

	return (fn(v2))
end

function ElementFxIdx(p)
	if p == 6 then
		return 2
	elseif p == 4 then
		return 3
	elseif p == 5 then
		return 4
	end

	return 1
end

function TypeToIdx(p)
	return p - 3
end

function IdxToType(p)
	return p + 3
end