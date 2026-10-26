module(..., package.seeall)
MATCH_MAKING_FAMILY_SUFFIX = { "_WIN", "_XB", "_PS", "_SWI", "_MOB" }

function GetPlatformFamilyFromPlatform(p)
	if p == 0 then
		return 0
	end

	if p == 3 or p == 4 then
		return 2
	end

	if p == 1 or p == 2 then
		return 1
	end

	if p == 5 then
		return 3
	elseif p == 7 then
		return 4
	end
end

function GetAccountsFromIrcWhoQueryResults(p, p2)
	local result = {}
	local v = false

	if p then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local __wf_atom_e75653c3 = __wf_atom_18a5d83b:__wf_atom_e75653c3()
		local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
		local __wf_atom_7f395d54 = __wf_atom_18a5d83b:__wf_atom_7f395d54()
		local v2 = StringSplit("|", p2)

		for i = 1, #v2 do
			local v3 = StringSplit(",", v2[i])
			local accountId = ""
			local isCrossSave = false
			local wasInCachedList

			if v3[3] == nil then
				wasInCachedList = false
			else
				wasInCachedList = v3[3] == "c"
			end

			v3[3] = nil
			local platform

			if __wf_atom_7e8ad928(v3[1]) then
				v3[1] = v3[2]
				platform = __wf_atom_63bb2bc6
			else
				accountId = v3[1]
				local v4 = string.find(v3[1], "_")

				if v4 == nil then
					platform = Engine.__wf_atom_940f8971(v3[2])

					if platform == 6 then
						v3[2] = Engine.__wf_atom_ba49d4ed(v3[2])
						platform = __wf_atom_63bb2bc6
					end
				else
					accountId = string.sub(v3[1], 1, v4 - 1)
					local v5 = string.sub(v3[1], v4 + 1, v4 + 2)
					local v6 = string.byte(v5)

					if v6 >= 48 and v6 <= 57 then
						platform = v6 - 48
					else
						platform = __wf_atom_63bb2bc6
					end

					if #v5 > 1 then
						isCrossSave = v5:sub(2, 2) == "X"
					else
						isCrossSave = false
					end
				end
			end

			if #v3 ~= 2 or (__wf_atom_7e8ad928(v3[1]) or __wf_atom_7e8ad928(v3[2])) then
				continue
			end

			local canCrossPlay = __wf_atom_7f395d54 or __wf_atom_63bb2bc6 == platform

			if accountId == __wf_atom_e75653c3 then
				v = true
			else
				table.insert(result, {
					IrcUserId = v3[1],
					Name = v3[2],
					AccountId = accountId,
					Platform = platform,
					CanCrossPlay = canCrossPlay,
					IsCrossSave = isCrossSave,
					WasInCachedList = wasInCachedList
				})
			end
		end
	end

	if p then
		if #result ~= 0 then
			v = false
		end
	else
		v = p
	end

	return result, v
end

function GetCrossPlatformUniquePlayerName(p, list, p2, p3, p4)
	local v = {}

	if p4 then
		local __wf_atom_940f8971 = Engine.__wf_atom_940f8971(p)
		local v2 = string.lower(Engine.__wf_atom_746f9d1b(p))

		for i = 0, 4 do
			if __wf_atom_940f8971 == i then
				continue
			end

			local __wf_atom_640a4779 = Engine.__wf_atom_640a4779(i, v2)

			if __wf_atom_640a4779 ~= p and list[__wf_atom_640a4779] ~= nil then
				table.insert(v, __wf_atom_640a4779)
			end
		end
	else
		for _, v2 in ipairs(list) do
			local v3 = nil

			if p2 == nil then
				if p3 then
					if not __wf_atom_7e8ad928(v2) then
						v3 = v2:__wf_atom_6be84646()
					end
				else
					v3 = v2
				end
			else
				v3 = v2[p2]
			end

			if v3 ~= nil and v3 ~= p then
				table.insert(v, v3)
			end
		end
	end

	return (Engine.GetCrossPlatformUniquePlayerName(p, v))
end

function RemoveNumericSuffixFromName(value)
	local v = string.find(value, "#")
	local v2

	if v then
		v2 = string.sub(value, v, v + 3)
		value = string.gsub(value, v2, "")
	end

	return value, v2
end

function GetPlatformAgnosticClanName(p)
	local v, _ = RemoveNumericSuffixFromName(p)
	return (Engine.__wf_atom_746f9d1b(v))
end

function GetCrossPlatformUniqueClanName(p, items, p2, p3)
	local v, v2 = RemoveNumericSuffixFromName(p)
	local v3 = string.lower(Engine.__wf_atom_746f9d1b(v))

	if p3 then
		if items[v3] ~= nil then
			for k, _ in pairs(items[v3]) do
				if k ~= p then
					return p
				end
			end

			return v
		end
	else
		for _, item in pairs(items) do
			if item == nil then
				continue
			end

			if p2 ~= nil then
				item = item[p2]
			end

			if item == p then
				continue
			end

			local v4, v5 = RemoveNumericSuffixFromName(item)
			local v6 = string.lower(Engine.__wf_atom_746f9d1b(v4))

			if v2 ~= v5 and v6 == v3 then
				return p
			end
		end
	end

	return v
end

function GetPlatformPlayerNames(list, p, p2)
	local count = #list

	if p2 ~= nil then
		count = math.min(p2, count)
	end

	local result = {}

	for i = 1, count do
		local v = list[i]

		if p ~= nil then
			v = v[p]
		end

		local __wf_atom_ed508ae4 = Engine.__wf_atom_ed508ae4(v)

		if __wf_atom_ed508ae4 == "" then
			table.insert(result, v)
		else
			table.insert(result, __wf_atom_ed508ae4)
		end
	end

	return result
end