module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local v = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")

local function fn(__wf_atom_70b880cb)
	local v2 = ""
	local affixes = __wf_atom_70b880cb.affixes
	local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Yellow)

	if affixes == nil then
		return (string.gsub(v2, "x%+", "+x"))
	end

	local languageSeparators = module.GetLanguageSeparators()
	local decimal = languageSeparators.Decimal
	local v3 = "%" .. languageSeparators.Thousands .. "?"

	if languageSeparators.ThousandsTable ~= nil then
		v3 = ""

		for _, v4 in pairs(languageSeparators.ThousandsTable) do
			v3 ..= "%" .. v4 .. "?"
		end
	end

	local v4 = "(%+?-?x?%d+%" .. decimal .. "?" .. v3 .. "%d*%%?)"

	for i = 1, #affixes do
		if affixes[i] == "" then
			continue
		end

		if v2 ~= "" then
			v2 ..= "\r\n"
		end

		local v5 = 1
		v2 ..= affixes[i]:gsub(v4, function(value)
			if value ~= nil then
				local v6 = string.gsub(value, "[%%?%+?x?" .. v3 .. "]", "")
				tonumber((string.gsub(v6, "%" .. decimal, ".")))
			end

			v5 += 1
			return string.format("<font color=\"" .. convertColorNumberToHex .. "\">%s</font>", value)
		end)
	end

	return (string.gsub(v2, "x%+", "+x"))
end

local function fn2(object, __wf_atom_70b880cb, __wf_atom_70b880cb2)
	local v2 = ""
	local affixes = __wf_atom_70b880cb.affixes

	if affixes == nil then
		return (string.gsub(v2, "x%+", "+x"))
	end

	local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Yellow)
	local convertColorNumberToHex2 = module.ConvertColorNumberToHex(_G.UIColor_Beige)
	local languageSeparators = module.GetLanguageSeparators()
	local decimal = languageSeparators.Decimal
	local v3 = "%" .. languageSeparators.Thousands .. "?"

	if languageSeparators.ThousandsTable ~= nil then
		v3 = ""

		for _, v4 in pairs(languageSeparators.ThousandsTable) do
			v3 ..= "%" .. v4 .. "?"
		end
	end

	for i = 1, #affixes do
		if affixes[i] == "" then
			continue
		end

		if v2 ~= "" then
			v2 ..= "\r\n"
		end

		local affix = affixes[i]

		if __wf_atom_70b880cb2 ~= nil then
			local v4 = "(%+?-?x?%d+%" .. decimal .. "?" .. v3 .. "%d*%%?)"
			local v5 = {}

			for k in __wf_atom_70b880cb2.affixes[i]:gmatch(v4) do
				table.insert(v5, k)
			end

			local v6 = 0
			local v7 = {}

			for _ = 1, #v5 do
				local v8 = string.find(affix, v4, v6)

				if v8 == nil then
					continue
				end

				v6 = v8 + 17
				table.insert(v7, v8)
			end

			local v8 = 1
			local v9 = i
			affix = affix:gsub(v4, function(value)
				local v10 = v5[v8]
				local v11

				if v10 ~= nil then
					local v12 = string.gsub(v10, "[%%?%+?x?" .. v3 .. "]", "")
					v11 = tonumber((string.gsub(v12, "%" .. decimal, ".")))
				end

				local v12

				if value ~= nil then
					local v13 = string.gsub(value, "[%%?%+?x?" .. v3 .. "]", "")
					v12 = tonumber((string.gsub(v13, "%" .. decimal, ".")))
				end

				local v13 = {
					Start = v8 == 1 and 0 or v7[v8 - 1],
					End = v7[v8]
				}
				v8 += 1

				if not v10 or value == v10 or v11 == nil or v12 == nil then
					return value
				end

				local smallerIsBetter

				if __wf_atom_70b880cb.affixPairs == nil or __wf_atom_70b880cb.affixPairs[v9] == nil then
					local v14 = string.find(affix, "<LOWER_IS_BETTER>", v13.Start)

					if v14 == nil or v13.End == nil then
						smallerIsBetter = false
					else
						smallerIsBetter = v14 < v13.End
					end
				else
					smallerIsBetter = __wf_atom_70b880cb.affixPairs[v9].smallerIsBetter
				end

				local v14

				if smallerIsBetter then
					v14 = module.Ternary(v12 < v11, convertColorNumberToHex, convertColorNumberToHex2)
				else
					v14 = module.Ternary(v11 < v12, convertColorNumberToHex, convertColorNumberToHex2)
				end

				return v10 .. " " .. object:__wf_atom_8e9ac384("<COMPARE_ARROW>", true) .. string.format(
					"<font color=\"" .. v14 .. "\">%s</font>",
					value
				)
			end)
		end

		v2 ..= affix
	end

	return (string.gsub(v2, "x%+", "+x"))
end

