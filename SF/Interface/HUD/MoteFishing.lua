local v = 0
local v2 = 0
local flag = false
local v3 = __wf_atom_10cd16b2(0, 0.5)
local v4 = __wf_atom_10cd16b2(0, 0.5)
local v5 = __wf_atom_10cd16b2(0, 0.5)
__wf_atom_10cd16b2(0, 0.5)
__wf_atom_10cd16b2(0, 0.5)
local loreMoteMinigameInstigator = nil
local loreMoteMinigameTarget = nil
local v6 = nil
local v7 = nil
local v8 = Vector()
local v9 = 0
local v10 = 0
local v11 = Vector()
local v12 = Vector()

function Initialize()
	__wf_atom_86cbd68d(mMovie, "LineBar.gotoAndStop", __wf_atom_421b01aa(v * 100, 0, 100))
	loreMoteMinigameTarget = _T.LoreMoteMinigameTarget
	loreMoteMinigameInstigator = _T.LoreMoteMinigameInstigator
	local position = loreMoteMinigameTarget:GetPosition()
	v7 = loreMoteMinigameInstigator:__wf_atom_d2b2176d():__wf_atom_74d951b0()
	v3:__wf_atom_4453e49c(v7.x)
	v4:__wf_atom_4453e49c(v7.y)
	v5:__wf_atom_4453e49c(v7.z)
	v6 = gRegion:CreateEntity(tetherBeam, position, Rotation())
	mMovie:__wf_atom_dac78d3d(true)
	local v13 = Vector()
	Randomize(v13)
	v13.z = 0
	Normalize(v13)
	v11 = v13
	v11 *= Random(3, 5)
end

local function fn(p)
	if __wf_atom_7e8ad928(loreMoteMinigameTarget) or __wf_atom_7e8ad928(loreMoteMinigameInstigator) then
		return
	end

	local position = loreMoteMinigameTarget:GetPosition()
	v7.x = v3:__wf_atom_2490589b(position.x, p)
	v7.y = v4:__wf_atom_2490589b(position.y, p)
	v7.z = v5:__wf_atom_2490589b(position.z, p)
	local aimPosition = loreMoteMinigameInstigator:GetAimPosition()
	local v13 = __wf_atom_fa8d0177(aimPosition, v7, Vector(0, 1, 0))
	loreMoteMinigameInstigator:__wf_atom_f0f9fb38(v13)

	if not __wf_atom_7e8ad928(v6) then
		local __wf_atom_1c374cc9 = loreMoteMinigameInstigator:__wf_atom_1c374cc9(Symbol("GAME_R1_FINGER1"))
		v6:SetPosition(position)
		v6:__wf_atom_a64eca67(__wf_atom_1c374cc9)
		v6:__wf_atom_7601b116(__wf_atom_1c374cc9)
	end
end

local function fn2(p)
	local v13

	if Engine.IsPlayingWithController() then
		v13 = Vector(v8.x, v8.y, 0)
	else
		v13 = Vector(v9, v10, 0)
	end

	local x = v13.x
	local y = v13.y
	local v14 = Vector()

	if flag then
		v14 += Vector(x, y, 0)
	end

	local v15 = Dot(v12, v12)
	local v16 = math.sqrt(v15)
	local v17 = 0.55 * v15 * 0.1 * 0.25
	local v18 = Vector()

	if v16 > 0.0001 then
		v18 = v12 / v16 * -v17
	end

	local _ = v16 * 0.1 / math.max(0.0001, p) < Length(v18)
	local v19 = Noise(v2)
	local v20 = Noise(v2 + 7)
	local v21 = v14 + Vector(v19, v20, 0)
	v12 += v21 + v18
	v11 += v12 * p
	local v22 = Length(v13)

	if v22 > 0.0001 then
		Normalize(v13)
	end

	local v23 = v13 * __wf_atom_421b01aa(v22, 0, 1)
	mMovie:__wf_atom_4c1c1986("MoteCircle", "Pull", 0, v23.x * 110)
	mMovie:__wf_atom_4c1c1986("MoteCircle", "Pull", 1, v23.y * 110)
	local v24 = math.atan2(v23.y, v23.x) * 57.29577951308232
	mMovie:__wf_atom_4c1c1986("MoteCircle", "Pull", 16, v24 + 90)
	mMovie:__wf_atom_e57658c2("MoteCircle.LineBar", 0, v23.x * 110)
	mMovie:__wf_atom_e57658c2("MoteCircle.LineBar", 1, v23.y * 110)
	local v25 = v11 - v23
	local v26 = Length(v25)
	local v27 = math.atan2(v25.y, v25.x) * 57.29577951308232
	mMovie:__wf_atom_e57658c2("MoteCircle.LineBar", 5, v26 * 110 / 256 * 100)
	mMovie:__wf_atom_e57658c2("MoteCircle.LineBar", 16, v27)
	local v28 = __wf_atom_421b01aa(v26, 0, 1)
	Color(255, 255, 255):__wf_atom_104bfe98(Color(255, 0, 0), __wf_atom_421b01aa(v28 - 0.5, 0, 1) * 2)
