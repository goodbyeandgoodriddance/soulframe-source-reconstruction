module(..., package.seeall)
local v = Type("/Lotus/Interface/MapConnectionSpline")
local v2 = { Velocity = 0, LoopTime = 192800, Splines = nil }
local v3 = {
	Vector(-2.3, 0.5, 0),
	Vector(-1.1, 1.4, 0.1),
	Vector(-0.2, 1.5, 0.2),
	Vector(0.3, 1.1, 0.4),
	Vector(0.8, 1.5, 0.2),
	Vector(1.4, 1.5, 0.3),
	Vector(1.7, 1, 0.5),
	Vector(1.3, 0.7, 0.4),
	Vector(1.8, 0.3, 0.3),
	Vector(2.4, 0.1, 0.32),
	Vector(1.2, -0.5, 0.2),
	Vector(1.3, -1.12, 0.3),
	Vector(0, -1.2, 0.4),
	Vector(-1.5, -0.4, 0.3),
	Vector(-2.6, -0.4, 0.2),
	Vector(-2.3, 0.5, 0),
	Vector(-1.1, 1.4, 0.1),
	Vector(-0.2, 1.5, 0.2)
}

local function fn()
	v2.Splines = {}

	for i = 1, #v3 - 3 do
		v2.Splines[i] = gRegion:CreateEntity(v, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		local v4 = {
			v3[i],
			v3[i + 1],
			v3[i + 2],
			v3[i + 3]
		}
		v2.Splines[i]:__wf_atom_ff43aa5a(v4)
		v2.Splines[i]:SetVisibility(false, true)
	end

	v2.Velocity = #v2.Splines / v2.LoopTime
end

local function fn2()
	if v2.Splines == nil then
		fn()
		return
	end

	for i = 1, #v3 - 3 do
		if not __wf_atom_7e8ad928(v2.Splines[i]) then
			continue
		end

		fn()
		break
	end
end

function GetFortressPosition()
	if __wf_atom_7e8ad928(gGameRules) then
		return nil
	end

	fn2()
	local __wf_atom_93691ff2 = gGameRules:__wf_atom_93691ff2()
	local v4 = 1 / v2.Velocity
	local v5 = __wf_atom_93691ff2 % (v4 * #v2.Splines)
	local v6 = math.floor(v5 / v4) + 1
	local v7 = v5 % v4 / v4
	local v8 = __wf_atom_421b01aa(v6, 1, #v2.Splines)
	local spline = v2.Splines[v8]

	if __wf_atom_7e8ad928(spline) then
		return __wf_atom_28d5d4aa
	end

	return spline:__wf_atom_bfb052a2(v7)
end

function GetSplinePoints()
	return v3
end