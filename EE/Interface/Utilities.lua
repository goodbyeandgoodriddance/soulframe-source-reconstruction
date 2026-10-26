module(..., package.seeall)
INCREMENT = 1
DECREMENT = -1
RIGHT_ALIGNED = 1
CENTER_ALIGNED = 2
LEFT_ALIGNED = 3
PLATFORM = {
	PC = 0,
	PS4 = 1,
	XBOX_ONE = 2,
	SWITCH = 3,
	PS5 = 4,
	TOUCH = 5,
	BIG_PIC = 6,
	SWITCH2 = 7
}
local thousandsTable = { string.char(194), (string.char(160)) }
local joined = table.concat(thousandsTable)
LANGUAGE_SEPARATOR_FORMATS = {
	{ Thousands = ",", Decimal = ".", Label = "1,000.00", Value = 1 },
	{ Thousands = ".", Decimal = ",", Label = "1.000,00", Value = 2 },
	{
		Thousands = joined,
		ThousandsTable = thousandsTable,
		Decimal = ",",
		Label = "1 000,00",
		Value = 3
	},
	{ Thousands = ".", Decimal = "'", Label = "1.000'00", Value = 4 },
	{
		Thousands = joined,
		ThousandsTable = thousandsTable,
		Decimal = ".",
		Label = "1 000.00",
		Value = 5
	}
}
local v = {
	_en = 1,
	_fr = 3,
	_it = 2,
	_de = 2,
	_es = 5,
	_pt = 2,
	_ru = 3,
	_pl = 3,
	_uk = 3,
	_tr = 2,
	_ja = 1,
	_tc = 1,
	_zh = 1,
	_ko = 1,
	_th = 1
}

function Alphanumeric()
	return "A-Za-z0-9"
end

function ValidChinese()
	return "\\u4E00-\\u9FCC\\u3400-\\u4DB5"
end

function Punctuation()
	return "!-/:-?@[-`{-~"
end

local function fn(p, p2, p3, p4)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gRegion) then
		return nil
	end

	if __wf_atom_7e8ad928(p2) then
		p2 = Vector()
	end

	if __wf_atom_7e8ad928(p3) then
		p3 = false
	end

	return (gRegion:PlaySound(p, p2, p3, 1, p4))
end

function PlaySound(p, p2, p3, p4)
	return (fn(p, p2, p3, p4))
end

local function fn2(p, p2, p3)
	if p then
		return p2
	end

	return p3
end

function Ternary(p, p2, p3)
	return fn2(p, p2, p3)
end

function ToggleValue(p, p2, p3, p4)
	local v2 = p + p2

	if p2 == INCREMENT and p4 < v2 then
		v2 = p3
	elseif p2 == DECREMENT and v2 < p3 then
		v2 = p4
	end

	return (__wf_atom_421b01aa(v2, p3, p4))
end

function ToggleValueNoWrap(p, p2, p3, p4)
	local v2 = p + p2

	if p2 == INCREMENT and p4 < v2 then
		v2 = p4
	elseif p2 == DECREMENT and v2 < p3 then
		v2 = p3
	end

	return (__wf_atom_421b01aa(v2, p3, p4))
end

local function fn3(items, p)
	for k, item in pairs(items) do
		if item == p then
			return k
		end
	end

	return -1
end

function FindInTable(p, p2)
	return (fn3(p, p2))
end

function IsValueInTable(items, p)
	for _, item in pairs(items) do
		if item == p then
			return true
		end
	end

	return false
end

function CopyTable(items)
	local result = {}

	for k, item in pairs(items) do
		result[k] = item
	end

	return result
end

local function fn4(items)
	if type(items) ~= "table" then
		return items
	end

	local result = {}

	for k, item in pairs(items) do
		result[k] = fn4(item)
	end

	return result
end

function CopyTableRecursive(p)
	return (fn4(p))
end

function GetEntityFromTag(p, gRegion2)
	local v2 = nil

	if p == nil then
		return v2
	end

	local v3 = Symbol(p)

	if v3 == EMPTY_SYMBOL then
		return v2
	end

	if gRegion2 == nil then
		gRegion2 = gRegion
	end

	if not __wf_atom_7e8ad928(gRegion2) then
		return (gRegion2:__wf_atom_0a6a5887(v3))
	end

	return v2
end

function GetNearestEntityFromTag(p, p2, gRegion2)
	local v2 = nil

	if p == nil then
		return v2
	end

	local v3 = Symbol(p)

	if v3 == EMPTY_SYMBOL then
		return v2
	end

	if gRegion2 == nil then
		gRegion2 = gRegion
	end

	if __wf_atom_7e8ad928(gRegion2) then
		return v2
	end

	if p2 == nil then
		return (gRegion2:__wf_atom_0a6a5887(v3))
	end

	return (gRegion2:FindNearestTagged(v3, p2))
end

function ToDeg(p)
	return 180 / 3.1415927410125732 * p
end

local function fn5(p)
	return 3.1415927410125732 / 180 * (p % 360)
end

function ToRad(p)
	return (fn5(p))
end

function WrapAngle(p)
	while p > 180 do
		p -= 360
	end

	while p < -180 do
		p += 360
	end

	return p
end

function GetSquaredDistanceBetweenPoints(p, p2)
	local v2 = p2.X - p.X
	local v3 = p2.Y - p.Y
	return v3 * v3 + v2 * v2
end

function GetDistanceBetweenPoints(p, p2)
	local v2 = p2.X - p.X
	local v3 = p2.Y - p.Y
	return (math.sqrt(v3 * v3 + v2 * v2))
end

function GetDistanceBetweenPointsEx(p, p2, p3, p4)
	local v2 = p3 - p
	local v3 = p4 - p2
	return (math.sqrt(v3 * v3 + v2 * v2))
end

function GetAngleBetweenPoints(p, p2, p3, p4)
	local v2 = p3 - p
	local v3 = math.atan2(v2, p4 - p2)

	if v2 < 0 then
		v3 = 3.1415927410125732 * 2 + v3
	end

	return v3 % (3.1415927410125732 * 2)
end

function IntersectLineToPlane(p, p2, p3, p4)
	local v2 = Dot(p3, p2)

	if v2 == 0 then
		return Vector()
	end

	return p + p2 * ((p4 - Dot(p3, p)) / v2)
end

function GetScreenCursor(object)
	return (Vector(object:__wf_atom_5e6e15c8("_root", 30), object:__wf_atom_5e6e15c8("_root", 31), 0))
end

local function fn6(p, p2)
	if p2 then
		return math.floor(p * 10 ^ p2 + 0.5) / 10 ^ p2
	end

	return (math.floor(p + 0.5))
end

function Round(p, p2)
	return (fn6(p, p2))
end

function IsDevicePsMove(p)
	local v2 = tonumber(p)
	return v2 >= 7 and v2 < 11
end

local function fn7(p, p2, p3)
	return string.format("%02X%02X%02X", p, p2, p3)
end

function ConvertRGB2HEX(p, p2, p3)
	return (fn7(p, p2, p3))
end

local function fn8(p)
	return {
		r = bit32.band(bit32.arshift(p, 16), 255),
		g = bit32.band(bit32.arshift(p, 8), 255),
		b = bit32.band(p, 255)
	}
end

function HEX2RGB(p)
	return (fn8(p))
end

function RGB2UINT(data)
	return math.floor(data.r) * 65536 + math.floor(data.g) * 256 + data.b
end

function HEX2UINT(p)
	return RGB2UINT(HEX2RGB(p))
end

function InterpolateColors(p, p2, p3)
	local v2 = bit32.band(bit32.arshift(p, 16), 255)
	local v3 = bit32.band(bit32.arshift(p, 8), 255)
	local v4 = bit32.band(p, 255)
	local v5 = bit32.band(bit32.arshift(p2, 16), 255)
	local v6 = bit32.band(bit32.arshift(p2, 8), 255)
	local v7 = bit32.band(p2, 255)
	local v8 = __wf_atom_421b01aa(v2 + p3 * (v5 - v2), 0, 255)
	local v9 = __wf_atom_421b01aa(v3 + p3 * (v6 - v3), 0, 255)
	local v10 = __wf_atom_421b01aa(v4 + p3 * (v7 - v4), 0, 255)
	return (tonumber("0x" .. fn7(v8, v9, v10)))
end

function ConvertHSB2RGB(p, p2, p3)
	local v2, v3

	if p2 == 0 then
		v2 = p3
		v3 = v2
		v2 = v3
	else
		local v4 = p == 360 and 0 or p
		local v5 = math.floor(v4 / 60)
		local v6 = v4 / 60 - v5
		v3 = p3 * (1 - p2)
		v2 = p3 * (1 - p2 * v6)
		local v7 = p3 * (1 - p2 * (1 - v6))

		if v5 == 0 then
			v2 = v3
			v3 = v7
		elseif v5 == 1 then
			local v8 = v2
			v2 = v3
			v3 = p3
			p3 = v8
		elseif v5 == 2 then
			v2 = v7
			v3, p3 = p3, v3
		elseif v5 == 3 then
			local v8 = v2
			v2 = p3
			p3 = v3
			v3 = v8
		elseif v5 == 4 then
			v2 = p3
			p3 = v7
		elseif v5 ~= 5 then
			p3 = 0
			v3 = 0
			v2 = 0
		end
	end

	return (fn7(p3 * 255, v3 * 255, v2 * 255))
end

function RunForAllLocalAvatars(callback)
	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

	if not __wf_atom_7e8ad928(__wf_atom_a8553251) then
		for _, v2 in ipairs(__wf_atom_a8553251) do
			if not __wf_atom_7e8ad928(v2) then
				callback(v2)
			end
		end
	end
