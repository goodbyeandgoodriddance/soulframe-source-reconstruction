function EnterTrigger(_, _) end

function ExitTrigger(_, _) end

function ScriptTriggerManagement(instance)
	if not (gRegion:IsMaster() and instance:GetCreator()) then
		return
	end

	local v

	if not __wf_atom_7e8ad928(thornsAreaFX) then
		v = gRegion:CreateEntity(thornsAreaFX, instance:GetPosition(), __wf_atom_80368bb1)
	end

	local __wf_atom_68de036a = instance:GetCreator():__wf_atom_68de036a()
	local damageData = Engine.DamageData()
	damageData.blockableProjType = 4
	damageData.baseAmount = aoeBaseDamage + baseDamageRankMod * __wf_atom_68de036a
	damageData:__wf_atom_7498285f(aoeDamageType, 1)
	damageData:__wf_atom_6b472125(instance:GetCreator())
	local __wf_atom_9fb9a1d6 = instance:GetCreator():__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

	if __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		damageData:__wf_atom_34a8a27a(instance)
	else
		damageData:__wf_atom_34a8a27a(__wf_atom_9fb9a1d6)
	end

	local total = 0

	while total < conjurationLifetime do
		if #instance:__wf_atom_6f4fd712() > 0 then
			for _, v2 in ipairs(instance:__wf_atom_6f4fd712()) do
				if instance:GetCreator():__wf_atom_129d1aba(v2) or v2:__wf_atom_59cb39a4() then
					continue
				end

				v2:__wf_atom_649bf33e(damageData)
			end
		end

		Sleep(conjurationDamageRate)
		total += conjurationDamageRate
	end

	if not __wf_atom_7e8ad928(v) then
		v:Destroy()
	end

	instance:Destroy()
end