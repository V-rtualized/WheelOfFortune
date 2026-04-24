WOF.Effect({
	key = "boss_interference",
	message = "k_wof_effect_boss_interference",
	is_shared = true,
	removal_mode = "end_ante",
	flag = "boss_interference",
}):inject()

local set_blind_ref = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
	set_blind_ref(self, blind, reset, silent)
	if reset or not WOF.flags.boss_interference then return end
	if not G.GAME or G.GAME.blind ~= self then return end
	local bs = G.GAME.round_resets.blind_states
	if not bs or not (bs.Small == 'Current' or bs.Big == 'Current') then return end

	local boss_key = G.GAME.round_resets.blind_choices and G.GAME.round_resets.blind_choices.Boss
	if not boss_key or not G.P_BLINDS[boss_key] then return end
	local boss_debuff = G.P_BLINDS[boss_key].debuff
	if not boss_debuff or not next(boss_debuff) then return end

	self.debuff = copy_table(boss_debuff)
	for _, v in ipairs(G.playing_cards) do
		self:debuff_card(v)
	end
end
