local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Souls.Powers.EntitySoulModeScans")
local v = { 2, 1, 0 }
local v2 = {
	[0] = {
		DecoColourBase = 9509402,
		DecoColourLow = 9509402,
		DecoColourHigh = 9509402,
		TrailColour = 14249053,
		LightColour = 14249053
	},
	[2] = {
		DecoColourBase = 1533183,
		DecoColourLow = 1533183,
		DecoColourHigh = 1533183,
		TrailColour = 8761599,
		LightColour = 8761599
	},
	[1] = {
		DecoColourBase = 1935127,
		DecoColourLow = 1935127,
		DecoColourHigh = 1935127,
		TrailColour = 12451750,
		LightColour = 12451750
	}
}

local function fn(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		print("ERROR - Mockery SoulStealEntity - Somehow instigating avatar of soulsteal did not have an inventory control.")
	else
		local __wf_atom_a8e8c5c4 = __wf_atom_d2b2176d:__wf_atom_a8e8c5c4()

		if not (__wf_atom_7e8ad928(__wf_atom_a8e8c5c4) or __wf_atom_d2b2176d:__wf_atom_d93821d0((__wf_atom_a8e8c5c4:__wf_atom_55da7898()))) then
			return __wf_atom_a8e8c5c4
		end
	end

	return nil
end

function OnPreDeathSteal(object, object2)
	module2.GiveEnemyScan(object, object2)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if not __wf_atom_575542c8 then
		print("ERROR - Mockery SoulStealEntity - Spirit Avatar invalid on SoulSteal start.")
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_575542c8:__wf_atom_bb3e7833(soulType)
	local v3 = nil

	if __wf_atom_bb3e7833 then
		v3 = __wf_atom_bb3e7833:__wf_atom_e919fb8e()

		if v3 then
			local total = 0

			while __wf_atom_bb3e7833 and v3 and not v3.bPullStarted do
				Sleep(0)
				total += __wf_atom_084b3e93()

				if total > 1 then
					break
				end
			end
		end
	else
		Sleep(0.5)
	end

	local __wf_atom_6f4c1c1b = __wf_atom_575542c8:__wf_atom_6f4c1c1b()

	if __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) then
		print("WARNING - Mockery SoulStealEntity: Attempted to destroy spirit body on owning mockery when soul stealing wisp, but owning mockery did not exist. This implies this wisp was soul stolen without killing a mockery first.")
	else
		local taggedChildren = module.FindTaggedChildren(__wf_atom_6f4c1c1b:__wf_atom_be0bea4a(), Symbol("SpiritDeco"))

		if #taggedChildren > 0 then
			for _, v4 in ipairs(taggedChildren) do
				v4:Destroy()
			end
		end
	end

	__wf_atom_575542c8:SetVisibility(false)
	object:__wf_atom_e919fb8e()
	local __wf_atom_876731d0 = object:__wf_atom_876731d0()
	local __wf_atom_9fe17f23 = object:__wf_atom_9fe17f23()

	if __wf_atom_7e8ad928(__wf_atom_876731d0) or __wf_atom_7e8ad928(__wf_atom_9fe17f23) then
		__wf_atom_876731d0 = fn(object2)

		if __wf_atom_7e8ad928(__wf_atom_876731d0) then
			__wf_atom_876731d0 = object2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			if __wf_atom_7e8ad928(__wf_atom_876731d0) then
				print("WARNING - Mockery SoulStealEntity: Fallback of instigator avatar.")
				__wf_atom_876731d0 = object2
			else
				print("WARNING - Mockery SoulStealEntity: Fallback of pact: ", __wf_atom_876731d0:__wf_atom_5b41f63b())
			end
		else
			print("WARNING - Mockery SoulStealEntity: Fallback of weapon: ", __wf_atom_876731d0:__wf_atom_5b41f63b())
		end
	else
		object2 = __wf_atom_9fe17f23
	end

	if gRegion:IsMaster() then
		local total = 0

		while __wf_atom_bb3e7833 and v3 and not v3.bPullComplete do
			Sleep(0)
			total += __wf_atom_084b3e93()

			if total > 1 then
				break
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) then
			__wf_atom_6f4c1c1b:__wf_atom_30d17f39(0, 20, 0, 0, object2, __wf_atom_876731d0)
		end

		__wf_atom_575542c8:Destroy()
	end
end

function OnIdleSoulSteal(object, object2)
	if gRegion:IsMaster() then
		local __wf_atom_575542c8 = object:__wf_atom_575542c8()
		local __wf_atom_30e3d82b = __wf_atom_575542c8:__wf_atom_30e3d82b()

		if not (__wf_atom_7e8ad928(__wf_atom_575542c8) or __wf_atom_7e8ad928(__wf_atom_30e3d82b)) then
			__wf_atom_30e3d82b:__wf_atom_30b587a4()
			__wf_atom_575542c8:SetBlackboardBool(Symbol("IsEarlySoulSteal"), true)
			object2:Attach(IdleStealFX, Symbol("GAME_L1_ARM3"))
		end
	end
