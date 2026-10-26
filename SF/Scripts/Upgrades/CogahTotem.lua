local module = require("SF.Scripts.Libs.EncounterLib")

function OnUnapplyUpgrade(object)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode.cogahTotem) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode.cogahTotem.damageMultiplier)) then
		object:__wf_atom_d2b2176d():RemoveUpgrade(
			mDamageUpgradeType,
			2,
			__wf_atom_e919fb8e.hardMode.cogahTotem.damageMultiplier,
			__wf_atom_77e05d3b
		)
		__wf_atom_e919fb8e.hardMode.cogahTotem.damageMultiplier = 1
	end
end

function UpdateMeleeDamage(object)
	if not gRegion:IsMaster() then
		return
	end

	if module.IsHardModeActive() then
		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
			local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
			local hardModeSubBossKillCount = module.GetHardModeSubBossKillCount()
			local damageMultiplier = mDamageBonusFactor * math.log(hardModeSubBossKillCount + 1)

			if
				__wf_atom_e919fb8e.hardMode ~= nil
				and __wf_atom_e919fb8e.hardMode.cogahTotem ~= nil
				and __wf_atom_e919fb8e.hardMode.cogahTotem.damageMultiplier ~= nil
			then
				__wf_atom_d2b2176d:RemoveUpgrade(
					mDamageUpgradeType,
					3,
					__wf_atom_e919fb8e.hardMode.cogahTotem.damageMultiplier,
					__wf_atom_77e05d3b
				)
				__wf_atom_e919fb8e.hardMode.cogahTotem.damageMultiplier = damageMultiplier
				__wf_atom_d2b2176d:AddUpgrade(mDamageUpgradeType, 3, damageMultiplier, __wf_atom_77e05d3b)
			end
		end
	else
		OnUnapplyUpgrade(object)
	end
end

function OnApplyUpgrade(object, _, p)
	if not gRegion:IsMaster() then
		return
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode) then
			__wf_atom_e919fb8e.hardMode = {}
		end

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.hardMode.cogahTotem) then
			__wf_atom_e919fb8e.hardMode.cogahTotem = {}
		end

		__wf_atom_e919fb8e.hardMode.item = p
		__wf_atom_e919fb8e.hardMode.cogahTotem.damageMultiplier = 1
		__wf_atom_e919fb8e.hardMode.subBossKillCallback = UpdateMeleeDamage
		UpdateMeleeDamage(object)
	end
end