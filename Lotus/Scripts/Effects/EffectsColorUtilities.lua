module(..., package.seeall)

local function fn(object, p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_0d9e9dec = SF.__wf_atom_0d9e9dec(p)
	object:SetMaterialParam(
		SF.__wf_atom_d6e83752,
		__wf_atom_0d9e9dec.red / 255,
		__wf_atom_0d9e9dec.green / 255,
		__wf_atom_0d9e9dec.blue / 255,
		1
	)
	local __wf_atom_4f97dab1 = SF.__wf_atom_4f97dab1(p)
	object:SetMaterialParam(
		SF.__wf_atom_22715eb5,
		__wf_atom_4f97dab1.red / 255,
		__wf_atom_4f97dab1.green / 255,
		__wf_atom_4f97dab1.blue / 255,
		1
	)
end

function ApplyHighLow(p, p2)
	fn(p, p2)
end

local function fn2(p, p2)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return
	end

	local __wf_atom_0d9e9dec = SF.__wf_atom_0d9e9dec(p2)
	Effects.__wf_atom_e20e9e6f(
		p,
		SF.__wf_atom_d6e83752,
		__wf_atom_0d9e9dec.red / 255,
		__wf_atom_0d9e9dec.green / 255,
		__wf_atom_0d9e9dec.blue / 255,
		1
	)
	local __wf_atom_4f97dab1 = SF.__wf_atom_4f97dab1(p2)
	Effects.__wf_atom_e20e9e6f(
		p,
		SF.__wf_atom_22715eb5,
		__wf_atom_4f97dab1.red / 255,
		__wf_atom_4f97dab1.green / 255,
		__wf_atom_4f97dab1.blue / 255,
		1
	)
end

function ApplyHighLowOnParticleSysChildren(p, p2)
	fn2(p, p2)
end

function ApplyEnergyTints(object, data, data2, data3)
	if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(data2) or __wf_atom_7e8ad928(data3) then
		return
	end

	object:SetMaterialParam(SF.__wf_atom_3b7bc4af, data.red / 255, data.green / 255, data.blue / 255, 1)
	object:SetMaterialParam(SF.__wf_atom_d6e83752, data3.red / 255, data3.green / 255, data3.blue / 255, 1)
	object:SetMaterialParam(SF.__wf_atom_22715eb5, data2.red / 255, data2.green / 255, data2.blue / 255, 1)
end

local function fn3(p) -- 10 equivalent calls inferred from this helper
	if p <= 0.03928 then
		return p / 12.92
	end

	return (math.pow((p + 0.055) / 1.055, 2.4))
end

function ApplyEnergyTintsSRGB(object, data, data2, data3)
	if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(data2) or __wf_atom_7e8ad928(data3) then
		return
	end

	object:SetMaterialParam(SF.__wf_atom_3b7bc4af, fn3(data.red / 255), fn3(data.green / 255), fn3(data.blue / 255), 1) -- inferred equivalent call
	object:SetMaterialParam(SF.__wf_atom_d6e83752, data3.red / 255, data3.green / 255, data3.blue / 255, 1)
	object:SetMaterialParam(SF.__wf_atom_22715eb5, data2.red / 255, data2.green / 255, data2.blue / 255, 1)
end

local function fn4(instance, object, p, p2, p3, value)
	local v = value or 1
	local __wf_atom_3b7bc4af = SF.__wf_atom_3b7bc4af

	if not __wf_atom_7e8ad928(p) then
		__wf_atom_3b7bc4af = p
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local colors = __wf_atom_e55d02aa:__wf_atom_eb82ab1f():GetColors(p2)

		if colors:Initialized(p3) then
			local v2 = Color(colors:GetColor(p3))

			if instance:IsA(__wf_atom_8939e086) then
				instance:__wf_atom_8cd234d5(v2, v2)
			else
				instance:SetMaterialParam(
					__wf_atom_3b7bc4af,
					fn3(v2.red / 255) * v, -- inferred equivalent call
					fn3(v2.green / 255) * v, -- inferred equivalent call
					fn3(v2.blue / 255) * v, -- inferred equivalent call
					1
				)
			end

			fn(instance, v2)
		else
			instance:__wf_atom_6d11d81e(__wf_atom_3b7bc4af)
		end
	end
end

function ApplyEnergyColor(p, p2, p3, p4)
	fn4(p, p2, p3, 0, 6, p4)
end

function ApplyColor(p, p2, p3, p4, p5)
	fn4(p, p2, p3, p4, p5)
end

function ApplyColorFromSuitOrWeapon(p, object)
	if not __wf_atom_7e8ad928(object) then
		object:ApplyEnergyColor(p)
	end
end

function ApplyEnergyTint(object, object2)
	local v = Color(4, 100, 220, 255)
	local __wf_atom_e55d02aa = object2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local colors = __wf_atom_e55d02aa:__wf_atom_eb82ab1f():GetColors(0)

		if colors:Initialized(6) then
			v = Color(colors:GetColor(6))
		end
	end

	object:__wf_atom_7fff6c98(v)
end

function EnergyHighColor(p)
	return SF.__wf_atom_4f97dab1(p)
end

function EnergyLowColor(p)
	return SF.__wf_atom_0d9e9dec(p)
end

function LinearToSRGB(data)
	local v = Color()
	local v2 = math.sqrt(data.red / 255)
	local v3 = math.sqrt(v2)
	local v4 = math.sqrt(v3)
	v.red = __wf_atom_421b01aa(v2 * 0.585 + v3 * 0.783 - v4 * 0.368, 0, 1) * 255
	local v5 = math.sqrt(data.green / 255)
	local v6 = math.sqrt(v5)
	local v7 = math.sqrt(v6)
	v.green = __wf_atom_421b01aa(v5 * 0.585 + v6 * 0.783 - v7 * 0.368, 0, 1) * 255
	local v8 = math.sqrt(data.blue / 255)
	local v9 = math.sqrt(v8)
	local v10 = math.sqrt(v9)
	v.blue = __wf_atom_421b01aa(v8 * 0.585 + v9 * 0.783 - v10 * 0.368, 0, 1) * 255
	v.alpha = data.alpha
	return v
end

function SRGBToLinear(p)
	return fn3(p / 255) -- inferred equivalent call
end

function SRGBToLinear255(data)
	local v = Color()
	v.red = fn3(data.red / 255) * 255 -- inferred equivalent call
	v.green = fn3(data.green / 255) * 255 -- inferred equivalent call
	v.blue = fn3(data.blue / 255) * 255 -- inferred equivalent call
	v.alpha = data.alpha
	return v
end

function RGBToHSV(data)
	local v = data.red / 255
	local v2 = data.green / 255
	local v3 = data.blue / 255
	local v4 = math.min(v, v2, v3)
	local v5 = math.max(v, v2, v3)
	local v6 = v5 - v4
	local v7 = 0
	local v8 = not (v5 > 0) and 0 or v6 / v5
	local v9, v10, v11

	if v6 > 0 then
		v9 = ((v5 - v) / 6 + v6 / 2) / v6
		v10 = ((v5 - v2) / 6 + v6 / 2) / v6
		v11 = ((v5 - v3) / 6 + v6 / 2) / v6
	else
		v11 = 0
		v10 = 0
		v9 = 0
	end

	if v == v5 then
		v7 = v11 - v10
	elseif v2 == v5 then
		v7 = v9 + 1 / 3 - v11
	elseif v3 == v5 then
		v7 = v10 + 2 / 3 - v9
	end

	if v7 < 0 then
		v7 += 1
	end

	if v7 > 1 then
		v7 -= 1
	end

	return v7, v8, v5
end

function HSVToRGB(p, p2, p3)
	local v = p * 6
	local v2 = v == 6 and 0 or v
	local v3 = math.floor(v2)
	local v4 = p3 * (1 - p2)
	local v5 = p3 * (1 - p2 * (v2 - v3))
	local v6 = p3 * (1 - p2 * (1 - (v2 - v3)))

	if v3 == 0 then
		v5 = v4
		v4 = v6
	elseif v3 == 1 then
		local v7 = v5
		v5 = v4
		v4 = p3
		p3 = v7
	elseif v3 == 2 then
		v5 = v6
		v4, p3 = p3, v4
	elseif v3 == 3 then
		local v7 = v5
		v5 = p3
		p3 = v4
		v4 = v7
	elseif v3 == 4 then
		v5 = p3
		p3 = v6
	end

	local v7 = Color()
	v7.red = math.abs(p3 * 255)
	v7.green = math.abs(v4 * 255)
	v7.blue = math.abs(v5 * 255)
	v7.alpha = 255
	return v7
end

function ParticleQuality()
	if gClient then
		return gClient:__wf_atom_c22da057():__wf_atom_a8ac7109().particleSysQuality
	end

	return 0
end