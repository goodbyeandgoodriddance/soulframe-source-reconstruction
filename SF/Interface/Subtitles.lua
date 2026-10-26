local module = require("EE.Interface.Utilities")
local v = nil
local v2 = ""
local v3 = 0
local v4 = nil
local v5 = nil
local v6 = 1
local v7 = { "Subtitle", "Subtitle1" }
local v8 = nil

local function fn(p)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p, 94)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(p, 40)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(p, 43)
	local v9 = mMovie:__wf_atom_5e6e15c8(p, 50) + 6.2
	local v10 = mMovie:__wf_atom_5e6e15c8(p, 1) - 1 - 2
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(p, 36)
	local v11 = {}

	for k in string.gmatch(__wf_atom_387f260e, "[^\n]+") do
		v11[#v11 + 1] = k
	end

	mMovie:__wf_atom_e57658c2("Background", 1, v10)

	for i = 1, __wf_atom_5e6e15c8_3 do
		local v12 = "Background.Line" .. i

		if not mMovie:__wf_atom_253d7085(v12) then
			__wf_atom_86cbd68d(mMovie, "Background.Line1.duplicateMovieClip", "Line" .. i, i)
			mMovie:OverrideMaterial(v12, backgroundMaterial)
		end

		mMovie:__wf_atom_2dedec1a(v12, 13, true)
		mMovie:__wf_atom_e57658c2(v12, 1, (i - 1) * v9)
		mMovie:__wf_atom_e57658c2(v12, 15, v9 + 4)

		if i == __wf_atom_5e6e15c8_3 then
			mMovie:__wf_atom_e57658c2(v12, 14, (__wf_atom_5e6e15c8 + 26) * v)
		else
			if v11[i] then
				mMovie:__wf_atom_50d60589(p, 36, v11[i])
				__wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(p, 40)
			end

			mMovie:__wf_atom_e57658c2(v12, 14, (__wf_atom_5e6e15c8_2 + 26) * v)
		end
	end

	mMovie:__wf_atom_50d60589(p, 36, __wf_atom_387f260e)

	for i = __wf_atom_5e6e15c8_3 + 1, v3 do
		mMovie:__wf_atom_2dedec1a("Background.Line" .. i, 13, false)
	end

	v3 = __wf_atom_5e6e15c8_3
end

local function fn2()
	local subtitleClipName = v7[v8]
	local v9

	if v8 == 1 then
		v9 = v7[2]
	else
		v9 = v7[1]
	end

	_T.SubtitleClipName = subtitleClipName
	__wf_atom_ec43d06e(mMovie, v9, 8, { 12 }, { 0 }, 0.334)
	__wf_atom_ec43d06e(mMovie, subtitleClipName, 8, { 12 }, { 100 }, 0.334)
end

local function fn3(p, p2)
	local v9 = p == nil and "" or p

	if v2 == v9 then
		return true
	end

	local subtitleText = ""

	if p2 then
		subtitleText = v9
	elseif v9 ~= "" then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v9, true)
		local v10 = string.gsub(__wf_atom_8e9ac384, "#", "")
		subtitleText = string.gsub(v10, "\r\n\r\n", " ")
	end

	if v8 == 1 then
		v8 = 2
	else
		v8 = 1
	end

	local v10 = v7[v8]

	if v9 ~= "" then
		_T.SubtitleText = subtitleText
	end

	if v9 == "" then
		if v2 ~= "" then
			local v11 = mMovie:IsVisible() and 2 or 0
			__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, v11, 0, function()
				_T.SubtitleVisible = false
				mMovie:__wf_atom_50d60589(v10, 36, subtitleText)
			end)
		end
	else
		if v2 == "" then
			mMovie:__wf_atom_e57658c2("_root", 12, 0)
			mMovie:__wf_atom_e57658c2("Background", 12, 50)
			mMovie:__wf_atom_50d60589(v10, 36, subtitleText)
			__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 1)
			_T.SubtitleVisible = true
		else
			mMovie:__wf_atom_50d60589(v10, 36, subtitleText)
		end

		fn(v10)
		fn2()
	end

	v2 = v9
	return true
end

function Initialize()
	if v == nil then
		v = mMovie:__wf_atom_5e6e15c8("Subtitle", 5) / 100
		v = mMovie:__wf_atom_5e6e15c8("Subtitle1", 5) / 100
	end

	mMovie:__wf_atom_50d60589("Subtitle", 46, "bottom")
	mMovie:__wf_atom_50d60589("Subtitle", 36, "")
	mMovie:__wf_atom_50d60589("Subtitle1", 46, "bottom")
	mMovie:__wf_atom_50d60589("Subtitle1", 36, "")
	_T.SubtitleClipName = "Subtitle"
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:OverrideMaterial("Background.Line1", backgroundMaterial)
	_T.SubtitleVisible = false
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if _T.velocityCoords then
		mMovie:__wf_atom_e57658c2("_root", 0, module.Round(_T.velocityCoords.x))
		mMovie:__wf_atom_e57658c2("_root", 1, module.Round(_T.velocityCoords.y))
	end

	if v5 and not __wf_atom_7e8ad928(v4) then
		local v9 = false

		if gRegion:__wf_atom_883d0564() then
			local __wf_atom_f8317305 = Resource(v4):__wf_atom_f8317305()

			for i = v6, #v5 do
				if not (__wf_atom_f8317305 <= v5[i][1]) then
					continue
				end

				fn3(v5[i][2], true)
				v6 = i
				v9 = true
				break
			end
		end

		if not v9 then
			v5 = nil
			fn3("")
		end
	end

	local hideSubtitles = tonumber(_T.HideSubtitles) or 0
	mMovie:SetVisible(hideSubtitles < 1)
end

function DisplaySubTitle(p)
	fn3(p)
	return true
end

function DisplaySubTitleIfEmpty(p)
	if v2 == "" then
		fn3(p)
	end
end

function ClearSpecificSubTitle(p)
	if v2 == p then
		fn3("")
	end
end

function SetFullScreenSubtitles(p, p2)
	local v9 = mMovie:__wf_atom_8e9ac384(p, false) .. "\r\n"
	v5 = {}
	v6 = 1
	local v10 = nil

	for k in string.gmatch(v9, "(.-)\r\n") do
		if v10 == nil then
			local v11 = string.gsub(k, "%[", "")
			v10 = tonumber((string.gsub(v11, "%]", "")))
		else
			table.insert(v5, { v10, k })
			v10 = nil
		end
	end

	v4 = WeakResource(p2)
end

function OpenFileFlashMovie()
	fn3("/Lotus/Language/Test/TestLoc")
end