local module = require("EE.Interface.Utilities")
local count = 0
local fn

local function fn2() -- 1 equivalent call inferred from this helper
	__wf_atom_8e4fda44:__wf_atom_5d67a2c5(progressScreen)
	mMovie:Close()
end

fn = function()
	local ternary = module.Ternary(Engine.__wf_atom_fc67ba71(), consoleImages, images)
	local ternary2 = module.Ternary(Engine.__wf_atom_fc67ba71(), consoleFitImageToScreen, fitImageToScreen)

	if Engine.__wf_atom_fc67ba71() then
		mMovie:__wf_atom_7df746cd(0)
	end

	count += 1

	if ternary[count] == nil then
		fn2() -- inferred equivalent call
	else
		mMovie:__wf_atom_c90af43a("Image", ternary[count])
		mMovie:__wf_atom_97cd8326()
		mMovie:__wf_atom_97cd8326()
		local y, x

		if ternary2[count] then
			local __wf_atom_80cf57aa = ternary[count]:__wf_atom_80cf57aa()
			local v = 1280 / __wf_atom_80cf57aa.x
			local v2 = 720 / __wf_atom_80cf57aa.y

			if v2 < v then
				y = __wf_atom_80cf57aa.y * v
				x = 1280
			else
				x = __wf_atom_80cf57aa.x * v2
				y = 720
			end
		else
			local __wf_atom_80cf57aa = ternary[count]:__wf_atom_80cf57aa()
			x = __wf_atom_80cf57aa.x
			y = __wf_atom_80cf57aa.y
		end

		mMovie:__wf_atom_e57658c2("Image", 14, x)
		mMovie:__wf_atom_e57658c2("Image", 15, y)
		local v = imageDuration[count]
		local v2 = v == nil and 5 or v
		__wf_atom_ec43d06e(mMovie, "Image", 0, { 12 }, { 100 }, fadeTime, 0, function()
			__wf_atom_ec43d06e(mMovie, "Image", 0, { 12 }, { 0 }, fadeTime, v2, fn)
		end)
	end
end

function Initialize()
	mMovie:__wf_atom_e57658c2("Image", 12, 0)
	fn()
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
end

function Shutdown() end