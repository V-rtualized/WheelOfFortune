-- Grid layout metadata for each animation.
-- Frame dimensions are determined at load time from the image, so both 1x and 2x work.
-- Regular animations (95 frames):  10 cols × 10 rows
-- Rare animations  (123 frames):   13 cols × 10 rows
-- Shared 94-frame:  10 cols × 10 rows
-- Shared 104-frame: 10 cols × 11 rows
local ANIM_META = {
	-- Personal effect animations
	green_1           = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	green_2           = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	green_3           = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	red_1             = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	red_2             = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	red_3             = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	yellow_1          = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	yellow_2          = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	yellow_3          = { frames = 95,  cols = 10, rows = 10, spf = 0.03 },
	rare_red_to_green = { frames = 123, cols = 13, rows = 10, spf = 0.03 },
	rare_green_to_red = { frames = 123, cols = 13, rows = 10, spf = 0.03 },
	-- Shared effect animations (each has its own dedicated sprite sheet)
	haha              = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	wrong_loyalty     = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	shop_taxes        = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	boss_interference = { frames = 94,  cols = 10, rows = 10, spf = 0.04 },
	find_me           = { frames = 94,  cols = 10, rows = 10, spf = 0.04 },
	vampire_dream     = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	lucky_day         = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	royal_glass       = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	resource_drain    = { frames = 94,  cols = 10, rows = 10, spf = 0.04 },
	groundhog_day     = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	blissful_ignorance= { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	random_morph      = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	evolution         = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	overflow          = { frames = 104, cols = 10, rows = 11, spf = 0.04 },
	blinds            = { frames = 94,  cols = 10, rows = 10, spf = 0.04 },
}

-- Maps full SMODS effect keys to animation category.
WOF.effect_categories = {
	-- Good (18) → green animations
	wof_effect_wheeloffortune_pack_insight        = "good",
	wof_effect_wheeloffortune_tag_bonanza         = "good",
	wof_effect_wheeloffortune_double_draw         = "good",
	wof_effect_wheeloffortune_shop_upgrade        = "good",
	wof_effect_wheeloffortune_legendary_comeback  = "good",
	wof_effect_wheeloffortune_training_weights    = "good",
	wof_effect_wheeloffortune_temperance_value    = "good",
	wof_effect_wheeloffortune_rare_snowball       = "good",
	wof_effect_wheeloffortune_we_are_rich         = "good",
	wof_effect_wheeloffortune_master_thief        = "good",
	wof_effect_wheeloffortune_indigo_blessing     = "good",
	wof_effect_wheeloffortune_lucky_streak        = "good",
	wof_effect_wheeloffortune_economic_boom       = "good",
	wof_effect_wheeloffortune_foil_factory        = "good",
	wof_effect_wheeloffortune_tarot_god           = "good",
	wof_effect_wheeloffortune_recycling           = "good",
	wof_effect_wheeloffortune_planetary_alignment = "good",
	wof_effect_wheeloffortune_suit_mastery        = "good",
	-- Bad (6) → red animations
	wof_effect_wheeloffortune_shop_inflation      = "bad",
	wof_effect_wheeloffortune_parasite            = "bad",
	wof_effect_wheeloffortune_cards_are_tired     = "bad",
	wof_effect_wheeloffortune_ouija_funboy        = "bad",
	wof_effect_wheeloffortune_dementia            = "bad",
	wof_effect_wheeloffortune_rents_due           = "bad",
	-- Neutral (12) → yellow animations
	wof_effect_wheeloffortune_dicarderito         = "neutral",
	wof_effect_wheeloffortune_doing_nothing       = "neutral",
	wof_effect_wheeloffortune_library             = "neutral",
	wof_effect_wheeloffortune_phantom_pain        = "neutral",
	wof_effect_wheeloffortune_double_or_nothing   = "neutral",
	wof_effect_wheeloffortune_mirage              = "neutral",
	wof_effect_wheeloffortune_mosaic              = "neutral",
	wof_effect_wheeloffortune_tea_break           = "neutral",
	wof_effect_wheeloffortune_gambler_shuffle     = "neutral",
	wof_effect_wheeloffortune_switcheroo          = "neutral",
	wof_effect_wheeloffortune_eternal_spin        = "neutral",
	wof_effect_wheeloffortune_experience_exchange = "neutral",
	-- Shared effects → each maps directly to its dedicated animation key
	wof_effect_wheeloffortune_haha                = "haha",
	wof_effect_wheeloffortune_wrong_loyalty       = "wrong_loyalty",
	wof_effect_wheeloffortune_shop_taxes          = "shop_taxes",
	wof_effect_wheeloffortune_boss_interference   = "boss_interference",
	wof_effect_wheeloffortune_find_me             = "find_me",
	wof_effect_wheeloffortune_vampire_dream       = "vampire_dream",
	wof_effect_wheeloffortune_lucky_day           = "lucky_day",
	wof_effect_wheeloffortune_royal_glass         = "royal_glass",
	wof_effect_wheeloffortune_resource_drain      = "resource_drain",
	wof_effect_wheeloffortune_blissful_ignorance  = "blissful_ignorance",
	wof_effect_wheeloffortune_random_morph        = "random_morph",
	wof_effect_wheeloffortune_evolution           = "evolution",
	wof_effect_wheeloffortune_overflow            = "overflow",
	wof_effect_wheeloffortune_blinds              = "blinds",
}

-- Pick a random animation variant.
-- Good/bad each have 3 normal variants and 1 rare with 33% lower weight.
-- Neutral has 3 equal-weight variants and no rare.
local function pick_variant(category)
	if category == "good" then
		-- weights [1, 1, 1, 0.67] → total 3.67
		local r = math.random() * 3.67
		if r < 1 then
			return "green_1"
		elseif r < 2 then
			return "green_2"
		elseif r < 3 then
			return "green_3"
		else
			return "rare_red_to_green"
		end
	elseif category == "bad" then
		local r = math.random() * 3.67
		if r < 1 then
			return "red_1"
		elseif r < 2 then
			return "red_2"
		elseif r < 3 then
			return "red_3"
		else
			return "rare_green_to_red"
		end
	elseif category == "neutral" then
		return "yellow_" .. math.random(3)
	else
		return category  -- shared effects map directly to their animation key
	end
end

-- Load a PNG from the mod's filesystem via NFS (bypasses LOVE2D's sandboxed FS).
local function load_image(path)
	local bytes = NFS.read("data", path)
	if not bytes then return nil end
	local ok, result = pcall(function()
		return love.graphics.newImage(love.filesystem.newFileData(bytes, "img.png"))
	end)
	return ok and result or nil
