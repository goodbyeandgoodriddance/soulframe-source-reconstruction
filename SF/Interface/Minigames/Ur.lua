local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local v = 1
local v2 = nil
local v3 = 0
local v4 = {}
local v5 = { {}, {} }
local v6 = { {}, {} }
local v7 = {}
local v8 = {}
local v9 = { {}, {} }
local v10 = {}
local v11 = {}
local v12 = {}
local v13 = { 0, 0 }
local v14 = { 0, 0 }
local v15 = nil
local flag = false
local flag2 = false
local flag3 = false
local v16 = { {}, {} }
local flag4 = false
local flag5 = true
local v17 = { 0.75, 0.5, 0.25 }
local v18 = { v17[1], v17[1] }
local v19 = false
local v20 = nil
local total = 0
local v21 = { 0, 0 }
local v22 = { 0, 0 }
local v23 = 1
local v24 = 0
local flag6 = false
local v25 = nil
local frozen = table.freeze({
	MP_START = 0,
	MP_PLAYING = 1,
	MP_FLIP = 2,
	MP_MOVE = 3,
	MP_NO_VALID_MOVES = 4,
	MP_QUIT = 5
})
local frozen2 = table.freeze({
	NON_HUB_GAME = 0,
	SELECTING_SIDE = 1,
	OPPONENT_TURN = 2,
	LOCAL_TURN = 3
})
local NON_HUB_GAME = frozen2.NON_HUB_GAME
local v26 = {}
local v27 = nil
local v28 = nil
local v29 = nil

local function fn(p)
	if __wf_atom_7e8ad928(gMatchingService) or __wf_atom_7e8ad928(v29) then
		return
	end

	local encoded = cjson.encode(p)
	gMatchingService:__wf_atom_6ff767a1(v29, encoded)
end

local function fn2(p)
	fn({ minigame = "ur", type = frozen.MP_FLIP, value = p })
end

local function fn3(p)
	fn({ minigame = "ur", type = frozen.MP_MOVE, value = p })
end

local function fn4()
	fn({ minigame = "ur", type = frozen.MP_NO_VALID_MOVES, value = "" })
end

local function fn5()
	fn({ minigame = "ur", type = frozen.MP_QUIT, value = "" })
end

local function fn6()
	if v13[1] == 0 and v13[2] == 0 or v13[1] > v13[2] then
		return true
	end

	local v30 = { 0, 0 }
	local v31 = 0
	local v32 = nil

	for k, v33 in v6 do
		for _, v34 in v33 do
			v30[k] += v34

			if v31 < v34 then
				v32 = k
				v31 = v34
			elseif v34 == v31 then
				v32 = nil
			end
		end
	end

	return v30[1] > v30[2] or v30[1] == v30[2] and v32 ~= nil and v32 == 1
end

