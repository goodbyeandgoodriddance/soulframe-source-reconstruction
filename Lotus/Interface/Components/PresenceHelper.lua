module(..., package.seeall)
LITE_PRESENCE_RESYNC_INTERVAL = 60
RICH_PRESENCE_RESYNC_INTERVAL = 15
RICH_TO_LITE_RATIO = LITE_PRESENCE_RESYNC_INTERVAL / RICH_PRESENCE_RESYNC_INTERVAL

function Create()
	return {
		mMoviesToSync = {},
		GetParentEnv = function(p)
			if p.mParentEnv ~= nil then
				return p.mParentEnv
			end

			local v = 1
			local mParentEnv

			repeat
				mParentEnv = getfenv(v)
				v += 1
			until mParentEnv.mMovie

			p.mParentEnv = mParentEnv
			return mParentEnv
		end,
		CanResyncPresence = function(self)
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if
				__wf_atom_7e8ad928(__wf_atom_18a5d83b)
				or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01()))
			then
				return false
			end

			for i = 1, #self.mMoviesToSync do
				local movie = __wf_atom_8e4fda44:FindMovie(self.mMoviesToSync[i])

				if not __wf_atom_7e8ad928(movie) and movie:Execute("CanResyncPresence", "") then
					return true
				end
			end

			return false
		end,
		ResyncRichPresence = function(self)
			_T.NextRichPresenceResync = nil
			__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("ResyncRichPresence", "")
		end,
		ResyncLitePresence = function(self)
			_T.NextLitePresenceResync = nil
			__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("ResyncLitePresence", "")
		end,
		Update = function(self, p)
			if
				_T.NextLitePresenceResync ~= nil
				and _T.NextRichPresenceResync ~= nil
				and _T.NextRichPresenceResync < p
			then
				if self:CanResyncPresence() then
					if _T.CountRichPresenceResync == nil then
						_T.CountRichPresenceResync = 0
					end

					_T.CountRichPresenceResync = _T.CountRichPresenceResync + 1

					if _T.CountRichPresenceResync ~= RICH_TO_LITE_RATIO then
						self:ResyncRichPresence()
						return
					end

					self:ResyncLitePresence()
					_T.CountRichPresenceResync = 0
				else
					_T.NextRichPresenceResync = p + RICH_PRESENCE_RESYNC_INTERVAL
				end
			end
		end
	}
end