end

function PrintTable(items)
	if __wf_atom_7e8ad928(items) then
		print("------- Empty Table -----")
		return
	end

	print("-------------------------")

	for k, item in pairs(items) do
		print("[" .. tostring(k) .. "]->" .. tostring(item) .. "(" .. type(item) .. ")")
	end

	print("-------------------------")
end

local v2 = nil

local function fn9()
	if __wf_atom_7e8ad928(v2) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			v2 = __wf_atom_18a5d83b:Settings()
		end
	end

	if not __wf_atom_7e8ad928(v2) then
		local __wf_atom_7427fc59 = v2:__wf_atom_7427fc59()

		if __wf_atom_7427fc59 ~= 0 then
			return __wf_atom_7427fc59
		end
	end

	return v[__wf_atom_b953295d():c_str()]
end

function GetNumericSeparatorsIndex()
	return fn9()
end

local function fn10()
	return LANGUAGE_SEPARATOR_FORMATS[fn9()]
end

function GetLanguageSeparators()
	return fn10()
end

local function fn11(p)
	if p then
		return ","
	end

	return fn10().Thousands
end

function GetThousandsSeparator(p)
	return fn11(p)
end

local function fn12(p)
	if p then
		return "."
	end

	return fn10().Decimal
end

function GetDecimalsSeparator(p)
	return fn12(p)
end

local function fn13(value, p)
	if p then
		return value
	end

	local v3 = fn11()
	local v4 = fn9()
	local c_str = __wf_atom_b953295d():c_str()
	local v5 = string.gsub(c_str, "_", "")

	if (v5 == "es" or v5 == "pl") and (v4 == 3 or v4 == 5) then
		local v6 = tonumber(value)

		if v6 and v6 < 10000 and v6 > -10000 then
			v3 = ""
		end
	end

	repeat
		local v6
		value, v6 = string.gsub(value, "^(-?%d+)(%d%d%d)", "%1" .. v3 .. "%2")
	until v6 == 0 or v3 == ""

	return value
end

function SeparateWithCommas(p)
	return (fn13(p))
end

function FormatNumber(p, p2, p3, p4, p5, p6)
	local v3 = p2 == nil and 0 or p2
	local v4 = p3 == nil or p3

	if p4 == nil then
		p4 = false
	end

	if p5 then
		return (Script.__wf_atom_dd995f29(p, 0, v3, v4, p4))
	end

	if p6 == nil then
		p6 = fn9()
	end

	return (Script.__wf_atom_dd995f29(p, p6, v3, v4, p4))
end

function UnFormatNumber(value)
	if fn10().Value == 1 or type(value) ~= "string" then
		return (tonumber(value))
	end

	local v3 = fn11()
	local v4

	if v3 == "." then
		v4 = value:gsub("\\.", "")
	else
		v4 = value:gsub(v3, "")
	end

	local v5 = fn12()
	local v6

	if v5 == "." then
		v6 = v4:gsub("\\.", ".")
	else
		v6 = v4:gsub(v5, ".")
	end

	return (tonumber(v6))
end

function FormatNumberCompact(p)
	local v3 = math.floor(p + 0.5)
	local v4, v5

	if v3 < 10000 then
		v4 = "%.0f"
		v5 = ""
	else
		v3 = p * 0.001

		if v3 < 999.5 then
			v4 = "%.3g"
			v5 = "K"
		else
			v3 = p * 1e-6
			v4 = "%.3g"
			v5 = "M"
		end
	end

	return string.format(v4, v3) .. v5
end

local function fn14(list, p)
	if type(list) == "table" then
		list = list[p] or list[#list]
	end

	return list
end

function RetroAnimateTyping(object, p, list, list2, p2, callback, value, value2, p3)
	local v3 = value or 0.105
	local v4 = value2 or 0
	local v5 = nil
	local v6 = nil
	local v7 = 1
	local count = 0
	local v8 = 0
	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("<CURSOR_BLINK>", true)
	local __wf_atom_8e9ac384_2 = object:__wf_atom_8e9ac384("<CURSOR_STATIC>", true)
	local v9 = fn14(p, 1)
	local v10 = fn14(p, 2)
	local v11 = 0
	local v12 = 0
	local v13

	if type(list2) == "table" then
		v13 = {}

		for _, v14 in ipairs(list2) do
			for _, v15 in ipairs(StringSplit("\r\n", v14)) do
				table.insert(v13, v15)
			end
		end
	else
		v13 = StringSplit("\r\n", list2)
	end

	if type(list) == "table" then
		for _, v14 in ipairs(list) do
			object:__wf_atom_50d60589(v14, 36, "")
			object:__wf_atom_e57658c2(v14, 72, 0)
			object:__wf_atom_e57658c2(v14, 73, 0)
		end
	else
		object:__wf_atom_50d60589(list, 36, "")
		object:__wf_atom_e57658c2(list, 72, 0)
		object:__wf_atom_e57658c2(list, 73, 0)
	end

	local function fn15()
		object:__wf_atom_50d60589(p2, 36, __wf_atom_8e9ac384)

		if callback ~= nil then
			callback()
		end
	end

	local function fn16()
		if p2 ~= nil then
			local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(v5, 50)
			object:__wf_atom_e57658c2(p2, 50, __wf_atom_5e6e15c8)
			local v14 = object:__wf_atom_5e6e15c8(v5, 41) - __wf_atom_5e6e15c8
			object:__wf_atom_e57658c2(p2, 1, object:__wf_atom_5e6e15c8(v5, 1) + v14)
			local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(v5, 95)
			object:__wf_atom_e57658c2(p2, 0, v11 + __wf_atom_5e6e15c8_2)
		end
	end

	local function fn17(p4)
		if v6 ~= nil then
			if v6 then
				fn16()
				PlaySound(v10)
			end

			if p2 ~= nil then
				object:__wf_atom_50d60589(p2, 36, __wf_atom_8e9ac384_2)
			end

			v6 = nil
		end

		local v14 = math.floor(p4)

		if v8 < v14 then
			object:__wf_atom_e57658c2(v5, 72, v14 + v12)

			if p2 ~= nil then
				local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(v5, 95)
				object:__wf_atom_e57658c2(p2, 0, v11 + __wf_atom_5e6e15c8)
			end

			PlaySound(v9)
			v8 = v14
		end
	end

	local function fn18()
		v6 = count > 0
		v8 = 0
		v7 = 1
		count += 1
		local v14 = v13[count]
		local count2 = #v14
		local v15 = fn14(v4, count)
		local v16 = count < #v13 and fn18 or fn15
		local v17 = fn14(list, count)

		if v5 == v17 then
			v12 = object:__wf_atom_5e6e15c8(v5, 72)
			local __wf_atom_387f260e = object:__wf_atom_387f260e(v5, 36)
			object:__wf_atom_50d60589(v5, 36, __wf_atom_387f260e .. "\r\n" .. v14)
		else
			v5 = v17
			v12 = 0
			object:__wf_atom_50d60589(v5, 36, v14)
		end

		if p2 ~= nil then
			object:__wf_atom_50d60589(p2, 36, __wf_atom_8e9ac384)
			v11 = p3 or -(object:__wf_atom_5e6e15c8(v5, 50) / 7)
			v11 += object:__wf_atom_5e6e15c8(v5, 0)

			if object:__wf_atom_387f260e(v5, 45) == "right" then
				v11 += object:__wf_atom_5e6e15c8(v5, 14) - object:__wf_atom_5e6e15c8(v5, 94)
			else
				v11 += 2
			end
		end

		__wf_atom_ec43d06e(object, v5, 0, { fn17 }, { count2 }, v3 * count2, v15, v16)
	end

	fn18()
	fn16()
end

local function fn15(object, p, list, p2, p3, p4, p5, p6)
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 74)
	local v3 = false

	if not (object:__wf_atom_5e6e15c8(p, 76) >= 0 and p3 < __wf_atom_5e6e15c8) then
		return __wf_atom_5e6e15c8, false
	end

	if p4 > 0 and __wf_atom_5e6e15c8 == p4 - 1 then
		object:__wf_atom_e57658c2(list, 1, object:__wf_atom_5e6e15c8(list, 1) + p6)
		object:__wf_atom_e57658c2(list, 0, p5)
		return __wf_atom_5e6e15c8, true
	else
		local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(p, 75)
		object:__wf_atom_e57658c2(list, 0, object:__wf_atom_5e6e15c8(list, 0) + __wf_atom_5e6e15c8_2 + p2)
		return __wf_atom_5e6e15c8, v3
	end
end

