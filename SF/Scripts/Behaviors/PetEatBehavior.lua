local module = require("SF.Scripts.Libs.PlayerPetLib")
local v = nil
local v2 = nil

function TeleportPet(object, p, p2)
	if not __wf_atom_7e8ad928(teleportFxType) then
		object:Attach(teleportFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 1)
	end

	if not __wf_atom_7e8ad928(teleportAnim) then
		object:__wf_atom_921c1a5f(teleportAnim, false, 3, 3, true, 1)
	end

	object:Teleport(p, p2)
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
	Sleep(1)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local position = v:GetPosition()
	v:__wf_atom_a06d543c()
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_c9fc989f)
	local v3 = object:GetPosition() - position
	Normalize(v3)
	local v4 = position + v3 * hasTargetSpawnDistFromPlayer

	if not __wf_atom_7e8ad928(v2) then
		v4 = v2:__wf_atom_0e0a6fee(v4)
	end

	module.SetCanPet(v:__wf_atom_a96eb2aa(), false, "Eating")
	local __wf_atom_ccd337ec = object:__wf_atom_ccd337ec(commandBbSymbol)

	if not __wf_atom_7e8ad928(v4) then
		__wf_atom_30e3d82b:StartMoving(v4, 1, true, 1, 0.05, false)
		Sleep(0)
		__wf_atom_30e3d82b:__wf_atom_7f96e896(false)
		object:__wf_atom_9af7625d(v)

		while
			not __wf_atom_7e8ad928(v)
			and not v:IsKilled()
			and not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
			and __wf_atom_30e3d82b:__wf_atom_46292900()
			and __wf_atom_ccd337ec == cubCommand
		do
			local __wf_atom_9af7625d = object:__wf_atom_9af7625d(v)

			if __wf_atom_9af7625d < 16 then
				object:SetPosture(0)
			end

			__wf_atom_ccd337ec = object:__wf_atom_ccd337ec(commandBbSymbol)
			Sleep(0.1)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:__wf_atom_7d4910e4() then
				break
			end

			if __wf_atom_30e3d82b:__wf_atom_d932d88f() or not (__wf_atom_9af7625d > 4) then
				continue
			end

			Sleep(3)
			local v5 = v:GetPosition() + v:__wf_atom_a06d543c() * 1.5
			local v6 = __wf_atom_fa8d0177(v5, v:GetPosition())
			TeleportPet(object, v5, v6)
			break
		end

		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		Sleep(2)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			while __wf_atom_bb3e7833:__wf_atom_7d4910e4() do
				Sleep(0)
			end
		end

		__wf_atom_30e3d82b:__wf_atom_7f96e896(true)
		object:__wf_atom_cecb2d55(commandBbSymbol, 0)
		print("PetEatBehavior: Finished eating !")
	end
end

function Deactivate(object, _)
	local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()

	if not __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
		local __wf_atom_a96eb2aa = __wf_atom_6115a2e2:__wf_atom_a96eb2aa()

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			module.SetCanPet(__wf_atom_a96eb2aa, true, "Eating")
		end
	end
end