function onViewportSizeChanged(_, _)
	local screenDimensions, v30 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("EndCard.Blacker", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("EndCard.Blacker", 15, v30)
end

local function fn7()
	flag = true
end

local function fn8(p, p2)
	mMovie:__wf_atom_7f57ab2f(p, "Glow", 13, p2)
end

local function fn9()
	if not __wf_atom_7e8ad928(v26) and v26.type == frozen.MP_FLIP then
		local value = tonumber(v26.value)

		if __wf_atom_7e8ad928(value) then
			print("Ur ERROR! opponent flip value is not a number!")
		end

		if not __wf_atom_7e8ad928(v27) and NON_HUB_GAME == frozen2.SELECTING_SIDE then
			v3 = 0

			if v27 < value then
				NON_HUB_GAME = frozen2.OPPONENT_TURN
				v = 2
				fn8("Coins", false)
				fn8("OCoins", true)
				print("Ur GAME_STATE: OPPONENT_TURN(local: " .. v27 .. ", opponent: " .. value .. ")")
			elseif value < v27 then
				NON_HUB_GAME = frozen2.LOCAL_TURN
				v = 1
				fn8("Coins", true)
				fn8("OCoins", false)
				print("Ur GAME_STATE: LOCAL_TURN(local: " .. v27 .. ", opponent: " .. value .. ")")
			else
				v = 1
				fn8("Coins", true)
				fn8("OCoins", false)
				print("Ur GAME_STATE: SELECTING_SIDE(local: " .. v27 .. ", opponent: " .. value .. ")")
				v26 = {}
				v27 = nil
			end
		end
	end
end

local function fn10(p, value)
	v15:AddTimer(value or 0.5, function()
		gRegion:__wf_atom_c4f78a8f():__wf_atom_1a73b1c2(p)
	end)
end

local function fn11(p, p2)
	return mMovie:__wf_atom_8e9ac384(p, true) .. p2
end

local function fn12()
	mMovie:__wf_atom_50d60589("Score.Score", 36, (tostring(v13[1])))
	local v30 = -mMovie:__wf_atom_5e6e15c8("Score.Score", 40) / 2
	mMovie:__wf_atom_e57658c2("Score.Score", 0, v30 + 2)
	mMovie:__wf_atom_50d60589("OScore.Score", 36, (tostring(v13[2])))
	local v31 = -mMovie:__wf_atom_5e6e15c8("OScore.Score", 40) / 2
	mMovie:__wf_atom_e57658c2("OScore.Score", 0, v31 + 2)

	if v14[1] ~= v13[1] then
		v14[1] = v13[1]
		mMovie:__wf_atom_e57658c2("A7", 5, 60)
		mMovie:__wf_atom_e57658c2("A7", 6, 60)
		__wf_atom_ec43d06e(mMovie, "A7", 4, { 5, 6 }, { 100, 100 }, 1, 0)
		mMovie:__wf_atom_c90af43a("A7.EndIcon", endTilePlayerIcons[v13[1]])
		mMovie:__wf_atom_2dedec1a("A7.EndIcon", 13, true)
	end

	if v14[2] ~= v13[2] then
		v14[2] = v13[2]
		mMovie:__wf_atom_e57658c2("O7", 5, 60)
		mMovie:__wf_atom_e57658c2("O7", 6, 60)
		__wf_atom_ec43d06e(mMovie, "O7", 4, { 5, 6 }, { 100, 100 }, 1, 0)
		mMovie:__wf_atom_c90af43a("O7.EndIcon", endTileAvakotIcons[v13[2]])
		mMovie:__wf_atom_2dedec1a("O7.EndIcon", 13, true)
	end

	if v13[1] == 4 then
		if v13[2] == 0 then
			mMovie:__wf_atom_7d7314f1("EndCard.Result.Label.Text", "/SF/Language/Minigames/UrShutout")
		else
			mMovie:__wf_atom_7d7314f1("EndCard.Result.Label.Text", "/SF/Language/Minigames/UrVictory")
		end

		mMovie:__wf_atom_e57658c2("EndCard.Winner", 1, mMovie:__wf_atom_5e6e15c8("EndCard.Player", 1))
		mMovie:__wf_atom_c90af43a("EndCard.Result.Glow", victoryGlow)
		module.PlaySound(winSound)
		flag6 = true
		fn10(lostTransmission, 2)
	elseif v13[2] == 4 then
		if v13[1] == 0 then
			mMovie:__wf_atom_7d7314f1("EndCard.Result.Label.Text", "/SF/Language/Minigames/UrTotalDefeat")
		else
			mMovie:__wf_atom_7d7314f1("EndCard.Result.Label.Text", "/SF/Language/Minigames/UrDefeat")
		end

		mMovie:__wf_atom_e57658c2("EndCard.Winner", 1, mMovie:__wf_atom_5e6e15c8("EndCard.Avakot", 1))
		mMovie:__wf_atom_c90af43a("EndCard.Result.Glow", defeatGlow)
		module.PlaySound(loseSound)
		flag6 = true
		fn10(wonTransmission, 2)
	end

	if flag6 then
		flag4 = false
		flag5 = false
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 50 }, 1, 0)
		__wf_atom_ec43d06e(mMovie, "EndCard", 8, { 12 }, { 200 }, 1, 0)
		__wf_atom_86cbd68d(mMovie, "EndCard.swapDepths", 5300)
		local v32 = "<p><font color=\"#A79C7E\"><br>" .. fn11("<MOVES>", v21[1]) .. "   " .. fn11("<CAPTURES>", v22[1]) .. "   " .. fn11("<TIME>", module.FormatNumber(total, 1)) .. "</font></p>"
		mMovie:__wf_atom_50d60589("EndCard.Player.Stats", 36, v32)
		mMovie:__wf_atom_e57658c2("EndCard.Player.Stats", 11, 10984574)
		mMovie:__wf_atom_50d60589("EndCard.Player.Score", 36, v13[1])
		mMovie:__wf_atom_e57658c2(
			"EndCard.Player.Score",
			0,
			-mMovie:__wf_atom_5e6e15c8("EndCard.Player.Score", 40) / 2 + 2
		)
		mMovie:__wf_atom_e57658c2("EndCard.Player.Score", 11, 14524216)
		mMovie:__wf_atom_50d60589("EndCard.Player.Name", 36, mMovie:__wf_atom_387f260e("Score.Name", 36))
		mMovie:__wf_atom_e57658c2("EndCard.Player.Name", 11, 14524216)
		mMovie:__wf_atom_50d60589("EndCard.Avakot.Score", 36, v13[2])
		mMovie:__wf_atom_e57658c2(
			"EndCard.Avakot.Score",
			0,
			-mMovie:__wf_atom_5e6e15c8("EndCard.Avakot.Score", 40) / 2 + 2
		)
		mMovie:__wf_atom_e57658c2("EndCard.Avakot.Score", 11, 14524216)

		if NON_HUB_GAME == frozen2.NON_HUB_GAME then
			mMovie:__wf_atom_7d7314f1("EndCard.Avakot.Name.Text", "/SF/Language/Characters/Avakot")
		end

		mMovie:__wf_atom_e57658c2("EndCard.Avakot.Name", 11, 14524216)
		mMovie:OverrideMaterial("EndCard.Winner.Glow", glowMaterial)
		mMovie:__wf_atom_e57658c2("EndCard.Result.Glow", 14, mMovie:__wf_atom_5e6e15c8("EndCard.Result.Label", 40) * 2)
		mMovie:__wf_atom_e57658c2("EndCard.Result.Glow", 12, 35)
		mMovie:__wf_atom_e57658c2("EndCard.Result.Label", 11, 12363651)
	end