function AnimateTyping(object, p, p2, value, callback, p3, p4, callback2, p5, list, p6, p7)
	if __wf_atom_7e8ad928(object) then
		if callback then
			callback()
		end
	else
		local v3 = p3 == nil and 1 or p3
		local v4 = p4 == nil and 0 or p4
		object:__wf_atom_50d60589(p2, 36, value)
		local v5 = p6 == nil and 0 or p6
		local v6 = Ternary(#list > 0, object:__wf_atom_5e6e15c8(list, 0), 0)
		local v7 = 0
		local v8 = {}
		local v9 = {}
		local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p2, 50)
		local v10 = __wf_atom_5e6e15c8 + 10

		if #list > 0 then
			local __wf_atom_387f260e = object:__wf_atom_387f260e(p2, 45)
			local v11 = string.find(value, "\r\n")
			local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(p2, 14)
			local __wf_atom_5e6e15c8_3 = object:__wf_atom_5e6e15c8(p2, 0)
			local count = 0

			while v11 ~= nil do
				count += 1
				table.insert(v8, v11)
				local v12 = string.sub(value, v11 + #v8 + count)
				v11 = string.find(v12, "\r\n")

				if v11 ~= nil then
					v11 = v11 + v8[#v8] - 1
				end

				if __wf_atom_387f260e == "left" then
					table.insert(v9, v6)
				elseif __wf_atom_387f260e == "right" then
					local v13 = string.find(v12, "\r\n")

					if v13 ~= nil then
						v12 = string.sub(v12, 1, v13 - 1)
					end

					local v14 = string.len(v12) * (__wf_atom_5e6e15c8 / 2)
					table.insert(v9, __wf_atom_5e6e15c8_3 + __wf_atom_5e6e15c8_2 - v14)
				end
			end
		end

		local v11 = p5 == nil and 1 or p5
		object:__wf_atom_e57658c2(p2, 73, v11)
		local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(p2, 40)

		if v3 > 0 then
			object:__wf_atom_e57658c2(p2, 72, 0)
		end

		local __wf_atom_5e6e15c8_3 = object:__wf_atom_5e6e15c8(p2, 80)
		local v12 = __wf_atom_5e6e15c8_3 == nil and 0 or __wf_atom_5e6e15c8_3
		local v13 = 1

		local function fn16(p8)
			if v3 < 0 then
				p8 = 1 - p8
			elseif p8 == 1 then
				object:__wf_atom_e57658c2(p2, 72, -1)
				return
			end

			local __wf_atom_5e6e15c8_4 = object:__wf_atom_5e6e15c8(p2, 80)
			local v14 = (__wf_atom_5e6e15c8_4 == nil and 0 or __wf_atom_5e6e15c8_4) * p8

			if v11 ~= 1 then
				v14 = math.floor(v14)
			end

			object:__wf_atom_e57658c2(p2, 72, v14)
			fn(p)

			if #list > 0 then
				local v15, v16

				if v13 <= #v8 then
					v15 = v8[v13]
					v16 = v9[v13]
				else
					v15 = 0
					v16 = 0
				end

				local v17, v18 = fn15(object, p2, list, v5, v7, v15, v16, v10)
				v7 = v17

				if v18 then
					v13 += 1
				end
			end

			if callback2 then
				callback2(p8)
			end
		end

		local v14 = math.abs(v3) * 0.0125 * v12

		if not p7 then
			v14 = math.max(0.35, v14)
		end

		__wf_atom_ec43d06e(object, p2, 0, { fn16 }, { 1 }, v14, v4, callback)
		return __wf_atom_5e6e15c8_2
	end
end

function CreateObservable(mValue2, mOnChangeFunc, mCompareFunc)
	return {
		mValue = mValue2,
		mOnChangeFunc = mOnChangeFunc,
		mCompareFunc = mCompareFunc,
		Set = function(state, mValue)
			local v3

			if state.mCompareFunc == nil then
				v3 = mValue ~= state.mValue
			else
				v3 = state.mCompareFunc(mValue, state.mValue)
			end

			if v3 then
				state.mOnChangeFunc(mValue, state.mValue)
			end

			state.mValue = mValue
		end,
		Get = function(p)
			return p.mValue
		end
	}
end

function CreateInputDeviceObservable(mOnChangeFunc)
	return {
		mValue = Engine.IsPlayingWithController(),
		mOnChangeFunc = mOnChangeFunc,
		Update = function(self)
			local isPlayingWithController = Engine.IsPlayingWithController()

			if isPlayingWithController ~= self.mValue then
				self.mOnChangeFunc(self.mValue)
			end

			self.mValue = isPlayingWithController
		end
	}
end

function SetFitText(object, p, p2)
	local v3 = p2 == nil and "" or p2
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 14)
	object:__wf_atom_50d60589(p, 97, v3)
	object:__wf_atom_e57658c2(p, 93, __wf_atom_5e6e15c8)
end

function SetFittedText(object, p, p2, p3)
	local v3 = p3 == nil and "" or p3
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 14)
	object:__wf_atom_50d60589(p, 97, v3)
	object:__wf_atom_e57658c2(p, 93, __wf_atom_5e6e15c8)
	object:__wf_atom_50d60589(p, 36, p2)
end

function FitTextIntoLines(object, p, p2, p3, p4)
	local v3 = p4 == nil and "" or p4
	object:__wf_atom_e57658c2(p, 92, p2)
	object:__wf_atom_50d60589(p, 97, v3)
	object:__wf_atom_50d60589(p, 36, p3)
end

function FadeBackground(object, p, p2, p3, callback)
	local __wf_atom_9b8947bc = object:__wf_atom_9b8947bc()
	__wf_atom_ec43d06e(object, "_level0", 0, { function(p4)
			local v3 = __wf_atom_9b8947bc + p4 * (p - __wf_atom_9b8947bc)

			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_0cf0fdbe(v3)
			end
		end }, { 1 }, p2, p3, function(_)
		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_0cf0fdbe(p)
		end

		if callback ~= nil then
			callback()
		end
	end)
end

function ShuffleTable(list)
	local count = #list

	while count >= 2 do
		local v3 = math.random(count)
		local v4 = list[v3]
		local v5 = list[count]
		list[count] = v4
		list[v3] = v5
		count -= 1
	end

	return list
end

function SeededShuffleTable(list, p)
	local v3 = p or __wf_atom_c08f5a0e
	local count = #list

	while count >= 2 do
		local v4 = v3(1, count)
		local v5 = list[v4]
		local v6 = list[count]
		list[count] = v5
		list[v4] = v6
		count -= 1
	end

	return list
end

local function fn16(value)
	local v3 = ""

	for i = 1, #value do
		local v4 = string.byte((value:sub(-i, -i)))

		if v4 >= 48 and v4 < 58 then
			v4 += 8

			if v4 >= 58 then
				v4 += 7
			end
		elseif v4 >= 65 and v4 < 91 then
			v4 += 8

			if v4 >= 91 then
				v4 += 6
			end
		elseif v4 >= 97 and v4 < 123 then
			v4 += 8

			if v4 >= 123 then
				v4 -= 75
			end
		end

		v3 ..= string.char(v4)
	end

	local v4 = string.gsub(v3, "%?", "%%3F")
	local v5 = string.gsub(v4, "&", "%%26")
	return "credentials=" .. string.gsub(v5, "=", "%%3D")
end

local function fn17()
	local v3 = string.lower(__wf_atom_c67f9605:__wf_atom_2863bfee())
	return string.find(v3, "api%-dev") ~= nil
end

function IsDevServer()
	return fn17()
end

local function fn18()
	local v3 = string.lower(__wf_atom_c67f9605:__wf_atom_2863bfee())
	return string.find(v3, "api%-test") ~= nil
end

function IsTestServer()
	return fn18()
end

local function fn19()
	local v3 = string.lower(__wf_atom_c67f9605:__wf_atom_2863bfee())
	return string.find(v3, "/localhost/") ~= nil
end

function IsLocalServer()
	return fn19()
end

function IsRetailServer()
	return not (fn17() or fn18() or fn19())
end

function DoOpenWebBrowser(value, value2, p)
	if value2 == nil then
		value2 = value
	end

	if p and string.find(value, "forums.soulframe.com") == nil then
		local c_str = __wf_atom_b953295d():c_str()
		local v3 = string.gsub(c_str, "_", "")
		local v4

		if v3 == "pt" then
			v4 = "pt-br"
		elseif v3 == "zh" then
			v4 = "zh-hans"
		elseif v3 == "tc" then
			v4 = "zh-hant"
		elseif v3 == "tr" then
			v4 = "en"
		else
			v4 = v3
		end

		value = string.gsub(value, "soulframe.com", "soulframe.com/" .. v4)
	end

	if string.find(value, "support.soulframe.com") == nil then
		local v3 = "soulframe.com"
		local v4

		if IsDevServer() then
			v4 = "https://dev." .. v3
		elseif IsTestServer() then
			v4 = "https://test." .. v3
		else
			v4 = "https://www." .. v3
		end

		value = string.gsub(value, ".*soulframe.com", v4)
	end

	if
		__wf_atom_a0f6588f ~= nil
		and not (Engine.__wf_atom_578fc9dd() or string.match(value, "signup?") or string.match(value, "resetpassword"))
	then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if
			not __wf_atom_7e8ad928(__wf_atom_18a5d83b)
			and (string.match(value, "https://dev.soulframe.com") or string.match(value, "https://www.soulframe.com") or string.match(value, "https://soulframe.com") or string.match(value, "https://test.soulframe.com"))
		then
			local v3 = string.gsub(value, "http.*://.*soulframe.com", "")
			local v4 = string.gsub(value, "%.com/.*", "")
			local v5 = __wf_atom_18a5d83b:__wf_atom_c80df685() .. __wf_atom_18a5d83b:__wf_atom_93547e3b()

			if string.find(v3, "auth") == nil then
				local v6 = fn16(v5)
				local v7 = string.gsub(v3, "%?", "%%3F")
				local v8 = string.gsub(v7, "&", "%%26")
				value = v4 .. ".com/auth?" .. v6 .. "&nologin=1" .. "&redirect=" .. string.gsub(v8, "=", "%%3D")
			else
				local v6 = string.find(value, "?")

				if v6 == nil then
					value ..= "?" .. fn16(v5)
				else
					string.sub(value, 1, v6)
					value ..= "&" .. fn16(v5)
				end
			end
		end
	end

	if
		gClient:__wf_atom_c22da057():__wf_atom_a8ac7109().currentDisplayMode.windowMode == 0
		or not Engine.__wf_atom_6f25c160()
	then
		__wf_atom_37151f8f(value)
	else
		Engine.__wf_atom_f33803ab(value)
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		local v3 = string.gsub(value2, "%.", "_")
		local v4 = string.gsub(v3, "(%/+)$", "")

		if v4 ~= "" then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("OPENED_BROWSER_LINK"), v4)
		end
	end
