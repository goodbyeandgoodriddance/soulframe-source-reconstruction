local module = require("SF.Scripts.Libs.RaycastLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
require("SF.Scripts.Libs.TaleLib")
local v = nil
local v2 = 0
local v3 = "0"
local v4 = 0
local v5 = "0"
local v6 = 0
local v7 = "0"
local v8 = 0
local v9 = "0"
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = 0
local v14 = false
local v15 = "0"
local v16 = 1
local v17 = false
local v18 = 1
local v19 = 1
local v20 = 1
local v21 = 1
local names = nil
local names2 = nil
local v22 = nil
local v23 = { "PlayerAvatar", "Targeting Dummy" }
local v24 = 1
local v25 = 1
local v26 = nil
local v27 = {
	{ name = "Idle", int = 1 },
	{ name = "Movement Test", int = 2 },
	{ name = "Melee Attacks Test", int = 3 },
	{ name = "Ranged Attack Test", int = 1 },
	{ name = "Cast Tests", int = 4 },
	{ name = "Animation Player", int = 1 }
}
local v28 = {
	{ name = "MoveIdle", int = 1 },
	{ name = "Walk", int = 2 },
	{ name = "Jog", int = 3 },
	{ name = "Run", int = 4 }
}
local v29 = {}
local names3 = {}
local v30 = {
	{ mode = 1, name = "Play Once" },
	{ mode = 2, name = "Loop" }
}
local names4 = {}
local v31 = {
	{ mode = 0, name = "Defualt Anim Movement" },
	{ mode = 2, name = "Physics Driven Movement" },
	{ mode = 4, name = "HorizontalAnim Driven Movement" },
	{ mode = 3, name = "Anim Driven Movement" },
	{ mode = 1, name = "Decoupled Anim Movement" }
}
local names5 = {}
local v32 = 1
local v33 = 1
local v34 = 1
local v35 = 1
local v36 = 1
local v37 = true
local v38 = false
local v39 = 0
local v40 = nil
local v41 = nil
local v42 = {}
local v43 = {}
local v44 = 1
local v45 = false
local v46 = false
local v47 = nil
local v48 = {}
local v49 = {}
local v50 = 1
local v51 = nil
local v52 = 1
local categoryNames = {}
local categoryTable = {}
local names6 = {}
local v53 = 1
local v54 = 1
local v55 = {}
local custTestHarness = nil
local v56 = WeakResource("/SF/Types/Enemies/Melee/OdeCombatTester")
local v57 = 3
local v58 = "2"
local v59 = 0
local v60 = "2"
local v61 = nil
local v62 = { "Bool", "Float" }
local v63 = 1
local v64 = "Var"
local v65 = Symbol()
local v66 = "Value"
local v67 = {
	{
		categoryName = "Bosses",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Bosses/TempestBayor/TempestBayorAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Bosses/TempestBayor/TempestBayorCombatTester")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Bosses/LadyOfDendria/LadyOfDendriaBossAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Bosses/LadyOfDendria/DeoraBossCombatTester")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Bosses/GarrenRood/GarrenRoodBossAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Bosses/GarrenRood/GarrenCombatTester")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Bosses/GarrensHerd/GarrensHerdBaseAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Bosses/GarrenRood/GarrenCombatTester")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Nimrod/NimrodAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Sinecure/Nimrod/NimrodCombatTester")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Nimrod/NimrodSubBossAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Sinecure/Nimrod/NimrodCombatTester")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Bosses/CorruptedBromius/CorruptedBromiusAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Bosses/CorruptedBromius/BromiusCombatTester")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Bosses/CorruptedBromius/VadgarBear/VadagarBearAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Bosses/CorruptedBromius/BromiusCombatTester")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/Mendicant/Wazzard/MendicantWazzardAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/Mendicant/Wazzard/MendicantWazzardSubBossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/Mendicant/Wazzard/MendicantWazzardVotiveAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantKing/MendicantKingAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantKing/MendicantKingVotiveAgent")
			}
		}
	},
	{
		categoryName = "Sinecure - Soldiers",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntNightAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntDualAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntDualEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntAxeEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntDualAxeEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntPolearmAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntPolearmEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntShieldAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntShieldEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Soldier/MeleeGruntSpikedMaceEliteAgent")
			}
		}
	},
	{
		categoryName = "Sinecure - Knights",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeAxeAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeAxeOfficerAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeDaggerAndShieldAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeGreatSwordAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeGreatSwordSubBossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeMaceAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeMaceOfficerAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeMaceOfficerSubBossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeMaceOfficerTwoAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeSwordAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeSwordOfficerAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeSwordOfficerTwoAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Knight/MeleeHeavyNightAgent")
			}
		}
	},
	{
		categoryName = "Sinecure - Hunters",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Hunter/MeleeGruntScoutHunterAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Hunter/MeleeHunterDaggerEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Hunter/MeleeHunterDaggerDisguisedAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Hunter/RangedHunterBowAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Hunter/RangedHunterBowEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Hunter/RangedHunterBowSniperAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Hunter/RangedHunterBowSubBossAgent")
			}
		}
	},
	{
		categoryName = "Sinecure - Casters",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Caster/OdeBattleCasterAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Caster/OdeCasterAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/Caster/OdeCasterEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/OdeCasterSubBoss/OdeCasterCourageSubbossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/OdeCasterSubBoss/OdeCasterGraceSubbossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/OdeCasterSubBoss/OdeCasterSpiritSubbossAgent")
			}
		}
	},
	{
		categoryName = "Sinecure - Machines + Animals",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/OdeAttackDog/OdeAttackDogAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/OdeAttackDog/CorruptedOdeAttackDog/CorruptedOdeAttackDogAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/OdeAttackDog/CorruptedOdeAttackDog/CorruptedOdeAttackDogSubBossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/SiegeEngine/SiegeEngineAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Sinecure/OdeDrone/OdeDroneAgent")
			}
		}
	},
	{
		categoryName = "Mendicants",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Mendicant/Mounted/MendicantMountedKnightAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Mendicant/Mounted/MndRiderCombatTester"),
				bIsMounted = true
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Mendicant/Mounted/MendicantMountedKnightSubBossAgent"),
				CustTestHarness = WeakResource("/SF/Types/Enemies/Mendicant/Mounted/MndRiderCombatTester"),
				bIsMounted = true
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantKnight/MendicantKnightAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantKnight/MendicantKnightBellCleaverAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantKnight/MendicantKnightBellCleaverSubBossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantThrall/MendicantThrallAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantWazzardKnight/MendicantWazzardKnightAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantWazzardKnight/MendicantWazzardKnightSubBossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/MendicantWazzardKnight/MendicantWazzardKnightSwordAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/Mendicant/MendicantCaster/MendicantCasterAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/Mendicant/MendicantCaster/MendicantWazzardCasterAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Ranged/Mendicant/Wazzard/MendicantWazzardVotiveAgent")
			}
		}
	},
	{
		categoryName = "Corrupted Wildlife",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Corrupted/CorruptedSlug/CorruptedSlugAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Corrupted/CorruptedSlug/CorruptedSlugSubBossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Corrupted/Decapede/CorruptedDecapedeAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Corrupted/Decapede/CorruptedDecapedeGruntAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Spider/SpiderAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Spider/SpiderEliteAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Spider/SpiderSubBossAgent")
			}
		}
	},
	{
		categoryName = "Corrupted Sproutfolk",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/CorruptedSproutFolk/CorruptedSproutFolkGrunt/CorruptedSproutGruntAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/CorruptedSproutFolk/CorruptedSproutFolkGrunt/CorruptedSproutSpearGruntAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/SquidPlant/SquidplantAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/CorruptedSproutFolk/CorruptedSproutFolkAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/CorruptedSproutFolk/CorruptedSproutFolkSubBossAgent")
			}
		}
	},
	{
		categoryName = "Ghosts",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/WanderingGhostKnight/MiniGhostKnightAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/WanderingGhostKnight/WanderingGhostKnightAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/WanderingGhostKnight/WanderingGhostSoldierAgent")
			}
		}
	},
	{
		categoryName = "Mockeries",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/TypeWoodMockeries/MockeryWoodHoundUnarmedAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/TypeWoodMockeries/MockeryWoodWomanCasterAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/MockeryManAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/MockeryArmoredManAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/MockeryArmoredManAgentB")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/MockeryArmoredManAgentC")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/MockeryArmoredManSubBossAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/MockeriesSpirits/MockerySpiritManAgent")
			},
			{
				enemyType = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/MockeriesSpirits/MockerySpiritWomanAgent")
			}
		}
	},
	{
		categoryName = "Circade",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Circade/CircadeGhostKnightAgent"),
				CustTestHarness = nil
			}
		}
	},
	{
		categoryName = "Other",
		categoryTable = {
			{
				enemyType = WeakResource("/SF/Types/Enemies/Melee/ThralledSoliders/ThralledDendritSpearmenAgent"),
				CustTestHarness = nil
			}
		}
	}
}