end

local function fn13(p, p2)
	if flag6 then
		return
	end

	module.PlaySound(coinTossSound)

	if __wf_atom_7e8ad928(p2) then
		v3 = 0
	end

	local v30 = {}
	local v31 = {}
	local v32 = {}
	local v33 = {}

	for i = 1, 4 do
		local v34 = p .. ".Coin" .. i
		v30[i] = mMovie:__wf_atom_5e6e15c8(v34, 0)
		v31[i] = mMovie:__wf_atom_5e6e15c8(v34, 1)
		v32[i] = {
			__wf_atom_8d119bab(-80, 80),
			__wf_atom_8d119bab(-40, 40),
			__wf_atom_8d119bab(140, 180),
			__wf_atom_8d119bab(0.35, 0.7)
		}
		mMovie:__wf_atom_e57658c2(v34, 16, v32[i][2])
		v33[i] = mMovie:__wf_atom_cfc41e35(v34, "Heads", 12)
	end

	local function fn14()
		module.PlaySound(coinLandSound)

		for i = 1, 4 do
			local v34

			if __wf_atom_7e8ad928(p2) then
				v34 = __wf_atom_c08f5a0e(1, 2)
			elseif p2 > 0 then
				v34 = 1
				p2 -= 1
			else
				v34 = 2
			end

			if v34 == 1 then
				mMovie:__wf_atom_4c1c1986(p .. ".Coin" .. i, "Heads", 12, 100)
				mMovie:__wf_atom_4c1c1986(p .. ".Coin" .. i, "Tails", 12, 0)

				if __wf_atom_7e8ad928(p2) then
					v3 += 1
				end
			else
				mMovie:__wf_atom_4c1c1986(p .. ".Coin" .. i, "Heads", 12, 0)
				mMovie:__wf_atom_4c1c1986(p .. ".Coin" .. i, "Tails", 12, 100)
			end
		end

		flag3 = false
		__wf_atom_ec43d06e(mMovie, p, 0, { function(p3)
				for i = 1, 4 do
					local v34 = p .. ".Coin" .. i
					local v35 = math.abs((Noise(i * 13.4 + Time() * 0.5))) * -100
					local v36 = __wf_atom_104bfe98(v31[i] + v35, v31[i], (math.pow(p3, 4)))
					mMovie:__wf_atom_e57658c2(v34, 1, v36)
					v32[i][2] = __wf_atom_104bfe98(v32[i][2], 0, (math.pow(p3, 0.5)))
					mMovie:__wf_atom_e57658c2(v34, 16, v32[i][2])
				end
			end }, { 1 }, 0.35)

		if __wf_atom_7e8ad928(p2) then
			if v3 == 0 then
				module.PlaySound(_G.UISound_Error)
				module.PlaySound(badRollSound)
				fn7()
			else
				flag2 = true
			end

			if NON_HUB_GAME > frozen2.NON_HUB_GAME then
				v27 = v3
				fn2(v27)

				if NON_HUB_GAME == frozen2.SELECTING_SIDE then
					fn9()
				end
			end
		end
	end

	__wf_atom_ec43d06e(mMovie, p, 0, { function(p3)
			local v34 = __wf_atom_fa1258d0()

			for i = 1, 4 do
				local v35 = p .. ".Coin" .. i
				local v36 = math.sin(p3 * 1 * 3.1415927410125732) * -v32[i][3]
				local v37 = __wf_atom_104bfe98(v31[i] + v36, v31[i], (math.pow(p3, 4)))
				local v38 = __wf_atom_104bfe98(v30[i] * v32[i][4], v30[i], (math.pow(p3, 4)))
				mMovie:__wf_atom_e57658c2(v35, 0, v38)
				mMovie:__wf_atom_e57658c2(v35, 1, v37)
				v32[i][2] += v32[i][1] * v34
				mMovie:__wf_atom_e57658c2(v35, 16, v32[i][2])
				math.pow(p3, 0.5)
			end
		end }, { 1 }, 0.65, nil, fn14)
end

local function fn14()
	if flag6 then
		return
	end

	if v == 2 then
		if flag5 then
			flag3 = true
			v15:AddTimer(0.2, function()
				fn13("OCoins")
			end)
		else
			fn8("OCoins", true)
			fn8("Coins", false)
		end
	elseif flag4 then
		flag3 = true
		v15:AddTimer(0.2, function()
			fn13("Coins")
		end)
	else
		fn8("Coins", true)
		fn8("OCoins", false)
	end
end

local function fn15()
	if flag6 then
		return
	end

	if v == 1 then
		if NON_HUB_GAME > frozen2.SELECTING_SIDE then
			NON_HUB_GAME = frozen2.OPPONENT_TURN
		end

		v = 2
	else
		if NON_HUB_GAME > frozen2.SELECTING_SIDE then
			NON_HUB_GAME = frozen2.LOCAL_TURN
		end

		v = 1
	end

	v3 = 0
	fn14()
end

function Flip(_, p)
	if flag6 or p == "Coins" and v ~= 1 or p == "OCoins" and v ~= 2 or not mMovie:__wf_atom_bd8fa442(p, "Glow", 13) then
		return
	end

	if v3 == 0 then
		fn13(p)
		fn8(p, false)
	end
end