end

function DoShowPlatformHelp()
	return (__wf_atom_992afeea())
end

function DoShowPlatformParty()
	return (ShowPlatformParty())
end

function DoShowPlatformChallenges()
	return (__wf_atom_61307a9e())
end

function DoShowPlatformStore(p)
	local v3 = false

	if
		gClient:__wf_atom_c22da057():__wf_atom_a8ac7109().currentDisplayMode.windowMode == 0
		or not Engine.__wf_atom_6f25c160()
	then
		if not gGameRules:__wf_atom_137430a3() then
			return false, "/Lotus/Language/Menu/Store_NetworkError_Windows"
		end

		if Engine.__wf_atom_84bb79c2() then
			v3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_0013b994(p)
		elseif Engine.__wf_atom_55da63fe() then
			if __wf_atom_a0f6588f:__wf_atom_5f4e19e3(p) then
				v3 = __wf_atom_2683d059(p)
			else
				_ShowMessage("/Lotus/Language/Menu/Store_AlreadyOwned_Switch")
			end
		else
			v3 = __wf_atom_2683d059(p)
		end
	else
		v3 = Engine.__wf_atom_f33803ab(p)
	end

	if v3 then
		return true, ""
	end

	return false, "/Lotus/Language/Menu/Store_NetworkError_Windows"
end

function IsUGCRestricted()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	return not (__wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_18a5d83b:__wf_atom_563ea37f())
end

function GetChatMovie()
	return _G.UIMovie_ChatReduxMovie
end

local function fn20(object, p, flag)
	if __wf_atom_7e8ad928(flag) then
		flag = false
	end

	local __wf_atom_d5a50cb5 = object:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = object:__wf_atom_c4f6543f()
	local __wf_atom_97cd8326 = object:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = object:__wf_atom_54eeda24()
	local x = p.x
	local y = p.y

	if object:__wf_atom_6e4667f6() then
		local __wf_atom_68d996b1 = object:__wf_atom_68d996b1()
		local half__wf_atom_97cd8326 = __wf_atom_97cd8326 / 2
		local half__wf_atom_54eeda24 = __wf_atom_54eeda24 / 2
		local __wf_atom_c1b77578 = object:__wf_atom_c1b77578()

		if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 6 then
			x *= __wf_atom_68d996b1
		elseif __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 7 then
			x = half__wf_atom_97cd8326 + (x - half__wf_atom_97cd8326) * __wf_atom_68d996b1
		elseif __wf_atom_c1b77578 == 2 or __wf_atom_c1b77578 == 5 or __wf_atom_c1b77578 == 8 then
			x = __wf_atom_97cd8326 + (x - __wf_atom_97cd8326) * __wf_atom_68d996b1
		end

		if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 2 then
			y *= __wf_atom_68d996b1
		elseif __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 5 then
			y = half__wf_atom_54eeda24 + (y - half__wf_atom_54eeda24) * __wf_atom_68d996b1
		elseif __wf_atom_c1b77578 == 6 or __wf_atom_c1b77578 == 7 or __wf_atom_c1b77578 == 8 then
			y = __wf_atom_54eeda24 + (y - __wf_atom_54eeda24) * __wf_atom_68d996b1
		end
	end

	local __wf_atom_3dc387fe = object:__wf_atom_3dc387fe()

	if
		__wf_atom_3dc387fe == 0
		or __wf_atom_3dc387fe ~= 2
		and (__wf_atom_d5a50cb5 < __wf_atom_97cd8326 or __wf_atom_c4f6543f < __wf_atom_54eeda24)
	then
		x /= __wf_atom_97cd8326
		y /= __wf_atom_54eeda24
	else
		local __wf_atom_c1b77578 = object:__wf_atom_c1b77578()

		if object:__wf_atom_3dc387fe() == 2 then
			__wf_atom_97cd8326, __wf_atom_54eeda24 = object:__wf_atom_08c20354(__wf_atom_97cd8326, __wf_atom_54eeda24)
			x, y = object:__wf_atom_08c20354(x, y)
		end

		local v3 = __wf_atom_d5a50cb5 - __wf_atom_97cd8326
		local v4 = __wf_atom_c4f6543f - __wf_atom_54eeda24

		if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 6 then
			x /= __wf_atom_d5a50cb5
		elseif __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 7 then
			x = (x + v3 * 0.5) / __wf_atom_d5a50cb5
		elseif __wf_atom_c1b77578 == 2 or __wf_atom_c1b77578 == 5 or __wf_atom_c1b77578 == 8 then
			x = (x + v3) / __wf_atom_d5a50cb5
		end

		if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 2 then
			y /= __wf_atom_c4f6543f
		elseif __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 5 then
			y = (y + v4 * 0.5) / __wf_atom_c4f6543f
		elseif __wf_atom_c1b77578 == 6 or __wf_atom_c1b77578 == 7 or __wf_atom_c1b77578 == 8 then
			y = (y + v4) / __wf_atom_c4f6543f
		end
	end

	if flag then
		x = x * 2 - 1
		y = y * 2 - 1
	end

	return (Vector(x, y, 5))
end

function TransformPixelToViewportCoordinates(p, p2, p3)
	return (fn20(p, p2, p3))
end

local function fn21(object, p, flag)
	if __wf_atom_7e8ad928(flag) then
		flag = false
	end

	local x = p.x
	local y = p.y
	local __wf_atom_d5a50cb5 = object:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = object:__wf_atom_c4f6543f()
	local __wf_atom_97cd8326 = object:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = object:__wf_atom_54eeda24()

	if flag then
		x = (x + 1) / 2
		y = (y + 1) / 2
	end

	local __wf_atom_3dc387fe = object:__wf_atom_3dc387fe()

	if
		__wf_atom_3dc387fe == 0
		or __wf_atom_3dc387fe ~= 2
		and (__wf_atom_d5a50cb5 < __wf_atom_97cd8326 or __wf_atom_c4f6543f < __wf_atom_54eeda24)
	then
		x *= __wf_atom_97cd8326
		y *= __wf_atom_54eeda24
	else
		local __wf_atom_c1b77578 = object:__wf_atom_c1b77578()
		local v3, v4

		if object:__wf_atom_3dc387fe() == 2 then
			v3, v4 = object:__wf_atom_08c20354(__wf_atom_97cd8326, __wf_atom_54eeda24)
		else
			v4 = __wf_atom_54eeda24
			v3 = __wf_atom_97cd8326
		end

		local v5 = __wf_atom_d5a50cb5 - v3
		local v6 = __wf_atom_c4f6543f - v4

		if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 6 then
			x *= __wf_atom_d5a50cb5
		elseif __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 7 then
			x = x * __wf_atom_d5a50cb5 - v5 * 0.5
		elseif __wf_atom_c1b77578 == 2 or __wf_atom_c1b77578 == 5 or __wf_atom_c1b77578 == 8 then
			x = x * __wf_atom_d5a50cb5 - v5
		end

		if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 2 then
			y *= __wf_atom_c4f6543f
		elseif __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 5 then
			y = y * __wf_atom_c4f6543f - v6 * 0.5
		elseif __wf_atom_c1b77578 == 6 or __wf_atom_c1b77578 == 7 or __wf_atom_c1b77578 == 8 then
			y = y * __wf_atom_c4f6543f - v6
		end

		if object:__wf_atom_3dc387fe() == 2 then
			x, y = object:__wf_atom_6efc7cd1(x, y)
		end
	end

	if not object:__wf_atom_6e4667f6() then
		return (Vector(x, y, 5))
	end

	local __wf_atom_68d996b1 = object:__wf_atom_68d996b1()
	local half__wf_atom_97cd8326 = __wf_atom_97cd8326 / 2
	local half__wf_atom_54eeda24 = __wf_atom_54eeda24 / 2
	local __wf_atom_c1b77578 = object:__wf_atom_c1b77578()

	if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 6 then
		x /= __wf_atom_68d996b1
	elseif __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 7 then
		x = (x - half__wf_atom_97cd8326) / __wf_atom_68d996b1 + half__wf_atom_97cd8326
	elseif __wf_atom_c1b77578 == 2 or __wf_atom_c1b77578 == 5 or __wf_atom_c1b77578 == 8 then
		x = (x - __wf_atom_97cd8326) / __wf_atom_68d996b1 + __wf_atom_97cd8326
	end

	if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 2 then
		y /= __wf_atom_68d996b1
	elseif __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 5 then
		y = (y - half__wf_atom_54eeda24) / __wf_atom_68d996b1 + half__wf_atom_54eeda24
	elseif __wf_atom_c1b77578 == 6 or __wf_atom_c1b77578 == 7 or __wf_atom_c1b77578 == 8 then
		y = (y - __wf_atom_54eeda24) / __wf_atom_68d996b1 + __wf_atom_54eeda24
	end

	return (Vector(x, y, 5))
end

function TransformViewportToPixelCoordinates(p, p2, p3)
	return (fn21(p, p2, p3))
end

function GetScreenBasedPosition(object, p)
	return object:__wf_atom_5e6e15c8(p, 2), (object:__wf_atom_5e6e15c8(p, 3))
end