local function fn(instance)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsKilled()) then
		local position, v68

		if instance:IsA(__wf_atom_f806fd7a) then
			local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
			local position2 = instance:GetPosition()
			local __wf_atom_8f18e876 = instance:__wf_atom_8f18e876()
			local v69 = position2 + __wf_atom_9341614d(
				Vector(__wf_atom_8f18e876, 0, 0),
				Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			)
			position = __wf_atom_2202ffb6:__wf_atom_7d789620():__wf_atom_0e0a6fee(v69, 100, 100)
			v68 = __wf_atom_fa8d0177(position, position2)
			gRegion:__wf_atom_5b35a0c8(
				position2,
				Color(0, 255, 0),
				"Subboss: " .. tostring(instance:__wf_atom_db682341()),
				1,
				10
			)
		else
			position = instance:GetPosition()
			v68 = instance:__wf_atom_dc309f8a()
		end

		__wf_atom_c4f78a8f:Teleport(position, v68)
		__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(v68)
	end
end

local function fn2(object, p)
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	__wf_atom_a2a18137.y = object:EyePosition().y
	local v68 = __wf_atom_a2a18137 + __wf_atom_a06d543c * p
	local __wf_atom_0e0a6fee = v12:__wf_atom_0e0a6fee(v68)
	local groundPos = module.GetGroundPos(
		__wf_atom_0e0a6fee,
		__wf_atom_28d5d4aa,
		Vector(0, -5, 0),
		nil,
		__wf_atom_28d5d4aa
	)

	if groundPos == __wf_atom_28d5d4aa then
		return nil
	end

	v26 = gRegion:CreateEntity(targetDummy, groundPos, __wf_atom_80368bb1)
end

local function fn3()
	v24 = __wf_atom_b046908b(v23, v24)

	if v25 ~= v24 then
		v25 = v24
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if v25 == 1 then
			v11:__wf_atom_f23858e5(__wf_atom_c4f78a8f)
		elseif v25 == 2 then
			if __wf_atom_7e8ad928(v26) then
				fn2(__wf_atom_c4f78a8f, 3)
			end

			v11:__wf_atom_f23858e5(v26)
		end
	end
end

local function fn4()
	if __wf_atom_2ebdf85a("AI Target Settings") then
		__wf_atom_07947f07()
		fn3()
		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Spawn Target Dummy") then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if __wf_atom_7e8ad928(v26) then
				fn2(__wf_atom_c4f78a8f, 3)
				return
			end

			v26:Destroy()
			fn2(__wf_atom_c4f78a8f, 3)

			if v25 == 2 then
				v11:__wf_atom_f23858e5(v26)
			end
		end
	end
end

local function fn5()
	v64 = __wf_atom_4f10b8c4("Blackboard Var", v64)
	__wf_atom_78aeed31()
	v63 = __wf_atom_b046908b(v62, v63)
	v66 = __wf_atom_4f10b8c4("Blackboard Value", v66)

	if v63 == 1 then
		__wf_atom_05a856ad("Current " .. tostring(v64) .. "BB Var: " .. tostring(v10:__wf_atom_52077f7a(Symbol(v64))))
	elseif v63 == 2 then
		__wf_atom_05a856ad("Current " .. tostring(v64) .. "BB Var: " .. tostring(v10:__wf_atom_ccd337ec(Symbol(v64))))
	end

	if __wf_atom_80afb308("Set BlackBoard Variable") then
		if v63 == 1 then
			local v68 = v66 == "true"
			v10:SetBlackboardBool(Symbol(v65), v68)
		elseif v63 == 2 then
			local v68 = tonumber(v66)
			v10:__wf_atom_cecb2d55(Symbol(v65), v68)
		end
	end
end

local function fn6()
	local damageData = Engine.DamageData()

	if __wf_atom_2ebdf85a("Enemy Force Interuptions") then
		__wf_atom_07947f07()

		if __wf_atom_80afb308("Force Stagger") then
			damageData:__wf_atom_d6f4d914(16, true)
			v10:__wf_atom_649bf33e(damageData)

			if not __wf_atom_7e8ad928(v40) then
				v40:__wf_atom_2c8638a6()
				v45 = false
			end
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Force Knockback") then
			damageData:__wf_atom_d6f4d914(0, true)
			v10:__wf_atom_649bf33e(damageData)

			if not __wf_atom_7e8ad928(v40) then
				v40:__wf_atom_2c8638a6()
				v45 = false
			end
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Force KnockDown") then
			damageData:__wf_atom_d6f4d914(19, true)
			v10:__wf_atom_649bf33e(damageData)

			if not __wf_atom_7e8ad928(v40) then
				v40:__wf_atom_2c8638a6()
				v45 = false
			end
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Force Stun") then
			damageData:__wf_atom_d6f4d914(18, true)
			v10:__wf_atom_649bf33e(damageData)

			if not __wf_atom_7e8ad928(v40) then
				v40:__wf_atom_2c8638a6()
				v45 = false
			end
		end
	end
