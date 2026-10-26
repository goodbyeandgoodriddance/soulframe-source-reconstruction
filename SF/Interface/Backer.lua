local v = {}
local v2 = {}
local v3 = {}

function Initialize()
	mMovie:OverrideMaterial("Blurer", visRangeMaterial)
	mMovie:OverrideMaterial("Backer", visRangeMaterial)
	mMovie:__wf_atom_e57658c2("Blurer", 12, 0)
	_T.ShowBackground = ShowBackground
	_T.HideBackground = HideBackground
	_T.IsShowingBacker = IsShowingBacker
end

function Shutdown()
	_T.ShowBackground = nil
	_T.HideBackground = nil
	_T.IsShowingBacker = nil
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
end

local function fn(p)
	local v4 = v2.Invalid ~= nil

	if v4 == (p > 0) then
		if v4 then
			v2.Invalid += p
		end

		return false
	else
		if v4 then
			if v2.Invalid > 1 then
				v2.Invalid += p
				return false
			else
				v2.Invalid = nil
			end
		else
			v2.Invalid = 1
		end

		return true
	end
end

local function fn2()
	for i = 3, __wf_atom_3d7f4c32() do
		local v4 = getfenv(i)

		if
			not __wf_atom_7e8ad928(v4)
			and not __wf_atom_7e8ad928(v4.mMovie)
			and v4.mMovie ~= mMovie
			and not __wf_atom_7e8ad928(v4.mMovie:__wf_atom_6d61d595())
		then
			return v4.mMovie:__wf_atom_6d61d595():GetName()
		end
	end

	return nil
end

local function fn3(p)
	local v4 = fn2()

	if v4 == nil then
		return fn(p == nil and -1 or 1)
	end

	local v5 = v2[v4] ~= nil

	if p == nil then
		if v5 then
			v2[v4] = nil

			for i = #v3, 1, -1 do
				if v3[i] ~= v4 then
					continue
				end

				table.remove(v3, i)
				break
			end

			return true
		end
	elseif not v5 then
		v2[v4] = p
		table.insert(v3, v4)
		return true
	end

	return false
end

local function fn4(data, p)
	local mFadeTime = data.mFadeTime or 0.3
	local mDelayTime = data.mDelayTime or 0
	local v4 = data.mHideBlur and 0 or 30
	local mFade = tonumber(data.mFade)
	local mVisibilitySize = tonumber(data.mVisibilitySize) or 0
	local mFadeSize = tonumber(data.mFadeSize) or 0.4
	local v5

	if mFade == nil then
		v5 = 0.5
		mVisibilitySize = 1
	else
		v5 = 1 - (mFade - 1) / 2
	end

	if p then
		visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, v5)
		visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, mVisibilitySize)
		visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, mFadeSize)
		__wf_atom_ec43d06e(mMovie, "Blurer", 8, { 12 }, { v4 }, mFadeTime, mDelayTime)
	else
		local __wf_atom_b90af225 = visRangeMaterial:__wf_atom_b90af225(SF.__wf_atom_5ddc828f, 1)
		local __wf_atom_b90af225_2 = visRangeMaterial:__wf_atom_b90af225(SF.__wf_atom_cf0d1cc6, 1)
		local __wf_atom_b90af225_3 = visRangeMaterial:__wf_atom_b90af225(SF.__wf_atom_7a5b8f59, 1)
		local v6 = v5 - __wf_atom_b90af225
		local v7 = mVisibilitySize - __wf_atom_b90af225_2
		local v8 = mFadeSize - __wf_atom_b90af225_3
		__wf_atom_ec43d06e(mMovie, "Blurer", 8, {
			12,
			function(p2)
				visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, __wf_atom_b90af225 + v6 * p2)
				visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, __wf_atom_b90af225_2 + v7 * p2)
				visRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, __wf_atom_b90af225_3 + v8 * p2)
			end
		}, { v4, 1 }, mFadeTime, mDelayTime)
	end

	__wf_atom_ec43d06e(mMovie, "Backer", 8, { 12 }, { 70 }, mFadeTime, mDelayTime)
	v = data
end

function ShowBackground(p)
	local v4 = type(p) ~= "table" and {} or p
	local v5 = not IsShowingBacker()

	if not (fn3(v4) and v ~= v4) then
		return
	end

	fn4(v4, v5)
end

function HideBackground(p)
	if p == nil or p.ForceHide ~= true then
		if not fn3() then
			return
		end

		local count = #v3

		if count > 0 then
			fn4(v2[v3[count]])
		else
			local v4 = type(p) ~= "table" and {} or p
			local mFadeTime = v4.mFadeTime or 0.3
			local mDelayTime = v4.mDelayTime or 0
			__wf_atom_ec43d06e(mMovie, "Blurer", 8, { 12 }, { 0 }, mFadeTime, mDelayTime)
			__wf_atom_ec43d06e(mMovie, "Backer", 8, { 12 }, { 0 }, mFadeTime, mDelayTime)
		end
	else
		fn3()
		mMovie:__wf_atom_e57658c2("Blurer", 12, 0)
		mMovie:__wf_atom_e57658c2("Backer", 12, 0)
	end
end

function IsShowingBacker()
	return #v3 > 0
end