function ConvertToScreenPosition(object, p)
	local v3 = TransformPixelToViewportCoordinates(object, p)
	return Vector(v3.x * object:__wf_atom_d5a50cb5(), v3.y * object:__wf_atom_c4f6543f(), 0)
end

local function fn22(object, p, p2)
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 2)
	local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(p, 3)
	local v3, v4

	if p2 then
		v3 = 0
		v4 = 0
	else
		v3 = object:__wf_atom_5e6e15c8("_root", 0)
		v4 = object:__wf_atom_5e6e15c8("_root", 1)
	end

	if __wf_atom_5e6e15c8 == nil or v3 == nil then
		return 0, 0
	end

	return __wf_atom_5e6e15c8 - v3, __wf_atom_5e6e15c8_2 - v4
end

function GetRootBasedPosition(p, p2, p3)
	return fn22(p, p2, p3)
end

local function fn23(object, p, p2, object2, p3)
	local __wf_atom_c35fbccd = object2:__wf_atom_c35fbccd()

	if __wf_atom_c35fbccd == 0 then
		__wf_atom_c35fbccd = object:__wf_atom_d5a50cb5() / object:__wf_atom_c4f6543f()
	end

	local v3 = math.tan((fn5((p3 == nil and 20 or p3) * 0.5)))
	local v4 = v3 * __wf_atom_c35fbccd
	local v5 = fn20(object, { x = p, y = p2, z = 0 }, true)
	return v5.x * v4, -v5.y * v3
end

function GetScreenParticlesCoord(p, p2, p3, p4, p5)
	return fn23(p, p2, p3, p4, p5)
end

local function fn24(object, p, p2, p3, gRegion2, p4, p5, p6)
	local v3 = nil

	if
		__wf_atom_7e8ad928(p)
		or not p6 and (object:__wf_atom_5e6e15c8("_root", 12) == 0 or not object:IsVisible())
		or __wf_atom_7e8ad928(_T.BackgroundMovie) and not __wf_atom_7e8ad928(_T.pauseMenuOpen) and _T.pauseMenuOpen
	then
		return v3
	end

	if gRegion2 == nil then
		gRegion2 = gRegion
	end

	if __wf_atom_7e8ad928(gRegion2) then
		return v3
	end

	local gameCamera = gRegion2:GetGameCamera()

	if
		__wf_atom_7e8ad928(gameCamera)
		or not (object:DrawOverCinematics() or __wf_atom_7e8ad928(gRegion2:__wf_atom_c3b255b8()))
	then
		return v3
	end

	if not __wf_atom_7e8ad928(object) then
		p2, p3 = fn23(object, p2, p3, gameCamera)
	end

	local v4 = p4 == nil and 0 or p4
	return (gameCamera:Attach(p, EMPTY_SYMBOL, Vector(p2, p3, 1 + v4), p5 or Rotation()))
end

function CreateScreenParticles(p, p2, p3, p4, p5, p6, p7, p8)
	return fn24(p, p2, p3, p4, p5, p6, p7, p8)
end

function CreateParticles(p, p2, p3, p4, p5, p6, p7, p8, p9)
	local v3 = p4 == nil and 0 or p4
	local v4 = p5 == nil and 0 or p5
	local v5, v6 = fn22(p, p2, true)

	if v5 == nil or v6 == nil then
		return nil
	end

	return fn24(p, p3, v5 + v3, v6 + v4, p6, p7, p8, p9)
end

function CreateParticlesOnMouse(object, p, p2, p3, p4, p5, p6, p7)
	local v3 = p2 == nil and 0 or p2
	local v4 = p3 == nil and 0 or p3
	return fn24(
		object,
		p,
		object:__wf_atom_5e6e15c8("_root", 30) + v3,
		object:__wf_atom_5e6e15c8("_root", 31) + v4,
		p4,
		p5,
		p6,
		p7
	)
end

function CreateUIParticles(mMovie, mClipName, mFx, p, p2, gRegion2, p3, p4, mRotation, p5)
	if
		__wf_atom_7e8ad928(mFx)
		or (mMovie:__wf_atom_5e6e15c8("_root", 12) == 0 or not mMovie:IsVisible()) and not p3
	then
		return nil
	end

	if gRegion2 == nil then
		gRegion2 = gRegion
	end

	if __wf_atom_7e8ad928(gRegion2) then
		return nil
	end

	local v3 = {
		mMovie = mMovie,
		mRegion = gRegion2,
		mClipName = mClipName,
		mFx = mFx,
		mOffsetX = p == nil and 0 or p,
		mOffsetY = p2 == nil and 0 or p2,
		mRotation = mRotation,
		mDesiredVisibility = true,
		CameraEntity = gRegion2:GetGameCamera(),
		mCameraRelative = p5 or false
	}

	if __wf_atom_7e8ad928(v3.CameraEntity) then
		v3.mInstance = gRegion2:CreateEntity(v3.mFx, __wf_atom_28d5d4aa, Rotation(0, 45, 0))
	else
		v3.mInstance = gRegion2:CreateEntity(v3.mFx, v3.CameraEntity:GetPosition(), Rotation(0, 45, 0))
	end

	v3.mVisible = true

	if __wf_atom_7e8ad928(v3.mInstance) then
		print("ERROR: Failed to CreateUIParticles clipname=" .. tostring(mClipName))
		return nil
	end

	function v3:Update(_, p6)
		local mVisible = self.mMovie:IsVisible() and self.mMovie:__wf_atom_5e6e15c8("_root", 12) > 0

		if self.mVisible ~= mVisible then
			self.mVisible = mVisible
			self:SetVisibility(self.mVisible, true)
		end

		if not __wf_atom_7e8ad928(self.mInstance) then
			local mDiegetic = self.mDiegetic
			self.mDiegetic = not p4 and self.mMovie:__wf_atom_a224b472()

			if self.mDiegetic ~= mDiegetic then
				if self.DiegeticChangeCallback ~= nil then
					self:DiegeticChangeCallback()
				end

				self.mInstance:__wf_atom_ee6085fe(not self.mDiegetic)
				self.mInstance:__wf_atom_b45f070e(self.mDiegetic)
			end

			local x = 0
			local y = 0

			if p6 == nil then
				if p4 then
					x = self.mMovie:__wf_atom_97cd8326() / 2
					y = self.mMovie:__wf_atom_54eeda24() / 2
				elseif self.mClipName ~= nil then
					x, y = fn22(self.mMovie, self.mClipName, true)
				end
			else
				x = p6.X
				y = p6.Y
			end

			local v4 = x + self.mOffsetX
			local v5 = y + self.mOffsetY

			if self.mDiegetic then
				local __wf_atom_09e83ac4 = self.mMovie:__wf_atom_09e83ac4(v4, v5)
				self.mInstance:SetPosition(__wf_atom_09e83ac4)
			else
				if __wf_atom_7e8ad928(v3.CameraEntity) then
					print("ERROR: There wasnt a valid pRegion:GetGameCamera()")
					return nil
				end

				local v6, v7 = fn23(self.mMovie, v4, v5, v3.CameraEntity)
				local v8 = Vector(v6, v7, 1)
				self.mInstance:AttachToInPlace(v3.CameraEntity, EMPTY_SYMBOL)
				self.mInstance:__wf_atom_e310f01f(v8, __wf_atom_80368bb1)

				if self.mCameraRelative then
					local v9 = Vector(v6, v7, 0)
					Effects.__wf_atom_77d11fb4(self.mInstance, v9)
				end
			end

			self.mInstance:__wf_atom_e424c72a(true)

			if self.mRotation ~= nil and self.mInstance:IsA(__wf_atom_8939e086) then
				self.mInstance:__wf_atom_de8fbee6(self.mRotation, self.mRotation)
			end
		end
	end

	function v3:SetVisibility(mDesiredVisibility, p6)
		if not p6 then
			self.mDesiredVisibility = mDesiredVisibility
		end

		if mDesiredVisibility or __wf_atom_7e8ad928(self.mInstance) then
			if
				mDesiredVisibility
				and self.mDesiredVisibility
				and __wf_atom_7e8ad928(self.mInstance)
				and not __wf_atom_7e8ad928(self.mRegion)
			then
				self.mInstance = self.mRegion:CreateEntity(v3.mFx, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		else
			self.mRegion:__wf_atom_dd1e4d10(self.mInstance)
			self.mInstance = nil
		end
	end

	function v3:Destroy()
		if not __wf_atom_7e8ad928(self.mInstance) then
			self.mRegion:__wf_atom_dd1e4d10(self.mInstance)
			self.mInstance = nil
		end
	end

	v3:Update(0)
	return v3
end

function ShowYesOrNoMessage(locString, p, firstDelay, titleString)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = locString

	if titleString then
		dialogSettings.titleString = titleString
	end

	dialogSettings.firstString = "/Menu/Confirm_Item_Yes"
	dialogSettings.secondString = "/Menu/Confirm_Item_No"

	if firstDelay then
		dialogSettings.firstDelay = firstDelay
	end

	dialogSettings:SetCallback(p)
	return (gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings))
end

function ShowConfirmMessage(locString, p, firstDelay, titleString)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = locString

	if titleString then
		dialogSettings.titleString = titleString
	end

	if firstDelay then
		dialogSettings.firstDelay = firstDelay
	end

	dialogSettings:SetCallback(p)
	return (gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings))
end

function ShowTwoOptionMessage(locString, p, firstDelay, titleString, firstString, secondString)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = locString

	if titleString then
		dialogSettings.titleString = titleString
	end

	dialogSettings.firstString = firstString
	dialogSettings.secondString = secondString

	if firstDelay then
		dialogSettings.firstDelay = firstDelay
	end

	dialogSettings:SetCallback(p)
	return (gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings))
