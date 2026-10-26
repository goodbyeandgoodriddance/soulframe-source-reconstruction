local module = require("SF.Scripts.Libs.TransmissionSet")
local v = Resource("/Lotus/Types/Game/Store/ProductsManifest")
local v2 = Resource("/Lotus/Types/Gameplay/Minigames/Investigation/InvestigationBlockingInputFilter")
local v3 = { "Grace   ", "Power   ", "Spirit  ", "Life  " }
local v4 = false
local v5 = false
local v6 = 1
local v7 = 1
local v8 = 1
local flag = false
local v9 = {}
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local attributes = {}

local function fn(level)
	if not __wf_atom_7e8ad928(level) then
		local levelArgs = Engine.OpenLevelArgs()
		levelArgs.level = level
		levelArgs.menuMovie = __wf_atom_c67f9605:__wf_atom_cf8a801d()
		levelArgs.gameRules = gClient:__wf_atom_2aee259b()
		levelArgs.hostingMultiplayer = false
		levelArgs.restartLevel = false
		Engine.OpenLevel(levelArgs)
	end
end

local function fn2()
	v4, v5 = __wf_atom_489de21b("ForgeMenu", v5)

	if v4 then
		__wf_atom_05a856ad("                                                                 Ancestor Standing: " .. _T.AncestorStanding .. "   ")

		if __wf_atom_83a4046b("Forge Tabs") then
			if __wf_atom_19d02a1f("Forge") then
				__wf_atom_05a856ad("")
				v7 = __wf_atom_1e44eb21("Choose a recipe", { "Basic Ode Dagger", "Rare Ornate Longsword" }, v7, 2)
				__wf_atom_05a856ad("")
				flag = true

				if v7 == 1 then
					v9.title = "BASIC ODE DAGGER"
					v9.fragments = "Warped Ode Dagger Hilt"
					v9.materials = "3x Frostbound Gems, 1x Rose Heartwood"
					v9.kintsugi = { "Ode Steel", "Stoneglass", "Gold" }
				elseif v7 == 2 then
					v9.title = "RARE ORNATE LONGSWORD"
					v9.fragments = "Rare Ornate Longsword Blade Shard, Rare Ornate Longsword Pommel"
					v9.materials = "2x Star Gems, 1x Restored gold goblet"
					v9.kintsugi = { "Dark Iron", "Shardcopper", "Carbonsteel" }
				end

				v9.songs = { "Battle", "Fire", "Healing" }
				__wf_atom_05a856ad("FORGE " .. v9.title .. " RECIPE")
				__wf_atom_07947f07()
				__wf_atom_05a856ad("Fragments: " .. v9.fragments)
				__wf_atom_05a856ad("Materials: " .. v9.materials)
				__wf_atom_07947f07()
				__wf_atom_05a856ad("Kintsugi Material:")
				v6 = __wf_atom_fdfab732("##kint", v6, v9.kintsugi)

				if v6 >= 2 and _T.ForgeLevel < v6 then
					__wf_atom_05a856ad("Forge level " .. v6 .. " required!")
					flag = false
				end

				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Song:")
				v8 = __wf_atom_fdfab732("Song", v8, v9.songs)
				__wf_atom_05a856ad("Words: Fortune, Surge")
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Result: " .. v9.kintsugi[v6] .. " " .. v9.title .. " of " .. v9.songs[v8])
				__wf_atom_05a856ad("Additional Stats: ")
				__wf_atom_05a856ad("    Small chance for enemies to drop more coin")
				__wf_atom_05a856ad("    Combos do increasing damage")
				__wf_atom_05a856ad("")

				if flag then
					__wf_atom_80afb308("Craft Weapon")
				end

				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Repair") then
				__wf_atom_05a856ad("")

				if __wf_atom_80afb308("Repair Items (50 Standing)") and _T.AncestorStanding >= 50 then
					_T.AncestorStanding = _T.AncestorStanding - 50
				end

				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Upgrade") then
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Forge Level: " .. _T.ForgeLevel .. "   ")
				__wf_atom_05a856ad("Upgrade Requirements: " .. 1000 * _T.ForgeLevel .. " Standing, " .. _T.ForgeLevel .. " Words")

				if __wf_atom_80afb308("Upgrade Forge") and _T.AncestorStanding >= 1000 * _T.ForgeLevel then
					_T.ForgeLevel = _T.ForgeLevel + 1
					_T.AncestorStanding = _T.AncestorStanding - 1000 * _T.ForgeLevel
				end

				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Trade") then
				__wf_atom_05a856ad("")

				if __wf_atom_80afb308("Sell Item") then
					_T.AncestorStanding = _T.AncestorStanding + 100
				end

				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Side Quests") then
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Lost Fragment: I heard a tale of a village in a cavern where a hero of old is laid to rest...")
				__wf_atom_c5303493()
			end
		end
	end

	__wf_atom_48bcafdc()
