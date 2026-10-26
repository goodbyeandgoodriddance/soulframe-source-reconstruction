local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.ModifySkyLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local v = Resource("/SF/Types/Lore/TutorialLore/WeatherEffectsFragment")
local v2 = Symbol("/SF/Language/Codex/WeatherEffectsLightningMemory")
local v3 = WeakResource("/SF/Upgrades/Mods/Aura/Weather/LightningAuraUpgrade")
local v4 = WeakResource("/SF/Types/Gameplay/Tutorial/TutorialTriggerWeatherLightningEffect")
local v5 = Symbol("/SF/Language/Codex/WeatherEffectsPostRainMemory")
local v6 = WeakResource("/SF/Upgrades/Mods/Aura/Weather/PostRainAuraUpgrade")
local v7 = WeakResource("/SF/Types/Gameplay/Tutorial/TutorialTriggerWeatherPostRainEffect")
local v8 = Symbol("/SF/Language/Codex/WeatherEffectsFogMemory")
local v9 = Symbol("/SF/Language/Codex/WeatherEffectsRainbowMemory")
local v10 = WeakResource("/SF/Upgrades/Mods/Aura/Weather/RainbowAuraUpgrade")
local v11 = WeakResource("/SF/Types/Gameplay/Tutorial/TutorialTriggerWeatherRainbowEffect")
local v12 = { v3, v6, v10 }
local v13 = WeakResource("/SF/Types/Quests/PreAlpha/Q1WakeUp")
local v14 = nil
local v15 = nil

local function fn(p)
	if gGameRules:__wf_atom_7247d14f(p, nil) ~= nil then
		return
	end

	gGameRules:__wf_atom_2c71af3a(Type(p))
	v15 = v14:__wf_atom_e919fb8e()

	if v15.activeWeatherEffectAuras == nil then
		v15.activeWeatherEffectAuras = {}
	end

	table.insert(v15.activeWeatherEffectAuras, p)
end

local function fn2(object, p, p2)
	if not module.HasSpecificLoreMemoryUnlocked(object, v, p) then
		module.GiveLoreFragmentMemory(object, v, p, true)

		if not __wf_atom_7e8ad928(p2) then
			object:Attach(Type(p2), EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 1)
		end
	end
end

local function fn3()
	v15 = v14:__wf_atom_e919fb8e()

	if v15 ~= nil and #v15.activeWeatherEffectAuras > 0 then
		for i, activeWeatherEffectAura in ipairs(v15.activeWeatherEffectAuras) do
			table.remove(v15.activeWeatherEffectAuras, i)
			gGameRules:__wf_atom_e61a251e(Type(activeWeatherEffectAura))
		end
	end

	if module2.IsLightning() then
		fn(v3)
	end

	if module2.IsRainbow() then
		fn(v10)
	end

	if module2.WasPreviouslyRaining() then
		fn(v6)
	end
end

function TrackWeatherEvents(p)
	v14 = p
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if module3.QuestIsActive(v13) and not module3.IsQuestInReplay(v13) then
		return
	end

	for _, v16 in ipairs(v12) do
		if gGameRules:__wf_atom_7247d14f(v16, nil) ~= nil then
			gGameRules:__wf_atom_e61a251e(Type(v16))
		end
	end

	if gRegion:IsMaster() then
		module2.AddWeatherCycleChangeCallback(fn3)

		if module2.IsLightning() then
			fn(v3)
		end

		if module2.IsRainbow() then
			fn(v10)
		end

		if module2.WasPreviouslyRaining() then
			fn(v6)
		end
	end

	local __wf_atom_22020464 = v:__wf_atom_22020464()
	local v16 = {}

	for _, v17 in ipairs(__wf_atom_22020464) do
		if not module.HasSpecificLoreMemoryUnlocked(__wf_atom_c4f78a8f, v, v17) then
			table.insert(v16, v17)
		end
	end

	while v16 ~= nil and #v16 ~= 0 do
		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				break
			end
		end

		if gGameRules:__wf_atom_7247d14f(v6, nil) ~= nil then
			fn2(__wf_atom_c4f78a8f, v5, v7)
		end

		if gGameRules:__wf_atom_7247d14f(v3, nil) ~= nil then
			fn2(__wf_atom_c4f78a8f, v2, v4)
		end

		if module2.IsOvercast() then
			fn2(__wf_atom_c4f78a8f, v8)
		end

		if gGameRules:__wf_atom_7247d14f(v10, nil) ~= nil then
			fn2(__wf_atom_c4f78a8f, v9, v11)
		end

		Sleep(3)
	end
end