local v = false
local v2 = 1
local flag = false

local function fn() -- 1 equivalent call inferred from this helper
	mMovie:Close()
end

local function fn2(value, p)
	if not flag then
		return
	end

	flag = false
	local v3 = value or 1
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, v3, 0, p)
	__wf_atom_ec43d06e(mMovie, "Top", 8, { 1 }, { v2 * -86 }, v3)
	__wf_atom_ec43d06e(mMovie, "Bottom", 8, { 1 }, { v2 * 86 + 720 }, v3)
end

local function fn3(value, p)
	if flag or v then
		return
	end

	flag = true
	local v3 = value or 1
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, v3, 0, p)
	__wf_atom_ec43d06e(mMovie, "Top", 8, { 1 }, { 0 }, v3)
	__wf_atom_ec43d06e(mMovie, "Bottom", 8, { 1 }, { 720 }, v3)
end

function Shutdown()
	_T.HideCinAspectBars = nil
end

function Initialize()
	mMovie:__wf_atom_e57658c2("Top", 1, -86)
	mMovie:__wf_atom_e57658c2("Bottom", 1, 806)
	fn3()
	fn() -- inferred equivalent call
end

function onViewportSizeChanged(p, p2, _, _)
	local v3

	if p / p2 > 16 / 9 then
		local v4 = p2 - p / (7 / 3)
		v3 = __wf_atom_421b01aa(v4 / 2, 0, 86)
	else
		v3 = 86
	end

	v2 = v3 / 86
	fn3()
end

function Update()
	local v3 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v3)
	local __wf_atom_c3b255b8 = gRegion:__wf_atom_c3b255b8()

	if __wf_atom_7e8ad928(__wf_atom_c3b255b8) and not __wf_atom_7e8ad928(__wf_atom_392793db) then
		__wf_atom_c3b255b8 = __wf_atom_392793db:__wf_atom_c3b255b8()

		if
			not __wf_atom_7e8ad928(__wf_atom_c3b255b8)
			and string.find(tostring(__wf_atom_c3b255b8:__wf_atom_db682341()), "Kahl") == nil
		then
			__wf_atom_c3b255b8 = nil
		end
	end

	if __wf_atom_7e8ad928(__wf_atom_c3b255b8) then
		if not v then
			v = true
			fn2(3, fn)
		end
	elseif flag == (_T.HideCinAspectBars == true) then
		if flag then
			fn2()
		else
			fn3()
		end
	end
end