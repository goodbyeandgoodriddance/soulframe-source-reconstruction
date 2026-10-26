local module = require("SF.Scripts.Libs.PlayerPetLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("Lotus.Scripts.Libs.Query")
local v = nil
local v2 = nil
local v3 = nil

local function fn(object)
	local position = object:GetPosition()
	local __wf_atom_28ce676a = module3.WaitForAiDir():__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, queryRange, spacing)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(0, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_28a1a374(Vector(0, -1, 0), geoFilters)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("WolfDigSpots"), Color("0xFF00FF"))
	local positions = module4.GetPositions(1, __wf_atom_28ce676a)
	local v4

	if #positions > 0 then
		return positions[__wf_atom_5784a397(1, #positions)]
	end

	return v4
end

function RollDrop(instance)
	if __wf_atom_7e8ad928(digDroptable) then
		return false
	end

	if not gRegion:IsMaster() then
		return
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local enemyLevel = module2.GetEnemyLevel(instance)
	local v4 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_4ebf67cb) then
		return false
	end

	local __wf_atom_6ba3aebe = digDroptable:__wf_atom_6ba3aebe(
		instance,
		EMPTY_SYMBOL,
		v4,
		__wf_atom_28d5d4aa,
		__wf_atom_28d5d4aa
	)

	if __wf_atom_7e8ad928(__wf_atom_6ba3aebe) then
		return false
	end

	if teleportLoot then
		__wf_atom_6ba3aebe:Teleport(v3, Rotation(v3.heading, 0, 0))
	end

	return true
end

function Evaluate(object, _)
	v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v = object:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(v) or v:IsKilled() then
		object:__wf_atom_cecb2d55(commandBbSymbol, 0)
		return false
	else
		return true
	end
end

function Activate(object, _)
	if __wf_atom_7e8ad928(v) and __wf_atom_7e8ad928(v:__wf_atom_a96eb2aa()) then
		return false
	end

	module.SetCanPet(v:__wf_atom_a96eb2aa(), false, "Digging")
	object:__wf_atom_086a7266()
	v3 = fn(object)

	if __wf_atom_7e8ad928(v3) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	object:__wf_atom_921c1a5f(digTellAnim, true, 4, 1, true)
	object:__wf_atom_c215662d(v3)
	local total = 0

	if __wf_atom_7e8ad928(v3) then
		return
	end

	__wf_atom_30e3d82b:StartMoving(v3, 2, true, 1, 0.05, false)
	Sleep(0)
	__wf_atom_30e3d82b:__wf_atom_7f96e896(false)

	while
		not __wf_atom_7e8ad928(v)
		and not v:IsKilled()
		and not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
		and __wf_atom_30e3d82b:__wf_atom_46292900()
	do
		local __wf_atom_c215662d = object:__wf_atom_c215662d(v3)

		if __wf_atom_c215662d < 16 then
			object:SetPosture(0)
		end

		if __wf_atom_c215662d <= 1 then
			break
		end

		if giveUpPathingTime <= total then
			return false
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	__wf_atom_30e3d82b:__wf_atom_b414eabf()
	Sleep(0.1)
	local v4 = __wf_atom_5784a397(diggingDurationRange.minValue, diggingDurationRange.maxValue)
	object:__wf_atom_921c1a5f(digStartAnim, true, 4, 1, true)
	local entity = gRegion:CreateEntity(digFxType, v3, __wf_atom_80368bb1)
	object:__wf_atom_921c1a5f(digCycleAnim, false, 4, 2, true)
	local total2 = 0

	while total2 < v4 do
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
	end

	if RollDrop(object) then
		object:__wf_atom_921c1a5f(digEndSuccessAnim, false, 4, 1, true)
	else
		object:__wf_atom_921c1a5f(digEndFailAnim, false, 4, 1, true)
	end

	return true
end

function Deactivate(object, _)
	if not __wf_atom_7e8ad928(object) then
		v = object:__wf_atom_6115a2e2()

		if not (__wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(v:__wf_atom_a96eb2aa())) then
			module.SetCanPet(v:__wf_atom_a96eb2aa(), true, "Digging")
		end
	end
end