end

local function fn25(locString)
	local v3 = string.find(locString, "/", 1, true)
	local v4 = string.find(locString, " ", 1, false)

	if not __wf_atom_7e8ad928(v3) and v3 == 1 and __wf_atom_7e8ad928(v4) and not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_24ce2091(locString)
	end
end

function _ShowMessage(locString, p, value, disableLocalization)
	fn25(locString)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = value or 0
	dialogSettings.locString = locString

	if __wf_atom_7e8ad928(disableLocalization) then
		disableLocalization = false
	end

	dialogSettings.disableLocalization = disableLocalization

	if p ~= nil then
		dialogSettings:SetCallback(p)
	end

	return (gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings))
end

function ShowMessage(p, p2, p3, p4)
	return (_ShowMessage(p, p2, p3, p4))
end

function ShowErrorMessage(locString, p, value, p2, p3)
	fn25(locString)
	local v3 = fn2(__wf_atom_7e8ad928(p3), _T.BackgroundMovie, p3)

	if not __wf_atom_7e8ad928(v3) then
		local __wf_atom_8e9ac384 = v3:__wf_atom_8e9ac384(" <BIG_PROBLEM> \n\r", true)

		if p2 then
			locString = __wf_atom_8e9ac384 .. locString
		else
			locString = __wf_atom_8e9ac384 .. v3:__wf_atom_8e9ac384(locString, true)
		end
	end

	fn(_G.UISound_Error)
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = value or 0
	dialogSettings.locString = locString
	dialogSettings.disableLocalization = not __wf_atom_7e8ad928(v3) or p2 == true

	if p ~= nil then
		dialogSettings:SetCallback(p)
	end

	return (gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings))
end

function ShowCustomMessage(p)
	fn25(p.locString)
	return (gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(p))
end

function RepositionCallouts(object, list)
	if Engine.IsPlayingWithController() then
		local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(list[1] .. ".Callout", 0)

		for i = 2, #list do
			local v3 = tonumber(object:__wf_atom_76657dba(list[i - 1] .. ".Callout.Label", "textWidth")) + 10
			object:__wf_atom_4c1c1986(list[i], "Callout", 0, __wf_atom_5e6e15c8 + v3)
			__wf_atom_5e6e15c8 += v3
		end
	end
end

function AttachFunctionToEnvironment(p, p2, callback)
	local v3 = p2

	while p["Prev_" .. v3] ~= nil do
		v3 = "Prev_" .. v3
	end

	p["Prev_" .. v3] = p[p2]

	if p["Prev_" .. v3] == nil then
		p[p2] = callback
	else
		p[p2] = function(...)
			setfenv(1, p)
			p["Prev_" .. v3](...)
			callback(...)
		end
	end
end

function HookUpEnvironmentCallback(p, p2, p3, p4)
	local v3 = "REMAPPED_" .. p3

	if p2[v3] == nil then
		p2[v3] = {}
		local v4 = "ORIGINAL_" .. p3

		if p2[p3] ~= nil then
			p2[v4] = p2[p3]
		end

		p2[p3] = function(...)
			setfenv(1, p2)

			for _, v5 in pairs(p2[v3]) do
				if v5[1](...) then
					return true
				end
			end

			if p2[v4] ~= nil then
				p2[v4](...)
			end
		end
	end

	p2[v3][p] = { p4 }
end

local function fn26(value)
	return string.find(value, "ERROR_INTERNET_") ~= nil
		or string.find(value, "ERROR_HTTP_") ~= nil
		or string.find(value, "HttpSendRequest failed") ~= nil
		or string.find(value, "HTTPRequest wait failed") ~= nil
		or string.find(value, "HTTPRequest::Open failed") ~= nil
		or string.find(value, "HTTPRequest::Send failed") ~= nil
		or string.find(value, "HTTP error") ~= nil
		or string.find(value, "OpenSSL") ~= nil
end

function IsConnectionErrorMsg(p)
	return fn26(p)
end

local function fn27(value)
	print(value)

	if fn26(value) then
		return "/Lotus/Language/Menu/SocialOverlay_NoConnectionError"
	end

	if string.find(value, "Authentication failure") ~= nil then
		return "/Lotus/Language/Menu/CraftingErrorText_AuthenticationFailed"
	end

	if string.find(value, "Log-in expired") ~= nil then
		return "/Lotus/Language/Menu/ConnectionError_LoginExpired"
	end

	if string.find(value, "Guild does not exist") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_NonExistentGuildError"
	end

	if string.find(value, "does not exist") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_NonExistentUserError"
	end

	if string.find(value, "is ignoring you") ~= nil then
		return "/Lotus/Language/Menu/Chat_PlayerIgnoringYou"
	end

	if not (string.find(value, "User is already in a guild") == nil and string.find(value, "User already invited to clan") == nil) then
		return "/Lotus/Language/Menu/SocialOverlay_UserAlreadyInGuildError"
	end

	if string.find(value, "User is not in a guild") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_UserNotInGuildError"
	end

	if string.find(value, "Invalid permission") ~= nil then
		return "/Lotus/Language/Dojo/Generic_INVALID_PERMISSION"
	end

	if string.find(value, "Guild has no member with id") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_UserNotInGuildError"
	end

	if string.find(value, "Guild name already in use") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_GuildNameAlreadyInUseError"
	end

	if string.find(value, "Alliance name already in use") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_AllianceNameAlreadyInUseError"
	end

	if string.find(value, "Already invited to alliance") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_GuildAlreadyInvitedToAllianceError"
	end

	if string.find(value, "Guild is already in an alliance") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_GuildAlreadyInAllianceError"
	end

	if string.find(value, "No pending alliance invitation.") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_NotInAllianceError"
	end

	if string.find(value, "Service Unavailable") ~= nil then
		return "/Lotus/Language/Menu/Profile_FailedToConnect"
	end

	if string.find(value, "Connection attempt timed out.") ~= nil then
		return "/Lotus/Language/Game/Connection_attempt_timed_out"
	end

	if string.find(value, "Bad server port-range") ~= nil then
		return "/Lotus/Language/Game/Bad_server_port_range"
	end

	if string.find(value, "Disconnected") ~= nil then
		return "/Lotus/Language/Game/DisconnectedMsg"
	end

	if string.find(value, "RESTRICTED_CLAN_NAME") ~= nil then
		return "/Lotus/Language/Clan/Clan_Name_Profanity_Error"
	end

	if string.find(value, "Cannot add self as a Friend") == nil then
		return "/Lotus/Language/Menu/SocialOverlay_NoConnectionError"
	end

	return "/Lotus/Language/Menu/SocialOverlay_FriendAddSelfError"
end

function ParseConnectionErrorMsg(p)
	return fn27(p)
end

function ParseAddFriendErrorMsg(value)
	if #value == 0 then
		return "/Lotus/Language/Menu/SocialOverlay_NonExistentUserError"
	end

	if string.find(value, "Friend Invite Restriction") ~= nil then
		return "/Lotus/Language/Game/Friend_Invite_Restriction"
	end

	if string.find(value, "Player has too many friends") ~= nil then
		return "/Lotus/Language/Game/TooManyFriends"
	end

	if string.find(value, "Target player has too many friends") ~= nil then
		return "/Lotus/Language/Game/TargetTooManyFriends"
	end

	if string.find(value, "Account Suspended") ~= nil then
		return "/Lotus/Language/CustomerSupport/CompromisedAccountGenericMessage"
	end

	if string.find(value, "Already a friend") ~= nil then
		return (string.sub(value, 17))
	end

	if string.find(value, "Added a blocked Xbox player") ~= nil then
		return "/Lotus/Language/Menu/SocialOverlay_AddBlockedPlayerError"
	end

	if string.find(value, "PLATFORM_MISMATCH") ~= nil then
		return (string.sub(value, 18))
	end

	local v3 = string.find(value, "user ")
	local v4 = string.find(value, "already in ")

	if v3 and v4 and v3 < v4 then
		local name = string.sub(value, v3 + 5, v4 - 1)
		return (Localize("/Lotus/Language/Menu/SocialOverlay_AlreadyFriendError", { NAME = name }))
	else
		return (fn27(value))
	end
end

function ParseAddToGuildErrorMsg(value)
	local v3

	if value == "1" then
		v3 = "/Lotus/Language/Menu/ClanCreationItemRequired"
	elseif value == "MAX_SIZE" then
		local __wf_atom_76f14d30 = gGameData:__wf_atom_76f14d30()

		if __wf_atom_76f14d30 >= 1000 then
			v3 = "/Lotus/Language/Menu/GuildSizeCap5"
		elseif __wf_atom_76f14d30 >= 300 then
			v3 = "/Lotus/Language/Menu/GuildSizeCap4"
		elseif __wf_atom_76f14d30 >= 100 then
			v3 = "/Lotus/Language/Menu/GuildSizeCap3"
		elseif __wf_atom_76f14d30 >= 30 then
			v3 = "/Lotus/Language/Menu/GuildSizeCap2"
		else
			v3 = "/Lotus/Language/Menu/GuildSizeCap1"
		end
	elseif string.find(value, "Invite restricted") then
		v3 = "/Lotus/Language/Menu/SocialOverlay_UserGuildInviteRestricted"
	elseif string.find(value, "Account Suspended") then
		v3 = "/Lotus/Language/CustomerSupport/CompromisedAccountGenericMessage"
	elseif string.find(value, "Already requested") then
		v3 = "/Lotus/Language/Clan/JoinClanAlreadyRequested"
	elseif string.find(value, "Already pending") then
		v3 = "/Lotus/Language/Clan/CheckPendingTab"
	elseif string.find(value, "Request limit") then
		v3 = "/Lotus/Language/Clan/TooManyJoinClanRequests"
	elseif string.find(value, "Has invite") then
		v3 = "/Lotus/Language/Clan/JoinClanHasInvite"
	elseif string.find(value, "Must be tutored") then
		v3 = "/Lotus/Language/Clan/UntutoredAccount"
	elseif string.find(value, "PLATFORM_MISMATCH") == nil then
		v3 = string.find(value, "Crossplatform disallowed")
			and "/Lotus/Language/Multiplayer/SocialOverlay_InviteFailCrossPlatformMismatch"
			or string.find(value, "User has kicked status") and "/Lotus/Language/Clan/CannotInviteKickedPlayer"
			or fn27(value)
	else
		v3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_bdc99e61()
			and "/Lotus/Language/Multiplayer/SocialOverlay_InviteFailCrossPlatformMismatch"
			or "/Lotus/Language/Multiplayer/SocialOverlay_GuildPlatformMismatch"
	end

	return value == v3 and "/Lotus/Language/Menu/PurchaseFailure_UnknownError" or v3