end

WOF.anim_images = {}
WOF.anim_quads  = {}

for key, meta in pairs(ANIM_META) do
	local img = load_image(WOF.path .. "assets/" .. key .. ".png")

	if img then
		img:setFilter("linear", "linear")
		WOF.anim_images[key] = img

		local img_w, img_h = img:getDimensions()
		local fw = img_w / meta.cols
		local fh = img_h / meta.rows

		-- 0.5px inset on every quad prevents bilinear filtering from sampling
		-- into the adjacent empty cell on the frozen last frame.
		local INSET = 0.5
		local quads = {}
		for i = 0, meta.frames - 1 do
			local col = i % meta.cols
			local row = math.floor(i / meta.cols)
			quads[i + 1] = love.graphics.newQuad(
				col * fw + INSET,
				row * fh + INSET,
				fw - 2 * INSET,
				fh - 2 * INSET,
				img_w,
				img_h
			)
		end
		WOF.anim_quads[key] = quads
	else
		sendWarnMessage("[WOF] Failed to load animation sprite sheet: " .. key, WOF.id)
	end
end

-- Animation state (nil = idle).
-- Fields: phase ("playing"|"text"), key, frame, elapsed, text_elapsed,
--         display_name, description
WOF.anim_state        = nil
WOF.last_anim_variant = nil  -- kept for compatibility; not used for timing anymore

-- Start a spin animation overlay. Returns the chosen variant key.
function WOF.start_spin_animation(effect)
	local category = WOF.effect_categories[effect.key] or "neutral"
	local variant  = pick_variant(category)
	local msg      = type(effect.message) == "function"
	                 and effect.message()
	                 or localize(effect.message)
	WOF.last_anim_variant = variant
	WOF.anim_state = {
		phase        = "playing",
		key          = variant,
		frame        = 1,
		elapsed      = 0,
		text_elapsed = 0,
		display_name = effect.display_name or "",
		description  = msg,
	}
	return variant
end

-- Advance animation frames each game tick.
local _game_update = Game.update
function Game:update(dt)
	_game_update(self, dt)
	local s = WOF.anim_state
	if not s then return end

	if s.phase == "playing" then
		local meta = ANIM_META[s.key]
		s.elapsed = s.elapsed + dt
		if s.elapsed >= meta.spf then
			s.elapsed = s.elapsed - meta.spf
			s.frame   = s.frame + 1
			if s.frame > meta.frames then
				s.frame        = meta.frames  -- hold last frame during text phase
				s.phase        = "text"
				s.text_elapsed = 0
			end
		end
	elseif s.phase == "text" then
		s.text_elapsed = s.text_elapsed + dt
		if s.text_elapsed >= 2.0 then
			WOF.anim_state = nil
		end
	end
end

-- Render the animation overlay on top of everything else.
local _love_draw = love.draw
love.draw = function()
	_love_draw()
	local s = WOF.anim_state
	if not s then return end

	local img = WOF.anim_images[s.key]
	if not img then return end

	local meta   = ANIM_META[s.key]
	local sw, sh = love.graphics.getDimensions()

	-- Get actual frame size from the loaded image (works for both 1x and 2x).
	local fw = img:getWidth()  / meta.cols
	local fh = img:getHeight() / meta.rows

	love.graphics.push("all")
	love.graphics.setCanvas()  -- ensure we draw to the screen, not an internal canvas
	love.graphics.origin()

	-- Dimmed backdrop
	love.graphics.setColor(0, 0, 0, 0.65)
	love.graphics.rectangle("fill", 0, 0, sw, sh)

	-- Center animation, scale to 40% of window height
	local scale = (sh * 0.4) / fh
	local dw    = fw * scale
	local dh    = fh * scale
	local ox    = (sw - dw) / 2
	local oy    = (sh - dh) / 2

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(img, WOF.anim_quads[s.key][s.frame], ox, oy, 0, scale, scale)

	-- After animation ends: fade in effect name (gold, above) and description (white, below)
	if s.phase == "text" then
		local t = s.text_elapsed
		local alpha
		if t < 0.25 then
			alpha = t / 0.25
		elseif t > 1.75 then
			alpha = (2.0 - t) / 0.25
		else
			alpha = 1
		end
		alpha = math.max(0, math.min(1, alpha))

		local font = love.graphics.getFont()

		love.graphics.setColor(1, 0.84, 0, alpha)
		local name_w = font:getWidth(s.display_name)
		love.graphics.print(s.display_name, (sw - name_w) / 2, oy - font:getHeight() - 12)

		love.graphics.setColor(1, 1, 1, alpha)
		local desc_w = font:getWidth(s.description)
		love.graphics.print(s.description, (sw - desc_w) / 2, oy + dh + 12)
	end

	love.graphics.pop()
end
