module(..., package.seeall)
local module = require("EE.Interface.Utilities")

local function fn(p, p2, uiColor_PvpKill, uiColor_PvpKill2)
	local v = ("<p><font color=\"#" .. string.format("%X", uiColor_PvpKill) .. "\"><b>" .. p) .. "</b></font><font color=\"#FFFFFF\">"
	local v2 = ("</font><font color=\"#" .. string.format("%X", uiColor_PvpKill2) .. "\"><b>" .. p2) .. "</b></font></p>"
	return (Localize("/Lotus/Language/Game/PlayerKilledPlayer", { PLAYER_A = v, PLAYER_B = v2 }))
end

local function fn2(p, p2, uiColor_PvpKill, uiColor_PvpKill2, name)
	local v = ("<p><font color=\"#" .. string.format("%X", uiColor_PvpKill) .. "\"><b>" .. p) .. "</b></font><font color=\"#FFFFFF\">"
	local v2 = ("</font><font color=\"#" .. string.format("%X", uiColor_PvpKill2) .. "\"><b>" .. p2) .. "</b></font></p>"

	if __wf_atom_7e8ad928(name) then
		return (Localize("/Lotus/Language/Game/PlayerKilledPlayer", { PLAYER_A = v, PLAYER_B = v2 }))
	end

	return v .. (" [" .. name .. "] ") .. v2
end

local function fn3()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v in pairs(__wf_atom_3c8e1a7a) do
		local __wf_atom_8537d7d4 = v:__wf_atom_8537d7d4()
		local __wf_atom_6be84646 = v:__wf_atom_6be84646()

		if gGameRules:JoinTeam(v, __wf_atom_8537d7d4) then
			print("PvpTeamSelect: Adding " .. __wf_atom_6be84646 .. " to previous team " .. __wf_atom_8537d7d4)
		else
			for i = 1, gGameRules:__wf_atom_86b8aa11() do
				if not gGameRules:JoinTeam(v, i - 1) then
					continue
				end

				print("PvpTeamSelect: Adding " .. __wf_atom_6be84646 .. " to team " .. i - 1)
				break
			end
		end
	end
end