end

local function fn3()
	v4, v5 = __wf_atom_489de21b("Arsenal", v5)

	if v4 and __wf_atom_83a4046b("Arsenal Tabs") then
		if __wf_atom_19d02a1f("Equipment") then
			__wf_atom_05a856ad("")
			local mNames = {}

			for _, v19 in ipairs(v14) do
				table.insert(mNames, v19.mName)
			end

			v10 = __wf_atom_fdfab732("Helmet", v10, mNames)
			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Equip##Helmet") then
				gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():__wf_atom_902bc395(Type(v14[v10].mItem))
			end

			__wf_atom_05a856ad("")
			local mNames2 = {}

			for _, v19 in ipairs(v15) do
				table.insert(mNames2, v19.mName)
			end

			v11 = __wf_atom_fdfab732("Body", v11, mNames2)
			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Equip##Body") then
				gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():__wf_atom_902bc395(Type(v15[v11].mItem))
			end

			__wf_atom_05a856ad("")
			local mNames3 = {}

			for _, v19 in ipairs(v16) do
				table.insert(mNames3, v19.mName)
			end

			v12 = __wf_atom_fdfab732("Weapon", v12, mNames3)
			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Equip##Weapon") then
				gRegion:__wf_atom_c4f78a8f():GiveItem(Type(v16[v12].mItem), true)
			end

			__wf_atom_05a856ad("")
			local mNames4 = {}

			for _, v19 in ipairs(v17) do
				table.insert(mNames4, v19.mName)
			end

			v13 = __wf_atom_fdfab732("Soul", v13, mNames4)
			__wf_atom_78aeed31()

			if __wf_atom_80afb308("Equip##Soul") then
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
				local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
				local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
				local v19 = {}

				for i = 0, __wf_atom_e55d02aa:__wf_atom_06f3cb74() - 1 do
					local __wf_atom_b9a1f18c = __wf_atom_e55d02aa:__wf_atom_b9a1f18c(i)

					if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) or not __wf_atom_b9a1f18c:IsA(__wf_atom_abf506db) then
						continue
					end

					table.insert(v19, __wf_atom_b9a1f18c:__wf_atom_1bb5b1ff())
				end

				__wf_atom_c4f78a8f:GiveItem(Type(v17[v13].mItem), true)

				for _, v20 in ipairs(v19) do
					__wf_atom_d2b2176d:__wf_atom_902bc395(Type(v20))
				end
			end

			__wf_atom_c5303493()
		end

		if __wf_atom_19d02a1f("Attributes") then
			__wf_atom_05a856ad("")
			__wf_atom_05a856ad("Moved to the Oracle next to the fireplace")
			__wf_atom_c5303493()
		end
	end

	__wf_atom_48bcafdc()
end

local function fn4()
	v4, v5 = __wf_atom_489de21b("CartoMenu", v5)

	if v4 then
		__wf_atom_05a856ad("                                             Ancestor Standing: " .. _T.AncestorStanding .. "   ")

		if __wf_atom_83a4046b("Carto Tabs") then
			if __wf_atom_19d02a1f("World Map") then
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Good afternoon, where can I take you today?")
				__wf_atom_05a856ad("")

				for i, v19 in ipairs(shortcutLevels) do
					if __wf_atom_80afb308((tostring(shortcutNames[i]))) then
						fn(v19)
					end

					__wf_atom_78aeed31()
					__wf_atom_05a856ad(v19:__wf_atom_5b41f63b())
					__wf_atom_07947f07()
				end

				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("The cart rolls off into the ethereal swamp, taking you")
				__wf_atom_05a856ad("wherever you need to go...")
				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Trade") then
				__wf_atom_05a856ad("")

				if __wf_atom_80afb308("Turn in maps & knowledge (500 standing)") then
					_T.AncestorStanding = _T.AncestorStanding + 500
				end

				__wf_atom_05a856ad("")
				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Tourist Info") then
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Want info on a specific town or place? Ask me, I've travelled far and wide!")
				__wf_atom_c5303493()
			end
		end
	end

	__wf_atom_48bcafdc()
end

