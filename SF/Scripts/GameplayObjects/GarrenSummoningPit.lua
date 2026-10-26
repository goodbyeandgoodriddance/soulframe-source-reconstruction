local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("Lotus.Scripts.Libs.AudioLib")
local activeWorldBossAvatar = nil

local function fn(activeWorldBossAvatar2)
	if __wf_atom_7e8ad928(activeWorldBossAvatar2) then
		return nil
	end

	for i = 1, #avatarTypes do
		if activeWorldBossAvatar2:IsA(avatarTypes[i]) then
			return i
		end
	end

	return nil
end

local function fn2(activeWorldBossAvatar2, p, p2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local cameraControl = __wf_atom_c4f78a8f:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			cameraControl:__wf_atom_4dab66dd(activeWorldBossAvatar2:GetPosition(), -1, p, 2)
			__wf_atom_eab484a7:__wf_atom_a6c0f1b8(4, 0.3, 0.3, p2)
		end
	end
end

local function fn3()
	activeWorldBossAvatar = _T.ActiveWorldBossAvatar

	if __wf_atom_7e8ad928(activeWorldBossAvatar) then
		return
	end

	if _T.MinibossRevealed == nil then
		_T.MinibossRevealed = {}
	end

	_T.MinibossRevealed[activeWorldBossAvatar] = true
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StagEruptionAnticipationSeq"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Disable()
	end

	local __wf_atom_a2a18137 = gRegion:__wf_atom_ef7900cf()[1]:__wf_atom_a2a18137()
	local v = __wf_atom_fa8d0177(activeWorldBossAvatar:__wf_atom_a2a18137(), __wf_atom_a2a18137)
	v.pitch = 0
	v.bank = 0
	activeWorldBossAvatar:__wf_atom_84d66e8e(v)
	activeWorldBossAvatar:MotionControl():__wf_atom_3a1d0c16(v)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = 20
	radialDamageData.baseAmount = 10
	radialDamageData:__wf_atom_6b472125(activeWorldBossAvatar)
	radialDamageData:__wf_atom_d6f4d914(17, true)
	local v2 = fn(activeWorldBossAvatar)
	local revealAnim = revealAnims[v2]

	if not __wf_atom_7e8ad928(revealAnim) then
		activeWorldBossAvatar:__wf_atom_921c1a5f(revealAnim, false, 4, 1, false)
		activeWorldBossAvatar:__wf_atom_8914dfde("ShowBoss", 5)
	end

	if __wf_atom_7e8ad928(activeWorldBossAvatar) then
		print("Boss avatar became nil after ShowBoss event")
		return
	end

	activeWorldBossAvatar:__wf_atom_d1b42aad(true)
	activeWorldBossAvatar:SetVisibility(true)
	activeWorldBossAvatar:__wf_atom_30964595(true)
	activeWorldBossAvatar:__wf_atom_0ed81088(true)
	activeWorldBossAvatar:SetDisableGravity(false)
	activeWorldBossAvatar:__wf_atom_8914dfde("Erupt", 5)

	if __wf_atom_7e8ad928(activeWorldBossAvatar) then
		print("Boss avatar became nil after Erupt event")
		return
	end

	gRegion:CreateEntity(eruptFxType, activeWorldBossAvatar:GetPosition(), __wf_atom_80368bb1)
	fn2(activeWorldBossAvatar, 6, 2)
	radialDamageData:__wf_atom_98d98d81(activeWorldBossAvatar:GetPosition())
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	activeWorldBossAvatar:__wf_atom_8914dfde("BossBar", 5)

	if __wf_atom_7e8ad928(activeWorldBossAvatar) then
		print("vadagar stag became null or got killed after BossBar suspend.")
		return
	end

	local v3 = Symbol("BossAwarenessTrigger")
	local __wf_atom_f582136d = activeWorldBossAvatar:__wf_atom_f582136d(__wf_atom_589cefdb)

	for _, v4 in ipairs(__wf_atom_f582136d) do
		if __wf_atom_7e8ad928(v4) or v4:__wf_atom_db682341() ~= v3 then
			continue
		end

		v4:Enable()
	end

	while not __wf_atom_7e8ad928(activeWorldBossAvatar) and activeWorldBossAvatar:__wf_atom_c138b19b(revealAnim) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(activeWorldBossAvatar) then
		print("Boss avatar became nil during reveal animation")
		return
	end

	module.SetImmunity(activeWorldBossAvatar, false)
	activeWorldBossAvatar:SetBlackboardBool(Symbol("CanFight"), true)
	activeWorldBossAvatar:__wf_atom_30e3d82b():__wf_atom_f54283ea()
end

function OnTouched(object)
	object:Disable()
	fn3()
end

function SetUpSummoningPit(p)
	__wf_atom_55142dd4(p, "OnTouched")
end