end

local function fn7()
	Sleep(0.5)

	for k in pairs(v49) do
		v49[k] = nil
	end

	v47 = v10:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	v48 = v47:__wf_atom_36b4a6e5()

	for _, v68 in ipairs(v48) do
		table.insert(v49, v68:GetName())

		if v68:IsActive() then
			v68:DeactivateAbility()
		end
	end
end

function StartAbilityCast()
	local __wf_atom_248bb7ae = v47:__wf_atom_248bb7ae(v48[v50])
	v51 = v48[v50]
	local __wf_atom_eda97f5a = v11:__wf_atom_eda97f5a()
	Sleep(v59)

	if v47:__wf_atom_c497b0ae(__wf_atom_248bb7ae):IsActive() then
		v10:__wf_atom_623b3028(Symbol("/Language/Game/AbilityCastError"))
		v46 = false
	else
		v11:__wf_atom_cca1dc04(v51, __wf_atom_eda97f5a, true)

		if __wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(v10) then
		end
	end
end

function LoopAbilityCast()
	while v46 do
		v10:__wf_atom_8a035cd5(Symbol("StartAbilityCast"), true)
		Sleep(v57)
	end
end

local function fn8()
	__wf_atom_07947f07()
	v58 = __wf_atom_4f10b8c4("LoopDelay", v58)
	v57 = tonumber(v58)
	__wf_atom_07947f07()
	v60 = __wf_atom_4f10b8c4("PreAttackDelay", v60)
	v59 = tonumber(v60)
	__wf_atom_05a856ad("Override Cooldown Time")
	__wf_atom_78aeed31()
	v52 = __wf_atom_4f10b8c4("1")
end

local function fn9(p, p2) -- 4 equivalent calls inferred from this helper
	local v68, v69 = __wf_atom_d2655286(p, p2 or false)
	return v68, v69
end

local function fn10()
	if #v48 <= 0 then
		__wf_atom_05a856ad("Agent " .. v11:GetName() .. " Has no equipped Power Suit abilities")
		return
	end

	v50 = __wf_atom_fdfab732("##CastTest", v50, v49)
	__wf_atom_07947f07()

	if __wf_atom_80afb308("Activate Cast") and v47:__wf_atom_8db03a52() == false then
		if v46 then
			v10:__wf_atom_8a035cd5(Symbol("LoopAbilityCast"), false)
		else
			v10:__wf_atom_8a035cd5(Symbol("StartAbilityCast"), false)
		end
	end

	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Reload Casts") then
		fn7()
	end

	__wf_atom_78aeed31()
	local _, v68 = fn9("Loop", v46) -- inferred equivalent call
	v46 = v68
	__wf_atom_07947f07()
	v11:__wf_atom_9a1e4ed3()
	__wf_atom_07947f07()
	fn8()
	__wf_atom_07947f07()
	fn4()
end

local function fn11()
	if #testAnims == 0 then
		return
	end

	for _, anim in ipairs(testAnims) do
		table.insert(v29, { name = anim:GetName(), anim = anim })
		table.insert(names3, anim:GetName())
	end

	for _, v68 in ipairs(v30) do
		table.insert(names4, v68.name)
	end

	for _, v68 in ipairs(v31) do
		table.insert(names5, v68.name)
	end
end

local function fn12()
	if #testAnims == 0 or #names4 == 0 then
		__wf_atom_05a856ad("No Animations found, please add any _anim assets to the enemy combat tester attachment on " .. v10:__wf_atom_5b41f63b() .. ".")
		__wf_atom_07947f07()

		if __wf_atom_80afb308("Reload Animations") then
			fn11()
		end
	else
		v33 = __wf_atom_fdfab732("##AnimTest", v33, names3)
		__wf_atom_07947f07()

		if __wf_atom_80afb308("Play") then
			v39 = v10:__wf_atom_921c1a5f(v29[v33].anim, false, v31[v32].mode, v30[v34].mode, true, 1)
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Stop") and v10:__wf_atom_c138b19b(v29[v33].anim, false) then
			v10:StopAnimation()
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Reload Animations") then
			fn11()
		end

		__wf_atom_07947f07()

		if __wf_atom_2ebdf85a("Playback Controls") then
			__wf_atom_07947f07()
			__wf_atom_05a856ad("Play Mode")
			__wf_atom_78aeed31()
			v34 = __wf_atom_fdfab732("##Playmode", v34, names4)
			__wf_atom_05a856ad("Anim Movement")
			__wf_atom_78aeed31()
			v32 = __wf_atom_fdfab732("##animMovement", v32, names5)
			__wf_atom_05a856ad("PlayRate")
			__wf_atom_78aeed31()
			v36 = __wf_atom_4f10b8c4(v36)
			v35 = tonumber(v36)
		end
	end
end

local function fn13()
	Sleep(0.5)
	v40 = v10:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

	if __wf_atom_7e8ad928(v40) then
		return
	end

	v42 = {}
	v43 = {}
	v41 = v40:__wf_atom_75a0566d()

	for i = 0, 33 do
		local __wf_atom_775d8b1c = v41:__wf_atom_775d8b1c(i, true)

		if __wf_atom_7e8ad928(__wf_atom_775d8b1c) then
			continue
		end

		local name = String(__wf_atom_775d8b1c:GetName() .. "  " .. tostring(i))
		table.insert(v42, { meleeSet = __wf_atom_775d8b1c, meleeContext = i, name = name })
		table.insert(v43, name)
	end
end

function PlayMeleeCombo()
	v10:__wf_atom_9373d0eb(0, true)
	local entity = v11:__wf_atom_9a1e4ed3().entity

	if not __wf_atom_7e8ad928(entity) then
		v10:__wf_atom_5127af76(entity, entity:__wf_atom_a2a18137())
	end

	Sleep(v59)

	for _ = 1, v41:__wf_atom_5e696f4d(v42[v44].meleeContext) do
		v40:__wf_atom_01e1d257(v42[v44].meleeContext)
	end

	if v45 then
		while v40:__wf_atom_85821ed3() or v41:__wf_atom_24cef05f(v42[v44].meleeContext, 0) do
			Sleep(0)
		end

		Sleep(v57)
		v10:__wf_atom_8a035cd5(Symbol("PlayMeleeCombo"), false)
	end
end

