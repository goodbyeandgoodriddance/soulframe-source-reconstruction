module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local v = {
	"<DT_IMPACT>",
	"<DT_PUNCTURE>",
	"<DT_SLASH>",
	"<DT_FIRE>",
	"<DT_FREEZE>",
	"<DT_ELECTRICITY>",
	"<DT_POISON>",
	"<DT_EXPLOSION>",
	"<DT_RADIATION>",
	"<DT_GAS>",
	"<DT_MAGNETIC>",
	"<DT_VIRAL>",
	"<DT_CORROSIVE>",
	"<DT_RADIANT>",
	"<DT_SENTIENT>"
}
local v2 = {
	"/Lotus/Language/Game/RK_NONE",
	"/Lotus/Language/Game/RK_FLESH",
	"/Lotus/Language/Game/RK_CLONED_FLESH",
	"/Lotus/Language/Game/RK_INFESTED_FLESH",
	"/Lotus/Language/Game/RK_TENNO_FLESH",
	"/Lotus/Language/Game/RK_ROBOTIC",
	"/Lotus/Language/Game/RK_MACHINERY",
	"/Lotus/Language/Game/RK_INFESTED",
	"/Lotus/Language/Game/RK_FOSSILIZED",
	"/Lotus/Language/Game/RK_ARMOR",
	"/Lotus/Language/Game/RK_HULKING_ARMOR",
	"/Lotus/Language/Game/RK_INFESTED_ARMOUR",
	"/Lotus/Language/Game/RK_TENNO_ARMOR",
	"/Lotus/Language/Game/RK_SHIELD",
	"/Lotus/Language/Game/RK_HEAVY_SHIELD",
	"/Lotus/Language/Game/RK_TENNO_SHIELD"
}
local v3 = { "<DT_RADIANT>", "<DT_SENTIENT>" }

function GetResistTypes()
	return v2
end

local function fn(p, value, p2, p3, p4, p5, p6)
	if not p2 then
		return
	end

	local v4, v5

	if p6 then
		v4 = "<b>"
		v5 = "</b>"
	else
		v4 = ""
		v5 = ""
	end

	if value ~= "" then
		p ..= "<font color=\"" .. p3 .. "\">" .. v4 .. value:gsub("%:", "") .. module.Ternary(
			p2 == "",
			v5 .. "</font>",
			": " .. v5 .. "</font>"
		)
	end

	if p5 then
		return p .. "<font color=\"" .. p4 .. "\">" .. v4 .. p2 .. v5 .. "</font>"
	end

	return p .. "<font color=\"" .. p4 .. "\">" .. v4 .. p2 .. v5 .. "<br></font>"
end

