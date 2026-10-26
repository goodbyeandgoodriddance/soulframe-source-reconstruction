local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local activeFightController = nil
local v = nil
local v2 = false
local v3 = nil
local v4 = Symbol("WaitToFight")
local v5 = Symbol("WSP13_BOSSFIGHTTRIGGER")

function OnMobsDamaged(object, _, _)
	object:__wf_atom_9d766292()

	if object:IsKilled() then
		_T.MobsKilled -= 1
	end
end

function TriggerCommandAnims(object)
	object:__wf_atom_9b5dcd3b(orderThrallAnim, true, 4, 1, true)

	if not __wf_atom_7e8ad928(orderThrallLoopAnim) then
		object:__wf_atom_9b5dcd3b(orderThrallLoopAnim, true, 4, 2, true)
	end
end

local function fn(object, p)
	module.SetImmunity(object, true)
	local mobsKilled = p or #v.MobAgents

	if playTransmission then
		module2.PlayGlobalTransmission(questTransmissionSet, transmissionTag, false)
	end

	local playerAvatar = v.PlayerAvatars[1]

	if not __wf_atom_7e8ad928(orderThrallAnim) then
		object:__wf_atom_8a035cd5(Symbol("TriggerCommandAnims"), false)
	end

	for i = 1, mobsKilled do
		local mobAgent = v.MobAgents[i]

		if __wf_atom_7e8ad928(mobAgent.Avatar) or mobAgent.Avatar:IsKilled() then
			continue
		end

		mobAgent.Avatar:SetBlackboardBool(v4, false)
		mobAgent.Avatar:__wf_atom_51cd6126(Symbol("OnMobsKilled"), "OnMobsDamaged")
		mobAgent.Avatar:__wf_atom_30964595(true)
		mobAgent.Avatar:__wf_atom_15b36b95(true)
		mobAgent.Agent:SetPaused(false, Symbol("ThralledAgent"))
		module.SetImmunity(mobAgent.Avatar, false)
		mobAgent.Agent:__wf_atom_920a5a62()
		mobAgent.Agent:__wf_atom_f54283ea()
		mobAgent.Agent:StormTarget(playerAvatar)
	end

	v2 = true
	_T.MobsKilled = mobsKilled
end

function Evaluate(_, _)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v5)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v = activeFightController:__wf_atom_e919fb8e()
	end

	return 1
end

function Activate(object, _)
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v5)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v = activeFightController:__wf_atom_e919fb8e()
	end

	if gRegion:IsMaster() then
		object:__wf_atom_30e3d82b():__wf_atom_c3393b16(50, 50, 360, 90)
		object:__wf_atom_d2b2176d():AddUpgrade(169, 4, 0)
		object:__wf_atom_8d98f2fc(false, false, false)
	end

	v.SetCustomLockOnSettings(false)
	v3 = #v.MobAgents
	fn(object, v3)

	while not (v2 and _T.MobsKilled <= 0) do
		Sleep(0)
	end

	v2 = false
	Sleep(delayToResumeFight)
	object:SetBlackboardBool(Symbol("OrderThrall"), false)
	module.SetImmunity(object, false)
	object:__wf_atom_8d98f2fc(true, true, true)
	v.SetCustomLockOnSettings(true)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	object:__wf_atom_30e3d82b():StormTarget(__wf_atom_c4f78a8f)
end