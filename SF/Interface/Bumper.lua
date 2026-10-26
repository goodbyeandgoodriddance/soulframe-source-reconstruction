local module = require("EE.Interface.Utilities")
local v = 1

local function fn() -- 1 equivalent call inferred from this helper
	mMovie:Close()
end

local function fn2(p)
	mMovie:__wf_atom_0cf0fdbe(1 - p)
end

local function fn3()
	local image = images[v]

	if image == nil then
		fn() -- inferred equivalent call
		return
	end

	mMovie:__wf_atom_c90af43a("Image", image)
	local x = mMovie:__wf_atom_97cd8326()
	local y

	if image:IsA(__wf_atom_8a33958d) then
		y = mMovie:__wf_atom_54eeda24()
		mMovie:OverrideMaterial("Image", videoMaterial)
	else
		mMovie:OverrideMaterial("Image", nil)
		local __wf_atom_80cf57aa = image:__wf_atom_80cf57aa()
		x = __wf_atom_80cf57aa.x
		y = __wf_atom_80cf57aa.y
	end

	local __wf_atom_d5a50cb5 = mMovie:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = mMovie:__wf_atom_c4f6543f()
	local v2 = imageScale[v] or 1

	if module.GetPlatform() == module.PLATFORM.PC then
		if x < __wf_atom_d5a50cb5 and y < __wf_atom_c4f6543f then
			v2 *= ((__wf_atom_c4f6543f - y) * 0.65 + y) / __wf_atom_c4f6543f
		end

		local v3 = mMovie:__wf_atom_97cd8326() / mMovie:__wf_atom_54eeda24()
		local v4 = __wf_atom_d5a50cb5 / __wf_atom_c4f6543f

		if v4 < v3 then
			v2 = v2 / v4 * v3
		end
	end

	mMovie:__wf_atom_e57658c2("Image", 14, x * v2)
	mMovie:__wf_atom_e57658c2("Image", 15, y * v2)
	local v3 = imageDuration[v] or 3
	__wf_atom_ec43d06e(mMovie, "Image", 0, { 12 }, { 100 }, fadeTime, 0, function()
		if images[v + 1] == nil then
			__wf_atom_ec43d06e(mMovie, "Image", 1, { 12 }, { 0 }, fadeTime, v3, function()
				mMovie:__wf_atom_0c1c47f2(nil)
				__wf_atom_ec43d06e(mMovie, "Image", 1, { fn2 }, { 1 }, fadeTime, 0.5, fn)
			end)
		else
			__wf_atom_ec43d06e(mMovie, "Image", 0, { 12 }, { 0 }, fadeTime, v3, function()
				v += 1
				fn3()
			end)
		end
	end)
end

function Initialize()
	mMovie:__wf_atom_e57658c2("Image", 12, 0)
	mMovie:__wf_atom_7df746cd(0)
	__wf_atom_ec43d06e(mMovie, "Image", 0, {}, {}, 0, 1, fn3)
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
end

function Shutdown() end

function onViewportSizeChanged(_, _, _, _)
	fn3()
end

local _ = 0
local v2 = {
	{ W = 1792, H = 828 },
	{ W = 2360, H = 1640 },
	{ W = 1612, H = 720 },
	{ W = 2400, H = 1080 }
}

function onKeyDown_MENU_CANCEL() end