module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local clip = "Controls.Top"
local clip2 = "Controls.Right"
local clip3 = "Controls.Bottom"
local clip4 = "Controls.Left"
local v = {
	{
		action = "GEAR_HOTKEY_0",
		clip = clip,
		highlightClip = "TopPetal",
		defaultDPad = "GAMEPAD_UP"
	},
	{
		action = "SUMMON_SPARROW",
		clip = clip2,
		highlightClip = "RightPetal",
		defaultDPad = "GAMEPAD_RIGHT"
	},
	{
		action = "CONSUMABLES_HOLD",
		clip = clip3,
		highlightClip = "BottomPetal",
		defaultDPad = "GAMEPAD_DOWN"
	},
	{ action = "NEXT_INV", clip = clip4, highlightClip = "LeftPetal", defaultDPad = "GAMEPAD_LEFT" }
}

local function fn(data, __wf_atom_4dc54686, p, p2)
	local __wf_atom_c7fa5e0c = data.mMovie:__wf_atom_c7fa5e0c(p, __wf_atom_4dc54686)
	local v2 = __wf_atom_c7fa5e0c ~= p and __wf_atom_c7fa5e0c:sub(1, 1) ~= "\""
	data.mMovie:__wf_atom_50d60589(p2, 36, module.Ternary(v2, __wf_atom_c7fa5e0c, ""))
end

local function fn2(data)
	if __wf_atom_7e8ad928(data.mAvatar) then
		return
	end

	local __wf_atom_4dc54686 = data.mAvatar:__wf_atom_4dc54686()

	for _, v2 in ipairs(v) do
		fn(data, __wf_atom_4dc54686, "<" .. v2.action .. ">", data.baseClip .. "." .. v2.clip .. ".Prompt")
	end

	data.mMovie:__wf_atom_50d60589(
		data.baseClip .. ".Controls.GamepadCentralPrompt",
		36,
		data.mMovie:__wf_atom_8e9ac384("<GAMEPAD_UDLR>", true)
	)
end

local function fn3(object)
	object.mMovie:__wf_atom_e57658c2(object.baseClip .. "." .. clip .. ".Count", 44, _G.UIColor_Beige)
	object.mMovie:__wf_atom_e57658c2(object.baseClip .. ".AmmoCounter.Count", 44, _G.UIColor_Beige)

	for _, v2 in ipairs(v) do
		object.mMovie:__wf_atom_e57658c2(object.baseClip .. "." .. v2.highlightClip, 11, _G.UIColor_Tan)
	end
end

local function fn4()
	for _, v2 in ipairs(v) do
		if __wf_atom_8e4fda44:__wf_atom_981c3f0b(v2.action) ~= v2.defaultDPad then
			return false
		end
	end

	return true
end

