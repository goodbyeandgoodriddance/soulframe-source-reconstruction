local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(_, object)
	local all = gRegion:FindAll(__wf_atom_43e0c427, object:GetPosition(), 0, 20)
	local count = 0

	for _, v in ipairs(all) do
		local __wf_atom_6009c8ed = v:__wf_atom_6009c8ed()

		if
			__wf_atom_7e8ad928(__wf_atom_6009c8ed)
			or not __wf_atom_6009c8ed:IsKilled()
			or not __wf_atom_6009c8ed:__wf_atom_129d1aba(object)
		then
			continue
		end

		count += 1

		if count >= 2 then
			return 1
		end
	end

	return 0
end

function ActivateAbility(p, object, _, _)
	if not module.PlayAnimAndSuspendUntilEvent(p, activateAnim, animEvent, false, 2, 1, true) then
		return
	end

	local all = gRegion:FindAll(__wf_atom_43e0c427, object:GetPosition(), 0, 20)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	for _, v in ipairs(all) do
		if __wf_atom_7e8ad928(v) then
			continue
		end

		local __wf_atom_6009c8ed = v:__wf_atom_6009c8ed()

		if
			__wf_atom_7e8ad928(__wf_atom_6009c8ed)
			or not __wf_atom_6009c8ed:IsKilled()
			or not __wf_atom_6009c8ed:__wf_atom_129d1aba(object)
		then
			continue
		end

		local __wf_atom_419f7d69 = __wf_atom_6009c8ed:__wf_atom_419f7d69()

		if __wf_atom_7e8ad928(__wf_atom_419f7d69) then
			continue
		end

		local position = __wf_atom_6009c8ed:GetPosition()
		local __wf_atom_2f2bada0 = __wf_atom_6009c8ed:__wf_atom_2f2bada0()
		local __wf_atom_68de036a = __wf_atom_6009c8ed:__wf_atom_68de036a()
		local __wf_atom_402b3832 = __wf_atom_2202ffb6:__wf_atom_402b3832(
			__wf_atom_419f7d69,
			position,
			__wf_atom_2f2bada0,
			EMPTY_SYMBOL,
			__wf_atom_68de036a
		)

		if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
			local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				__wf_atom_50a7d83e:__wf_atom_7470861b():__wf_atom_3a9cc076(__wf_atom_50a7d83e)
				local __wf_atom_f51f1faa = __wf_atom_50a7d83e:__wf_atom_f51f1faa()

				if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
					__wf_atom_f51f1faa:__wf_atom_db0012e0(v, true)
					__wf_atom_f51f1faa:__wf_atom_0a31fc70()
				end

				__wf_atom_50a7d83e:__wf_atom_80db4712(11, 0)
				__wf_atom_50a7d83e:__wf_atom_5047e0ed(true)
			end
		end

		__wf_atom_6009c8ed:Destroy()
		v:Destroy()
		Sleep(Random(0.2, 0.4))
	end
end