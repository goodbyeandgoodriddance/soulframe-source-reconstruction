local module = require("SF.Interface.SFUtilities")
local v = nil
local v2 = Type("/SF/Types/Player/SfAvatarArsenal")

function GetOrCreateProxyAvatar(object, p)
	if __wf_atom_7e8ad928(v) then
		local v3 = gRegion:IsMaster() and 3 or 4
		v = gRegion:CreateEntity(v2, object:GetPosition(), Rotation(0, 0, 0), p, p, v3)
	end

	v:__wf_atom_c274907d(p)
	v:SetVisibility(false, false)
	v:SetPosition(object:GetPosition())
	v:SetFaction(object:__wf_atom_e93896ba())
	return v, function()
		if not __wf_atom_7e8ad928(v) then
			gRegion:__wf_atom_dd1e4d10(v)
		end
	end
end

function CreateProxyWeapon(object, p, value, list, list2, p2, p3, p4, p5)
	local object2 = gRegion:CreateObject(Type(p), object, module.GetReplicationMode())

	if __wf_atom_7e8ad928(object2) then
		return nil, nil
	end

	if not object2:IsA(__wf_atom_d98e64fe) then
		object2:SetOwner(object)
	end

	if p3 then
		object2:__wf_atom_1e1dacd2(p3)
	end

	if p4 ~= nil then
		object2:__wf_atom_07d75cec(p4)
	end

	if object2:IsA(__wf_atom_9df43583) then
		object2:__wf_atom_67dd6811(value or 0)

		if p2 then
			object2:__wf_atom_e4db3360(p2)
		end

		if p5 then
			object2:__wf_atom_a60eeb4b(p5)
		end
	end

	if object2:IsA(__wf_atom_77e05d3b) and not __wf_atom_7e8ad928(object) then
		local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c:IsA(__wf_atom_77e05d3b) then
			__wf_atom_35a10d3c:__wf_atom_3696233a()
		end
	end

	local v3 = {}
	local envoyInventoryControl = module.GetEnvoyInventoryControl()

	if not __wf_atom_7e8ad928(envoyInventoryControl) then
		local v4 = envoyInventoryControl:__wf_atom_72055871(p) or {}

		for i = 1, #v4 do
			if __wf_atom_7e8ad928(v4[i].mItemType) then
				continue
			end

			local mItemType = v4[i].mItemType
			local object3 = gRegion:CreateObject(Type(mItemType), object2, module.GetReplicationMode())
			object3:__wf_atom_eaa00d7a((object3:__wf_atom_254ac1f5(v4[i].mLevel)))
			object2:AddUpgrade(object3)
			table.insert(v3, object3)
		end
	end

	if not object2:IsA(__wf_atom_abf506db) then
		for i = 1, #list do
			local mItemType = list[i].mItemType

			if __wf_atom_7e8ad928(mItemType) then
				continue
			end

			local object3 = gRegion:CreateObject(Type(mItemType), object2, module.GetReplicationMode())
			local v4

			if list2 and #list2 <= i then
				v4 = list2[i]
			end

			if v4 then
				if __wf_atom_72884638("SF.ScaleAspectsWithQuality") and p2 > 1 then
					v4 = object3:__wf_atom_b36d8955(p2 - 1, v4)
				end

				object3:__wf_atom_eaa00d7a(v4)
			end

			object2:AddUpgrade(object3)
			table.insert(v3, object3)
		end
	end

	return object2, function()
		if not __wf_atom_7e8ad928(object2) then
			object2:SetOwner(nil)
			gRegion:__wf_atom_dd1e4d10(object2)
		end

		for i = 1, #v3 do
			if not __wf_atom_7e8ad928(v3[i]) then
				gRegion:__wf_atom_dd1e4d10(v3[i])
			end
		end
	end
end

function CreateProxyWeaponOneShot(p, p2, p3, p4, callback)
	local v3, v4 = CreateProxyWeapon(p, p2, p3, p4)
	callback(v3)
	v4()
end

function GetWeaponElementUpgradesAndFingerprints(p)
	local result = {}
	local result2 = {}

	if __wf_atom_7e8ad928(p.RawItem) then
		return result, result2
	end

	if not __wf_atom_7e8ad928(p.RawItem.mItemType) and p.RawItem.mItemType:IsA(__wf_atom_2fc5c2e8) then
		local __wf_atom_43563387 = p.RawItem:__wf_atom_43563387()

		for _, v3 in ipairs(__wf_atom_43563387) do
			if __wf_atom_7e8ad928(v3.mType) then
				continue
			end

			table.insert(result, { mItemType = v3.mType })
			table.insert(result2, "")
		end
	end

	if not __wf_atom_7e8ad928(p.RawItem.mUpgradeType) then
		table.insert(result, { mItemType = p.RawItem.mUpgradeType })
		table.insert(result2, p.RawItem.mUpgradeFingerprint)
	end

	if not __wf_atom_7e8ad928(p.RawItem.mAspectType) then
		table.insert(result, { mItemType = p.RawItem.mAspectType })
		table.insert(result2, p.RawItem.mAspectFingerprint)
	end

	return result, result2
