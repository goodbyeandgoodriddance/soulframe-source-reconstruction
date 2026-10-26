function OnUpgradeApplied(p, p2, _, _, object)
	local __wf_atom_60ba1637 = object:__wf_atom_60ba1637()

	if __wf_atom_7e8ad928(__wf_atom_60ba1637) or __wf_atom_7e8ad928(p2) then
		return
	end

	local victim = __wf_atom_60ba1637.victim

	if
		__wf_atom_7e8ad928(victim)
		or victim:IsKilled()
		or victim:__wf_atom_bedb4e3f()
		or victim:__wf_atom_129d1aba(p)
	then
		return
	end

	local damageData = Engine.DamageData()
	damageData:__wf_atom_6d7ec072(Engine.UpgradedValue(0))
	damageData.criticalChance = 1
	damageData.criticalMultiplier = 1
	damageData:__wf_atom_7498285f(15, 1)
	damageData:__wf_atom_6b472125(p)
	damageData:__wf_atom_34a8a27a(p2)
	victim:__wf_atom_649bf33e(damageData)
end