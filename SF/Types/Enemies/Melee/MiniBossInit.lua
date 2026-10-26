local v = Symbol("HardModedAbandoning")
require("Lotus.Scripts.Libs.AbilitiesLib")
Symbol("BlockingBehavior")
local module = require("SF.Scripts.Libs.TransmissionSet")
local _ = Symbol("Boss")

function MiniBoss(_, object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if
		__wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		or __wf_atom_3d96ddcd:IsKilled()
		or not __wf_atom_3d96ddcd:IsA(__wf_atom_67c46eba)
	then
		return
	end

	__wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	object:Disable()
	local name = names[__wf_atom_5784a397(1, #names)]

	if __wf_atom_3d96ddcd:__wf_atom_818ea3a7() == "" then
		__wf_atom_3d96ddcd:__wf_atom_17e77e5b(Localize(name, nil))
	end

	__wf_atom_3d96ddcd:__wf_atom_5cb037b2(Symbol(name))
	local v2 = Symbol("BossAwarenessTrigger")
	local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(__wf_atom_589cefdb)

	for _, v3 in ipairs(__wf_atom_f582136d) do
		if __wf_atom_7e8ad928(v3) or v3:__wf_atom_db682341() ~= v2 then
			continue
		end

		v3:Enable()
	end

	local v3 = Range(30, 60)
	local v4 = 1
	local preBattle = PreBattle

	if gRegion:IsMaster() then
		local __wf_atom_30e3d82b = __wf_atom_3d96ddcd:__wf_atom_30e3d82b()

		if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			return
		end

		while not __wf_atom_30e3d82b:__wf_atom_04ea4887() do
			if v4 <= 0 then
				local tauntTransmissionSet = tauntTransmissionSet
				local position = __wf_atom_3d96ddcd:GetPosition()
				module.PlayRadialTransmission(tauntTransmissionSet, preBattle, position, 100)
				v4 = __wf_atom_5784a397(v3.minValue, v3.maxValue)
			end

			v4 -= __wf_atom_084b3e93()
			Sleep(0)

			if
				__wf_atom_7e8ad928(__wf_atom_30e3d82b)
				or __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
				or __wf_atom_3d96ddcd:IsKilled()
			then
				return
			end
		end
	end

	local duringBattle = DuringBattle
	module.CloseTransmissions()
	local tauntTransmissionSet = tauntTransmissionSet
	local position = __wf_atom_3d96ddcd:GetPosition()
	module.PlayRadialTransmission(tauntTransmissionSet, duringBattle, position, 100)
end

function OnInstigatorEnter(instance, object)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_7e6ed5fa) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	while __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		if __wf_atom_7e8ad928(object) then
			return
		end

		__wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
		Sleep(0)
	end

	if not __wf_atom_3d96ddcd:IsA(__wf_atom_9e85eea2) then
		return
	end

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		if __wf_atom_3d96ddcd:__wf_atom_3a6b0cbb() then
			instance:__wf_atom_97f3b941(__wf_atom_3d96ddcd)
			break
		else
			Sleep(0)
		end
	end
end

function OnInstigatorExit(object, instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_7e6ed5fa) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	while __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		__wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
		Sleep(0)
	end

	if not __wf_atom_3d96ddcd:IsA(__wf_atom_9e85eea2) then
		return
	end

	instance:__wf_atom_67505464(__wf_atom_3d96ddcd)
end

function BossHealthBarMonitor(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	while __wf_atom_7e8ad928(_T.SetupBossAvatar) do
		Sleep(0)
	end

	Sleep(0.5)
	object:__wf_atom_25861d04()
	local v2 = false
	local v3 = nil
	local flag = false

	while object:__wf_atom_7fd8fbb3() > 0 and not object:IsKilled() do
		local __wf_atom_5f572b28s = {}

		for i = 0, object:__wf_atom_7fd8fbb3() - 1 do
			local __wf_atom_5f572b28 = object:__wf_atom_5f572b28(i)

			if __wf_atom_7e8ad928(__wf_atom_5f572b28) then
				continue
			end

			local __wf_atom_818ea3a7 = __wf_atom_5f572b28:__wf_atom_818ea3a7()

			if __wf_atom_818ea3a7 == "" then
				__wf_atom_5f572b28:__wf_atom_17e77e5b(Localize("", nil))
			end

			__wf_atom_5f572b28:__wf_atom_5cb037b2(Symbol(__wf_atom_818ea3a7))
			table.insert(__wf_atom_5f572b28s, __wf_atom_5f572b28)
		end

		v2 = v2 or #__wf_atom_5f572b28s > 1
		local v4

		if #__wf_atom_5f572b28s == #v3 then
			local flag2 = true

			for i, v5 in ipairs(__wf_atom_5f572b28s) do
				if v5 == v3[i] then
					continue
				end

				v4 = false
				flag2 = false
				break
			end

			if flag2 then
				v4 = true
			end
		else
			v4 = false
		end

		if not v4 then
			_T.SetupBossAvatarList(__wf_atom_5f572b28s, v2)
			v3 = __wf_atom_5f572b28s
		end

		if gGameRules:__wf_atom_d163c8e5(v, 0) == 1 then
			_T.SetupBossAvatar(nil)
			flag = true
		elseif flag then
			_T.SetupBossAvatarList(v3, v2)
			flag = false
		end

		Sleep(0.5)
		object:__wf_atom_25861d04()
	end

	if _T.SetupBossAvatar ~= nil then
		_T.SetupBossAvatar(nil)
	end
end