module(..., package.seeall)

function CreateStepSequencerLoader()
	return {
		IsLoading = false,
		Loader = nil,
		StepSequencer = nil,
		StepSequencerType = WeakResource("/Lotus/Powersuits/Bard/StepSequencerLocal"),
		StepSequencerRes = nil,
		NotePackInfo = nil,
		NotePackRes = nil,
		FingerPrint = nil,
		Looping = true
	}
end

function ResLoadNotePacks(state, list, fingerPrint)
	state.FingerPrint = fingerPrint
	state.NotePackRes = nil
	local v = {}

	if __wf_atom_7e8ad928(state.StepSequencerRes) then
		table.insert(v, state.StepSequencerType:__wf_atom_5b41f63b())
	end

	state.NotePackInfo = {}

	for _, v2 in ipairs(list) do
		if __wf_atom_7e8ad928(v2.NotePack) then
			continue
		end

		table.insert(state.NotePackInfo, v2)
		table.insert(v, v2.NotePack:__wf_atom_5b41f63b())
	end

	state.Loader = UISys.__wf_atom_c0dbe47c(v)
	state.IsLoading = true

	if not __wf_atom_7e8ad928(state.StepSequencer) then
		state.StepSequencer:SetPaused(true)
	end
end

function UpdateStepSequencer(state)
	if __wf_atom_7e8ad928(state) then
		return nil
	end

	if
		not state.Looping
		and not __wf_atom_7e8ad928(state.StepSequencer)
		and state.StepSequencer:__wf_atom_160c488b()
	then
		state.StepSequencer:Destroy()
		state.StepSequencer = nil
		state.StepSequencerRes = nil
		state.NotePackInfo = nil
		state.NotePackRes = nil
		state.FingerPrint = nil
		state.Loader = nil
	end

	if not state.IsLoading then
		return nil
	end

	if __wf_atom_7e8ad928(state.Loader) then
		state.IsLoading = false
	elseif state.Loader:__wf_atom_86399a47() then
		if __wf_atom_7e8ad928(state.NotePackRes) then
			if __wf_atom_7e8ad928(state.StepSequencerRes) then
				state.StepSequencerRes = Resource(state.StepSequencerType)
			end

			state.NotePackRes = {}
			local v = {}

			for _, v2 in ipairs(state.NotePackInfo) do
				local noteType = v2.NoteType
				local notePack = Resource(v2.NotePack)

				if __wf_atom_7e8ad928(notePack) then
					continue
				end

				table.insert(state.NotePackRes, { NoteType = noteType, NotePack = notePack })

				for i = 0, notePack:__wf_atom_1bafb2e9(noteType) - 1 do
					local __wf_atom_66f452b1 = notePack:__wf_atom_66f452b1(noteType, i)

					if not __wf_atom_7e8ad928(__wf_atom_66f452b1) then
						table.insert(v, __wf_atom_66f452b1:__wf_atom_5b41f63b())
					end
				end
			end

			if #v > 0 then
				state.Loader = UISys.__wf_atom_c0dbe47c(v)
			else
				state.IsLoading = false
			end
		else
			if __wf_atom_7e8ad928(state.StepSequencer) then
				if not __wf_atom_7e8ad928(state.StepSequencerRes) then
					state.StepSequencer = gRegion:CreateEntity(
						state.StepSequencerRes,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
				end
			else
				state.StepSequencer:SetPaused(false)
			end

			if not __wf_atom_7e8ad928(state.StepSequencer) then
				for _, notePackRe in ipairs(state.NotePackRes) do
					if not __wf_atom_7e8ad928(notePackRe.NotePack) then
						state.StepSequencer:__wf_atom_1176ad85(notePackRe.NoteType, notePackRe.NotePack)
					end
				end

				if state.FingerPrint ~= nil then
					if type(state.FingerPrint) == "string" then
						state.StepSequencer:__wf_atom_8ea975e7(state.FingerPrint)
					else
						state.StepSequencer:__wf_atom_8ea975e7(Resource(state.FingerPrint):__wf_atom_f298d802():c_str())
					end
				end

				state.StepSequencer:__wf_atom_7e8611b5(0)
				state.StepSequencer:__wf_atom_372df88b(state.Looping)
			end

			state.IsLoading = false
		end
	end

	return not state.IsLoading
end

function SyncSequencer(object)
	object:Initialize()

	if not gRegion:IsMaster() then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			object:__wf_atom_7e8611b5(__wf_atom_eab484a7:__wf_atom_2ec8fe45() / 2)
		end
	end

	object:__wf_atom_810ef00c(true)
end

function GetMaxSavedSequencers(object)
	local count = 0

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		return SF.__wf_atom_866d7b7d + count
	end

	local __wf_atom_caa82b8d = object:__wf_atom_caa82b8d(__wf_atom_9eddfa99)
	local __wf_atom_da43e3f3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():__wf_atom_da43e3f3()

	for i = 1, #__wf_atom_da43e3f3 do
		if not __wf_atom_da43e3f3[i].mItemType:IsA(__wf_atom_9eddfa99) then
			continue
		end

		for j = 1, #__wf_atom_caa82b8d do
			if
				__wf_atom_caa82b8d[j]:GetItem() ~= __wf_atom_da43e3f3[i].mItemType
				or __wf_atom_caa82b8d[j]:AlwaysAvailable()
			then
				continue
			end

			count += 1
		end
	end

	return SF.__wf_atom_866d7b7d + count
end