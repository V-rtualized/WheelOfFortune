WOF.tea_break_end_time = nil
WOF.tea_break_audio = nil

WOF.Effect({
	key = "tea_break",
	message = "k_wof_effect_tea_break",
	is_shared = false,
	on_add = function(self)
		WOF.tea_break_end_time = G.TIMERS.REAL + 30
		WOF.flags.tea_break = true
		local data = NFS.read("data", WOF.path .. "assets/voice_message.ogg")
		if data then
			local ok, source = pcall(function()
				return love.audio.newSource(love.sound.newDecoder(data), "stream")
			end)
			if ok and source then
				WOF.tea_break_audio = source
				local vol = (G.SETTINGS.SOUND.volume / 100.0) * (G.SETTINGS.SOUND.game_sounds_volume / 100.0)
				WOF.tea_break_audio:setVolume(vol)
				WOF.tea_break_audio:play()
			end
		end
	end,
}):inject()
