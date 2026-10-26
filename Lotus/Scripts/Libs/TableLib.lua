module(..., package.seeall)

local function fn(list, p, p2) -- 3 equivalent calls inferred from this helper
	if p == p2 then
		return
	end

	local v = list[p]
	list[p] = list[p2]
	list[p2] = v
end

local function fn2(list, count, p, p2, callback)
	local v = list[p2]
	fn(list, p, p2) -- inferred equivalent call

	for i = count, p - 1 do
		if not (callback(list[i], v) > 0) then
			continue
		end

		fn(list, i, count) -- inferred equivalent call
		count += 1
	end

	fn(list, count, p) -- inferred equivalent call
	return count
end

local function fn3(list, p, p2, p3, p4)
	if p2 <= p then
		return
	end

	if p4 then
		Sleep(0)
	end

	local v = fn2(list, p, p2, math.floor(p + (p2 - p) / 2), p3)
	fn3(list, p, v - 1, p3, p4)
	fn3(list, v + 1, p2, p3, p4)
end

local function fn4(items, callback, options)
	local result = options or {}

	for k, item in pairs(items) do
		result[k] = callback(item)
	end

	return result
end

local function fn5(list, callback, options)
	local v = not list and 0 or table.maxn(list) or 0
	local result = options or {}
	local v2 = 1

	for i = 1, v do
		local v3 = list[i]

		if not callback(v3) then
			continue
		end

		result[v2] = v3
		v2 += 1
	end

	if result == options then
		for i = v2, v do
			result[i] = nil
		end
	end

	return result
end

local TableLib = {}

function TableLib.Search(items, p)
	if __wf_atom_7e8ad928(items) then
		return 0
	end

	for k, item in pairs(items) do
		if item == p then
			return k
		end
	end

	return 0
end

function TableLib.SearchByFunction(items, p, callback)
	if __wf_atom_7e8ad928(items) then
		return 0
	end

	for k, item in pairs(items) do
		if callback(item, p) then
			return k
		end
	end

	return 0
end

function TableLib.RemoveByElement(list, p)
	local v

	if __wf_atom_7e8ad928(list) then
		v = 0
	else
		local flag = true

		for k, v2 in pairs(list) do
			if v2 ~= p then
				continue
			end

			v = k
			flag = false
			break
		end

		if flag then
			v = 0
		end
	end

	if v > 0 then
		table.remove(list, v)
	end
end

function TableLib.SetDifference(list, list2)
	local result = {}

	if #list2 > 0 then
		for _, v in ipairs(list) do
			local v2

			if __wf_atom_7e8ad928(list2) then
				local k = 0
				v2 = k
			else
				local flag = true

				for k, v3 in pairs(list2) do
					if v3 ~= v then
						continue
					end

					v2 = k
					flag = false
					break
				end

				if flag then
					v2 = 0
				end
			end

			if v2 == 0 then
				table.insert(result, v)
			end
		end
	else
		for _, v in ipairs(list) do
			table.insert(result, v)
		end
	end

	return result
end

function TableLib.Random(list, p)
	local result = {}

	while #result < p do
		local v = __wf_atom_c08f5a0e(1, #list)

		if not __wf_atom_7e8ad928(list[v]) then
			table.insert(result, list[v])
			table.remove(list, v)
		end

		Sleep(0)
	end

	return result
end

function TableLib.Reverse(list)
	local result = {}

	for _, v in ipairs(list) do
		table.insert(result, 1, v)
	end

	return result
end

function TableLib.QuickSort(list, p, p2)
	if #list == 1 then
		return
	end

	local v = __wf_atom_7e8ad928(p2) and true or p2
	fn3(list, 1, #list, p, v)
end

function TableLib.RemoveIfNil(list)
	for i = table.maxn(list), 1, -1 do
		if __wf_atom_7e8ad928(list[i]) then
			table.remove(list, i)
		end
	end
end

function TableLib.MinElement(list, callback)
	if #list == 0 then
		return nil
	end

	local v = list[1]

	for i = 2, #list do
		local v2 = list[i]

		if callback(v2, v) then
			v = v2
		end
	end

	return v
end

function TableLib.InPlaceShuffle(list)
	for i = #list, 2, -1 do
		local v = __wf_atom_5784a397(1, i)
		local v2 = list[i]
		list[i] = list[v]
		list[v] = v2
	end
end

function TableLib.Slice(list, value, p)
	local v = value or 1
	local result = {}

	for i = v, p or #list do
		result[i - v + 1] = list[i]
	end

	return result
end

TableLib.Map = fn4

function TableLib.InPlaceMap(p, p2)
	return (fn4(p, p2, p))
end

TableLib.Filter = fn5

function TableLib.InPlaceFilter(p, p2)
	return (fn5(p, p2, p))
end

function TableLib.GetKeyFromValue(p, items)
	for k, item in pairs(items) do
		if item == p then
			return k
		end
	end

	return nil
end

return TableLib