function GetMoteDescription(data, p, p2, p3)
	local upgradeInfo = SF.UpgradeInfo()
	upgradeInfo.mItemType = data.Type
	local v2 = p and "<p>" or "<p align=\"left\">"
	local instance = data.Instance
	local statsColor = data.StatsColor or _G.UIColor_Beige
	local v3 = "<font color=\"" .. module.ConvertColorNumberToHex(statsColor) .. "\">"
	local descriptionColor = data.DescriptionColor or _G.UIColor_Gold
	local _ = "<font color=\"" .. module.ConvertColorNumberToHex(descriptionColor) .. "\">"

	if __wf_atom_7e8ad928(instance) or data.Polarity == nil then
		v2 = data.Type:IsA(WeakResource("/SF/Upgrades/SFPactUpgrade")) and "<PACT_CATEGORY_ICON>"
			or data.Type:IsA(__wf_atom_f8bb7ca2) and "<WEAPON_CATEGORY_ICON>"
			or v2
	elseif data.Upgrade ~= nil and data.Polarity ~= nil then
		local v4 = GetStatsDescription(data.Upgrade.mUpgradeFingerprint, data.Upgrade, data.Weapon, p, p2, p3)

		if v4 ~= "" then
			v2 ..= "</font>"
		end

		if v4 ~= "" then
			v2 = (v2 .. v3) .. v4
		end
	end

	return v2 .. "</p>"
end

function GetStatsDescription(p, p2, object, p3, p4, p5)
	local mItemType = p2.mItemType

	if __wf_atom_7e8ad928(mItemType) then
		return ""
	end

	local v2

	if not __wf_atom_7e8ad928(object) then
		v2 = object:__wf_atom_1bb5b1ff()
	end

	local object2 = gRegion:CreateObject(Type(mItemType))
	object2:__wf_atom_eaa00d7a(p, v2)
	local v3 = ""
	local __wf_atom_70b880cb = object2:__wf_atom_70b880cb(p)

	if p3 then
		local encoded

		if p == "" then
			encoded = cjson.encode({ lvl = 1 })
		else
			local decoded = cjson.decode(p)

			if decoded.lvl then
				decoded.lvl += 1
			else
				decoded.lvl = 1
			end

			encoded = cjson.encode(decoded):gsub("\\/", "/")
		end

		object2:__wf_atom_eaa00d7a(encoded, v2)
		v3 = fn2(p4, object2:__wf_atom_70b880cb(encoded), __wf_atom_70b880cb)
	elseif p5 then
		v3 = fn(__wf_atom_70b880cb)
	elseif __wf_atom_70b880cb.affixes ~= nil then
		for _, affix in ipairs(__wf_atom_70b880cb.affixes) do
			if v3 ~= "" then
				v3 ..= "\r\n"
			end

			v3 ..= affix
		end
	end

	gRegion:__wf_atom_dd1e4d10(object2)
	return v3
end

function GetTotemBg(p)
	if p == 9 then
		return _G.UITexture_MoteCardBgTextures[3]
	elseif p == 10 then
		return _G.UITexture_MoteCardBgTextures[5]
	elseif p == 11 then
		return _G.UITexture_MoteCardBgTextures[4]
	end

	return _G.UITexture_MoteCardBgTextures[2]
end

function CalcTotemColor(p)
	if p == 9 then
		return 16764108
	elseif p == 10 then
		return 14548957
	elseif p == 11 then
		return 14548981
	end

	return 16777215
end

function IsMatchingPolarity(p, p2)
	if p == 9 and p2 == 1 or p == 11 and p2 == 3 then
		return true
	elseif p == 10 then
		return p2 == 2
	else
		return false
	end
end

function UpdateMoteInstructions(object, p, p2, p3, p4, p5)
	local v2 = ""
	object:__wf_atom_e57658c2(p, 12, 100)

	if p2 == 3 then
		v2 = "<p><font face=\"Spectral Italic\">" .. object:__wf_atom_8e9ac384("/SF/Language/Tutorial/UseRune", true) .. "</font></p>"
		object:__wf_atom_e57658c2(p, 12, 100)
	elseif p5 or not IsMatchingPolarity(p3, p4) then
		local v3

		if p3 == 9 then
			v3 = "AT_COURAGE"
		elseif p3 == 11 then
			v3 = "AT_GRACE"
		elseif p3 == 10 then
			v3 = "AT_SPIRIT"
		else
			v3 = ""
		end

		if #v3 > 0 then
			v2 = "<p><font face=\"Spectral Italic\">" .. object:__wf_atom_8e9ac384(
				"/SF/Language/Tutorial/MatchTotemSlot",
				false,
				{
					SLOT_NAME = object:__wf_atom_8e9ac384("/SF/Language/Menu/" .. v3, false)
				}
			) .. "</font></p>"
		else
			print("polarity invalid: ", p3)
		end

		object:__wf_atom_e57658c2(p, 12, module.Ternary(v3 ~= "", 100, 0))
	else
		v2 = TitleCase(object:__wf_atom_8e9ac384("/SF/Language/Motes/MatchingVirtueBonusApplied", false))
		object:__wf_atom_e57658c2(p, 44, 12363651)
		object:__wf_atom_e57658c2(p, 12, 60)
	end

	object:__wf_atom_50d60589(p, 36, v2)
end

function GetMoteTexture(instance, p)
	if __wf_atom_7e8ad928(instance) then
		return nil
	end

	local v2 = __wf_atom_7e8ad928(p) and "" or p
	local uiTexture_MoteFrameTexturesActive = _G.UITexture_MoteFrameTexturesActive

	if instance:IsA(v) then
		uiTexture_MoteFrameTexturesActive = _G.UITexture_MoteFrameTexturesPassive
	end

	local __wf_atom_a8dac107 = instance:__wf_atom_a8dac107(v2)
	local __wf_atom_c6a5f697 = instance:__wf_atom_c6a5f697(v2)
	return uiTexture_MoteFrameTexturesActive[1 + __wf_atom_a8dac107 * 4 + __wf_atom_c6a5f697]
end