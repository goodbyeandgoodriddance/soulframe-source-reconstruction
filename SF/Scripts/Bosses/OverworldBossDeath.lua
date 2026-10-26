require("Lotus.Scripts.Libs.AudioLib")

local function fn(object) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_d1b42aad(false)
	object:__wf_atom_30964595(false)
	object:__wf_atom_0ed81088(false)
	object:SetDisableGravity(true)
end

function OnOverworldBossDeath(object)
	fn(object) -- inferred equivalent call

	if not __wf_atom_7e8ad928(_T.SetupBossAvatar) then
		_T.SetupBossAvatar(nil)
	end

	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_76724198 = object:__wf_atom_30e3d82b():__wf_atom_76724198()

	if __wf_atom_7e8ad928(__wf_atom_76724198) then
		return
	end

	__wf_atom_76724198:__wf_atom_8e6fec76(4)
end