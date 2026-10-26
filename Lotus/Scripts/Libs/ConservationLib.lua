local states = {
	UNINITIALIZED = 0,
	INITIALIZED = 1,
	PITCH_GAME_INITIATED = 2,
	ANIMAL_RESPONSE = 3,
	DOING_PITCH_MATCHING = 4,
	CALL_MATCHED = 5,
	PITCH_GAME_CALLS_COMPLETE = 25,
	SPAWNED = 26,
	SLEPT = 27,
	ESCAPED = 28
}

local function fn(huntingState)
	return {
		huntingState = huntingState,
		SetHint = function(p, hint)
			p.hint = hint
		end,
		GetState = function(self)
			if __wf_atom_7e8ad928(self.huntingState) then
				return 0
			end

			return self.huntingState:GetState()
		end,
		SetState = function(self, p)
			self.huntingState:SetState(p)
		end,
		GetCallPoint = function(self)
			return self.huntingState:GetCallPoint()
		end,
		SetCallPoint = function(self, p)
			self.huntingState:SetCallPoint(p)
		end,
		SetPitches = function(self, p, p2)
			self.huntingState:SetPitches(p, p2)
		end,
		GetPitchAtTime = function(self, p)
			return self.huntingState:GetPitchAtTime(p)
		end,
		IsEncounterOver = function(self)
			local state = self:GetState()
			return state == 0 or states.SPAWNED <= state
		end,
		MatchesAnimal = function(p, tag)
			local callPoint = p.huntingState:GetCallPoint()
			return not __wf_atom_7e8ad928(callPoint) and callPoint:HasTag(tag)
		end
	}
end

local function fn2()
	local currentConservationEncounter = _T.currentConservationEncounter

	if not currentConservationEncounter then
		return
	end

	if not __wf_atom_7e8ad928(currentConservationEncounter.huntingState) then
		return currentConservationEncounter
	end

	local activeConservationEncounters = _T.activeConservationEncounters

	for i = #activeConservationEncounters, 1, -1 do
		if __wf_atom_7e8ad928(activeConservationEncounters[i].huntingState) then
			table.remove(activeConservationEncounters, i)
		end
	end

	_T.currentConservationEncounter = nil
end

local ConservationLib = {}
ConservationLib.states = states
ConservationLib.MIN_PITCH = 0
ConservationLib.MAX_PITCH = 20
ConservationLib.callPointTag = Symbol("AnimalCallPoint")

function ConservationLib.AddConservationEncounterState(huntingState)
	if not _T.activeConservationEncounters then
		_T.activeConservationEncounters = {}
	end

	local currentConservationEncounter = fn(huntingState)
	table.insert(_T.activeConservationEncounters, currentConservationEncounter)

	if __wf_atom_7e8ad928(_T.pendingRequestedConservationEncounter) then
		if not _T.currentConservationEncounter then
			_T.currentConservationEncounter = currentConservationEncounter
		end
	else
		local __wf_atom_3d96ddcd = huntingState:__wf_atom_3d96ddcd()

		while __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
			Sleep(0)
			__wf_atom_3d96ddcd = huntingState:__wf_atom_3d96ddcd()
		end

		if __wf_atom_3d96ddcd == _T.pendingRequestedConservationEncounter then
			_T.currentConservationEncounter = currentConservationEncounter
			_T.pendingRequestedConservationEncounter = nil
		end
	end
end

function ConservationLib:EndEncounter()
	local currentConservationEncounter = _T.currentConservationEncounter

	if currentConservationEncounter and currentConservationEncounter.huntingState == self.huntingState then
		_T.currentConservationEncounter = nil
	end

	local activeConservationEncounters = _T.activeConservationEncounters

	for i = 1, #activeConservationEncounters do
		if activeConservationEncounters[i].huntingState ~= self.huntingState then
			continue
		end

		table.remove(activeConservationEncounters, i)
		break
	end

	self.huntingState:EndEncounter()
end

ConservationLib.GetCurrentConservationEncounter = fn2

function ConservationLib.GetCurrentConservationEncounterState()
	local v = fn2()

	if v then
		return v.huntingState:GetState()
	end

	return 0
end

function ConservationLib.SetCurrentConservationEncounterByStartPoint(pendingRequestedConservationEncounter)
	for i = #_T.activeConservationEncounters, 1, -1 do
		local activeConservationEncounter = _T.activeConservationEncounters[i]

		if __wf_atom_7e8ad928(activeConservationEncounter.huntingState) then
			table.remove(_T.activeConservationEncounters, i)
		else
			local huntingState = activeConservationEncounter.huntingState
			local __wf_atom_3d96ddcd = huntingState:__wf_atom_3d96ddcd()

			while __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
				Sleep(0)
				__wf_atom_3d96ddcd = huntingState:__wf_atom_3d96ddcd()
			end

			if __wf_atom_3d96ddcd == pendingRequestedConservationEncounter then
				_T.currentConservationEncounter = activeConservationEncounter
				return
			end
		end
	end

	_T.pendingRequestedConservationEncounter = pendingRequestedConservationEncounter
end

function ConservationLib.SetCurrentConservationEncounterByCallPoint(p)
	for i = #_T.activeConservationEncounters, 1, -1 do
		local activeConservationEncounter = _T.activeConservationEncounters[i]

		if __wf_atom_7e8ad928(activeConservationEncounter.huntingState) then
			table.remove(_T.activeConservationEncounters, i)
		elseif activeConservationEncounter.huntingState:__wf_atom_3273c55d(p) then
			_T.currentConservationEncounter = activeConservationEncounter
			break
		end
	end
end

function ConservationLib.GetConservationEncounterByCallPoint(p)
	for i = #_T.activeConservationEncounters, 1, -1 do
		local activeConservationEncounter = _T.activeConservationEncounters[i]

		if __wf_atom_7e8ad928(activeConservationEncounter.huntingState) then
			table.remove(_T.activeConservationEncounters, i)
		elseif activeConservationEncounter.huntingState:__wf_atom_3273c55d(p) then
			return activeConservationEncounter
		end
	end
end

function ConservationLib.GetConservationEncounterByHuntingState(p)
	local activeConservationEncounters = _T.activeConservationEncounters

	for i = 1, #activeConservationEncounters do
		if activeConservationEncounters[i].huntingState == p then
			return activeConservationEncounters[i]
		end
	end
end

function ConservationLib.GetConservationEncounterForHint(p)
	local activeConservationEncounters = _T.activeConservationEncounters

	for i = 1, #activeConservationEncounters do
		if activeConservationEncounters[i].hint == p then
			return activeConservationEncounters[i]
		end
	end
end

function ConservationLib.InitiatePitchGame(_)
	local v = fn2()

	if v then
		v.huntingState:SetState(states.PITCH_GAME_INITIATED)
	end
end

function ConservationLib.PitchGameMatch(_)
	local v = fn2()

	if v then
		v.huntingState:SetState(states.CALL_MATCHED)
	end
end

function ConservationLib:GetPitchAtTime()
	local v = fn2()

	if v then
		return v:GetPitchAtTime(self)
	end

	return 0
end

function ConservationLib.GetDisappearTimePercentage()
	local v = fn2()

	if v then
		return v.huntingState:GetDisappearTimePercentage()
	end

	return 0
end

function ConservationLib.SetDisappearTime(p, p2)
	local v = fn2()

	if v then
		v.huntingState:__wf_atom_dac31ee8(p)
		v.huntingState:__wf_atom_92f086ce(p2)
	end
end

return ConservationLib