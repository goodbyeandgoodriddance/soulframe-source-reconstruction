module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local v = { function(p)
		return Localize("/Lotus/Language/Railjack/CrewSkillPercent", {
			VALUE = module.FormatNumber(p * 100, 2, false)
		})
	end }
local v2 = {
	[84] = { mLoc = "/Lotus/Language/Labels/AVATAR_HEALTH_MAX" },
	[154] = { mLoc = "/Lotus/Language/Labels/AVATAR_SHIELD_MAX" },
	[292] = { mLoc = "/Lotus/Language/Labels/WEAPON_DAMAGE_AMOUNT", mFormatting = 1 },
	[476] = { mLoc = "/Lotus/Language/Labels/AVATAR_ABILITY_EFFICIENCY", mFormatting = 1 },
	[81] = { mLoc = "/Lotus/Language/Labels/AVATAR_HEAL_RATE", mFormatting = 1 },
	[101] = { mLoc = "/Lotus/Language/Labels/AVATAR_MOVEMENT_SPEED", mFormatting = 1 },
	[252] = { mLoc = "/Lotus/Language/Labels/WEAPON_HEAT_GENERATION", mFormatting = 1 },
	[453] = { mLoc = "/Lotus/Language/Labels/WEAPON_SPREAD", mFormatting = 1 }
}
local v3 = {
	[0] = {
		[0] = {
			{ upgradeType = 101, value = 0, operationType = 3 }
		},
		[1] = {
			{ upgradeType = 101, value = 0.05, operationType = 3 }
		},
		[2] = {
			{ upgradeType = 101, value = 0.05, operationType = 3 }
		},
		[3] = {
			{ upgradeType = 101, value = 0.05, operationType = 3 }
		},
		[4] = {
			{ upgradeType = 101, value = 0.05, operationType = 3 }
		},
		[5] = {
			{ upgradeType = 101, value = 0.05, operationType = 3 }
		}
	},
	[1] = {
		[0] = {
			{ upgradeType = 252, value = 0, operationType = 3 },
			{ upgradeType = 453, value = 0, operationType = 3 }
		},
		[1] = {
			{ upgradeType = 252, value = -0.1, operationType = 3 },
			{ upgradeType = 453, value = 0.15, operationType = 3 }
		},
		[2] = {
			{ upgradeType = 252, value = -0.1, operationType = 3 },
			{ upgradeType = 453, value = 0.15, operationType = 3 }
		},
		[3] = {
			{ upgradeType = 252, value = -0.1, operationType = 3 },
			{ upgradeType = 453, value = 0.15, operationType = 3 }
		},
		[4] = {
			{ upgradeType = 252, value = -0.1, operationType = 3 },
			{ upgradeType = 453, value = 0.15, operationType = 3 }
		},
		[5] = {
			{ upgradeType = 252, value = -0.1, operationType = 3 },
			{ upgradeType = 453, value = 0.15, operationType = 3 }
		}
	},
	[2] = {
		[0] = {
			{ upgradeType = 476, value = 0, operationType = 3 },
			{ upgradeType = 81, value = 0, operationType = 0 }
		},
		[1] = {
			{ upgradeType = 476, value = 0.1, operationType = 3 },
			{ upgradeType = 81, value = 0.02, operationType = 0 }
		},
		[2] = {
			{ upgradeType = 476, value = 0.1, operationType = 3 },
			{ upgradeType = 81, value = 0.02, operationType = 0 }
		},
		[3] = {
			{ upgradeType = 476, value = 0.1, operationType = 3 },
			{ upgradeType = 81, value = 0.02, operationType = 0 }
		},
		[4] = {
			{ upgradeType = 476, value = 0.1, operationType = 3 },
			{ upgradeType = 81, value = 0.02, operationType = 0 }
		},
		[5] = {
			{ upgradeType = 476, value = 0.1, operationType = 3 },
			{ upgradeType = 81, value = 0.02, operationType = 0 }
		}
	},
	[3] = {
		[0] = {
			{ upgradeType = 292, value = 0, operationType = 3 }
		},
		[1] = {
			{ upgradeType = 292, value = 0.4, operationType = 3 }
		},
		[2] = {
			{ upgradeType = 292, value = 0.4, operationType = 3 }
		},
		[3] = {
			{ upgradeType = 292, value = 0.4, operationType = 3 }
		},
		[4] = {
			{ upgradeType = 292, value = 0.4, operationType = 3 }
		},
		[5] = {
			{ upgradeType = 292, value = 0.4, operationType = 3 }
		}
	},
	[4] = {
		[0] = {
			{ upgradeType = 84, value = 0, operationType = 0 },
			{ upgradeType = 154, value = 0, operationType = 0 }
		},
		[1] = {
			{ upgradeType = 84, value = 300, operationType = 0 },
			{ upgradeType = 154, value = 100, operationType = 0 }
		},
		[2] = {
			{ upgradeType = 84, value = 300, operationType = 0 },
			{ upgradeType = 154, value = 100, operationType = 0 }
		},
		[3] = {
			{ upgradeType = 84, value = 300, operationType = 0 },
			{ upgradeType = 154, value = 100, operationType = 0 }
		},
		[4] = {
			{ upgradeType = 84, value = 300, operationType = 0 },
			{ upgradeType = 154, value = 100, operationType = 0 }
		},
		[5] = {
			{ upgradeType = 84, value = 300, operationType = 0 },
			{ upgradeType = 154, value = 100, operationType = 0 }
		}
	}
}