end

function GetWeaponElementUpgradesAndFingerprintsNoRawItem(data)
	local v3 = {}
	local v4 = {}

	if __wf_atom_7e8ad928(data) then
		return v3, v4
	end

	if not __wf_atom_7e8ad928(data.mUpgradeType) then
		table.insert(v3, { mItemType = data.mUpgradeType })
		table.insert(v4, data.mUpgradeFingerprint)
	end

	if not __wf_atom_7e8ad928(data.mAspectType) then
		table.insert(v3, { mItemType = data.mAspectType })
		table.insert(v4, data.mAspectFingerprint)
	end

	return v3, v4
end

function SetLevelExplicit(object, p, p2, p3, p4, p5, p6)
	if p3 == nil or p4 == nil or p5 == nil or p6 == nil then
		object:__wf_atom_2dedec1a(p .. ".LevelText", 13, false)
		object:__wf_atom_2dedec1a(p .. ".RankFill", 13, false)
		object:__wf_atom_2dedec1a(p .. ".Border", 13, false)
		object:__wf_atom_2dedec1a(p .. ".LevelShadow", 13, false)
	else
		object:__wf_atom_50d60589(p .. ".LevelText", 36, p3)
		object:__wf_atom_e57658c2(p .. ".LevelText", 44, p2)
		object:__wf_atom_2dedec1a(p .. ".LevelText", 13, true)
		object:__wf_atom_2dedec1a(p .. ".RankFill", 13, true)
		object:__wf_atom_2dedec1a(p .. ".Border", 13, true)
		object:__wf_atom_2dedec1a(p .. ".LevelShadow", 13, true)
		object:__wf_atom_e57658c2(p .. ".LevelShadow", 12, 65)
		local v3 = p5 - p4 == 0 and 0 or not (p5 > 0) and 1 or (p6 - p4) / (p5 - p4)
		object:__wf_atom_e57658c2(p .. ".RankFill.Mask", 6, v3 * 100)
	end
end

function SetLevel(object, p, p2, object2, p3, _)
	if p2 then
		local v3 = math.min(
			__wf_atom_c67f9605:__wf_atom_7da755e9(object2:__wf_atom_1bb5b1ff(), 0),
			__wf_atom_c67f9605:__wf_atom_b4a75eaa(object2:__wf_atom_9765cbd5(), object2:__wf_atom_1bb5b1ff())
		)
		object:__wf_atom_50d60589(p .. ".LevelText", 36, v3)
		object:__wf_atom_e57658c2(p .. ".LevelText", 44, p3)
		object:__wf_atom_2dedec1a(p .. ".LevelText", 13, true)
		object:__wf_atom_2dedec1a(p .. ".RankFill", 13, true)
		object:__wf_atom_2dedec1a(p .. ".Border", 13, true)
		object:__wf_atom_2dedec1a(p .. ".LevelShadow", 13, true)
		object:__wf_atom_e57658c2(p .. ".LevelShadow", 12, 65)
		local __wf_atom_679f426d = __wf_atom_c67f9605:__wf_atom_679f426d(object2:__wf_atom_9765cbd5(), object2)
		local __wf_atom_f05283f5 = __wf_atom_c67f9605:__wf_atom_f05283f5(object2:__wf_atom_9765cbd5(), object2)
		local __wf_atom_9765cbd5 = object2:__wf_atom_9765cbd5()
		local v4 = __wf_atom_f05283f5 - __wf_atom_679f426d == 0 and 0
			or not (__wf_atom_f05283f5 > 0) and 1
			or (__wf_atom_9765cbd5 - __wf_atom_679f426d) / (__wf_atom_f05283f5 - __wf_atom_679f426d)
		object:__wf_atom_e57658c2(p .. ".RankFill.Mask", 6, v4 * 100)
	else
		object:__wf_atom_2dedec1a(p .. ".LevelText", 13, false)
		object:__wf_atom_2dedec1a(p .. ".RankFill", 13, false)
		object:__wf_atom_2dedec1a(p .. ".Border", 13, false)
		object:__wf_atom_2dedec1a(p .. ".LevelShadow", 13, false)
	end
end

function IsWeaponStatItem(instance)
	return not __wf_atom_7e8ad928(instance) and (instance:IsA(__wf_atom_2c8a4b8d) or instance:IsA(__wf_atom_77e05d3b))
end