end

function Update()
	local v13 = __wf_atom_084b3e93()
	fn(v13)
	local _ = math.abs((math.sin(6.283185307179586 * __wf_atom_4658d645(Time() * 0.1)))) + math.abs((math.sin(6.283185307179586 * __wf_atom_4658d645(Time() * 0.035))))

	if flag then
		v += v13
	else
		v -= v13
	end

	v = __wf_atom_421b01aa(v, 0, 1)
	local v14 = v
	__wf_atom_86cbd68d(mMovie, "MoteCircle.LineBar.gotoAndStop", __wf_atom_421b01aa(v14 * 100, 0, 100))
	local __wf_atom_104bfe98_2 = Color(255, 255, 255):__wf_atom_104bfe98(
		Color(255, 0, 0),
		__wf_atom_421b01aa(v14 - 0.5, 0, 1) * 2
	)
	mMovie:__wf_atom_e57658c2("MoteCircle.LineBar.CraftRankFill", 11, __wf_atom_104bfe98_2:__wf_atom_dcecedb0())
	local v15 = math.pow(v, 2)
	v2 += v13 * __wf_atom_104bfe98(0.1, 0.2, v15)
	v2 = __wf_atom_4658d645(v2)
	Noise(v2)
	Noise(v2 + 7)
	mMovie:__wf_atom_4c1c1986("MoteCircle", "Mote", 0, v11.x * 110)
	mMovie:__wf_atom_4c1c1986("MoteCircle", "Mote", 1, v11.y * 110)
	fn2(v13)

	if __wf_atom_489de21b("MoteFishnig") then
		__wf_atom_05a856ad("CX: " .. v9)
		__wf_atom_48bcafdc()
	end
end

function onRawInputEvent(_, value, p)
	if string.find(value, "MOUSE_B0") ~= nil then
		if p == "1" then
			flag = true
		else
			flag = false
		end
	end
end

function onKeyDown_MENU_MOUSE_X(_, p)
	v9 = __wf_atom_421b01aa(v9 + tonumber(p) * 0.002, -1, 1)
	return true
end

function onKeyDown_MENU_MOUSE_Y(_, p)
	v10 = __wf_atom_421b01aa(v10 + tonumber(p) * 0.002, -1, 1)
	return true
end

function onKeyDown_MENU_X(_, p)
	v8.x = tonumber(p)
	return true
end

function onKeyUp_MENU_X(_, p)
	v8.x = tonumber(p)
	return true
end

function onKeyDown_MENU_Y(_, p)
	v8.y = -tonumber(p)
	return true
end

function onKeyUp_MENU_Y(_, p)
	v8.y = -tonumber(p)
	return true
end

function onKeyDown_MENU_CLICK()
	flag = true
	return true
end

function onKeyUp_MENU_CLICK()
	flag = false
	return true
end

function onKeyDown_MENU_SELECT()
	flag = true
	return true
end

function onKeyUp_MENU_SELECT()
	flag = false
	return true
end

function onKeyDown_MENU_CANCEL()
	mMovie:Close()
end