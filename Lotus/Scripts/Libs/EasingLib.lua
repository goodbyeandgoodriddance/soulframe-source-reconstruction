module(..., package.seeall)
local pow = math.pow
local sin = math.sin
local cos = math.cos
local sqrt = math.sqrt
local abs = math.abs
local asin = math.asin

function linear(p, p2, p3, p4)
	return p3 * p / p4 + p2
end

function inQuad(p, p2, p3, p4)
	return p3 * pow(p / p4, 2) + p2
end

function outQuad(p, p2, p3, p4)
	local v = p / p4
	return -p3 * v * (v - 2) + p2
end

function inOutQuad(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * pow(v, 2) + p2
	end

	return -p3 / 2 * ((v - 1) * (v - 3) - 1) + p2
end

function inOutQuadIntegral(p, p2, p3, p4)
	if p / p4 * 2 < 1 then
		return p * (p2 + 2 * p3 * p * p / (3 * p4 * p4))
	end

	return p * (p2 - p3 * (2 * p * p / (3 * p4 * p4) - 2 * p / p4 + 1)) + p3 * p4 / 6
end

local function fn(p, p2, p3, p4) -- 1 equivalent call inferred from this helper
	local v = p / p4
	return -p3 * v * (v - 2) + p2
end

function outInQuad(p, p2, p3, p4)
	if p < p4 / 2 then
		return fn(p * 2, p2, p3 / 2, p4) -- inferred equivalent call
	else
		local v = p * 2 - p4
		local v2 = p2 + p3 / 2
		return p3 / 2 * pow(v / p4, 2) + v2
	end
end

function inCubic(p, p2, p3, p4)
	return p3 * pow(p / p4, 3) + p2
end

function outCubic(p, p2, p3, p4)
	return p3 * (pow(p / p4 - 1, 3) + 1) + p2
end

function inOutCubic(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * v * v * v + p2
	end

	local v2 = v - 2
	return p3 / 2 * (v2 * v2 * v2 + 2) + p2
end

function outInCubic(p, p2, p3, p4)
	if p < p4 / 2 then
		local v = p * 2
		return p3 / 2 * (pow(v / p4 - 1, 3) + 1) + p2
	else
		local v = p * 2 - p4
		local v2 = p2 + p3 / 2
		return p3 / 2 * pow(v / p4, 3) + v2
	end
end

function inQuart(p, p2, p3, p4)
	return p3 * pow(p / p4, 4) + p2
end

function outQuart(p, p2, p3, p4)
	local v = p / p4 - 1
	return -p3 * (pow(v, 4) - 1) + p2
end

function inOutQuart(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * pow(v, 4) + p2
	end

	local v2 = v - 2
	return -p3 / 2 * (pow(v2, 4) - 2) + p2
end

function outInQuart(p, p2, p3, p4)
	if p < p4 / 2 then
		local v = p * 2
		local v2 = p3 / 2
		local v3 = v / p4 - 1
		return -v2 * (pow(v3, 4) - 1) + p2
	else
		local v = p * 2 - p4
		local v2 = p2 + p3 / 2
		return p3 / 2 * pow(v / p4, 4) + v2
	end
end

function inQuint(p, p2, p3, p4)
	return p3 * pow(p / p4, 5) + p2
end

function outQuint(p, p2, p3, p4)
	return p3 * (pow(p / p4 - 1, 5) + 1) + p2
end

function inOutQuint(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * pow(v, 5) + p2
	end

	local v2 = v - 2
	return p3 / 2 * (pow(v2, 5) + 2) + p2
end

function outInQuint(p, p2, p3, p4)
	if p < p4 / 2 then
		local v = p * 2
		return p3 / 2 * (pow(v / p4 - 1, 5) + 1) + p2
	else
		local v = p * 2 - p4
		local v2 = p2 + p3 / 2
		return p3 / 2 * pow(v / p4, 5) + v2
	end
end

function inSine(p, p2, p3, p4)
	return -p3 * cos(p / p4 * 1.5707963267948966) + p3 + p2
end

function outSine(p, p2, p3, p4)
	return p3 * sin(p / p4 * 1.5707963267948966) + p2
end

function inOutSine(p, p2, p3, p4)
	return -p3 / 2 * (cos(3.141592653589793 * p / p4) - 1) + p2
end

function outInSine(p, p2, p3, p4)
	if p < p4 / 2 then
		local v = p * 2
		return p3 / 2 * sin(v / p4 * 1.5707963267948966) + p2
	else
		local v = p * 2 - p4
		local v2 = p2 + p3 / 2
		local v3 = p3 / 2
		return -v3 * cos(v / p4 * 1.5707963267948966) + v3 + v2
	end
end

function inExpo(p, p2, p3, p4)
	if p == 0 then
		return p2
	end

	return p3 * pow(2, 10 * (p / p4 - 1)) + p2 - p3 * 0.001
end

function outExpo(p, p2, p3, p4)
	if p == p4 then
		return p2 + p3
	end

	return p3 * 1.001 * (-pow(2, -10 * p / p4) + 1) + p2
end

function inOutExpo(p, p2, p3, p4)
	if p == 0 then
		return p2
	end

	if p == p4 then
		return p2 + p3
	end

	local v = p / p4 * 2

	if v < 1 then
		return p3 / 2 * pow(2, 10 * (v - 1)) + p2 - p3 * 0.0005
	else
		local v2 = v - 1
		return p3 / 2 * 1.0005 * (-pow(2, -10 * v2) + 2) + p2
	end
end

function outInExpo(p, p2, p3, p4)
	if p < p4 / 2 then
		local v = p * 2
		local v2 = p3 / 2

		if v == p4 then
			return p2 + v2
		end

		return v2 * 1.001 * (-pow(2, -10 * v / p4) + 1) + p2
	else
		local v = p * 2 - p4
		local v2 = p2 + p3 / 2
		local v3 = p3 / 2

		if v == 0 then
			return v2
		end

		return v3 * pow(2, 10 * (v / p4 - 1)) + v2 - v3 * 0.001
	end
end

function inCirc(p, p2, p3, p4)
	local v = p / p4
	return -p3 * (sqrt(1 - pow(v, 2)) - 1) + p2
end

function outCirc(p, p2, p3, p4)
	return p3 * sqrt(1 - pow(p / p4 - 1, 2)) + p2
end

function inOutCirc(p, p2, p3, p4)
	local v = p / p4 * 2

	if v < 1 then
		return -p3 / 2 * (sqrt(1 - v * v) - 1) + p2
	else
		local v2 = v - 2
		return p3 / 2 * (sqrt(1 - v2 * v2) + 1) + p2
	end
end

function outInCirc(p, p2, p3, p4)
	if p < p4 / 2 then
		local v = p * 2
		return p3 / 2 * sqrt(1 - pow(v / p4 - 1, 2)) + p2
	else
		local v = p * 2 - p4
		local v2 = p2 + p3 / 2
		local v3 = p3 / 2
		local v4 = v / p4
		return -v3 * (sqrt(1 - pow(v4, 2)) - 1) + v2
	end
end

local function fn2(p, p2, p3, p4, p5, p6)
	if p == 0 then
		return p2
	end

	local v = p / p4

	if v == 1 then
		return p2 + p3
	end

	local v2 = p6 or p4 * 0.3
	local v3

	if p5 and not (p5 < abs(p3)) then
		v3 = v2 / 6.283185307179586 * asin(p3 / p5)
	else
		v3 = v2 / 4
		p5 = p3
	end

	local v4 = v - 1
	return -(p5 * pow(2, 10 * v4) * sin((v4 * p4 - v3) * 6.283185307179586 / v2)) + p2
end

local function fn3(p, p2, p3, p4, p5, p6)
	if p == 0 then
		return p2
	end

	local v = p / p4

	if v == 1 then
		return p2 + p3
	end

	local v2 = p6 or p4 * 0.3
	local v3

	if p5 and not (p5 < abs(p3)) then
		v3 = v2 / 6.283185307179586 * asin(p3 / p5)
	else
		v3 = v2 / 4
		p5 = p3
	end

	return p5 * pow(2, -10 * v) * sin((v * p4 - v3) * 6.283185307179586 / v2) + p3 + p2
end

function inElastic(p, p2, p3, p4, p5, p6)
	return (fn2(p, p2, p3, p4, p5, p6))
end

function outElastic(p, p2, p3, p4, p5, p6)
	return (fn3(p, p2, p3, p4, p5, p6))
end

function inOutElastic(p, p2, p3, p4, value, p5)
	if p == 0 then
		return p2
	end

	local v = p / p4 * 2

	if v == 2 then
		return p2 + p3
	end

	local v2 = p5 or p4 * 0.44999999999999996
	local v3 = value or 0
	local v4

	if v3 and not (v3 < abs(p3)) then
		v4 = v2 / 6.283185307179586 * asin(p3 / v3)
	else
		v4 = v2 / 4
		v3 = p3
	end

	if v < 1 then
		local v5 = v - 1
		return -0.5 * (v3 * pow(2, 10 * v5) * sin((v5 * p4 - v4) * 6.283185307179586 / v2)) + p2
	else
		local v5 = v - 1
		return v3 * pow(2, -10 * v5) * sin((v5 * p4 - v4) * 6.283185307179586 / v2) * 0.5 + p3 + p2
	end
end

function outInElastic(p, p2, p3, p4, p5, p6)
	if p < p4 / 2 then
		return (fn3(p * 2, p2, p3 / 2, p4, p5, p6))
	end

	return (fn2(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4, p5, p6))
end

function inBack(p, p2, p3, p4, value)
	local v = value or 1.70158
	local v2 = p / p4
	return p3 * v2 * v2 * ((v + 1) * v2 - v) + p2
end

function outBack(p, p2, p3, p4, value)
	local v = value or 1.70158
	local v2 = p / p4 - 1
	return p3 * (v2 * v2 * ((v + 1) * v2 + v) + 1) + p2
end

function inOutBack(p, p2, p3, p4, value)
	local v = (value or 1.70158) * 1.525
	local v2 = p / p4 * 2

	if v2 < 1 then
		return p3 / 2 * (v2 * v2 * ((v + 1) * v2 - v)) + p2
	end

	local v3 = v2 - 2
	return p3 / 2 * (v3 * v3 * ((v + 1) * v3 + v) + 2) + p2
end

local function fn4(p, p2, p3, p4, value) -- 1 equivalent call inferred from this helper
	local v = value or 1.70158
	local v2 = p / p4
	return p3 * v2 * v2 * ((v + 1) * v2 - v) + p2
end

local function fn5(p, p2, p3, p4, value) -- 1 equivalent call inferred from this helper
	local v = value or 1.70158
	local v2 = p / p4 - 1
	return p3 * (v2 * v2 * ((v + 1) * v2 + v) + 1) + p2
end

function outInBack(p, p2, p3, p4, value)
	if p < p4 / 2 then
		return fn5(p * 2, p2, p3 / 2, p4, value) -- inferred equivalent call
	else
		return fn4(p * 2 - p4, p2 + p3 / 2, p3 / 2, p4, value) -- inferred equivalent call
	end
end

local function fn6(p, p2, p3, p4)
	local v = p / p4

	if v < 4 / 11 then
		return p3 * (7.5625 * v * v) + p2
	end

	if v < 8 / 11 then
		local v2 = v - 6 / 11
		return p3 * (7.5625 * v2 * v2 + 0.75) + p2
	end

	if v < 10 / 11 then
		local v2 = v - 9 / 11
		return p3 * (7.5625 * v2 * v2 + 0.9375) + p2
	end

	local v2 = v - 21 / 22
	return p3 * (7.5625 * v2 * v2 + 0.984375) + p2
end

function outBounce(p, p2, p3, p4)
	return (fn6(p, p2, p3, p4))
end

function inBounce(p, p2, p3, p4)
	return p3 - fn6(p4 - p, 0, p3, p4) + p2
end

function inOutBounce(p, p2, p3, p4)
	if p < p4 / 2 then
		return (p3 - fn6(p4 - p * 2, 0, p3, p4) + 0) * 0.5 + p2
	else
		return fn6(p * 2 - p4, 0, p3, p4) * 0.5 + p3 * 0.5 + p2
	end
end

function outInBounce(p, p2, p3, p4)
	if p < p4 / 2 then
		return (fn6(p * 2, p2, p3 / 2, p4))
	end

	local v = p * 2 - p4
	local v2 = p2 + p3 / 2
	local v3 = p3 / 2
	return v3 - fn6(p4 - v, 0, v3, p4) + v2
end