local function fn16(p)
	if p == nil then
		return false
	end

	local v30 = v12[p]
	return v30 == nil or (v ~= 1 or not (v30 < 100)) and (v ~= 2 or not (v30 >= 100)) and p ~= "C4"
end

local function fn17(p)
	local v30 = v6[v][p]

	if v30 == nil or not mMovie:__wf_atom_a91463a8(v7[p], 13) then
		return 0
	end

	for i = 1, v3 do
		local v31 = v8[i]

		if not v31 then
			__wf_atom_86cbd68d(mMovie, "MoveDot.duplicateMovieClip", "MoveDot" .. i, i)
			v31 = "MoveDot" .. i
			v8[i] = v31
		end

		__wf_atom_86cbd68d(mMovie, v31 .. ".swapDepths", 4300 + i)
		v30 += 1
		local v32 = v9[v][v30]

		if v32 ~= nil then
			mMovie:__wf_atom_e57658c2(v31, 0, mMovie:__wf_atom_5e6e15c8(v32, 0))
			mMovie:__wf_atom_e57658c2(v31, 1, mMovie:__wf_atom_5e6e15c8(v32, 1))
			mMovie:__wf_atom_e57658c2(v31, 11, 12648384)
			mMovie:__wf_atom_e57658c2(v31, 12, 80)
			mMovie:__wf_atom_2dedec1a(v31, 13, true)
		end

		if not (v32 == nil or i == v3 and not fn16(v32)) then
			continue
		end

		module.PlaySound(_G.UISound_Error)
		mMovie:__wf_atom_e57658c2(v31, 11, 16761024)

		for j = 1, v3 do
			mMovie:__wf_atom_e57658c2(v8[j], 11, 16761024)
			mMovie:__wf_atom_e57658c2(v8[j], 12, 80)
		end

		return 0
	end

	local total2 = 1

	if (v ~= 2 or not flag5) and (v ~= 1 or not flag4) then
		return total2
	end

	local v31 = v6[v][p]
	local v32 = v9[v][v31 + v3]

	if v12[v32] then
		total2 += 2
	end

	if v11[v32] then
		total2 += 2
	end

	if v32 == v9[v][#v9[v]] then
		total2 += 2
	end

	return total2
end

local function fn18()
	for i = 1, #v8 do
		mMovie:__wf_atom_2dedec1a(v8[i], 13, false)
	end
end

local function fn19(p, p2)
	if p == nil then
		return
	end

	mMovie:__wf_atom_7f57ab2f(p, "Glow", 13, p2)
end

local function fn20(list, p)
	local v30 = __wf_atom_421b01aa(p, 0, 1)
	local v31 = (#list - 1) * v30
	local v32 = math.floor(v31) + 1
	local v33 = math.min(v32 + 1, #list)
	local v34 = v31 - (v32 - 1)
	return
		__wf_atom_104bfe98(list[v32][1], list[v33][1], v34),
		__wf_atom_104bfe98(list[v32][2], list[v33][2], v34),
		(__wf_atom_104bfe98(list[v32][3], list[v33][3], v34))
end

local function fn21(p, p2)
	module.PlaySound(knockOffSound)
	module.PlaySound(_G.UISound_HudAchievement)
	v24 = 0.5

	if math.random() < 0.1 then
		if p2 == 2 then
			fn10(gotCapturedTransmission)
		else
			fn10(capturedTransmission)
		end
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p, 0)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(p, 1)
	local v30 = v5[p2]
	local v31 = nil
	local v32 = nil

	for i = #v30, 1, -1 do
		local v33 = v30[i]

		if v33[1] then
			continue
		end

		v33[1] = p
		v31 = v33[2]
		v32 = v33[3]
		break
	end

	local v33 = 0

	for i = 1, #v30 do
		local v34 = v30[i]

		if not v34[1] then
			continue
		end

		__wf_atom_86cbd68d(mMovie, v34[1] .. ".swapDepths", 2000 - i)
		local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(v34[1], 100)

		if v33 then
			v6[p2][__wf_atom_5e6e15c8_3] = 0
			v33 = false
		else
			v6[p2][__wf_atom_5e6e15c8_3] = nil
		end
	end

	__wf_atom_ec43d06e(mMovie, p, 0, { function(p3)
			local v34 = __wf_atom_24a82b69(__wf_atom_24a82b69(p3))
			mMovie:__wf_atom_e57658c2(p, 0, __wf_atom_104bfe98(__wf_atom_5e6e15c8, v31, v34))
			local v35 = __wf_atom_104bfe98(__wf_atom_5e6e15c8_2, v32, v34)
			local v36

			if p2 == 1 then
				v36 = v35 + math.sin(v34 * 3.1415927410125732) * 100
			else
				v36 = v35 + math.sin(v34 * 3.1415927410125732) * -100
			end

			mMovie:__wf_atom_e57658c2(p, 1, v36)
		end }, { 1 }, 0.5)
end

local function fn22(p, p2)
	local v30 = v5[p2]

	for i = 1, #v30 do
		local v31 = v30[i]

		if v31[1] ~= p then
			continue
		end

		v31[1] = nil
		break
	end

	for i = 1, #v30 do
		local v31 = v30[i]

		if not v31[1] then
			continue
		end

		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v31[1], 100)
		v6[p2][__wf_atom_5e6e15c8] = 0
		break
	end
end

local function fn23(p)
	local v30 = v6[v][p]

	if v30 == nil then
		return
	end

	local v31 = v7[p]
	local v32 = v30 + v3
	local v33 = v9[v][v30]
	local v34 = v9[v][v32]

	if not fn16(v34) then
		module.PlaySound(_G.UISound_Error)
		return false
	end

	if NON_HUB_GAME == frozen2.LOCAL_TURN then
		fn3(p)
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v31, 0)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v31, 1)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(v31, 5)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(v34, 0)
	local __wf_atom_5e6e15c8_5 = mMovie:__wf_atom_5e6e15c8(v34, 1)
	local __wf_atom_5e6e15c8_6 = mMovie:__wf_atom_5e6e15c8(v34, 5)
	__wf_atom_86cbd68d(mMovie, v31 .. ".swapDepths", 3300)
	v21[v] += v3
	module.PlaySound(moveSound)
	v19 = true
	local v37 = {
		{ __wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2, __wf_atom_5e6e15c8_3 }
	}

	for i = 1, v3 do
		local v38 = v9[v][v30 + i]
		v37[i + 1] = {
			mMovie:__wf_atom_5e6e15c8(v38, 0),
			mMovie:__wf_atom_5e6e15c8(v38, 1),
			mMovie:__wf_atom_5e6e15c8(v38, 5)
		}
	end

	local v38 = math.max(0.5, #v37 * 0.25)
	__wf_atom_ec43d06e(mMovie, v31, 0, { function(p2)
			local v39 = __wf_atom_24a82b69(__wf_atom_24a82b69(p2))

			if #v37 > 1 then
				local v40, v41, v42 = fn20(v37, v39)
				mMovie:__wf_atom_e57658c2(v31, 0, v40)
				mMovie:__wf_atom_e57658c2(v31, 1, v41)
				mMovie:__wf_atom_e57658c2(v31, 5, v42)
				mMovie:__wf_atom_e57658c2(v31, 6, v42)
			else
				mMovie:__wf_atom_e57658c2(v31, 0, __wf_atom_104bfe98(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_4, v39))
				mMovie:__wf_atom_e57658c2(v31, 1, __wf_atom_104bfe98(__wf_atom_5e6e15c8_2, __wf_atom_5e6e15c8_5, v39))
				mMovie:__wf_atom_e57658c2(v31, 5, __wf_atom_104bfe98(__wf_atom_5e6e15c8_3, __wf_atom_5e6e15c8_6, v39))
				mMovie:__wf_atom_e57658c2(v31, 6, __wf_atom_104bfe98(__wf_atom_5e6e15c8_3, __wf_atom_5e6e15c8_6, v39))
			end

			mMovie:__wf_atom_4c1c1986(v31, "Glow", 12, (1 - p2) * 100)
		end }, { 1 }, v38, nil, function()
		v19 = false
		module.PlaySound(landSound)
	end)
	local v39 = v12[v34]

	if v39 then
		local v40 = v7[v39]
		local v41 = v == 1 and 2 or 1
		v15:AddTimer(v38 - 0.3, function()
			fn21(v40, v41)
		end)
		v22[v] += 1
	end

	if v30 == 0 then
		fn22(v31, v)
	else
		v12[v9[v][v30]] = nil
	end

	v12[v9[v][v32]] = p
	v6[v][p] = v32

	if v32 == #v9[v] then
		local v40 = v
		v15:AddTimer(v38, function()
			module.PlaySound(_G.UISound_HudAchievement)
			v12[v9[v40][v32]] = nil
			__wf_atom_ec43d06e(mMovie, v31, 0, { function(p2)
					local v41 = __wf_atom_24a82b69(1 - p2)
					mMovie:__wf_atom_e57658c2(v31, 12, v41 * 100)
					mMovie:__wf_atom_e57658c2(v31, 5, __wf_atom_104bfe98(10, 38, v41))
					mMovie:__wf_atom_e57658c2(v31, 6, __wf_atom_104bfe98(10, 38, v41))
				end }, { 1 }, 0.5, nil, function()
				mMovie:__wf_atom_2dedec1a(v31, 13, false)
			end)
			v13[v40] += 1
			fn12()

			if not flag6 then
				module.PlaySound(pointSound)
			end
		end)
	end

	fn19(v33, false)

	if v11[v34] then
		v15:AddTimer(v38, function()
			fn14()
			fn19(v34, true)
			module.PlaySound(protectedSound)
		end)
	else
		v15:AddTimer(v38, function()
			fn15()
		end)
	end

	return true
end

local function fn24(p)
	if v3 == 0 or NON_HUB_GAME == frozen2.SELECTING_SIDE then
		return false
	end

	if p < 100 then
		local v30 = v6[v][p]
		return v == 1 and not flag4 and v30
	else
		local v30 = v6[v][p]
		return v == 2 and not flag5 and v30
	end
end

function PieceFocused(p, p2)
	if not fn24(p) then
		v25 = { p, p2 }
		return
	end

	module.PlaySound(_G.UISound_Focus)
	v2 = p
	mMovie:__wf_atom_4c1c1986(p2, "Glow", 12, 100)
	fn17(p)
end

function PieceUnfocused(p, p2)
	v25 = nil

	if not fn24(p) then
		return
	end

	module.PlaySound(_G.UISound_Unfocus)
	v2 = nil
	mMovie:__wf_atom_4c1c1986(p2, "Glow", 12, 0)
	fn18()
end

function PieceReleased(_) end

function PiecePressed(p, p2)
	v25 = nil

	if not fn24(p) then
		return
	end

	if fn23(p) then
		mMovie:__wf_atom_4c1c1986(p2, "Glow", 12, 0)
		module.PlaySound(_G.UISound_Select)
		fn18()
		v3 = 0
	end
end

local function fn25(p, p2, p3, value, value2)
	local v30 = p2 - 1
	local v31 = p3 - 1
	local v32 = v4[v31]
	local v33 = v30 / 7
	local v34 = __wf_atom_104bfe98(v32.LX, v32.RX, v33)
	mMovie:__wf_atom_e57658c2(p, 0, v34 + (value or 0))
	local v35 = __wf_atom_104bfe98(v32.LY, v32.RY, v33)
	mMovie:__wf_atom_e57658c2(p, 1, v35 + (value2 or 0))
	local v36 = 94 + v31 * 3
	mMovie:__wf_atom_e57658c2(p, 5, v36)
	mMovie:__wf_atom_e57658c2(p, 6, v36)
end

local function fn26(p, i)
	if i < 5 or i > 12 then
		if p then
			return 1
		end

		return 3
	else
		return 2
	end
end

local function fn27()
	local v30 = {
		4,
		3,
		2,
		1,
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		8,
		7,
		6
	}
	v9[1] = {
		"A1",
		"A2",
		"A3",
		"A4",
		"C1",
		"C2",
		"C3",
		"C4",
		"C5",
		"C6",
		"C7",
		"C8",
		"A5",
		"A6",
		"A7"
	}
	v9[2] = {
		"O1",
		"O2",
		"O3",
		"O4",
		"C1",
		"C2",
		"C3",
		"C4",
		"C5",
		"C6",
		"C7",
		"C8",
		"O5",
		"O6",
		"O7"
	}
	v10 = {
		C1 = true,
		C2 = true,
		C3 = true,
		C4 = true,
		C5 = true,
		C6 = true,
		C7 = true,
		C8 = true
	}
	v11 = {
		A4 = true,
		C4 = true,
		O4 = true,
		O6 = true,
		A6 = true
	}

	for i, list in ipairs(v9) do
		for j, v31 in ipairs(list) do
			fn25(v31, v30[j], fn26(i == 2, j))
			mMovie:__wf_atom_7f57ab2f(v31, "Glow", 13, false)
			v12[v31] = nil
		end
	end

	fn25("A7", 6, 3, -2, -9)
	fn25("O7", 6, 1, -8, -18)
end

function Shutdown()
	module2.HideBackground()
	module3.RegisterHideHud(false)
end

function ConfirmQuit(p)
	if tonumber(p) ~= 4 then
		return
	end

	if fn6() then
		Quit()
		return
	end

	__wf_atom_ec43d06e(
		mMovie,
		"GameBoard",
		2,
		{ 16, 1, 0 },
		{ Random(-10, 10), Random(-400, -200), Random(-100, 2000) },
		0.5,
		0,
		Quit
	)
	local v30 = {}
	table.insert(v30, "T" .. 1)
	table.insert(v30, "OT" .. 1)
	table.insert(v30, "T" .. 2)
	table.insert(v30, "OT" .. 2)
	table.insert(v30, "T" .. 3)
	table.insert(v30, "OT" .. 3)
	table.insert(v30, "T" .. 4)
	table.insert(v30, "OT" .. 4)

	for _, v31 in v30 do
		__wf_atom_ec43d06e(mMovie, v31, 2, { 5, 6, 1, 0 }, {
			200,
			200,
			Random(-400, -200),
			Random(-100, 2000)
		}, 0.5, 0)
	end

	local v31 = {}
	table.insert(v31, "Coins.Coin" .. 1)
	table.insert(v31, "OCoins.Coin" .. 1)
	table.insert(v31, "Coins.Coin" .. 2)
	table.insert(v31, "OCoins.Coin" .. 2)
	table.insert(v31, "Coins.Coin" .. 3)
	table.insert(v31, "OCoins.Coin" .. 3)
	table.insert(v31, "Coins.Coin" .. 4)
	table.insert(v31, "OCoins.Coin" .. 4)

	for _, v32 in v31 do
		__wf_atom_ec43d06e(
			mMovie,
			v32,
			2,
			{ 5, 6, 1, 0 },
			{ 70, 70, Random(-1300, -1100), Random(-1000, 1000) },
			0.5,
			0
		)
	end
end

function TryQuit()
	module.ShowYesOrNoMessage("/SF/Language/Minigames/QuitUr", "ConfirmQuit")
end

function ExitButtonClicked()
	ConfirmQuit(4)
end

function Initialize()
	local v30 = {}
	table.insert(v30, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = ExitButtonClicked,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v30, getfenv(1))
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		mMovie:Close()
		return
	end

	mMovie:__wf_atom_c90af43a("GameBoard", gameBoardTexture)
	module3.RegisterHideHud(true)
	module2.ShowBackground({ mHideBlur = true })

	for i = 0, 2 do
		v4[i] = {
			LX = mMovie:__wf_atom_cfc41e35("Markers", "L" .. i, 0),
			LY = mMovie:__wf_atom_cfc41e35("Markers", "L" .. i, 1),
			RX = mMovie:__wf_atom_cfc41e35("Markers", "R" .. i, 0),
			RY = mMovie:__wf_atom_cfc41e35("Markers", "R" .. i, 1)
		}
	end

	mMovie:__wf_atom_2dedec1a("Markers", 13, false)
	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v15 = module4.CreateTimerMgr()
	v20 = gRegion:PlaySound(startSound, Vector(), false)
	mMovie:__wf_atom_50d60589("Score.Name", 36, __wf_atom_18a5d83b:__wf_atom_6be84646())
	v23 = __wf_atom_c08f5a0e(1, 3)
	local v31 = v23 == 2 and "II" or v23 == 3 and "III" or ""
	mMovie:__wf_atom_50d60589("OScore.Name", 36, Localize("/SF/Language/Characters/Avakot", {}) .. " " .. v31)
	fn12()
	module2.DissolveIn(mMovie)
	mMovie:__wf_atom_7f57ab2f("OCoins", "Glow", 13, false)
	mMovie:SetCallbacks("Coins", "CoinsFocused", "CoinsUnfocused", "CoinsReleased", "Flip")
	fn27()
	mMovie:__wf_atom_2dedec1a("MoveDot", 13, false)
	mMovie:__wf_atom_e57658c2("EndCard", 12, 0)
	v = 1

	for i = 1, 4 do
		local v32 = "T" .. i
		mMovie:SetCallbacks(v32, "PieceFocused", "PieceUnfocused", "PieceReleased", "PiecePressed")
		mMovie:__wf_atom_4c1c1986(v32, "Glow", 12, 0)
		mMovie:OverrideMaterial(v32 .. ".Glow", glowMaterial)
		mMovie:__wf_atom_c90af43a(v32 .. ".Icon", playerTokens[i])
		mMovie:__wf_atom_e57658c2(v32, 100, i)
		v7[i] = v32
		table.insert(v5[1], { v32, mMovie:__wf_atom_5e6e15c8(v32, 0), mMovie:__wf_atom_5e6e15c8(v32, 1) })
		__wf_atom_86cbd68d(mMovie, v32 .. ".swapDepths", 2000 - i)
		local v33 = "OT" .. i
		mMovie:__wf_atom_e57658c2(v33, 5, 91)
		mMovie:__wf_atom_e57658c2(v33, 6, 91)
		mMovie:__wf_atom_4c1c1986(v33, "Glow", 12, 0)
		mMovie:OverrideMaterial(v33 .. ".Glow", glowMaterial)
		mMovie:__wf_atom_c90af43a(v33 .. ".Icon", avakotTokens[i])
		mMovie:__wf_atom_e57658c2(v33, 100, 100 + i)
		v7[100 + i] = v33
		table.insert(v5[2], { v33, mMovie:__wf_atom_5e6e15c8(v33, 0), mMovie:__wf_atom_5e6e15c8(v33, 1) })
		__wf_atom_86cbd68d(mMovie, v33 .. ".swapDepths", 2000 - i)
	end

	v6[1][1] = 0
	v6[2][101] = 0

	for i = 1, 4 do
		mMovie:__wf_atom_4c1c1986("Coins." .. "Coin" .. i, "Heads", 12, 0)
		mMovie:__wf_atom_4c1c1986("OCoins." .. "Coin" .. i, "Heads", 12, 0)
	end

	__wf_atom_86cbd68d(mMovie, "Coins.swapDepths", 3001)
	__wf_atom_86cbd68d(mMovie, "OCoins.swapDepths", 3002)
	mMovie:__wf_atom_e57658c2("OCoins", 5, 91)
	mMovie:__wf_atom_e57658c2("OCoins", 6, 91)
	mMovie:__wf_atom_e57658c2("Coins", 1, 890)
	mMovie:__wf_atom_e57658c2("OCoins", 1, 200)
	mMovie:__wf_atom_2dedec1a("O7.EndIcon", 13, false)
	mMovie:__wf_atom_2dedec1a("A7.EndIcon", 13, false)
	fn8("Coins", false)
	fn8("OCoins", false)
	fn10(startTransmission)
	fn14()
	onViewportSizeChanged(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

local function fn28()
	local v30 = v == 2 and 100 or 0
	v16[v] = {}
	local v31 = false

	for i = 1, 4 do
		local v32 = i + v30
		local v33 = fn17(v32)

		if not (v33 > 0) then
			continue
		end

		table.insert(v16[v], { v32, v33 })
		v31 = true
	end

	if not v31 then
		if NON_HUB_GAME > frozen2.NON_HUB_GAME then
			fn4()
		end

		print("No valid move for player: " .. v)
		fn15()
	end

	fn18()
end

local function fn29(p, p2)
	if flag3 then
		return
	end

	if v18[p] > 0 then
		v18[p] -= p2
	else
		v18[p] = v17[v23]
		local v30 = v16[p]

		if #v30 == 0 then
			fn7()
			return
		end

		local total2 = 0

		for i = 1, #v30 do
			total2 += v30[i][2]
		end

		for i = 1, #v30 do
			v30[i][2] /= total2
		end

		module.ShuffleTable(v30)
		local v31 = 1

		if v23 ~= 1 then
			if v23 == 2 then
				table.sort(v30, function(a, b)
					return a[2] < b[2]
				end)
				local v32 = __wf_atom_8d119bab(0, 1)

				for i = 1, #v30 do
					local v33 = v30[i][2]

					if v32 <= v33 then
						v31 = i
						break
					else
						v32 -= v33
					end
				end
			elseif v23 == 3 then
				table.sort(v30, function(a, b)
					return a[2] > b[2]
				end)
				v31 = 1
			end
		end

		fn23(v30[v31][1])
	end
end

function Update()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:IsKilled() then
		mMovie:Close()
		return
	end

	local v30 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v30)
	total += v30

	if not __wf_atom_7e8ad928(v15) then
		v15:Update(v30)
	end

	v24 = math.max(0, v24 - v30)

	if v24 > 0 then
		local v31 = __wf_atom_24a82b69(v24) * 200
		mMovie:__wf_atom_e57658c2("_root", 0, Noise(Time() * 1.5) * v31 * 0.5)
		mMovie:__wf_atom_e57658c2("_root", 1, Noise(3.3 + Time() * 1.5) * v31)
	end

	if not (v19 or flag3) then
		if flag then
			flag = false
			fn15()
		else
			if flag2 then
				flag2 = false
				fn28()

				if v25 then
					local v31 = v25[1]
					local v32 = v25[2]
					v25 = nil
					PieceFocused(v31, v32)
				end
			end

			if v == 1 and flag4 then
				fn29(1, v30)
			end

			if v == 2 and flag5 then
				fn29(2, v30)
			end
		end
	end

	local v31 = math.abs((math.sin(__wf_atom_4658d645(Time() * 0.5) * 2 * 3.1415927410125732)))

	if v == 1 or NON_HUB_GAME == frozen2.SELECTING_SIDE then
		mMovie:__wf_atom_e57658c2("Coins.Glow", 12, v31 * 50 + 50)
	else
		mMovie:__wf_atom_e57658c2("Score.Backer", 12, 50)
	end
end

function Quit()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		if not __wf_atom_7e8ad928(v29) then
			fn5()
		end

		__wf_atom_c4f78a8f:__wf_atom_84b48bf2(0)

		if gGameRules:__wf_atom_95862cc1() then
			local v30 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
			gGameRules:SendControlMessage(v30)
		end

		local movie = __wf_atom_8e4fda44:FindMovie(WeakResource("/SF/Interface/Hub.swf"))

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("ClearRegattaGame", "")
		end

		__wf_atom_c4f78a8f:__wf_atom_7ab15c94(nil)
	end

	mMovie:Close()
	v20 = nil
end

function onKeyDown_MENU_SELECT(_, _)
	return true
end

function onKeyDown_MENU_CANCEL(_, _)
	TryQuit()
	return true
end

function onKeyDown_MENU_GENERIC1()
	return true
end

function onKeyDown_MENU_GENERIC2()
	return true
end

function ProcessHudMessage(p, from, to, p2)
	print("Ur HUDMessage: type(" .. p .. "), from(" .. from .. "), to(" .. to .. "), value(" .. p2 .. ")")
	local v30 = tonumber(p)

	if not __wf_atom_7e8ad928(v30) then
		v26 = { type = v30, from = from, to = to, value = p2 }

		if v30 == frozen.MP_START then
			flag4 = false
			flag5 = false
			NON_HUB_GAME = frozen2.SELECTING_SIDE
			v29 = from
			mMovie:__wf_atom_50d60589("OScore.Name", 36, p2)
			mMovie:__wf_atom_50d60589("EndCard.Avakot.Name", 36, p2)
			print("Ur GAME_STATE: SELECTING_SIDE")
		elseif v30 == frozen.MP_FLIP then
			v28 = tonumber(p2)

			if v28 == 0 then
				fn7()
			end

			fn13("OCoins", v28)

			if NON_HUB_GAME == frozen2.SELECTING_SIDE then
				fn9()
			end
		elseif v30 == frozen.MP_MOVE then
			local v31 = tonumber(p2) + 100
			v3 = v28

			if fn23(v31) then
				return
			end
		elseif v30 == frozen.MP_NO_VALID_MOVES then
			fn7()
		elseif v30 == frozen.MP_QUIT then
			flag6 = true
			v13[1] = 4
			v29 = nil
			fn12()
		end
	end
end

function SendRegattaGameRequest(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_94cc9c18) then
		local __wf_atom_70f5d0a5 = gGameRules:__wf_atom_70f5d0a5(__wf_atom_3d96ddcd)
		gMatchingService:__wf_atom_9c7c90fb():__wf_atom_2586e47b(__wf_atom_70f5d0a5)
		local v30 = {
			minigame = "ur",
			regattagamerequest = 1,
			value = gRegion:__wf_atom_eab484a7():__wf_atom_6be84646()
		}
		local encoded = cjson.encode(v30)
		gMatchingService:__wf_atom_6ff767a1(__wf_atom_70f5d0a5, encoded)
	end
end