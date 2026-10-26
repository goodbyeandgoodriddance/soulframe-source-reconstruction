local v = Symbol("Guard")
local v2 = false
local v3 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function FallingRocks()
	if not __wf_atom_7e8ad928(sequencer) then
		sequencer:Enable()
	end

	if not __wf_atom_7e8ad928(effect) then
		effect:Enable()
	end

	for _, v4 in ipairs(decos) do
		if not __wf_atom_7e8ad928(v4) then
			v4:SetVisibility(true)
		end
	end
end

function ReplaceWithPhysicsObject()
	for i, v4 in ipairs(decos) do
		if __wf_atom_7e8ad928(v4) then
			continue
		end

		local position = v4:GetPosition()
		local __wf_atom_dc309f8a = v4:__wf_atom_dc309f8a()
		v4:Destroy()
		gRegion:CreateEntity(objectTypes[i], position, __wf_atom_dc309f8a)
	end
end

function StaggerDamageTrigger(_, instance)
	if instance:IsA(__wf_atom_9e85eea2) then
		local __wf_atom_0559c091 = instance:__wf_atom_0559c091()

		if __wf_atom_0559c091 >= 8000 and __wf_atom_0559c091 < 9000 then
			local damageData = Engine.DamageData()

			if killAvatar then
				local v4 = instance:GetMaxHealth() + 50
				damageData:__wf_atom_6d7ec072(Engine.UpgradedValue(v4))
			else
				damageData:__wf_atom_6d7ec072(Engine.UpgradedValue(damageAmount))
			end

			damageData:__wf_atom_7498285f(damageType, 1)
			damageData:__wf_atom_812165c6(0)
			damageData:__wf_atom_d6f4d914(procType, true)
			instance:__wf_atom_649bf33e(damageData)
		end
	end
end

function OrderInvestigate()
	if __wf_atom_7e8ad928(v3) then
		return
	end

	local position = v3:__wf_atom_20cba70d()
	local __wf_atom_02fe8d73 = v3:__wf_atom_02fe8d73()
	local creator = v3:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local v4 = creator:__wf_atom_6199ef01() or {}
	local __wf_atom_26b04ea9 = creator:__wf_atom_26b04ea9()

	if not __wf_atom_7e8ad928(__wf_atom_26b04ea9) then
		for _, v5 in ipairs(__wf_atom_26b04ea9:__wf_atom_6199ef01()) do
			table.insert(v4, v5)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_02fe8d73) then
		position = __wf_atom_02fe8d73:GetPosition()
	end

	for _, v5 in ipairs(v4) do
		if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5:__wf_atom_50a7d83e()) then
			continue
		end

		if not (v5:__wf_atom_50a7d83e():__wf_atom_d5fda8be(v3:GetPosition()) < investgatePerceptionRange) then
			continue
		end

		v5:__wf_atom_30b587a4()
		gRegion:__wf_atom_2202ffb6():__wf_atom_fdd7548c(v5, 4, 18, position, __wf_atom_02fe8d73, 0, 0, true)
		v5:__wf_atom_42b767a2(v)
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(
		2,
		14,
		position,
		__wf_atom_02fe8d73,
		0,
		investgatePerceptionRange,
		true
	)
	v2 = true
	Sleep(perceptionCooldown)
	v2 = false
end

function OdeAtmosphereGenExplosion(instance, object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_679ed446 = object:__wf_atom_679ed446()
	v3 = instance

	if instance:__wf_atom_c6f1f83d() < 90000 then
		instance:Attach(damagedFx, EMPTY_SYMBOL)
		local __wf_atom_be0bea4a = instance:__wf_atom_be0bea4a()

		for _, v4 in ipairs(__wf_atom_be0bea4a) do
			for _, className in ipairs(fxTypesToRemove) do
				if not v4:IsA(className) then
					continue
				end

				v4:__wf_atom_e6ed03c8()
				v4:PlayTriggeredFade()
			end
		end

		if v2 == false then
			instance:__wf_atom_8a035cd5(Symbol("OrderInvestigate"), false)
		end

		Sleep(2)
		module.GiveXpToPlayer(destroyXp, __wf_atom_679ed446)
		instance:Destroy()
	end
end