module(..., package.seeall)

function CreateTimerMgr()
	return {
		mTimers = {},
		mRecycled = {},
		mMaxIndex = 0,
		Print = function(_, p)
			print("TimerMgr -> " .. tostring(p))
		end,
		Update = function(data, p)
			local mTimers = data.mTimers
			local v = nil

			for i = 1, data.mMaxIndex do
				local mTimer = mTimers[i]

				if mTimer == nil then
					continue
				end

				mTimer.Delta += p

				if not (mTimer.Delta >= mTimer.Duration) then
					continue
				end

				if not __wf_atom_7e8ad928(mTimer.Callback) then
					v = v == nil and {} or v
					table.insert(v, { callback = mTimer.Callback, arg = mTimer.Arg })
				end

				if mTimer.Loop then
					mTimer.Delta -= mTimer.Duration
				else
					table.insert(data.mRecycled, mTimer)
					mTimers[i] = nil
				end
			end

			if v ~= nil then
				for i = 1, #v do
					local v2 = v[i]
					v2.callback(v2.arg)
				end
			end
		end,
		RemoveTimer = function(data, p)
			if p == nil or p < 1 or data.mMaxIndex < p then
				return
			end

			local mTimers = data.mTimers
			local mTimer = mTimers[p]

			if mTimer ~= nil then
				table.insert(data.mRecycled, mTimer)
				mTimers[p] = nil
			end
		end,
		ClearTimers = function(p)
			local mRecycled = p.mRecycled
			local mTimers = p.mTimers

			for k, mTimer in pairs(mTimers) do
				if mTimer == nil then
					continue
				end

				table.insert(mRecycled, mTimer)
				mTimers[k] = nil
			end
		end,
		AddTimer = function(state, duration, callback, p, p2)
			local mRecycled = state.mRecycled
			local mTimers = state.mTimers

			if #mRecycled > 0 then
				local v = mRecycled[#mRecycled]
				table.remove(mRecycled, #mRecycled)
				local id = v.Id
				v.Delta = 0
				v.Duration = duration
				v.Callback = callback
				v.Arg = p2
				v.Loop = p ~= nil and p == true
				mTimers[id] = v
				return id
			else
				state.mMaxIndex += 1
				local mMaxIndex = state.mMaxIndex
				local v = {
					Delta = 0,
					Duration = duration,
					Callback = callback,
					Arg = p2,
					Loop = p ~= nil and p == true,
					Id = mMaxIndex
				}
				table.insert(mTimers, v)
				return mMaxIndex
			end
		end,
		HasTimer = function(p, p2)
			return p2 ~= nil and p.mTimers[p2] ~= nil
		end,
		HasTimerWithArg = function(p, p2)
			local mTimers = p.mTimers

			for _, mTimer in pairs(mTimers) do
				if mTimer.Arg == p2 then
					return true
				end
			end

			return false
		end,
		GetTimerWithArg = function(p, p2)
			local mTimers = p.mTimers

			for _, mTimer in pairs(mTimers) do
				if mTimer.Arg == p2 then
					return mTimer
				end
			end

			return nil
		end,
		GetTimeLeft = function(p, p2)
			if p2 == nil or p2 < 1 or p.mMaxIndex < p2 then
				return
			end

			local mTimer = p.mTimers[p2]

			if mTimer == nil then
				return
			else
				return mTimer.Duration - mTimer.Delta
			end
		end
	}
end