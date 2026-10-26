local module = require("EE.Interface.Utilities")
require("SF.Scripts.Libs.PlayerPetLib")
local playerWolfAvatar = nil
local v = __wf_atom_10cd16b2(1, 0.25)
local v2 = Vector()
local v3 = Vector()
local v4 = 0
local v5 = 0
local count = 0
local v6 = nil
local v7 = false
local v8 = nil
local v9 = nil
local v10 = nil

function Initialize()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_e919fb8e = __wf_atom_c4f78a8f:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
		mMovie:Close()
		return
	end

	v9 = {
		[0] = hungryIcon,
		[1] = overfedIcon,
		[2] = sleepyIcon,
		[3] = trackingIcon,
		[4] = energyIcon
	}
	v10 = {
		petStatGuardIcon,
		petStatSpeedIcon,
		petStatStaminaIcon,
		petStatSearchIcon,
		petStatSupportIcon
	}
	local module2 = require("Lotus.Interface.Libs.TimerMgr")
	v8 = module2.CreateTimerMgr()
	mMovie:__wf_atom_8fcdea81(__wf_atom_c4f78a8f:__wf_atom_a96eb2aa())
	playerWolfAvatar = __wf_atom_e919fb8e.PlayerWolfAvatar
	mMovie:__wf_atom_e57658c2("Status", 12, 0)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 12, 75)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 11, _G.UIColor_Beige)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Backer", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Backer", 12, 75)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 12, 0)
	mMovie:__wf_atom_c90af43a("Status.ScaleContainer.Backer", backerIcon)
	mMovie:__wf_atom_c90af43a("Status.ScaleContainer.Icon", energyIcon)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Backer", 5, 120)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Backer", 6, 120)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Flare", 5, 300)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Flare", 6, 300)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 11, _G.UIColor_Yellow)
	v4 = mMovie:__wf_atom_5e6e15c8("Status.ScaleContainer.Icon", 1)
end

function Update()
	if __wf_atom_7e8ad928(playerWolfAvatar) then
		mMovie:Close()
		return
	end

	local v11 = __wf_atom_084b3e93()
	local v12 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v12)

	if not __wf_atom_7e8ad928(v8) then
		v8:Update(v11)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = mMovie:__wf_atom_54eeda24()
	local screenDimensions, v13 = module.GetScreenDimensions(mMovie)
	v2.x = -(screenDimensions - __wf_atom_97cd8326) / 2
	v2.y = -(v13 - __wf_atom_54eeda24) / 2
	v3.x = __wf_atom_97cd8326 + (screenDimensions - __wf_atom_97cd8326) / 2
	v3.y = __wf_atom_54eeda24 + (v13 - __wf_atom_54eeda24) / 2
	local v14 = playerWolfAvatar:EyePosition() + Vector(0, playerWolfAvatar:__wf_atom_d547c32d(), 0)
	local __wf_atom_a2a18137 = playerWolfAvatar:__wf_atom_a2a18137()
	v:__wf_atom_4453e49c(v14.y - __wf_atom_a2a18137.y)
	__wf_atom_a2a18137.y += v:__wf_atom_2490589b(v14.y - __wf_atom_a2a18137.y, v12)
	local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(v14)
	local __wf_atom_d5fda8be = __wf_atom_c4f78a8f:__wf_atom_d5fda8be(v14)
	local v15 = __wf_atom_421b01aa(__wf_atom_d5fda8be / 35, 0, 1)
	local v16 = not (__wf_atom_74b9a49b.z > 0) and 0 or __wf_atom_104bfe98(220, 60, (math.pow(v15, 0.5)))
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer", 5, v16)
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer", 6, v16)
	local v17 = __wf_atom_104bfe98(-30, 0, v15)
	__wf_atom_74b9a49b.x = __wf_atom_421b01aa(__wf_atom_74b9a49b.x, v2.x + 30, v3.x - 30)
	__wf_atom_74b9a49b.y = __wf_atom_421b01aa(__wf_atom_74b9a49b.y - v17, v2.y + 44, v3.y - 44)
	mMovie:__wf_atom_e57658c2("Status", 0, __wf_atom_74b9a49b.x)
	mMovie:__wf_atom_e57658c2("Status", 1, __wf_atom_74b9a49b.y + v5)
end