local function fn14()
	if __wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(v11) then
		return
	end

	v44 = __wf_atom_fdfab732("##AttackTest", v44, v43)
	__wf_atom_78aeed31()

	if __wf_atom_80afb308("PlayAttack") and not v40:__wf_atom_85821ed3() then
		v10:__wf_atom_8a035cd5(Symbol("PlayMeleeCombo"), false)
	end

	__wf_atom_78aeed31()
	local _, v68 = fn9("Loop Melee Combo", v45) -- inferred equivalent call
	v45 = v68
	__wf_atom_07947f07()
	v58 = __wf_atom_4f10b8c4("LoopDelay", v58)
	v57 = tonumber(v58)
	__wf_atom_07947f07()
	v60 = __wf_atom_4f10b8c4("PreAttackDelay", v60)
	v59 = tonumber(v60)
	__wf_atom_07947f07()
end

local function fn15(p)
	if __wf_atom_7e8ad928(p) then
		names2 = nil
		v22 = nil
	else
		names2 = {}
		v22 = p

		for _, v68 in ipairs(v22) do
			table.insert(names2, v68.name)
		end
	end
end

local function fn16()
	v18 = __wf_atom_fdfab732("##TestingMode", v18, names)
	__wf_atom_78aeed31()

	if __wf_atom_80afb308("Change Testing Mode") and v20 ~= v18 then
		v20 = v18

		if v20 == 1 then
			v10:__wf_atom_cecb2d55(Symbol("TestMode"), v27[v20].int)
			fn15(nil)
		elseif v20 == 2 then
			v10:__wf_atom_cecb2d55(Symbol("TestMode"), v27[v20].int)
			fn15(v28)
		elseif v20 == 3 then
			v10:__wf_atom_cecb2d55(Symbol("TestMode"), v27[v20].int)
			fn15(nil)
			fn13()
		elseif v20 == 4 then
			v10:__wf_atom_cecb2d55(Symbol("TestMode"), v27[v20].int)
			fn15(nil)
		elseif v20 == 5 then
			v10:__wf_atom_cecb2d55(Symbol("TestMode"), v27[v20].int)
			fn15(nil)
			fn7()
		elseif v20 == 6 then
			v10:__wf_atom_cecb2d55(Symbol("TestMode"), v27[v20].int)
			fn15(nil)
			fn11()
		end
	else
		__wf_atom_07947f07()

		if not __wf_atom_7e8ad928(names2) then
			__wf_atom_4f3659d1(v27[v20].name .. "Settings")
			v19 = __wf_atom_fdfab732("##Tests", v19, names2)
			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Change Test") and v21 ~= v19 then
				v21 = v19

				if v20 == 1 then
					return
				end

				if v20 == 2 then
					v11:__wf_atom_6c491aa2(testingBehaviourAction, false)
					print("testing mode:" .. v27[v20].name .. "Test: " .. v22[v21].name .. " BBVal: " .. v22[v21].int)
					v10:__wf_atom_cecb2d55(Symbol("MoveMode"), v22[v21].int)
				end

				if v20 == 5 then
					print("testing mode:" .. v27[v20].name .. "Test: " .. v22[v21].name .. " BBVal: " .. v22[v21].int)
					v10:__wf_atom_cecb2d55(Symbol("Cast"), v22[v21].int)
				end
			end
		end
	end
end

local function fn17()
	if __wf_atom_2ebdf85a("Set AnimVariables") then
		local _, v68 = fn9("Set Standing Var", v37) -- inferred equivalent call
		v37 = v68
		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Set Standing State") then
			if v37 == true then
				v10:__wf_atom_78ad8b9f(128, 0)
			elseif v37 == false then
				v10:__wf_atom_78ad8b9f(128, 1)
			end
		end

		local _, v69 = fn9("Set Alerted Var", v38) -- inferred equivalent call
		v38 = v69
		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Set Alerted State") then
			if v38 == true then
				v10:__wf_atom_78ad8b9f(22, 0)
			elseif v38 == false then
				v10:__wf_atom_78ad8b9f(22, 1)
			end
		end
	end
end

local function fn18()
	if __wf_atom_2ebdf85a("Blackboard Variables") then
		__wf_atom_05a856ad("Test Mode Active  BlackBoard Var: " .. tostring(v10:__wf_atom_52077f7a(Symbol("TestingMode"))))
		__wf_atom_78aeed31()
		__wf_atom_05a856ad("Current Testing Mode BlackBoard Var: " .. tostring(v10:__wf_atom_ccd337ec(Symbol("TestMode"))))
		__wf_atom_07947f07()

		if v20 == 2 then
			__wf_atom_78aeed31()
			__wf_atom_05a856ad("Current " .. v27[v20].name .. "BB Var: " .. tostring(v10:__wf_atom_ccd337ec(Symbol("MoveMode"))))
		elseif v20 == 3 then
			__wf_atom_78aeed31()
			__wf_atom_05a856ad("Current " .. v27[v20].name .. "BB Var: " .. tostring(v10:__wf_atom_ccd337ec(Symbol("MeleeAttack"))))
		elseif v20 == 5 then
			__wf_atom_78aeed31()
			__wf_atom_05a856ad("Current " .. v27[v20].name .. "BB Var: " .. tostring(v10:__wf_atom_ccd337ec(Symbol("Cast"))))
			__wf_atom_4f3659d1("Cast Info")

			if not __wf_atom_7e8ad928(v51) then
				__wf_atom_05a856ad("Trying to cast: " .. v51:GetName())
				return
			end
		end

		if __wf_atom_2ebdf85a("Set BlackBoard Variables") then
			fn5()
		end
	end
end

function GodMode()
	while v14 and not (__wf_atom_7e8ad928(v10) or v10:IsKilled()) do
		if v10:__wf_atom_c6f1f83d() <= v13 * 0.5 then
			v10:SetHealth(v13)
		end

		Sleep(0)
	end
end

local function fn19()
	local v68 = nil

	if __wf_atom_2ebdf85a("Enemy Health Settings") then
		__wf_atom_07947f07()

		if __wf_atom_80afb308("Heal Enemy") then
			v10:SetHealth(v13)
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Kill Enemy") then
			v10:SetHealth(0)
		end

		__wf_atom_78aeed31()

		if __wf_atom_80afb308("Enter Pre Death") then
			v10:__wf_atom_7470861b():__wf_atom_befe3998(true)
		end

		__wf_atom_78aeed31()
		local v69, v70 = __wf_atom_d2655286("God Mode", v14)

		if v69 then
			v14 = v70

			if v14 then
				v10:__wf_atom_8a035cd5(Symbol("GodMode"), false)
			end
		end

		__wf_atom_78aeed31()
		local v71, v72 = __wf_atom_d2655286("Enable Boss Bar ", v17)

		if v71 then
			v17 = v72

			if __wf_atom_7e8ad928(v68) then
				local v73 = v10:Attach(
					Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
					Symbol("GAME_C1_SPINE1"),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1
				)
				v10:__wf_atom_7c8621d6()
				v73:Enable()
				v73:__wf_atom_400189c4(100)
			elseif not (v72 or __wf_atom_7e8ad928(v68)) then
				v68:Destroy()
			end
		end
	end
end

