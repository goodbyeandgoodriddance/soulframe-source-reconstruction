local module = require("SF.Scripts.Libs.EncounterLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
local v = Symbol("RandomTeam")
Symbol("ODE")
local v2 = nil
local v3 = WeakResource("/SF/Types/Player/EnvoyAvatar")
local v4 = nil
local position = nil
local v5 = nil
local v6 = nil
local v7 = 1

local function fn(instance)
	if gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_e93896ba = __wf_atom_7d789620:__wf_atom_e93896ba(0)
		local __wf_atom_dcf48c53 = __wf_atom_7d789620:__wf_atom_dcf48c53()
		local __wf_atom_57203011 = __wf_atom_7d789620:__wf_atom_57203011()
		local v8 = __wf_atom_5784a397(__wf_atom_dcf48c53, __wf_atom_57203011)

		if dropLootForInstigatorOnly and instance:IsA(__wf_atom_4ebf67cb) then
			dropTable:__wf_atom_0ad20b11(instance, instance, __wf_atom_e93896ba, v8)
		else
			dropTable:__wf_atom_6ba3aebe(instance, __wf_atom_e93896ba, v8, dropSpawnOffset)
		end

		_T.idleTimoutReset = true
	end
end

local function fn2(_)
	local all = gRegion:FindAll(__wf_atom_96b9d246)

	for _, v8 in ipairs(all) do
		v8:Disable()
		v8:FirePort("RemoveAgents")
	end
end

local function fn3(object, p, spawnCount)
	v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	position = object:GetPosition()
	v6 = object:__wf_atom_103377cc()
	v5 = object
	local entity = gRegion:CreateEntity(fogType, object:GetPosition(), __wf_atom_80368bb1, nil, nil)
	entity:PlaySound(fogActivateSound, false, 1, false)
	entity:__wf_atom_bf817354(0)
	local total = 0

	while total <= 5 and not __wf_atom_7e8ad928(entity) do
		entity:__wf_atom_bf817354(__wf_atom_104bfe98(0, 0.2, total))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v2) then
		return
	end

	while not module.ShouldShutDown(v5) do
		if spawnCount > 0 then
			local v8 = __wf_atom_104bfe98(spawnInterval.minValue, spawnInterval.maxValue, math.random())
			Sleep(v8)

			if not __wf_atom_7e8ad928(v2) then
				local __wf_atom_c91d5f5b = v4:__wf_atom_c91d5f5b(v2, v5, v6, v, p)

				if not __wf_atom_7e8ad928(__wf_atom_c91d5f5b) then
					v5:__wf_atom_97f955c1(__wf_atom_c91d5f5b)
					local __wf_atom_50a7d83e = __wf_atom_c91d5f5b:__wf_atom_50a7d83e()

					if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
						__wf_atom_c91d5f5b:__wf_atom_30b587a4()
						__wf_atom_50a7d83e:__wf_atom_2f3f52aa(5)
						spawnCount -= 1
					end
				end
			end
		elseif v5:__wf_atom_3634e6d2() == 0 or module.ShouldShutDown(v5) then
			module.RemoveAgents(v5)
			v5:__wf_atom_8e6fec76(6)
			break
		else
			Sleep(0)
		end
	end

	Sleep(2)
	local total2 = 0

	while total2 <= 4 and not __wf_atom_7e8ad928(entity) do
		entity:__wf_atom_bf817354(__wf_atom_104bfe98(0.2, 0, total2))
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
	end
end

function PumpkinLoot(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_679ed446 = object2:__wf_atom_679ed446()

	if __wf_atom_7e8ad928(__wf_atom_679ed446) or not __wf_atom_679ed446:IsA(v3) then
		fn(object)
	else
		fn(__wf_atom_679ed446)
	end

	if math.random() <= chance then
		local entity = gRegion:CreateEntity(PumpHint, object:GetPosition(), object:__wf_atom_dc309f8a(), nil, nil)

		if
			not __wf_atom_7e8ad928(entity)
			and not __wf_atom_7e8ad928(__wf_atom_679ed446)
			and __wf_atom_679ed446:IsA(v3)
		then
			entity:__wf_atom_8a035cd5(Symbol("PumpkinFighter"), false)
		end
	end

	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for _, v8 in ipairs(__wf_atom_be0bea4a) do
		v8:Destroy()
	end
end

function PumpkinFighter(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	Color(0, 0, 0)
	v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v4:Enable(true)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local blue = __wf_atom_0a6a5887:GetColor(object:GetPosition(), false).blue
		v2 = agentTypes[blue]
	end

	if __wf_atom_7e8ad928(v2) then
		v2 = agentTypes[__wf_atom_5784a397(1, #agentTypes)]
	end

	fn2()
	v7 = 1
	fn3(object, v7, spawnCount)
end

function ScareCrowTinit(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MidrathDensityVolume"))
	Color(0, 0, 0)
	local fallbackInt = fallbackInt

	if __wf_atom_7e8ad928(object) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local color = __wf_atom_0a6a5887:GetColor(object:GetPosition(), false)

		if not __wf_atom_7e8ad928(color) then
			fallbackInt = color.blue
		end
	end

	local v8 = WeakResource("/SF/Characters/SproutFolk/Gardener/SproutGardenerHatMAT")
	local v9 = WeakResource("/SF/Objects/Events/Halloween/Materials/StickMan/StickManAMat")
	local v10 = WeakResource("/SF/Characters/SproutFolk/Gardener/SproutBagMAT")

	for i = 0, object:__wf_atom_c0d09e05() do
		local __wf_atom_3de89c8e = object:__wf_atom_3de89c8e(i)

		if __wf_atom_7e8ad928(object) then
			break
		end

		if __wf_atom_7e8ad928(__wf_atom_3de89c8e) then
			continue
		end

		if __wf_atom_3de89c8e == v9 then
			object:__wf_atom_fd3ec680(
				Symbol("TintColor"),
				i,
				baseTint[fallbackInt]:__wf_atom_6f94332f(),
				baseTint[fallbackInt]:__wf_atom_5cad32b9(),
				baseTint[fallbackInt]:__wf_atom_0973634e(),
				112,
				false
			)
		elseif __wf_atom_3de89c8e == v8 or __wf_atom_3de89c8e == v10 then
			if not __wf_atom_7e8ad928(tint1) and fallbackInt >= 1 and fallbackInt <= #tint1 then
				object:__wf_atom_fd3ec680(
					SF.__wf_atom_09edb9da,
					i,
					tint1[fallbackInt]:__wf_atom_6f94332f(),
					tint1[fallbackInt]:__wf_atom_5cad32b9(),
					tint1[fallbackInt]:__wf_atom_0973634e(),
					112,
					false
				)
			end

			if not __wf_atom_7e8ad928(tint3) and fallbackInt >= 1 and fallbackInt <= #tint3 then
				object:__wf_atom_fd3ec680(
					SF.__wf_atom_1039bdda,
					i,
					tint3[fallbackInt]:__wf_atom_6f94332f(),
					tint3[fallbackInt]:__wf_atom_5cad32b9(),
					tint3[fallbackInt]:__wf_atom_0973634e(),
					112,
					false
				)
			end
		end
	end
end