function SetRarity(object, p, p2, p3)
	local v3 = p2 and 0 or 10
	object:__wf_atom_2dedec1a(p .. "." .. "RankIcon" .. 1, 13, false)
	object:__wf_atom_2dedec1a(p .. "." .. "RankIcon" .. 2, 13, false)
	object:__wf_atom_2dedec1a(p .. "." .. "RankIcon" .. 3, 13, false)

	if p3 < 0 then
		return
	end

	if p3 == 0 then
		local v4 = "RankIcon" .. 2
		object:__wf_atom_2dedec1a(p .. "." .. v4, 13, true)
		object:__wf_atom_e57658c2(p .. "." .. v4, 1, -30)
		object:__wf_atom_e57658c2(p .. "." .. v4, 14, 24)
		object:__wf_atom_e57658c2(p .. "." .. v4, 15, 24)
	end

	if p3 == 1 then
		local v4 = "RankIcon" .. 1
		object:__wf_atom_2dedec1a(p .. "." .. v4, 13, true)
		object:__wf_atom_e57658c2(p .. "." .. v4, 0, -8 - v3 / 2)
		object:__wf_atom_e57658c2(p .. "." .. v4, 1, -28)
		object:__wf_atom_e57658c2(p .. "." .. v4, 14, 24)
		object:__wf_atom_e57658c2(p .. "." .. v4, 15, 24)
		local v5 = "RankIcon" .. 3
		object:__wf_atom_2dedec1a(p .. "." .. v5, 13, true)
		object:__wf_atom_e57658c2(p .. "." .. v5, 0, v3 / 2 + 8)
		object:__wf_atom_e57658c2(p .. "." .. v5, 1, -28)
		object:__wf_atom_e57658c2(p .. "." .. v5, 14, 24)
		object:__wf_atom_e57658c2(p .. "." .. v5, 15, 24)
	end

	if p3 == 2 then
		local v4 = "RankIcon" .. 1
		object:__wf_atom_2dedec1a(p .. "." .. v4, 13, true)
		object:__wf_atom_e57658c2(p .. "." .. v4, 0, -16 - v3)
		object:__wf_atom_e57658c2(p .. "." .. v4, 1, -25)
		object:__wf_atom_e57658c2(p .. "." .. v4, 14, 18)
		object:__wf_atom_e57658c2(p .. "." .. v4, 15, 18)
		local v5 = "RankIcon" .. 2
		object:__wf_atom_2dedec1a(p .. "." .. v5, 13, true)
		object:__wf_atom_e57658c2(p .. "." .. v5, 1, -30)
		object:__wf_atom_e57658c2(p .. "." .. v5, 14, 24)
		object:__wf_atom_e57658c2(p .. "." .. v5, 15, 24)
		local v6 = "RankIcon" .. 3
		object:__wf_atom_2dedec1a(p .. "." .. v6, 13, true)
		object:__wf_atom_e57658c2(p .. "." .. v6, 0, v3 + 16)
		object:__wf_atom_e57658c2(p .. "." .. v6, 1, -25)
		object:__wf_atom_e57658c2(p .. "." .. v6, 14, 18)
		object:__wf_atom_e57658c2(p .. "." .. v6, 15, 18)
	end

	if p2 then
		object:__wf_atom_e57658c2(p .. ".Border", 15, 78)
		object:__wf_atom_e57658c2(p .. ".Border", 14, 78)
	else
		object:__wf_atom_e57658c2(p .. ".Border", 15, 60)
		object:__wf_atom_e57658c2(p .. ".Border", 14, 60)
		object:__wf_atom_e57658c2(p .. ".RankIcon1", 1, 0)
		object:__wf_atom_e57658c2(p .. ".RankIcon2", 1, 0)
		object:__wf_atom_e57658c2(p .. ".RankIcon3", 1, 0)
		object:__wf_atom_e57658c2(p .. ".RankIcon1", 14, 30)
		object:__wf_atom_e57658c2(p .. ".RankIcon1", 15, 30)
		object:__wf_atom_e57658c2(p .. ".RankIcon2", 14, 39)
		object:__wf_atom_e57658c2(p .. ".RankIcon2", 15, 39)
		object:__wf_atom_e57658c2(p .. ".RankIcon3", 14, 30)
		object:__wf_atom_e57658c2(p .. ".RankIcon3", 15, 30)
	end
end

function GetFactionIconFromFactionName(p)
	local v3 = p == "Cassid" and "<WEAPON_FACTION_CASSID>" or nil
	local v4 = p == "Dendrit" and "<WEAPON_FACTION_DENDRIT>" or v3
	local v5 = p == "Fey" and "<WEAPON_FACTION_FEY>" or v4
	local v6 = p == "Mendicant" and "<WEAPON_FACTION_MENDICANT>" or v5
	local v7 = p == "Mockery" and "<WEAPON_FACTION_Mockery>" or v6
	return p == "Ode" and "<WEAPON_FACTION_ODE>" or v7
end

function GetTextColorFromCraftwork(p)
	local v3 = p == "MILITARY" and 9745038 or 10984574
	local v4 = p == "OFFICER" and 8688580 or v3
	local v5 = p == "NOBLE" and 13935969 or v4
	local v6 = p == "MASTERWORK" and 12611150 or v5
	return p == "LEGENDARY" and 12157897 or v6
end

function GetMaterialColorFromCraftwork(p)
	local v3 = p == "MILITARY" and 2700585 or nil
	local v4 = p == "OFFICER" and 2764082 or v3
	local v5 = p == "NOBLE" and 4139533 or v4
	local v6 = p == "MASTERWORK" and 3740949 or v5
	return p == "LEGENDARY" and 2038052 or v6
end