local function fn20()
	fn19()
	__wf_atom_07947f07()
	__wf_atom_07947f07()
	fn6()
	__wf_atom_07947f07()
	__wf_atom_07947f07()
	fn17()
	__wf_atom_07947f07()
	__wf_atom_07947f07()
	fn18()
end

local function fn21()
	if __wf_atom_2ebdf85a("Player Lock On Settings") then
		v3 = __wf_atom_4f10b8c4("Lock On Radius", v3)
		v2 = tonumber(v3)
		__wf_atom_07947f07()
		v5 = __wf_atom_4f10b8c4("Lock On Distance", v5)
		v4 = tonumber(v5)
		__wf_atom_07947f07()
		v7 = __wf_atom_4f10b8c4("lock On Distance Fade", v7)
		v6 = tonumber(v7)
		__wf_atom_07947f07()
		v9 = __wf_atom_4f10b8c4("Lock On Size Fade", v9)
		v8 = tonumber(v9)
		__wf_atom_07947f07()

		if __wf_atom_80afb308("Set Lock On Distance") then
			module2.SetCustomLockOnSettings(gRegion:__wf_atom_c4f78a8f(), v2, v4, v6, v8)
		end
	end
end

function SpawnWithTestHarness(p, harness, p2, p3)
	v12 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_50a7d83e = v12:__wf_atom_c91d5f5b(Type(p), gRegion:__wf_atom_c4f78a8f(), 8, EMPTY_SYMBOL, v16):__wf_atom_50a7d83e()

	if p2 then
		AttachTestingHarness(__wf_atom_50a7d83e, harness, p3)
	end

	table.insert(v55, { avatar = __wf_atom_50a7d83e, harness = harness })
end