end

function OnSoulStealEntityCreated(object)
	if object then
		Sleep(0)
		local v3 = nil
		local total = 0

		while not v3 do
			v3 = object:__wf_atom_3d96ddcd()
			Sleep(0)
			total += __wf_atom_084b3e93()

			if total > 2 then
				break
			end
		end

		if v3 then
			v3:Attach(soulType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v3)
			local taggedChild = module.FindTaggedChild(v3:__wf_atom_be0bea4a(), Symbol("WispDeco"))

			if __wf_atom_7e8ad928(taggedChild) then
				print("MOCKERY WISP - ERROR - Cannot find wisp deco to change colors for.")
				return
			end

			local taggedChild2 = module.FindTaggedChild(taggedChild:__wf_atom_be0bea4a(), Symbol("WispEnergy"))
			local taggedChild3 = module.FindTaggedChild(taggedChild:__wf_atom_be0bea4a(), Symbol("WispTrail"))
			local taggedChild4 = module.FindTaggedChild(taggedChild:__wf_atom_be0bea4a(), Symbol("WispEmbers"))
			local taggedChild5 = module.FindTaggedChild(taggedChild:__wf_atom_be0bea4a(), Symbol("WispSmoke"))
			local taggedChild6 = module.FindTaggedChild(taggedChild:__wf_atom_be0bea4a(), Symbol("WispLight"))
			local info = object:GetInfo()
			local v4 = nil

			for _, v5 in ipairs(v) do
				if not info:__wf_atom_d74a80d6(v5) then
					continue
				end

				v4 = v2[v5]
				break
			end

			if not __wf_atom_7e8ad928(v4) then
				local v5 = Color(v4.DecoColourBase)
				local v6 = Color(v4.DecoColourLow)
				local v7 = Color(v4.DecoColourHigh)
				local v8 = Color(v4.TrailColour)
				local v9 = Color(v4.LightColour)

				if not __wf_atom_7e8ad928(taggedChild) then
					taggedChild:SetMaterialParam(
						Symbol("TintColor"),
						v5.red / 225,
						v5.green / 225,
						v5.blue / 225,
						225,
						false
					)
					taggedChild:SetMaterialParam(
						Symbol("LowColor"),
						v6.red / 225,
						v6.green / 225,
						v6.blue / 225,
						225,
						false
					)
					taggedChild:SetMaterialParam(
						Symbol("HighColor"),
						v7.red / 225,
						v7.green / 225,
						v7.blue / 225,
						225,
						false
					)
				end

				if not __wf_atom_7e8ad928(taggedChild2) then
					taggedChild2:SetMaterialParam(
						Symbol("TintColor"),
						v5.red / 225,
						v5.green / 225,
						v5.blue / 225,
						5,
						false
					)
					taggedChild2:SetMaterialParam(
						Symbol("LowColor"),
						v6.red / 225,
						v6.green / 225,
						v6.blue / 225,
						5,
						false
					)
					taggedChild2:SetMaterialParam(
						Symbol("HighColor"),
						v7.red / 225,
						v7.green / 225,
						v7.blue / 225,
						5,
						false
					)
				end

				if not __wf_atom_7e8ad928(taggedChild3) then
					taggedChild3:SetMaterialParam(
						Symbol("TintColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						225,
						false
					)
					taggedChild3:SetMaterialParam(
						Symbol("LowColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						5,
						false
					)
					taggedChild3:SetMaterialParam(
						Symbol("HighColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						5,
						false
					)
				end

				if not __wf_atom_7e8ad928(taggedChild4) then
					taggedChild4:SetMaterialParam(
						Symbol("TintColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						225,
						false
					)
					taggedChild4:SetMaterialParam(
						Symbol("LowColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						5,
						false
					)
					taggedChild4:SetMaterialParam(
						Symbol("HighColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						5,
						false
					)
				end

				if not __wf_atom_7e8ad928(taggedChild5) then
					taggedChild5:SetMaterialParam(
						Symbol("TintColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						225,
						false
					)
					taggedChild5:SetMaterialParam(
						Symbol("LowColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						5,
						false
					)
					taggedChild5:SetMaterialParam(
						Symbol("HighColor"),
						v8.red / 225,
						v8.green / 225,
						v8.blue / 225,
						5,
						false
					)
				end

				if not __wf_atom_7e8ad928(taggedChild6) then
					taggedChild6:SetColor(v9)
				end
			end
		else
			print("MOCKERY WISP - ERROR - Mockery Wisp SoulStealEntity wasn't attached to a Wisp avatar.")
		end
	end
end