function GetEnemyInfoText(object, data, p, p2)
	local v4 = p == nil and "#999999" or p
	local v5 = p2 == nil and "#FFFFFF" or p2
	local v6 = "<font color=\"" .. v4 .. "\">" .. object:__wf_atom_8e9ac384(
		"/Lotus/Language/Menu/AlertPopup_Faction",
		false
	) .. " "
	local v7 = string.upper(data.faction:c_str())

	if v7 == "GRINEER" then
		v6 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_GrineerUC", false)
	elseif v7 == "CORPUS" then
		v6 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_CorpusUC", false)
	elseif v7 == "INFESTATION" then
		v6 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_InfestationUC", false)
	elseif v7 == "OROKIN" then
		v6 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_OrokinUC", false)
	elseif v7 == "NEUTRAL" then
		v6 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Syndicates/Neutral", false)
	elseif v7 == "SENTIENT" then
		v6 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Game/Faction_SentientUC", false)
	elseif v7 == "STALKER" then
		v6 ..= object:__wf_atom_8e9ac384("/Lotus/Language/Game/Stalker", false)
	end

	local v8 = v6 .. "<br></font>"
	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(data.shortDesc:c_str(), false)

	if __wf_atom_8e9ac384 ~= "" then
		v8 ..= "<font color=\"" .. v5 .. "\">" .. __wf_atom_8e9ac384 .. "<br></font>"
	end

	local v9 = fn(v8, "", "", v4, v5)
	local __wf_atom_8e9ac384_2 = object:__wf_atom_8e9ac384("/Lotus/Language/Labels/AVATAR_HEALTH_MAX", false)
	local __wf_atom_8e9ac384_3 = object:__wf_atom_8e9ac384("/Lotus/Language/Labels/AVATAR_SHIELD", false)
	local __wf_atom_8e9ac384_4 = object:__wf_atom_8e9ac384("/Lotus/Language/Labels/AVATAR_ARMOUR", false)
	local maxHealth = data.maxHealth
	local maxShield = data.maxShield
	local armourRating = data.armourRating
	local v10 = { "", "", "" }
	local shieldResistance = data.shieldResistance
	local armourResistance = data.armourResistance
	local healthResistance = data.healthResistance

	if shieldResistance > 0 then
		__wf_atom_8e9ac384_3 = object:__wf_atom_8e9ac384(v2[shieldResistance + 1], false)
	end

	if armourResistance > 0 then
		__wf_atom_8e9ac384_4 = object:__wf_atom_8e9ac384(v2[armourResistance + 1], false)
	end

	if healthResistance > 0 then
		__wf_atom_8e9ac384_2 = object:__wf_atom_8e9ac384(v2[healthResistance + 1], false)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v11 = __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and {}
		or __wf_atom_c4f78a8f:__wf_atom_7470861b():__wf_atom_837c0b4a(
			shieldResistance,
			armourResistance,
			healthResistance
		)
	local v12 = { maxShield, armourRating, maxHealth }

	for i = 1, 3 do
		if not (v12[i] > 0) then
			continue
		end

		local v13 = ""
		local v14 = ""

		for j = 1, #v do
			local v15 = v[j]
			local v16

			if #v3 == 0 then
				v16 = false
			else
				local flag = true

				for _, v17 in ipairs(v3) do
					if v15 ~= v17 then
						continue
					end

					v16 = true
					flag = false
					break
				end

				if flag then
					v16 = false
				end
			end

			if v16 then
				continue
			end

			local v17 = v11[(i - 1) * #v + j]

			if v17 == 0 then
				continue
			end

			local ternary = module.Ternary(v17 > 0, "-", "+")

			if math.abs(v17) >= 0.75 then
				ternary ..= ternary .. ternary
			elseif math.abs(v17) >= 0.5 then
				ternary ..= ternary
			end

			if v17 < 0 then
				if v13 ~= "" then
					v13 ..= " "
				end

				v13 ..= object:__wf_atom_8e9ac384(v[j], true) .. ternary .. " "
			else
				if v14 ~= "" then
					v14 ..= " "
				end

				v14 ..= object:__wf_atom_8e9ac384(v[j], true) .. ternary .. " "
			end
		end

		if v13 ~= "" then
			v10[i] = "  <font color=\"" .. v5 .. "\">" .. v13 .. "<br></font>"
		end

		if v14 ~= "" then
			v10[i] ..= "<font color=\"" .. v5 .. "\">  " .. v14 .. "</font>"
		end
	end

	local v13 = ""

	if data.regionBits > 0 then
		local __wf_atom_161b95d4 = module2.GetStarChart():__wf_atom_161b95d4()

		for i = 1, #__wf_atom_161b95d4 do
			if not __wf_atom_ab3bf9ea(data.regionBits, i - 1) then
				continue
			end

			local __wf_atom_8e9ac384_5 = object:__wf_atom_8e9ac384(__wf_atom_161b95d4[i].name, false)

			if v13 ~= "" then
				__wf_atom_8e9ac384_5 = ", " .. __wf_atom_8e9ac384_5
			end

			v13 ..= __wf_atom_8e9ac384_5
		end
	end

	if maxShield > 0 then
		local v14 = armourRating > 0 or maxHealth > 0 or v13 ~= ""
		v9 = fn(v9, __wf_atom_8e9ac384_3, maxShield, v4, v4, nil, true)

		if v10[1] ~= "" then
			v9 = fn(v9, v10[1], "", v4, v5, not v14)
		end

		if v14 then
			v9 = fn(v9, "", "", v4, v5)
		end
	end

	if armourRating > 0 then
		local v14 = maxHealth > 0 or v13 ~= ""
		v9 = fn(v9, __wf_atom_8e9ac384_4, armourRating, v4, v4, nil, true)

		if v10[2] ~= "" then
			v9 = fn(v9, v10[2], "", v4, v5, not v14)
		end

		if v14 then
			v9 = fn(v9, "", "", v4, v5)
		end
	end

	if maxHealth > 0 then
		v9 = fn(v9, __wf_atom_8e9ac384_2, maxHealth, v4, v4, nil, true)

		if v10[3] ~= "" then
			v9 = fn(v9, v10[3], "", v4, v5, v13 == "")
		end
	end

	if v13 ~= "" then
		return (fn(
			fn(v9, "", "", v4, v5),
			object:__wf_atom_8e9ac384("/Lotus/Language/Game/Regions", false) .. ":",
			"<br>" .. v13,
			v4,
			v5,
			true,
			true
		))
	end

	return v9
end

local function fn2(p, p2)
	return p.Label < p2.Label
end

local function fn3(object, object2)
	local localize = object2:Localize(object, true)

	if object2.type:IsA(__wf_atom_9e85eea2) and object2.isLeader then
		localize = object:__wf_atom_8e9ac384("/Lotus/Language/EnemyLeaders/GenericLeaderName", false, {
			ENEMY = localize
		})
	end

	return localize
end

function GetLocalizedName(p, p2)
	return (fn3(p, p2))
end

local function fn4(object, object2, p, _, list, p2)
	local result = {}
	local v4 = {}
	local v5 = {}
	local v6 = {}
	local v7 = {}
	local v8 = {}
	local v9 = false
	local v10 = __wf_atom_72884638("LotusGameRules.UnlockCodex")
	local v11 = WeakResource("/Lotus/Types/BoosterPacks/RandomProjection")
	local related

	if
		p.type:IsA(__wf_atom_58a409f1)
		or p.type:IsA(__wf_atom_6317e6dc)
		or p.type:IsA(__wf_atom_d5a2d4b7)
		or p.type:IsA(__wf_atom_3cecff09)
		or p.type:IsA(__wf_atom_abf506db)
	then
		related = p.related
	end

	for i = 1, #related do
		local v12 = related[i]

		if __wf_atom_7e8ad928(v12) or not v12:IsA(__wf_atom_3530cade) then
			local v13

			if v12:IsA(__wf_atom_4ebf67cb) then
				v13 = object2:__wf_atom_c711142e(v12)
			elseif v12:IsA(__wf_atom_6317e6dc) then
				v13 = object2:__wf_atom_37a8a86f(v12)
			elseif v12:IsA(__wf_atom_58a409f1) then
				v13 = object2:__wf_atom_bd16feb6(v12)
			else
				v13 = object2:__wf_atom_fee280ca(v12)
			end

			local kind = v13.type

			if not __wf_atom_7e8ad928(kind) then
				local v14 = false

				if kind:IsA(__wf_atom_c8d7c4cd) then
					local v15 = Resource(kind)

					if not __wf_atom_7e8ad928(v15) then
						local c_str = v15:__wf_atom_211412ff():c_str()

						if c_str ~= "" then
							for j = 1, #list do
								local v16 = list[j]
								__wf_atom_83c14687(0)

								if v16.name ~= c_str then
									continue
								end

								if v4[v16.regionLocTag] == nil then
									v4[v16.regionLocTag] = {}
								end

								local v17 = string.upper(object:__wf_atom_8e9ac384(v16.locTag, true))

								if v10 or p2[v16.name] ~= nil or p2[kind:__wf_atom_5b41f63b()] ~= nil then
									if not v8[v16.regionLocTag] then
										v8[v16.regionLocTag] = true
									end

									v4[v16.regionLocTag][v17] = v17
								else
									v4[v16.regionLocTag][v17] = "???"
								end

								v14 = true
								break
							end
						end
					end
				end

				if not v14 then
					local v15 = p2[v13.type:__wf_atom_5b41f63b()]
					local reqScans = v13.reqScans

					if v13.type:IsA(__wf_atom_bfb77700) then
						reqScans = 1
						v15 = 1
					elseif not v15 then
						v15 = 0
					end

					local v16 = v10 and 1000 or v15

					if reqScans then
						__wf_atom_421b01aa(v16 / reqScans, 0, 1)
					end

					local label = string.upper((fn3(object, v13)))

					if v13.type:IsA(__wf_atom_2a625da3) then
						table.insert(v7, { Label = label, Found = true })
					else
						table.insert(result, { Label = label, Found = true })

						if v13.type:IsA(v11) then
							v9 = true
						end
					end
				end
			end
		elseif v12:IsA(nil) then
			local v13 = tostring(Resource(v12):__wf_atom_4f3855f9())
			v6[v13] = object:__wf_atom_8e9ac384(v13, false)
		else
			for j = 1, #list do
				local v13 = list[j]
				__wf_atom_83c14687(0)

				if not (not __wf_atom_7e8ad928(v13.randomizedItems) and v13.randomizedItems:__wf_atom_1bb5b1ff() == v12 or not __wf_atom_7e8ad928(v13.enemyCacheOverride) and v13.enemyCacheOverride:__wf_atom_1bb5b1ff() == v12) then
					continue
				end

				if v4[v13.regionLocTag] == nil then
					v4[v13.regionLocTag] = {}
				end

				local v14 = string.upper(object:__wf_atom_8e9ac384(v13.locTag, true))

				if v10 or p2[v13.name] ~= nil then
					if not v8[v13.regionLocTag] then
						v8[v13.regionLocTag] = true
					end

					v4[v13.regionLocTag][v14] = v14
				else
					v4[v13.regionLocTag][v14] = "???"
				end
			end
		end
	end

	if not v9 then
		for i = 1, #v7 do
			table.insert(result, v7[i])
		end
	end

	table.sort(result, fn2)

	for k, v12 in pairs(v4) do
		if v8[k] then
			local v13 = {}

			for _, v14 in pairs(v12) do
				table.insert(v13, v14)
			end

			table.sort(v13)
			local group = string.upper(object:__wf_atom_8e9ac384(k, false))
			table.insert(result, { Label = table.concat(v13, ", "), Group = group, Found = true })
		else
			table.insert(result, { Label = "???", Group = "???", Found = false })
		end
	end

	table.sort(v5, fn2)

	for i = 1, #v5 do
		table.insert(result, v5[i])
	end

	for _, label in pairs(v6) do
		table.insert(result, { Label = label, Found = true })
	end

	return result
end

function GetDropSources(p, p2, p3, p4, p5, p6)
	return (fn4(p, p2, p3, p4, p5, p6))
end

function GetDropSourcesString(object, p, p2, p3, p4, p5, p6, p7)
	local v4 = ""
	local v5 = fn4(object, p, p2, p3, p4, p5)
	local v6 = nil
	local v7 = p6 == nil and "#999999" or p6
	local v8 = p7 == nil and "#FFFFFF" or p7

	if #v5 == 0 then
		if p2.type:IsA(__wf_atom_6317e6dc) then
			v4 ..= "<font color=\"" .. v7 .. "\">" .. object:__wf_atom_8e9ac384(
				"/Lotus/Language/PrimeStore/Codex_PrimeVault",
				true
			) .. "</font>"
		end
	else
		for i = 1, #v5 do
			local v9 = v5[i]
			local label = v9.Label or ""
			local group = v9.Group or ""
			local v10 = group ~= ""

			if v6 == nil then
				v6 = v10
			elseif v6 ~= v10 then
				v4 ..= "<br>"
				v6 = v10
			end

			local v11 = not v9.Found and "???" or label
			local v12

			if group == "" then
				v12 = "<font color=\"" .. v7 .. "\">" .. TitleCase(v11) .. "</font>"
			else
				local v13 = group:gsub("%:", "")
				group = "<font color=\"" .. v7 .. "\">" .. TitleCase(v13) .. module.Ternary(v11 == "", "</font>", ": </font>")
				v12 = TitleCase(v11)
			end

			v4 ..= group .. v12

			if i ~= #v5 then
				v4 ..= "<br>"
			end
		end
	end

	return "<font color=\"" .. v8 .. "\">" .. object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Codex_DropSources", false) .. "</font><br>" .. v4
end

function OnStats(p, list)
	local v4 = WeakResource("/SF/Types/Game/BaseCosmeticEnhancer")
	local mScans = p.mScans
	local result = {}

	for i = 1, #mScans do
		result[mScans[i].type:__wf_atom_5b41f63b()] = mScans[i].scans
	end

	local mMissions = p.mMissions

	for i = 1, #mMissions do
		result[mMissions[i].location] = 1
	end

	local __wf_atom_a212d5ad = gGameData:__wf_atom_a212d5ad()

	for i = 1, #__wf_atom_a212d5ad do
		local c_str = __wf_atom_a212d5ad[i].mTag:c_str()

		if c_str ~= "" then
			result[c_str] = 1
		end

		for j = 1, #list do
			local v5 = list[j]
			__wf_atom_83c14687(0)

			if v5.name ~= c_str then
				continue
			end

			if not __wf_atom_7e8ad928(v5.randomizedItems) then
				result[v5.randomizedItems:__wf_atom_5b41f63b()] = 1
			end

			if __wf_atom_7e8ad928(v5.enemyCacheOverride) then
				break
			end

			result[v5.enemyCacheOverride:__wf_atom_5b41f63b()] = 1
			break
		end
	end

	local inventory = gGameData:GetInventory()
	local __wf_atom_8844017b = inventory:__wf_atom_8844017b()

	for i = 1, #__wf_atom_8844017b do
		local mItemType = __wf_atom_8844017b[i].mItemType

		if not __wf_atom_7e8ad928(mItemType) then
			result[mItemType:__wf_atom_5b41f63b()] = 2
		end
	end

	local __wf_atom_c84817dd = inventory:__wf_atom_c84817dd()

	for i = 1, #__wf_atom_c84817dd do
		local mItemType = __wf_atom_c84817dd[i].mItemType

		if
			__wf_atom_7e8ad928(mItemType)
			or not mItemType:IsA(__wf_atom_6317e6dc)
			or not (__wf_atom_c84817dd[i].mItemCount > 0)
		then
			continue
		end

		result[mItemType:__wf_atom_5b41f63b()] = 2
		local __wf_atom_2ad5cd23 = mItemType:__wf_atom_2ad5cd23()

		if __wf_atom_7e8ad928(__wf_atom_2ad5cd23) or result[__wf_atom_2ad5cd23:__wf_atom_5b41f63b()] ~= nil then
			continue
		end

		result[__wf_atom_2ad5cd23:__wf_atom_5b41f63b()] = 2
	end

	local v5 = { inventory:__wf_atom_063f1444(), inventory:GetUpgrades() }

	for _, v6 in pairs(v5) do
		for i = 1, #v6 do
			local mItemType = v6[i].mItemType

			if __wf_atom_7e8ad928(mItemType) or not mItemType:IsA(v4) then
				continue
			end

			result[mItemType:__wf_atom_5b41f63b()] = 2
		end
	end

	return result, list
end