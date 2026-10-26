local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Interface.SFUtilities")

function Run(_)
	local __wf_atom_0a6a5887 = __wf_atom_392793db:__wf_atom_0a6a5887(Symbol("CameraSpot"))
	module2.RegisterHideHud(true)
	Sleep(0)
	local __wf_atom_a5040fdf = __wf_atom_0a6a5887:__wf_atom_a5040fdf()
	local __wf_atom_0a6a5887_2 = __wf_atom_a5040fdf:__wf_atom_0a6a5887(Symbol("BoardA"))
	local __wf_atom_0a6a5887_3 = __wf_atom_a5040fdf:__wf_atom_0a6a5887(Symbol("BoardB"))
	__wf_atom_0a6a5887_2:SetMaterialParam(Symbol("TintColor"), 1, 0.91, 0.66, 0)
	__wf_atom_0a6a5887_3:SetVisibility(false, true)
	local v = 1
	local v2 = 0

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and v < #textures + 1 do
		__wf_atom_0a6a5887_2:__wf_atom_c03f9bdb(0, "SecondaryMap", textures[v])
		local v3 = 0

		while v3 < 1 and not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) do
			local v4 = __wf_atom_084b3e93()
			v3 = __wf_atom_421b01aa(v3 + v4 / 1, 0, 1)
			local v5 = __wf_atom_24a82b69(v3)
			local v6 = __wf_atom_104bfe98(0.1, 0.05, v5)
			local v7 = __wf_atom_104bfe98(0.1, 0.05, 1 - v5)
			__wf_atom_0a6a5887_2:SetMaterialParam(Symbol("TintColor"), 1, 0.91, 0.66, v5 * 0.8)
			__wf_atom_0a6a5887_2:SetMaterialParam(Symbol("RippleScale"), v6, v6)
			__wf_atom_0a6a5887_3:SetMaterialParam(Symbol("TintColor"), 1, 0.91, 0.66, (1 - v5) * 0.8)
			__wf_atom_0a6a5887_3:SetMaterialParam(Symbol("RippleScale"), v7, v7)
			Sleep(0)
		end

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			break
		end

		__wf_atom_0a6a5887_3:SetVisibility(true, true)
		v += 1
		local timing = timings[v]

		if timing == nil or timing <= 0 then
			timing = v2 + 3
		end

		if __wf_atom_7e8ad928(_T.TransmissionSoundInstance) then
			break
		end

		local v4 = _T.TransmissionSoundInstance:__wf_atom_53a51c90() - _T.TransmissionSoundInstance:__wf_atom_946fdac0()
		Sleep((math.max(0, timing - v4)))

		if __wf_atom_7e8ad928(_T.TransmissionSoundInstance) then
			break
		end

		v2 = _T.TransmissionSoundInstance:__wf_atom_53a51c90() - _T.TransmissionSoundInstance:__wf_atom_946fdac0()
		__wf_atom_0a6a5887_3, __wf_atom_0a6a5887_2 = __wf_atom_0a6a5887_2, __wf_atom_0a6a5887_3
	end

	if not __wf_atom_7e8ad928(_T.curTransmission) then
		module.Fade(true, 1, 1, true)
	end

	module2.RegisterHideHud(false)
end