local function fn4(p)
	local v = {}
	local v2 = 0
	local v3 = {}
	local v4 = {}
	table.insert(v4, {})
	table.insert(v4, {})
	local gGameRules2 = gGameRules
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v5 = {}

	if gPromotedToHost or not gGameRules:__wf_atom_6998f19c() then
		print("Restoring PreMigration Team assignment")

		for _, v6 in pairs(__wf_atom_3c8e1a7a) do
			local __wf_atom_d1d017f5 = gGameRules2:__wf_atom_d1d017f5(v6)

			if not (__wf_atom_d1d017f5 < 2) then
				continue
			end

			local __wf_atom_6be84646 = v6:__wf_atom_6be84646()
			print("Preferred team for " .. tostring(__wf_atom_6be84646) .. " is " .. tostring(__wf_atom_d1d017f5))
			local v7 = __wf_atom_d1d017f5 + 1

			if #v4[v7] < p then
				table.insert(v4[v7], __wf_atom_6be84646)
				v5[__wf_atom_6be84646] = 1
			else
				print("Not enough slots")
			end
		end
	end

	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for i = 1, #__wf_atom_bb46d8b6 do
		local v6 = __wf_atom_bb46d8b6[i]
		local groupName = v6.groupName

		if v5[v6.name] ~= nil then
			continue
		end

		if groupName == "" or gGameRules:__wf_atom_2b0b2f11(v6.name) then
			print("Player " .. tostring(v6.name) .. " -- no group")
			table.insert(v3, v6.name)
		else
			print("Player " .. tostring(v6.name) .. ", in group with " .. groupName)

			if not v[groupName] then
				print("Found new group - " .. groupName)
				v[groupName] = {}
				v2 += 1
			end

			table.insert(v[groupName], v6.name)
		end
	end

	local v6 = {}

	for k, v7 in pairs(v) do
		print("Group " .. k .. " has " .. tostring(#v7) .. " member(s)")
		local v8 = #v6 + 1

		for i = 1, #v6 do
			if not (#v7 < #v6[i]) then
				continue
			end

			v8 = i
			break
		end

		table.insert(v6, v8, k)
	end

	while #v4[1] + #v4[2] < #__wf_atom_bb46d8b6 do
		local ternary = module.Ternary(#v4[1] <= #v4[2], v4[1], v4[2])
		print("Groups to process = " .. tostring(v2))
		print("Team counts " .. tostring(#v4[1]) .. " and " .. tostring(#v4[2]))

		if v2 > 0 then
			local v7 = nil

			for i = 1, v2 do
				local v8 = v[v6[i]]
				local v9 = p - #ternary

				if __wf_atom_7e8ad928(v8) or not (#v8 <= v9) then
					print("Group too big, can't fit in team")
					break
				end

				print("Group " .. tostring(i) .. ", adding to team, " .. tostring(#ternary) .. " slot(s) taken so far, group has " .. tostring(#v8) .. " member(s)")
				v7 = i

				for _, v10 in pairs(v8) do
					table.insert(ternary, v10)
				end

				break
			end

			if v7 == nil then
				print("AutoAssignTeams failed! (group assignment) - splitting group")
				v7 = 1
				local v8 = v[v6[v7]]

				for _, v9 in pairs(v8) do
					print("New loose player " .. tostring(v9))
					table.insert(v3, v9)
				end
			end

			table.remove(v6, v7)
			v2 -= 1
		elseif #v3 > 0 then
			table.insert(ternary, v3[1])
			table.remove(v3, 1)
		else
			print("AutoAssignTeams failed! (individual assignment)")
			break
		end
	end

	if gPromotedToHost and gGameRules2:__wf_atom_6998f19c() then
		repeat
			local flag = false
			local v7 = 1
			local v8 = 1

			for i = 1, #v4 do
				local v9 = #v4[i]

				for j = 1, #v4 do
					if not (i ~= j and #v4[j] + 1 < v9) then
						continue
					end

					v8 = i
					v7 = j
					flag = true
				end
			end

			if flag then
				table.insert(v4[v7], v4[v8][#v4[v8]])
				table.remove(v4[v8], #v4[v8])
			end
		until not flag
	end

	for _, v7 in pairs(__wf_atom_3c8e1a7a) do
		local __wf_atom_6be84646 = v7:__wf_atom_6be84646()
		print("Assigning " .. __wf_atom_6be84646)

		for i = 1, #v4 do
			for _, v8 in pairs(v4[i]) do
				if v8 ~= __wf_atom_6be84646 then
					continue
				end

				local v9 = i - 1
				gGameRules2:JoinTeam(v7, v9)
				print("PvpTeamSelect: Adding " .. __wf_atom_6be84646 .. " to team " .. v9)
				break
			end
		end
	end
end

function BuildKillMessage(object, object2, p, p2, p3, p4)
	if
		__wf_atom_7e8ad928(gClient)
		or __wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object2)
		or p == ""
		or p2 == ""
		or not p4
	then
		return ""
	end

	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	local __wf_atom_e93896ba2 = object2:__wf_atom_e93896ba()
	local v = ""
	local name = ""

	if p4.DamageHistory[p] and p4.DamageHistory[p][p2] then
		local v2 = p4.DamageHistory[p][p2]

		if v2 then
			for i = 0, p4.HITTYPE_NUM - 1 do
				local hitType = v2.hitTypes[i]

				if not hitType then
					continue
				end

				if string.len(name) == 0 then
					name = hitType.name
				else
					name ..= "+" .. hitType.name
				end
			end

			p4.DamageHistory[p][p2].hitTypes = {}
			p4.DamageHistory[p][p2].lastHitTime = __wf_atom_c4e218a2() - 10000
		end
	end

	if object:__wf_atom_129d1aba(object2) then
		return v
	end

	local uiColor_PvpKill, uiColor_PvpKill2

	if __wf_atom_e93896ba == __wf_atom_e93896ba2 then
		uiColor_PvpKill = _G.UIColor_PvpKill
		uiColor_PvpKill2 = _G.UIColor_PvpKill
	else
		uiColor_PvpKill = module.Ternary(__wf_atom_e93896ba == p3, _G.UIColor_PvpTeamOne, _G.UIColor_PvpTeamTwo)
		uiColor_PvpKill2 = module.Ternary(__wf_atom_e93896ba2 == p3, _G.UIColor_PvpTeamOne, _G.UIColor_PvpTeamTwo)
	end

	if string.len(name) > 0 then
		return (fn2(p, p2, uiColor_PvpKill, uiColor_PvpKill2, name))
	end

	return (fn(p, p2, uiColor_PvpKill, uiColor_PvpKill2))
end

local v = {
	[1] = "PvpNode0",
	[2] = "PvpNode9",
	[3] = "PvpNode10",
	[4] = "PvpNode11",
	[6] = "PvpNode15",
	[7] = "PvpNode14",
	[8] = "PvpNode13",
	[9] = "PvpNode12",
	[11] = "PvpNode16"
}
local v2 = {
	PvpNode0 = 1,
	PvpNode12 = 1,
	PvpNode9 = 2,
	PvpNode13 = 2,
	PvpNode10 = 3,
	PvpNode14 = 3,
	PvpNode15 = 6,
	PvpNode16 = 6,
	PvpNode11 = 4
}

function PVPMode2NodeID(p)
	return v[p]
end

function NodeID2PVPMode(p)
	return v2[p]
end

function inheritsFrom(p)
	local v3 = {}
	local v4 = { __index = v3 }

	if p ~= nil then
		setmetatable(v3, { __index = p })
	end

	function v3.create(_)
		local v5 = {}
		setmetatable(v5, v4)
		return v5
	end

	function v3.class(_)
		return v3
	end

	function v3:superClass()
		return p
	end

	function v3.isa(_, p2)
		local v5 = v3
		local v6 = false

		while v5 ~= nil and v6 == false do
			if v5 == p2 then
				v6 = true
			else
				v5 = v5:superClass()
			end
		end

		return v6
	end

	return v3
end

function AutoAssignTeams(p, p2)
	if not gRegion:IsMaster() then
		return
	end

	if p2 == 3 then
		fn3()
	else
		fn4(p)
	end
end