function Create(mMovie, baseClip, p)
	local v2 = {
		mMovie = mMovie,
		mAvatar = nil,
		baseClip = baseClip,
		radialProgressMaterial = p.radialProgressMaterial,
		controlFlowerIcons = p.controlFlowerIcons,
		lastAmmoCount = nil,
		isShowingBowAmmo = nil,
		priorHealthPct = 0,
		priorHealthPctDir = 0,
		priorRegainHealthPct = 0,
		priorRegainHealthDir = 0,
		priorStabilityPct = 0,
		smoothFloatHealthPct = __wf_atom_10cd16b2(1, 0.125),
		smoothFloatRegainPct = __wf_atom_10cd16b2(0, 0.05),
		OnGamepadTransition = function(self)
			fn2(self)
			local v2 = fn4() and Engine.IsPlayingWithController()

			for _, v3 in ipairs(v) do
				self.mMovie:__wf_atom_2dedec1a(self.baseClip .. "." .. v3.clip .. ".Prompt", 13, not v2)
			end

			self.mMovie:__wf_atom_2dedec1a(self.baseClip .. ".Controls.GamepadCentralPrompt", 13, v2)
		end,
		OnControlsChanged = function(p2)
			fn2(p2)
		end,
		Initialize = function(self)
			self.mMovie:OverrideMaterial(self.baseClip .. ".HealthBarFill", self.radialProgressMaterial)
			self.mMovie:OverrideMaterial(self.baseClip .. ".RegainableHealthBarFill", self.radialProgressMaterial)
			self.mMovie:OverrideMaterial(self.baseClip .. ".StabilityBarFill", self.radialProgressMaterial)
			self.mMovie:__wf_atom_c90af43a(self.baseClip .. "." .. clip2 .. ".Icon", self.controlFlowerIcons[1])
			self.mMovie:__wf_atom_c90af43a(self.baseClip .. "." .. clip3 .. ".Icon", self.controlFlowerIcons[2])
			self.mMovie:__wf_atom_c90af43a(self.baseClip .. "." .. clip4 .. ".Icon", self.controlFlowerIcons[3])

			for _, v2 in ipairs(v) do
				self.mMovie:__wf_atom_e57658c2(self.baseClip .. "." .. v2.highlightClip, 12, 0)
			end

			fn3(self)
			self:OnGamepadTransition()
		end,
		InterpHealth = function(p2, p3)
			local v2 = __wf_atom_104bfe98(0.5, 1, p3)
			p2.mMovie:__wf_atom_1ca72041(p2.baseClip .. ".HealthBarFill", "AlphaTestThreshold", v2, 0, 0, 0)
			local v3

			if p3 > 0.5 then
				v3 = (p3 - 0.5) * 2
			else
				v3 = 1 - p3 * 2
			end

			local v4 = math.pow(v3, 2)
			local v5 = __wf_atom_104bfe98(120, 106, v4)
			local v6 = Rotation(0, 0, __wf_atom_104bfe98(-80, 80, p3))
			local v7 = __wf_atom_9341614d(Vector(0, 1, 0), v6) * v5
			p2.mMovie:__wf_atom_4c1c1986(p2.baseClip, "HealthBarCap", 0, -v7.x)
			p2.mMovie:__wf_atom_4c1c1986(p2.baseClip, "HealthBarCap", 1, -v7.y)
			local v8 = v6.bank * 1.125
			p2.mMovie:__wf_atom_4c1c1986(p2.baseClip, "HealthBarCap", 16, v8)
		end,
		InterpRegainableHealth = function(p2, p3)
			local v2 = __wf_atom_104bfe98(0.5, 1, p3)
			p2.mMovie:__wf_atom_1ca72041(p2.baseClip .. ".RegainableHealthBarFill", "AlphaTestThreshold", v2, 0, 0, 0)
			local v3

			if p3 > 0.5 then
				v3 = (p3 - 0.5) * 2
			else
				v3 = 1 - p3 * 2
			end

			local v4 = math.pow(v3, 2)
			local v5 = __wf_atom_104bfe98(120, 106, v4)
			local v6 = Rotation(0, 0, __wf_atom_104bfe98(-80, 80, p3))
			local v7 = __wf_atom_9341614d(Vector(0, 1, 0), v6) * v5
			p2.mMovie:__wf_atom_4c1c1986(p2.baseClip, "RegainableHealthBarCap", 0, -v7.x)
			p2.mMovie:__wf_atom_4c1c1986(p2.baseClip, "RegainableHealthBarCap", 1, -v7.y)
			local v8 = v6.bank * 1.125
			p2.mMovie:__wf_atom_4c1c1986(p2.baseClip, "RegainableHealthBarCap", 16, v8)
		end,
		Update = function(self, mAvatar, p2)
			if mAvatar ~= self.mAvatar then
				self.mAvatar = mAvatar
				fn2(self)
			end

			if __wf_atom_7e8ad928(p2) then
				self.mMovie:__wf_atom_2dedec1a(self.baseClip .. ".AmmoCounter", 13, false)
			elseif self.isShowingBowAmmo ~= false then
				self.mMovie:__wf_atom_2dedec1a(self.baseClip .. ".AmmoCounter", 13, false)
				self.isShowingBowAmmo = false
			end

			local v2 = __wf_atom_084b3e93()
			self.smoothFloatHealthPct:Update(v2)
			self.InterpHealth(self, self.smoothFloatHealthPct:__wf_atom_9e368823())
			self.smoothFloatRegainPct:Update(v2)
			self.InterpRegainableHealth(self, self.smoothFloatRegainPct:__wf_atom_9e368823())
		end,
		SetHealthPercent = function(state, priorHealthPct, priorRegainHealthPct)
			local function fn5(p2)
				state.mMovie:__wf_atom_4c1c1986(
					state.baseClip,
					"HealthBarFill",
					5,
					(math.max(1, __wf_atom_104bfe98(114.99999999999999, 100, p2)))
				)
				state.mMovie:__wf_atom_4c1c1986(
					state.baseClip,
					"HealthBarFill",
					6,
					(math.max(1, __wf_atom_104bfe98(114.99999999999999, 100, p2)))
				)
			end

			if state.priorHealthPct ~= priorHealthPct then
				state.smoothFloatHealthPct:__wf_atom_09294a87(priorHealthPct)
				local priorHealthDir = state.priorHealthPct < priorHealthPct and 1 or -1

				if state.priorHealthDir ~= priorHealthDir then
					state.priorHealthDir = priorHealthDir
					__wf_atom_ec43d06e(state.mMovie, state.baseClip .. ".HealthBarFill", 4, { fn5 }, { 1 }, 0.5)
				end

				state.priorHealthPct = priorHealthPct
			end

			state.mMovie:__wf_atom_7f57ab2f(state.baseClip, "RegainableHealthBarCap", 13, priorRegainHealthPct ~= 0)

			local function fn6(p2)
				state.mMovie:__wf_atom_4c1c1986(
					state.baseClip,
					"RegainableHealthBarFill",
					5,
					(math.max(1, __wf_atom_104bfe98(114.99999999999999, 100, p2)))
				)
				state.mMovie:__wf_atom_4c1c1986(
					state.baseClip,
					"RegainableHealthBarFill",
					6,
					(math.max(1, __wf_atom_104bfe98(114.99999999999999, 100, p2)))
				)
			end

			if state.priorRegainHealthPct ~= priorRegainHealthPct then
				if state.priorRegainHealthPct < priorRegainHealthPct then
					state.smoothFloatRegainPct:__wf_atom_4453e49c(priorRegainHealthPct)
				else
					state.smoothFloatRegainPct:__wf_atom_09294a87(priorRegainHealthPct)
				end

				local priorRegainDir = state.priorRegainHealthPct < priorRegainHealthPct and 1 or -1

				if state.priorRegainDir ~= priorRegainDir then
					state.priorRegainDir = priorRegainDir
					__wf_atom_ec43d06e(
						state.mMovie,
						state.baseClip .. ".RegainableHealthBarFill",
						4,
						{ fn6 },
						{ 1 },
						0.5
					)
				end

				state.priorRegainHealthPct = priorRegainHealthPct
			end
		end,
		SetStabilityPercent = function(state, priorStabilityPct)
			if state.priorStabilityPct == priorStabilityPct then
				return
			end

			local priorStabilityPct2 = state.priorStabilityPct
			__wf_atom_ec43d06e(state.mMovie, state.baseClip .. ".StabilityBarFill", 4, { function(p2)
					local v2 = __wf_atom_104bfe98(priorStabilityPct2, priorStabilityPct, p2)
					local v3 = __wf_atom_104bfe98(0.5, 1, v2)
					state.mMovie:__wf_atom_1ca72041(
						state.baseClip .. ".StabilityBarFill",
						"AlphaTestThreshold",
						v3,
						0,
						0,
						0
					)
					state.mMovie:__wf_atom_4c1c1986(
						state.baseClip,
						"StabilityBarFill",
						5,
						__wf_atom_104bfe98(105, 100, p2)
					)
					state.mMovie:__wf_atom_4c1c1986(
						state.baseClip,
						"StabilityBarFill",
						6,
						__wf_atom_104bfe98(105, 100, p2)
					)
				end }, { 1 }, 0.5)
			state.priorStabilityPct = priorStabilityPct
		end,
		SetPotionIcon = function(p2, p3)
			p2.mMovie:__wf_atom_c90af43a(p2.baseClip .. "." .. clip .. ".Icon", p3)
		end,
		SetPotionIconActive = function(p2, p3)
			p2.mMovie:__wf_atom_2dedec1a(p2.baseClip .. "." .. clip .. ".Count", 13, p3)
			p2.mMovie:__wf_atom_2dedec1a(p2.baseClip .. "." .. clip .. ".Icon", 13, p3)
		end,
		SetPotionCount = function(p2, p3)
			p2.mMovie:__wf_atom_50d60589(p2.baseClip .. "." .. clip .. ".Count", 36, p3)
			p2.mMovie:__wf_atom_e57658c2(p2.baseClip .. "." .. clip .. ".Count", 12, module.Ternary(p3 > 0, 100, 70))
		end,
		PulseControl = function(p2, p3, p4, p5)
			for _, v2 in ipairs(v) do
				if p3 ~= v2.action then
					continue
				end

				local v3 = p2.baseClip .. "." .. v2.highlightClip

				if p4 then
					local v4 = { (module.Ternary(p5, 40, 0)) }
					__wf_atom_ec43d06e(p2.mMovie, v3, 1, { 12 }, v4, 0.15, 0)
				else
					__wf_atom_ec43d06e(p2.mMovie, v3, 1, { 12 }, { 40 }, 0.15, 0, function()
						__wf_atom_ec43d06e(p2.mMovie, v3, 2, { 12 }, { 0 }, 0.15)
					end)
				end
			end
		end
	}
	v2:Initialize()
	return v2
end