local function fn5()
	v4, v5 = __wf_atom_489de21b("OracleMenu", v5)

	if v4 then
		__wf_atom_05a856ad("                                             Ancestor Standing: " .. _T.AncestorStanding .. "   ")

		if __wf_atom_83a4046b("Oracle Tabs") then
			if __wf_atom_19d02a1f("Skills") then
				__wf_atom_05a856ad("")

				for i = 1, #v3 do
					attributes[i] = v18:GetAttribute(i - 1)
				end

				for i = 1, 3 do
					__wf_atom_05a856ad(v3[i] .. ": " .. attributes[i])
					__wf_atom_78aeed31()

					if __wf_atom_80afb308("<##" .. i) then
						v18:__wf_atom_9189c3be(i - 1, (math.max(attributes[i] - 5, 0)))
					end

					__wf_atom_78aeed31()

					if __wf_atom_80afb308(">##" .. i) then
						v18:__wf_atom_9189c3be(i - 1, attributes[i] + 5)
					end
				end

				__wf_atom_05a856ad("")
				__wf_atom_05a856ad(v3[4] .. ": " .. attributes[4])
				__wf_atom_05a856ad("")

				if __wf_atom_80afb308("Reset Defaults") then
					v18:__wf_atom_9189c3be(0, 50)
					v18:__wf_atom_9189c3be(1, 50)
					v18:__wf_atom_9189c3be(2, 50)
				end

				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Alca Offerings") then
				__wf_atom_05a856ad("")

				if __wf_atom_80afb308("Give gems back to Alca (500 standing)") then
					_T.AncestorStanding = _T.AncestorStanding + 500
				end

				__wf_atom_05a856ad("")

				if __wf_atom_80afb308("Borrow ore for crafting (250 standing)") then
					_T.AncestorStanding = _T.AncestorStanding - 250
				end

				__wf_atom_05a856ad("")
				__wf_atom_c5303493()
			end
		end
	end

	__wf_atom_48bcafdc()
end

local function fn6()
	v4, v5 = __wf_atom_489de21b("ShamanMenu", v5)

	if v4 then
		__wf_atom_05a856ad("                                             Ancestor Standing: " .. _T.AncestorStanding .. "   ")

		if __wf_atom_83a4046b("Shaman Tabs") then
			if __wf_atom_19d02a1f("Healing") then
				__wf_atom_05a856ad("")

				if __wf_atom_80afb308("Heal me") then
					local maxHealth = v18:GetMaxHealth()
					v18:SetHealth(maxHealth)
				end

				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Craft Potions") then
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Uses your ingredients inventory and garden")
				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Ingredients") then
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("List of all your collected ingredients")
				__wf_atom_05a856ad("A limited number of ingredients are available to buy for standing")
				__wf_atom_c5303493()
			end

			if __wf_atom_19d02a1f("Scrying") then
				__wf_atom_05a856ad("")
				__wf_atom_05a856ad("Shaman uses scrying to find a random place to explore as a side quest for loot, for a price.")
				__wf_atom_c5303493()
			end
		end
	end

	__wf_atom_48bcafdc()
end

local function fn7(_, fn8, p)
	if __wf_atom_7e8ad928(_T.AncestorStanding) then
		_T.AncestorStanding = 10000
	end

	v18 = gRegion:__wf_atom_c4f78a8f()
	v5 = true
	gClient:__wf_atom_bdcfbc2e(true)

	while v5 and not __wf_atom_7e8ad928(p) do
		fn8()
		Sleep(0)
	end

	gClient:__wf_atom_bdcfbc2e(false)
end

function OracleAction(p, p2)
	fn7(p, fn5, p2)
end

function SmithAction(p, p2)
	if __wf_atom_7e8ad928(_T.ForgeLevel) then
		_T.ForgeLevel = 1
	end

	fn7(p, fn2, p2)
end

function CartoAction(p, p2)
	fn7(p, fn4, p2)
end

function ShamanAction(p, p2)
	fn7(p, fn6, p2)
end

function NightfoldVendor(_, _)
	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_3aa103d3() then
		return
	end

	_T.marketVendorTransmissionSet = mapTransmissionSet
	local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(vendorMovie)

	if not __wf_atom_7e8ad928(__wf_atom_5d67a2c5) then
		__wf_atom_5d67a2c5:Execute("OverrideVendorName", "/SF/Language/Vendor/NightfoldVendorName")
	end
end

function ArsenalAction(_, object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(object) or object ~= __wf_atom_c4f78a8f then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ArsenalWp"))

	if arsenalFirstLogin then
		_T.FirstLoginArsenal = true
		__wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FirstLoginArsenalWp"))
	end

	if math.abs(__wf_atom_0a6a5887:__wf_atom_dc309f8a().heading - object:MotionControl():__wf_atom_d9cb4b97().heading) > 160 then
		object:__wf_atom_921c1a5f(arsenalTurnAnim, true, 3, 1, true)
	end

	object:SetDisableMovement(true)
	Sleep(0)
	object:SetDisableMovement(false)

	if
		(__wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_3aa103d3())
		and not __wf_atom_7e8ad928(__wf_atom_8e4fda44)
	then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(arsenalMovie)
	end
end

function OpenMap(mapContextAction)
	if not __wf_atom_7e8ad928(mapTransmissionSet) then
		module.PlayLocalTransmission(mapTransmissionSet, Symbol("MapGreetings"), gRegion:__wf_atom_c4f78a8f())
	end

	mapContextAction:Disable()
	_T.MapContextAction = mapContextAction

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_39aa93e9(true)
	end
end