end

function ShouldMoveIntoTitleSafe()
	return Engine.__wf_atom_6d151271()
		or Engine.__wf_atom_703b1471()
		or Engine.__wf_atom_84bb79c2()
		or Engine.__wf_atom_55da63fe()
end

local function fn28(p, value, p2)
	if __wf_atom_15748473() then
		return 0
	end

	local v3 = "A-Za-z0-9_.\\-"

	if value ~= nil then
		v3 ..= value
	end

	if not p2 and (value == nil or string.find(value, " ") == nil) then
		v3 ..= " "
	end

	if __wf_atom_d9227398() then
		v3 ..= "\\u4E00-\\u9FCC\\u3400-\\u4DB5"
	end

	return (__wf_atom_932a80f8(p, v3))
end

function GetInvalidNameCharacters(p, p2)
	return fn28(p, p2, false)
end

function GetInvalidNewAccountNameCharacters(p, p2)
	return fn28(p, p2, true)
end

function ValidateName(list, value, list2)
	if #list == 0 and #list2 ~= 0 then
		return Localize(list2, nil)
	end

	local v3 = fn28(list, " &")

	if v3 > 0 then
		return Localize("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", nil) .. " " .. __wf_atom_f50c9d2d(list, v3, v3)
	end

	if __wf_atom_f8f86fc5(list, 1) == list then
		return nil
	end

	return Localize(value or "/Lotus/Language/Menu/Name_Profanity_Error", nil)
end

function ConvertColorNumberToHex(p)
	return "#" .. string.format("%06X", p)
end

function ConvertColorNumberToProceduralRGB(p)
	local v3 = fn8(p)
	return {
		r = v3.r / 255,
		g = v3.g / 255,
		b = v3.b / 255
	}
end

function ConvertHEX2RGB255(p)
	local v3 = fn8(p)
	return (Color(v3.r, v3.g, v3.b, 255))
end

function StringFindLast(value, p)
	local match = value:match(".*" .. p .. "()")

	if match == nil then
		return nil
	end

	return match - 1
end

function ConvertToRoman(p)
	if fn3({
		"_en",
		"_fr",
		"_it",
		"_de",
		"_es",
		"_pt",
		"_ru",
		"_pl",
		"_uk"
	}, __wf_atom_b953295d():c_str()) == -1 then
		return p
	end

	local v3 = ""

	while p >= 1000 do
		v3 ..= "M"
		p -= 1000
	end

	local v4 = v3 .. ({
		"",
		"C",
		"CC",
		"CCC",
		"CD",
		"D",
		"DC",
		"DCC",
		"DCCC",
		"CM"
	})[math.floor(p / 100) + 1]
	local v5 = p % 100
	return (v4 .. ({
		"",
		"X",
		"XX",
		"XXX",
		"XL",
		"L",
		"LX",
		"LXX",
		"LXXX",
		"XC"
	})[math.floor(v5 / 10) + 1]) .. ({
		"",
		"I",
		"II",
		"III",
		"IV",
		"V",
		"VI",
		"VII",
		"VIII",
		"IX"
	})[v5 % 10 + 1]
end

function RaySphereIntersection(p, p2, p3, p4)
	local v3 = 2 * Length(p2) ^ 2
	local v4 = 2 * Dot(p2, p - p3)
	local v5 = Length(p3) ^ 2 + Length(p) ^ 2 - 2 * Dot(p3, p) - p4 ^ 2
	local v6 = v4 ^ 2 - 2 * v3 * v5
	return v6 >= 0 and v4 < 0 and p + p2 * ((-math.sqrt(v6) - v4) / v3)
end

local function fn29(value)
	for _, v3 in ipairs({
		"(",
		")",
		".",
		"+",
		"-",
		"*",
		"?",
		"[",
		"^",
		"$"
	}) do
		value = string.gsub(value, "%" .. v3, "%%" .. v3)
	end

	return (string.gsub(value, "%%", "%%%%"))
end

function EscapeMagicCharacters(p)
	return (fn29(p))
end

function SanitizeTextForHTML(value)
	local v3 = string.gsub(value, "<", "&lt;")
	local v4 = string.gsub(v3, ">", "&gt;")
	return (string.gsub(v4, "\r([^\n])", "\r\n%1"))
end

local function fn30(object)
	local v3 = object:__wf_atom_a224b472() and 1 or 1 / object:__wf_atom_68d996b1()
	local v4 = object:__wf_atom_97cd8326() * v3
	local v5 = object:__wf_atom_54eeda24() * v3
	local v6 = object:__wf_atom_d5a50cb5() * v3
	local v7 = object:__wf_atom_c4f6543f() * v3
	local v8 = v6 / v4
	local v9 = v7 / v5
	local v10 = 1
	local v11 = 1

	if object:__wf_atom_3dc387fe() ~= 2 then
		return v10, v11
	end

	if v8 < v9 then
		return v10, v5 * v8 / v7
	end

	if v9 < v8 then
		v10 = v4 * v9 / v6
	end

	return v10, v11
end

function GetStageProp(p)
	return fn30(p)
end

function GetVisibilityCenter(object, p, p2)
	local v3 = object:__wf_atom_a224b472() and 1 or object:__wf_atom_68d996b1()
	local v4 = p / fn2(p2, object:__wf_atom_97cd8326(), object:__wf_atom_54eeda24())
	local v5 = 1
	local __wf_atom_c1b77578 = object:__wf_atom_c1b77578()
	local v6, v7 = fn30(object)

	if p2 then
		if __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 7 then
			return 0.5 + (v4 - 0.5) * v3 * v6
		end

		if __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 6 then
			return v4 * v3 * v6
		end

		if __wf_atom_c1b77578 == 5 or __wf_atom_c1b77578 == 2 or __wf_atom_c1b77578 == 8 then
			return 1 + (v4 - 1) * v3 * v6
		end
	else
		if __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 5 then
			return 0.5 + (v4 - 0.5) * v3 * v7
		end

		if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 2 then
			return v4 * v3 * v7
		end

		if __wf_atom_c1b77578 == 6 or __wf_atom_c1b77578 == 7 or __wf_atom_c1b77578 == 8 then
			return 1 + (v4 - 1) * v3 * v7
		end
	end

	return v5
end

function GetVisibilitySize(object, p, p2)
	local v3 = object:__wf_atom_a224b472() and 1 or 1 / object:__wf_atom_68d996b1()
	local v4, v5 = fn30(object)
	return p / (fn2(p2, object:__wf_atom_97cd8326(), object:__wf_atom_54eeda24()) * v3) * fn2(p2, v4, v5)
end

function GetVisibilityFadeSize(p, p2, p3)
	return GetVisibilitySize(p, p2, p3)
end

function GetScreenDimensions(object)
	local __wf_atom_3dc387fe = object:__wf_atom_3dc387fe()
	local __wf_atom_d5a50cb5 = object:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = object:__wf_atom_c4f6543f()
	local __wf_atom_97cd8326 = object:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = object:__wf_atom_54eeda24()

	if __wf_atom_3dc387fe == 2 then
		local v3 = __wf_atom_d5a50cb5 / __wf_atom_97cd8326
		local v4 = __wf_atom_c4f6543f / __wf_atom_54eeda24

		if v3 < v4 then
			__wf_atom_54eeda24 = fn6(__wf_atom_c4f6543f * (1 / v3))
		elseif v4 < v3 then
			__wf_atom_97cd8326 = fn6(__wf_atom_d5a50cb5 * (1 / v4))
		end
	else
		__wf_atom_97cd8326 = math.max(__wf_atom_d5a50cb5, __wf_atom_97cd8326)
		__wf_atom_54eeda24 = math.max(__wf_atom_c4f6543f, __wf_atom_54eeda24)
	end

	if object:__wf_atom_6e4667f6() then
		__wf_atom_97cd8326 *= 1 / object:__wf_atom_68d996b1()
		__wf_atom_54eeda24 *= 1 / object:__wf_atom_68d996b1()
	end

	return __wf_atom_97cd8326, __wf_atom_54eeda24
end

function GetProportionalScale(object)
	local __wf_atom_97cd8326 = object:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = object:__wf_atom_54eeda24()
	local __wf_atom_08c20354, v3 = object:__wf_atom_08c20354(__wf_atom_97cd8326, __wf_atom_54eeda24)
	local v4 = __wf_atom_97cd8326 / object:__wf_atom_d5a50cb5()
	local v5 = __wf_atom_54eeda24 / object:__wf_atom_c4f6543f()
	local v6 = __wf_atom_08c20354 / __wf_atom_97cd8326
	local v7 = v3 / __wf_atom_54eeda24
	return v4 * v6 * 100, v5 * v7 * 100