local function fn(data)
	if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(data.upgradeType) then
		return nil
	end

	local upgrade = Game.Upgrade()
	upgrade:__wf_atom_be789bbd(data.upgradeType)

	if __wf_atom_7e8ad928(data.operationType) then
		upgrade:__wf_atom_d31be7a2(4)
	else
		upgrade:__wf_atom_d31be7a2(data.operationType)
	end

	if __wf_atom_7e8ad928(data.value) then
		upgrade:SetValue(1)
		return upgrade
	end

	upgrade:SetValue(data.value)
	return upgrade
end

function GetUpgrades(p, p2)
	if p2 < 1 or p2 > 5 then
		print("CREW_MEMBER_SKILL_LIB rank arg is incorrect")
		return nil
	end

	local v4 = v3[p]

	if p == 0 or p == 1 then
		return nil
	end

	if __wf_atom_7e8ad928(v4) then
		print("CREW_MEMBER_SKILL_LIB skill arg is incorrect")
		return nil
	end

	local result = {}

	for i = 1, p2 do
		local v5 = v4[i]

		for j = 1, #v5 do
			local v6 = fn(v5[j])

			if not __wf_atom_7e8ad928(v6) then
				table.insert(result, v6)
			end
		end
	end

	return result
end

function GetSkillValues(object, p, value, value2, p2, p3)
	local v4 = {}

	if object ~= nil then
		local v5 = v3[p]

		if v5 ~= nil then
			local v6 = object:__wf_atom_ba6893d3(p) + (value or 0)
			local v7 = v6 + (value2 or 0)

			for i = 0, math.min(math.max(v6, v7), #v5) do
				for _, v8 in ipairs(v5[i]) do
					if v4[v8.upgradeType] == nil then
						v4[v8.upgradeType] = {}
					end

					if v4[v8.upgradeType][v8.operationType] == nil then
						v4[v8.upgradeType][v8.operationType] = { mValue = 0, mCompareValue = 0 }
					end

					if i <= v6 then
						v4[v8.upgradeType][v8.operationType].mValue = v4[v8.upgradeType][v8.operationType].mValue + v8.value
					end

					if i <= v7 then
						v4[v8.upgradeType][v8.operationType].mCompareValue = v4[v8.upgradeType][v8.operationType].mCompareValue + v8.value
					end
				end
			end
		end
	end

	local v5 = ""

	for k, v6 in pairs(v4) do
		if #v5 > 0 then
			v5 ..= "\r"
		end

		local v7 = v2[k] or {}
		local v8

		if v7.mFormatting ~= nil then
			v8 = v[v7.mFormatting]
		end

		for _, v9 in pairs(v6) do
			local mValue = v9.mValue
			local mCompareValue = v9.mCompareValue
			local v10 = mCompareValue - mValue
			local v11 = mValue >= 0
			local rounded = module.Round(mValue, 2)

			if v8 ~= nil then
				rounded = v8(rounded)
			end

			if v11 then
				rounded = "+" .. rounded
			end

			local v12 = mCompareValue >= 0
			local rounded2 = module.Round(mCompareValue, 2)

			if v8 ~= nil then
				rounded2 = v8(rounded2)
			end

			if v12 then
				rounded2 = "+" .. rounded2
			end

			if rounded ~= rounded2 then
				if v10 > 0 then
					rounded ..= "<font color=\"" .. p2 .. "\"><MINI_ARROW>" .. rounded2 .. "</font>"
				elseif v10 < 0 then
					rounded ..= "<font color=\"" .. p3 .. "\"><MINI_ARROW>" .. rounded2 .. "</font>"
				end
			end

			if v7.mLoc ~= nil then
				rounded ..= " " .. Localize(v7.mLoc, {})
			end

			v5 ..= rounded
		end
	end

	return v5
end