local function fn(p, p2)
	if p <= 0 or p2 ~= count or not v7 then
		return
	end

	__wf_atom_ec43d06e(mMovie, "Status.ScaleContainer.Icon", 6, { 5, 6 }, { 132, 132 }, 0.25, 0.01, function()
		if p2 ~= count or not v7 then
			return
		end

		__wf_atom_ec43d06e(mMovie, "Status.ScaleContainer.Icon", 8, { 5, 6 }, { 120, 120 }, 0.25, 0, function()
			if p2 ~= count or not v7 then
				return
			end

			fn(p - 1, p2)
		end)
	end)
end

local function fn2(p, p2, fn3)
	if p ~= v6 or p2 then
		count += 1
		local v11 = count
		local flag = false
		local v12 = 0
		v7 = true
		v5 = 100
		mMovie:__wf_atom_e57658c2("Status", 5, 25)
		mMovie:__wf_atom_e57658c2("Status", 6, 25)
		mMovie:__wf_atom_e57658c2("Status", 12, 0)
		mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Flare", 12, 0)
		mMovie:__wf_atom_c90af43a("Status.ScaleContainer.Icon", p)
		mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 1, v4)
		mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 5, 120)
		mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 6, 120)
		mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 12, 0)
		mMovie:__wf_atom_c90af43a("Status.ScaleContainer.Flare", glowTexture)
		mMovie:OverrideMaterial("Status.ScaleContainer.Flare", raysMaterial)
		__wf_atom_ec43d06e(mMovie, "Status", 4, {
			function(p3)
				if v11 ~= count then
					return
				end

				v12 = math.max(v12, __wf_atom_421b01aa(p3, 0, 1))
				mMovie:__wf_atom_e57658c2("Status", 12, __wf_atom_104bfe98(0, 75, v12))

				if p3 >= 1 then
					flag = true
				end

				if flag then
					p3 = 1 + (p3 - 1) * 0.3
				end

				v5 = __wf_atom_104bfe98(100, 0, p3)
			end,
			5,
			6
		}, { 1, 100, 100 }, 2, 0, function()
			if v11 ~= count then
				return
			end

			v5 = 0
			v7 = true
		end)
		__wf_atom_ec43d06e(mMovie, "Status.ScaleContainer.Flare", 6, { 12 }, { 100 }, 2, 0, nil)
		__wf_atom_ec43d06e(mMovie, "Status.ScaleContainer.Icon", 6, { 12 }, { 100 }, 0.8, 0, function()
			if v11 ~= count then
				return
			end

			v7 = true

			if fn3 ~= nil then
				fn3()
			end

			if v11 ~= count then
				return
			end

			__wf_atom_ec43d06e(mMovie, "Status", 6, { 12, 5, 6 }, { 0, 0, 0 }, 0.5, 5, function()
				if v11 ~= count then
					return
				end

				if not __wf_atom_7e8ad928(nil) then
					(nil):Destroy()
				end

				v7 = false
				v6 = nil
			end)
		end)
		v6 = p
	end
end

function OnPetStatIncreased(p, p2, p3)
	local v11 = tonumber(p)
	local v12 = p2 == "true"
	local v13 = p3 == "true"
	local happyIcon2

	if v12 then
		happyIcon2 = v10[v11]
	else
		happyIcon2 = happyIcon
	end

	local uiColor_Yellow = _G.UIColor_Yellow
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 11, uiColor_Yellow)
	mMovie:__wf_atom_2dedec1a("Status.ScaleContainer.Flare", 13, v13)
	fn2(happyIcon2, v12, function()
		if not __wf_atom_7e8ad928(statIncreasedSound) then
			module.PlaySound(statIncreasedSound)
		end

		__wf_atom_7e8ad928(statIncreaseFx)
	end)
end

function OnPetStatusChanged(p, p2)
	local v11 = tonumber(p)
	local v12 = p2 == "true"
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) or not __wf_atom_eab484a7:__wf_atom_5e8fa1ad() then
		return
	end

	local v13 = v9[v11]

	if __wf_atom_7e8ad928(v13) then
		return
	end

	local uiColor_Yellow = _G.UIColor_Yellow
	mMovie:__wf_atom_e57658c2("Status.ScaleContainer.Icon", 11, uiColor_Yellow)
	mMovie:__wf_atom_2dedec1a("Status.ScaleContainer.Flare", 13, false)
	fn2(v13, v12, function()
		if not __wf_atom_7e8ad928(statusChangedSound) then
			module.PlaySound(statusChangedSound)
		end
	end)
end

function Shutdown() end