end

function BlinkClip(object, p, p2, p3)
	local v3 = p2 == nil and 1 or p2
	local v4 = p3 == nil and 3 or p3
	__wf_atom_ec43d06e(object, p, 0, { function(p4)
			object:__wf_atom_e57658c2(p, 12, math.abs((math.cos(p4 * 3.1415927410125732 * v4))) * 70 + 30)
		end }, { 1 }, v3)
end

function MoveClipPosition(object, p, p2, p3)
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 0)
	local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(p, 1)

	if not __wf_atom_7e8ad928(p2) then
		object:__wf_atom_e57658c2(p, 0, __wf_atom_5e6e15c8 + p2)
	end

	if not __wf_atom_7e8ad928(p3) then
		object:__wf_atom_e57658c2(p, 1, __wf_atom_5e6e15c8_2 + p3)
	end
end

function SetClipScale(object, p, p2, p3)
	if __wf_atom_7e8ad928(p3) then
		p3 = p2
	end

	object:__wf_atom_e57658c2(p, 5, p2)
	object:__wf_atom_e57658c2(p, 6, p3)
end

function GetClipScale(object, p)
	return {
		x = object:__wf_atom_5e6e15c8(p, 5),
		y = object:__wf_atom_5e6e15c8(p, 6)
	}
end

function GetClipPosition(object, p)
	return object:__wf_atom_5e6e15c8(p, 0), (object:__wf_atom_5e6e15c8(p, 1))
end

function SetClipPosition(object, p, p2, p3)
	object:__wf_atom_e57658c2(p, 0, p2)
	object:__wf_atom_e57658c2(p, 1, p3)
end

function GetClipSize(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	else
		return object:__wf_atom_5e6e15c8(p, 14), (object:__wf_atom_5e6e15c8(p, 15))
	end
end

function SetClipSize(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_e57658c2(p, 14, p2)
	object:__wf_atom_e57658c2(p, 15, p3)
end

local function fn31(object, value)
	local result = {
		xTranslate = 0,
		yTranslate = 0,
		xScale = 1,
		yScale = 1,
		Apply = function(self, p, p2)
			return p * self.xScale + self.xTranslate, p2 * self.yScale + self.yTranslate
		end
	}

	if value == nil then
		return result
	end

	local v3 = StringSplit(".", value)

	for i = #v3, 1, -1 do
		local v4 = object:__wf_atom_5e6e15c8(value, 5) / 100
		local v5 = object:__wf_atom_5e6e15c8(value, 6) / 100
		result.xTranslate = result.xTranslate * v4 + object:__wf_atom_5e6e15c8(value, 0)
		result.yTranslate = result.yTranslate * v5 + object:__wf_atom_5e6e15c8(value, 1)
		result.xScale *= v4
		result.yScale *= v5
		value = value:sub(1, #value - #v3[i] - 1)
	end

	local v4 = object:__wf_atom_5e6e15c8("_root", 5) / 100
	local v5 = object:__wf_atom_5e6e15c8("_root", 6) / 100
	result.xTranslate = result.xTranslate * v4 + object:__wf_atom_5e6e15c8("_root", 0)
	result.yTranslate = result.yTranslate * v5 + object:__wf_atom_5e6e15c8("_root", 1)
	result.xScale *= v4
	result.yScale *= v5
	return result
end

function GetTransformToGlobal(p, p2)
	return fn31(p, p2)
end

function TransformPositionToGlobal(p, p2, p3, p4)
	if p2 ~= nil then
		p3, p4 = fn31(p, p2):Apply(p3, p4)
	end

	return p3, p4
end

local function fn32(object, p)
	local result = {
		xTranslate = 0,
		yTranslate = 0,
		xScale = 1,
		yScale = 1,
		Apply = function(self, p2, p3)
			return p2 * self.xScale - self.xTranslate, p3 * self.yScale - self.yTranslate
		end
	}

	if p == nil then
		return result
	end

	local v3 = StringSplit(".", p)
	local v4 = object:__wf_atom_5e6e15c8("_root", 5) / 100
	local v5 = object:__wf_atom_5e6e15c8("_root", 6) / 100
	result.xTranslate = result.xTranslate * v4 + object:__wf_atom_5e6e15c8("_root", 0)
	result.yTranslate = result.yTranslate * v5 + object:__wf_atom_5e6e15c8("_root", 1)
	result.xScale *= v4
	local v6 = ""

	for i = 1, #v3 do
		local v7 = v6 .. v3[i]
		local v8 = object:__wf_atom_5e6e15c8(v7, 5) / 100
		local v9 = object:__wf_atom_5e6e15c8(v7, 6) / 100
		result.xTranslate = (result.xTranslate + object:__wf_atom_5e6e15c8(v7, 0)) / v8
		result.yTranslate = (result.yTranslate + object:__wf_atom_5e6e15c8(v7, 1)) / v9
		result.xScale /= v8
		result.yScale /= v9
		v6 = v7 .. "."
	end

	return result
end

function GetTransformToLocal(p, p2)
	return fn32(p, p2)
end

function TransformPositionToLocal(p, p2, p3, p4)
	if p2 ~= nil then
		p3, p4 = fn32(p, p2):Apply(p3, p4)
	end

	return p3, p4
end

function SplitChildClipName(p)
	local v3 = StringSplit(".", p)
	return table.remove(v3, #v3), table.concat(v3, ".")
end

local function fn33()
	local pc = PLATFORM.PC

	if Engine.__wf_atom_b6edc589() then
		return PLATFORM.TOUCH
	end

	if Engine.__wf_atom_6d151271() then
		return PLATFORM.PS5
	end

	if Engine.__wf_atom_703b1471() then
		return PLATFORM.PS4
	end

	if Engine.__wf_atom_b290ec01() then
		return PLATFORM.SWITCH
	end

	if Engine.__wf_atom_b9407cac() then
		return PLATFORM.SWITCH2
	end

	if Engine.__wf_atom_84bb79c2() then
		return PLATFORM.XBOX_ONE
	end

	if Engine.__wf_atom_5f0554d9() then
		pc = PLATFORM.BIG_PIC
	end

	return pc
end

function GetPlatform()
	return fn33()
end

local function fn34(p)
	if p == PLATFORM.PC then
		return "PC"
	end

	if p == PLATFORM.TOUCH then
		return "Touch"
	end

	if p == PLATFORM.PS5 then
		return "PS5"
	end

	if p == PLATFORM.PS4 then
		return "PS4"
	end

	if p == PLATFORM.XBOX_ONE then
		return "XBone"
	end

	if not (p ~= PLATFORM.SWITCH and p ~= PLATFORM.SWITCH2) then
		return "Switch"
	end

	return p == PLATFORM.BIG_PIC and "BigPic" or ""
end

function GetPlatformString(p)
	if __wf_atom_7e8ad928(p) then
		p = fn33()
	end

	return fn34(p)
end

function IsMobileUI()
	return Engine.__wf_atom_b6edc589() or Engine.__wf_atom_5a538075()
end

local v3 = Symbol("ScalingPercent")

function ScaleSlicedMaterialsRatio(p, items)
	for _, item in pairs(items) do
		if not __wf_atom_7e8ad928(item) then
			item:__wf_atom_a042ff6c(v3, p)
		end
	end
end

function ScaleSlicedMaterials(backgroundMovie, p)
	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		backgroundMovie = _T.BackgroundMovie
	end

	if not __wf_atom_7e8ad928(backgroundMovie) then
		ScaleSlicedMaterialsRatio(
			math.min(
				backgroundMovie:__wf_atom_d5a50cb5() / backgroundMovie:__wf_atom_97cd8326(),
				backgroundMovie:__wf_atom_c4f6543f() / backgroundMovie:__wf_atom_54eeda24()
			),
			p
		)
	end
end

function ScaleVisRangeMaterials(p, p2, p3, p4, items, value)
	local v4 = GetVisibilityCenter(p, p2, p4)
	local v5 = GetVisibilitySize(p, p3, p4)
	local v6 = GetVisibilityFadeSize(p, value or 20)

	for _, item in pairs(items) do
		item:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, v4)
		item:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, v5)
		item:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, v6)
	end
end

function ScaleClipVisRangeMaterials(object, p, p2, p3, p4)
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, p2 and 2 or 3)
	local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(p, p2 and 14 or 15)
	ScaleVisRangeMaterials(object, __wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2, p2, p3, p4)
end

function GetSanitizedLevelName(value, p)
	local v4 = "an error occurred while parsing " .. value .. ": "
	local v5 = {}
	local v6 = nil

	for k in string.gmatch(value, "([^/]+)") do
		table.insert(v5, k)
	end

	if #v5 == 0 then
		print(v4 .. "could not parse full level name!")
		return v6
	end

	local v7 = v5[#v5]
	local v8 = {}

	for k in string.gmatch(v7, "([^.]+)") do
		table.insert(v8, k)
	end

	if #v8 == 2 then
		local v9 = v8[#v8]

		if v9 == "lp" then
			return (string.gsub(value, "/" .. v7, ""))
		elseif v9 == "level" then
			return (string.gsub(value, "." .. "level", ""))
		end

		print(v4 .. "unexpected file extension!")
		return v6
	else
		if p and #v8 == 1 and #v8[1] > 0 then
			return value
		end

		print(v4 .. "could not parse level name and extension!")
		return v6
	end
end