function AttachTestingHarness(object, p, bTestingMountedCombatant)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.AttachedTester) then
		__wf_atom_e919fb8e.bTestingMountedCombatant = bTestingMountedCombatant
		__wf_atom_e919fb8e.AttachedTester = object:Attach(Type(p), EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

function RemoveSpawnedTestSubjects(p, p2)
	if __wf_atom_7e8ad928(p) then
		for _, v68 in ipairs(v55.avatar) do
			v68.avatar:Destroy()
		end

		v55 = {}
	elseif not __wf_atom_7e8ad928(p) then
		table.remove(v55, p2)
		p.avatar:Destroy()
	end
end

local function fn22()
	if v27[v20] == nil then
		__wf_atom_05a856ad("Unknown Mode State " .. tostring(v20))
		return
	end

	if _G.testModeEnabled == false then
		return
	end

	__wf_atom_4f3659d1("Testing Controls")
	__wf_atom_05a856ad("Testing Mode:")

	if __wf_atom_7e8ad928(names) then
		names = {}

		for _, v68 in ipairs(v27) do
			table.insert(names, v68.name)
		end
	end

	fn16()
	__wf_atom_07947f07()

	if v20 == 6 then
		__wf_atom_4f3659d1("Animation Player")
		fn12()
		__wf_atom_07947f07()
		fn21()
		__wf_atom_07947f07()
		fn4()
	else
		if v20 == 2 then
			return
		end

		if v20 == 3 then
			__wf_atom_4f3659d1("Melee Attacks Tester")

			if __wf_atom_7e8ad928(v40) and not __wf_atom_7e8ad928(v11) then
				__wf_atom_05a856ad("Agent " .. v11:GetName() .. " Has no melee weapon in inventory")
				return
			end

			fn14()
			__wf_atom_07947f07()

			if __wf_atom_80afb308("Reload Attacks") then
				fn13()
			end

			__wf_atom_07947f07()
			__wf_atom_07947f07()
			fn4()
			__wf_atom_07947f07()
			__wf_atom_07947f07()
			fn21()
		elseif v20 == 5 then
			__wf_atom_4f3659d1("Abilities Cast Tester")
			fn10()
		elseif v20 == 4 then
			__wf_atom_05a856ad("Ranged Test Comming soon")
		end
	end
end

function ImguiAITesterWindow()
	if __wf_atom_489de21b(v10:GetName() .. " Testing Mode") then
		local v68, testModeEnabled = __wf_atom_d2655286("Enable Testing", _G.testModeEnabled)

		if v68 then
			_G.testModeEnabled = testModeEnabled

			if _G.testModeEnabled then
				if __wf_atom_7e8ad928(testingBehaviourAction) then
					__wf_atom_48bcafdc()
					return
				else
					v11:__wf_atom_6c491aa2(testingBehaviourAction, false)
				end
			else
				v11:__wf_atom_920a5a62()
			end
		end

		fn22()
		__wf_atom_07947f07()

		if __wf_atom_2ebdf85a(v10:GetName() .. " Stats") then
			__wf_atom_07947f07()
			local __wf_atom_9a1e4ed3 = v11:__wf_atom_9a1e4ed3()

			if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
				__wf_atom_05a856ad("TargetDistance: " .. math.round(__wf_atom_9a1e4ed3.distanceToTarget))
			end

			__wf_atom_78aeed31()
			local __wf_atom_c6f1f83d = v10:__wf_atom_c6f1f83d()
			__wf_atom_05a856ad("Enemy Health: " .. __wf_atom_c6f1f83d .. "/" .. v13 .. " (" .. math.max(__wf_atom_c6f1f83d / v13, 0) .. ")")
			__wf_atom_07947f07()
			fn20()
		end
	end

	__wf_atom_48bcafdc()
end

local function fn23()
	if __wf_atom_fca922b7("Spawned Testing Agents", 6) then
		__wf_atom_20c161dd(" AgentName", 200)
		__wf_atom_20c161dd("Health", 150)
		__wf_atom_20c161dd("Level", 100)
		__wf_atom_20c161dd("Attach Tester", 80)
		__wf_atom_20c161dd("Remove", 60)
		__wf_atom_20c161dd("Go To Type", 80)
		__wf_atom_04c2d310()

		for k, v68 in pairs(v55) do
			if __wf_atom_7e8ad928(v68.avatar) or v68.avatar:IsKilled() then
				table.remove(v55, k)
			else
				v68.avatar:__wf_atom_30e3d82b()
				__wf_atom_efa1c312()
				__wf_atom_a9e3d06e(0)
				__wf_atom_05a856ad("   " .. v68.avatar:GetName())
				__wf_atom_a9e3d06e(1)
				local maxHealth = v68.avatar:GetMaxHealth()
				local __wf_atom_c6f1f83d = v68.avatar:__wf_atom_c6f1f83d()
				__wf_atom_05a856ad("Enemy Health: " .. __wf_atom_c6f1f83d .. "/" .. maxHealth .. " (" .. math.max(__wf_atom_c6f1f83d / maxHealth, 0) .. ")")
				__wf_atom_07947f07()
				__wf_atom_78aeed31()
				__wf_atom_a9e3d06e(2)
				local __wf_atom_68de036a = v68.avatar:__wf_atom_68de036a()
				__wf_atom_05a856ad("Agent Level: " .. __wf_atom_68de036a)
				__wf_atom_a9e3d06e(3)

				if __wf_atom_80afb308("Attach##Tester" .. k) then
					AttachTestingHarness(v68.avatar, v68.harness)
				end

				__wf_atom_a9e3d06e(4)

				if __wf_atom_80afb308("Remove##Agent" .. k) then
					RemoveSpawnedTestSubjects(v55[k], k)
				end

				__wf_atom_a9e3d06e(5)

				if __wf_atom_80afb308("Go to Type##" .. k) then
					v:__wf_atom_3e5d2608({ v68.avatar:__wf_atom_30e3d82b():__wf_atom_1bb5b1ff() })
				end
			end
		end

		__wf_atom_3648d9a4()
	end
end

function GetEnemyDensityRange()
	local position = gRegion:__wf_atom_c4f78a8f():GetPosition()

	if __wf_atom_7e8ad928(v12) then
		v12 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local v68 = Range(v12:__wf_atom_dcf48c53(), v12:__wf_atom_57203011())

	if __wf_atom_7e8ad928(v61) then
		v61 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	end

	if __wf_atom_7e8ad928(v61) then
		return v68
	end

	local color = v61:GetColor(position, true)
	local v69 = math.max(math.floor((__wf_atom_104bfe98(v68.minValue, v68.maxValue, color.red / 255))), 1)
	local v70 = math.max(math.min(math.ceil(v69 + 3), v68.maxValue), v69)
	return (Range(v69, v70))
end

function SetEnemyListFromCategory()
	names6 = {}
	local name = nil
	local flag = nil
	categoryTable = v67[v53].categoryTable

	for _, v68 in ipairs(categoryTable) do
		if __wf_atom_7e8ad928(v68.enemyType) then
			if not flag then
				__wf_atom_f2daf912("ENEMY TESTER - Failed after: " .. name)
				flag = true
			end
		else
			name = v68.enemyType:GetName()
			table.insert(names6, name)

			if flag then
				__wf_atom_f2daf912("ENEMY TESTER - Succeeded at: " .. name)
				flag = false
			end
		end
	end
end

local function fn24(p, p2) -- 2 equivalent calls inferred from this helper
	local _, v68 = __wf_atom_d2655286(p, p2 or false)
	return v68
end

function AiTestMenu(p)
	v = p

	if __wf_atom_7e8ad928(_G.devImGuiSettings) then
		_G.devImGuiSettings = {}
	end

	if __wf_atom_7e8ad928(_G.testModeEnabled) then
		_G.testModeEnabled = false
	end

	if #categoryNames ~= #v67 then
		categoryNames = {}

		for _, v68 in ipairs(v67) do
			if #v68.categoryTable > 0 then
				table.insert(categoryNames, v68.categoryName)
			else
				__wf_atom_f2daf912("ENEMY TESTER - Category is empty: " .. v68.categoryName)
			end
		end
	end

	SetEnemyListFromCategory()
	local devImGuiSettings = _G.devImGuiSettings
	local v68, showEnemies = __wf_atom_489de21b("Enemy Testing Menu", true)
	devImGuiSettings.showEnemies = showEnemies

	if v68 and __wf_atom_83a4046b("Enemies") then
		if __wf_atom_19d02a1f("Spawn Agents") then
			fn23()
			__wf_atom_07947f07()
			v53 = __wf_atom_fdfab732("##SpawnCategory", v53, categoryNames)
			SetEnemyListFromCategory()
			v54 = __wf_atom_fdfab732("##SpawnType", v54, names6)
			v15 = __wf_atom_4f10b8c4("Override Spawn Level", v15)

			if __wf_atom_80afb308("Spawn Enemy") then
				local enemyType = categoryTable[v54].enemyType

				if __wf_atom_7e8ad928(categoryTable[v54].CustTestHarness) then
					custTestHarness = v56
				else
					custTestHarness = categoryTable[v54].CustTestHarness
				end

				if module2.IsInOverworld() and tonumber(v15) == 0 then
					local v70 = GetEnemyDensityRange()
					v16 = Random(v70.minValue, v70.maxValue)
				elseif tonumber(v15) >= 1 then
					v16 = tonumber(v15)
				else
					v16 = 1
				end

				local v70 = not __wf_atom_7e8ad928(categoryTable[v54].bIsMounted)
					and categoryTable[v54].bIsMounted
					and true
					or false
				SpawnWithTestHarness(enemyType, custTestHarness, false, v70)
			end

			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Spawn Enemy In Testing Mode") then
				local enemyType = categoryTable[v54].enemyType

				if __wf_atom_7e8ad928(categoryTable[v54].CustTestHarness) then
					custTestHarness = v56
				else
					custTestHarness = categoryTable[v54].CustTestHarness
				end

				if module2.IsInOverworld() and tonumber(v15) == 0 then
					local v70 = GetEnemyDensityRange()
					v16 = Random(v70.minValue, v70.maxValue)
				elseif tonumber(v15) >= 1 then
					v16 = tonumber(v15)
				else
					v16 = 1
				end

				local v70 = not __wf_atom_7e8ad928(categoryTable[v54].bIsMounted)
					and categoryTable[v54].bIsMounted
					and true
					or false
				SpawnWithTestHarness(enemyType, custTestHarness, true, v70)
			end

			__wf_atom_78aeed31()
			local _g = _G
			_g.testModeEnabled = fn24("Always Enable Testing Mode", _G.testModeEnabled) -- inferred equivalent call
			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Remove Test Subjects") then
				RemoveSpawnedTestSubjects()
			end

			__wf_atom_78aeed31()

			if __wf_atom_80afb308("20m Radial Damage x10000") then
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

				if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
					local position = __wf_atom_c4f78a8f:GetPosition()
					local radialDamageData = Engine.RadialDamageData()
					radialDamageData.baseAmount = 10000
					radialDamageData:__wf_atom_7498285f(0, 1)
					radialDamageData.radius = 20
					radialDamageData:__wf_atom_98d98d81(position)
					radialDamageData:__wf_atom_6b472125(__wf_atom_c4f78a8f)
					radialDamageData.checkForCover = false
					gRegion:__wf_atom_f6ec80de(radialDamageData)
				end
			end

			__wf_atom_c5303493()
		end

		if __wf_atom_19d02a1f("Enemy Levels") then
			if __wf_atom_7e8ad928(v12) then
				v12 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
			end

			local __wf_atom_dcf48c53 = v12:__wf_atom_dcf48c53()
			local __wf_atom_57203011 = v12:__wf_atom_57203011()
			local _t = _T
			_t.DebugDrawEnemyLevelGrid = fn24("Debug Draw Enemy Level Grid", _T.DebugDrawEnemyLevelGrid) -- inferred equivalent call
			__wf_atom_05a856ad("")
			__wf_atom_05a856ad("World Enemy Level Range: " .. __wf_atom_dcf48c53 .. "-" .. __wf_atom_57203011)

			if module3.IsHardModeActive() then
				__wf_atom_78aeed31()
				__wf_atom_05a856ad("")
				__wf_atom_78aeed31()
				__wf_atom_05a856ad("World Enemy Level Range in Red Night: " .. __wf_atom_dcf48c53 + _T.hardModeLevelMod .. "-" .. __wf_atom_57203011 + _T.hardModeLevelMod)
			end

			if _T.DebugDrawEnemyLevelGrid then
				if module2.IsInOverworld() then
					local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
					local x = __wf_atom_0a6a5887:__wf_atom_80cf57aa().x
					local v70 = __wf_atom_0a6a5887:GetPosition() - Vector(x / 2, 0, x / 2)
					local v71 = x / 256
					local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

					for i = 1, 256 do
						local v72 = i * v71

						for j = 1, 256 do
							local v73 = j * v71
							local v74 = v70 + Vector(v72, -10, v73)
							local color = __wf_atom_0a6a5887:GetColor(v74, true)
							local v75 = Color(color.red, 0, 0)

							if not (__wf_atom_c4f78a8f:__wf_atom_a5304c35(v74) <= 100) then
								continue
							end

							local v76 = v74 + Vector(v71 / 2, -50, v71 / 2)
							local enemyLevel = module3.GetEnemyLevel(nil, true, v76)
							gRegion:__wf_atom_9e272514(
								v76,
								Vector(v71, 80, v71),
								__wf_atom_80368bb1,
								Color(v75.red, 0, 0),
								1
							)
							gRegion:__wf_atom_5b35a0c8(
								v74 + Vector(0, 30, 0),
								v75,
								tostring(enemyLevel.minValue) .. "-" .. tostring(enemyLevel.maxValue),
								1.5,
								1
							)
						end
					end
				else
					_T.DebugDrawEnemyLevelGrid = false
					print("Player is not in overworld, cannot show level ranges")
					return
				end
			end

			local v70 = math.ceil(__wf_atom_57203011 / 4)

			if __wf_atom_fca922b7("LevelGuide", 4) then
				__wf_atom_20c161dd("Colour", 64)
				__wf_atom_20c161dd("Value", 64)
				__wf_atom_20c161dd("Level Range", 64)
				__wf_atom_20c161dd("Modified Level Range")
				__wf_atom_04c2d310()

				for i = 1, v70 do
					__wf_atom_efa1c312()
					__wf_atom_a9e3d06e(0)
					local v71 = math.max((i - 1) * 4 + 1, 1)
					local v72 = math.max(i * 4, 1)
					local v73 = __wf_atom_104bfe98(0, 255, v71 / __wf_atom_57203011)
					__wf_atom_6708a400(v73 / 255, 0, 0, 1, "######")
					__wf_atom_a9e3d06e(1)
					__wf_atom_05a856ad((tostring((math.ceil(v73)))))
					__wf_atom_a9e3d06e(2)
					__wf_atom_05a856ad(v71 .. "-" .. v72)

					if not module3.IsHardModeActive() then
						continue
					end

					__wf_atom_a9e3d06e(3)
					__wf_atom_05a856ad(v71 + _T.hardModeLevelMod .. "-" .. v72 + _T.hardModeLevelMod)
				end

				__wf_atom_3648d9a4()
			end

			__wf_atom_c5303493()
		end

		if __wf_atom_19d02a1f("Sub-Bosses") then
			if __wf_atom_7e8ad928(_T.DevEncounterHints) or __wf_atom_80afb308("Refresh List") then
				_T.DevEncounterHints = gRegion:FindAll(__wf_atom_f806fd7a)
			end

			__wf_atom_78aeed31()
			local v70, showSubbossLocations = __wf_atom_d2655286(
				"Debug Draw Locations",
				_T.ShowSubbossLocations or false
			)

			if v70 then
				_T.ShowSubbossLocations = showSubbossLocations
			end

			__wf_atom_78aeed31()
			__wf_atom_05a856ad("  ")
			__wf_atom_78aeed31()
			local v72, showSubbossLocationsTale = __wf_atom_d2655286(
				"Filter Tale Subbosses Only",
				_T.ShowSubbossLocationsTale or false
			)

			if v72 then
				_T.ShowSubbossLocationsTale = showSubbossLocationsTale
			end

			__wf_atom_07947f07()
			local v74 = Symbol("MT_SUBBOSS")
			local v75 = { "RockCastleMidCamp", "RockCastleCourtyardCamp", "RockCastleTopCamp" }
			local v76 = { "FortCurlailCamp", "FortDamCamp" }
			__wf_atom_05a856ad("")
			__wf_atom_05a856ad("This Level's Subboss Locations")
			__wf_atom_07947f07()

			if __wf_atom_fca922b7("LevelGuide", 6) then
				__wf_atom_20c161dd("EncounterHint Tag or Name", 200)
				__wf_atom_20c161dd("Encounter Template", 200)
				__wf_atom_20c161dd("Cooldown Tracker (red if on cooldown)")
				__wf_atom_20c161dd("Supports Tales", 100)
				__wf_atom_20c161dd("Commands", 200)
				__wf_atom_04c2d310()

				for i, devEncounterHint in ipairs(_T.DevEncounterHints) do
					if __wf_atom_7e8ad928(devEncounterHint) then
						continue
					end

					local __wf_atom_e370bfde = devEncounterHint:__wf_atom_e370bfde()
					local __wf_atom_e919fb8e = devEncounterHint:__wf_atom_e919fb8e()

					if not ((not _T.ShowSubbossLocationsTale or not __wf_atom_7e8ad928(__wf_atom_e919fb8e) and __wf_atom_e919fb8e.subbossCanSpawnInTales) and module2.TableContains(__wf_atom_e370bfde, v74)) then
						continue
					end

					__wf_atom_efa1c312()
					local subbossEncounterTemplateName = module3.GetSubbossEncounterTemplateName(devEncounterHint)
					local v77 = tostring(subbossEncounterTemplateName) == "VadagarStagEncounter"
					__wf_atom_a9e3d06e(0)
					local name = devEncounterHint:__wf_atom_db682341()

					if __wf_atom_7e8ad928(name) or name == EMPTY_SYMBOL then
						name = devEncounterHint:GetName()
					end

					local v78 = tostring(name)
					local flag = false
					local flag2 = false

					for _, v79 in ipairs(v75) do
						if v78 == v79 then
							flag2 = true
						end
					end

					for _, v79 in ipairs(v76) do
						if v78 == v79 then
							flag = true
						end
					end

					if v77 then
						__wf_atom_6708a400(0, 0.6, 0.4, 1, v78)
					elseif flag or flag2 then
						__wf_atom_6708a400(0.8, 0.5, 0, 1, v78)
					else
						__wf_atom_05a856ad(v78)
					end

					__wf_atom_a9e3d06e(1)

					if v77 then
						__wf_atom_6708a400(0, 0.6, 0.4, 1, subbossEncounterTemplateName)
					else
						__wf_atom_05a856ad(subbossEncounterTemplateName)
					end

					__wf_atom_a9e3d06e(2)
					local v79 = Symbol("NilTracker")

					if module2.IsInOverworld() then
						if flag2 then
							v79 = Symbol("KearnholdSiege")
						elseif flag then
							v79 = Symbol("CurlailSiege")
						else
							v79 = module3.GetSubBossTimerSymb(devEncounterHint, false)
						end
					elseif not (__wf_atom_7e8ad928(_G.LocationInfo) or __wf_atom_7e8ad928(_G.LocationInfo.currentLocation)) then
						v79 = Symbol("Dungeon-" .. tostring(_G.LocationInfo.currentLocation) .. "-SubBoss")
					end

					local flag3 = false

					if gGameData:__wf_atom_b3cdb701(v79) then
						__wf_atom_6708a400(1, 0, 0, 0.9, (tostring(v79)))
						flag3 = true
					else
						__wf_atom_6708a400(1, 1, 1, 0.5, (tostring(v79)))
					end

					__wf_atom_a9e3d06e(3)
					local v80

					if __wf_atom_7e8ad928(__wf_atom_e919fb8e) or not __wf_atom_e919fb8e.subbossCanSpawnInTales then
						v80 = false
					else
						if flag3 then
							__wf_atom_05a856ad("Yes (cooldown)")
						else
							__wf_atom_05a856ad("Yes")
						end

						v80 = true
					end

					__wf_atom_a9e3d06e(4)

					if __wf_atom_80afb308("< Goto##" .. tostring(i)) then
						fn(devEncounterHint)
					end

					__wf_atom_78aeed31()

					if __wf_atom_80afb308("Reset Time Trackers##" .. tostring(i)) then
						gGameData:__wf_atom_04988606(v79, "")
						_T.DevEncounterHints = nil
					end

					if not _T.ShowSubbossLocations then
						continue
					end

					local position = devEncounterHint:GetPosition()

					if not (not _T.ShowSubbossLocationsTale or _T.ShowSubbossLocationsTale and v80 and subbossEncounterTemplateName ~= "EnterDungeonSubboss") then
						continue
					end

					if gGameData:__wf_atom_b3cdb701(v79) then
						gRegion:__wf_atom_628723a6(position, position + Vector(0, 20, 0), Color(192, 192, 192), 0.1)
						gRegion:__wf_atom_5b35a0c8(
							position + Vector(0, 20, 0),
							Color(192, 192, 192),
							subbossEncounterTemplateName .. " [On Cooldown]",
							1,
							0.1
						)
					else
						gRegion:__wf_atom_628723a6(position, position + Vector(0, 20, 0), Color(255, 255, 255), 0.1)
						gRegion:__wf_atom_5b35a0c8(
							position + Vector(0, 20, 0),
							Color(255, 255, 255),
							subbossEncounterTemplateName,
							1,
							0.1
						)
					end
				end

				__wf_atom_3648d9a4()
			end

			if module2.IsInOverworld() then
				__wf_atom_07947f07()
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Dungeon Entrances")
				__wf_atom_07947f07()

				if __wf_atom_fca922b7("DungeonSubbosses", 6) then
					__wf_atom_20c161dd("Dungeon Entrance Id", 200)
					__wf_atom_20c161dd("Subboss Agent", 300)
					__wf_atom_20c161dd("Cooldown Tracker")
					__wf_atom_20c161dd("Hardmode Tracker")
					__wf_atom_20c161dd("Supports Tales", 100)
					__wf_atom_20c161dd("Commands", 200)
					__wf_atom_04c2d310()

					for k, v77 in pairs(_G.DungeonEntranceInfo) do
						if __wf_atom_7e8ad928(v77.subbossAgent) then
							continue
						end

						if __wf_atom_7e8ad928(v77.entranceWp) then
							_T.DevEncounterHints = nil
							break
						end

						__wf_atom_efa1c312()
						__wf_atom_a9e3d06e(0)
						__wf_atom_05a856ad(k)
						__wf_atom_a9e3d06e(1)
						__wf_atom_05a856ad(v77.subbossAgent:GetName())
						__wf_atom_a9e3d06e(2)
						local v78 = Symbol("Dungeon-" .. k .. "-SubBoss")
						local flag = false

						if gGameData:__wf_atom_b3cdb701(v78) then
							__wf_atom_6708a400(1, 0, 0, 0.9, (tostring(v78)))
							flag = true
						else
							__wf_atom_6708a400(1, 1, 1, 0.5, (tostring(v78)))
						end

						__wf_atom_a9e3d06e(3)

						if __wf_atom_7e8ad928(nil) then
							__wf_atom_05a856ad("Cannot Find Hit")
						else
							local __wf_atom_e919fb8e = (nil):__wf_atom_e919fb8e()

							if
								not __wf_atom_7e8ad928(__wf_atom_e919fb8e)
								and __wf_atom_e919fb8e.subbossCanSpawnInTales
							then
								if flag then
									__wf_atom_05a856ad("Yes (cooldown)")
								else
									__wf_atom_05a856ad("Yes")
								end
							end
						end

						__wf_atom_a9e3d06e(4)

						if __wf_atom_80afb308("< Goto##" .. tostring(k)) then
							fn(v77.entranceWp)
						end

						__wf_atom_78aeed31()

						if __wf_atom_80afb308("Reset Time Tracker##" .. tostring(k)) then
							gGameData:__wf_atom_04988606(v78, "")
						end

						if not _T.ShowSubbossLocations then
							continue
						end

						local position = v77.entranceWp:GetPosition()

						if gGameData:__wf_atom_b3cdb701(v78) then
							gRegion:__wf_atom_628723a6(position, position + Vector(0, 3, 0), Color(0, 192, 128), 0.1)
							gRegion:__wf_atom_5b35a0c8(
								position + Vector(0, 3, 0),
								Color(0, 192, 128),
								v77.subbossAgent:GetName() .. " [On Cooldown]",
								1,
								0.1
							)
						else
							gRegion:__wf_atom_628723a6(position, position + Vector(0, 3, 0), Color(0, 255, 192), 0.1)
							gRegion:__wf_atom_5b35a0c8(
								position + Vector(0, 3, 0),
								Color(0, 255, 192),
								v77.subbossAgent:GetName(),
								1,
								0.1
							)
						end
					end

					__wf_atom_3648d9a4()
				end
			end

			__wf_atom_c5303493()
		end

		__wf_atom_8ec4e5b4()
	end

	__wf_atom_48bcafdc()

	if not _G.devImGuiSettings.showEnemies then
		RemoveSpawnedTestSubjects()
	end

	return _G.devImGuiSettings.showEnemies
end

function StartTester(p)
	__wf_atom_7e8ad928(p)
end