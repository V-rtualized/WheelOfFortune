WOF.Effect({
	key = "tag_bonanza",
	message = localize("k_wof_effect_tag_bonanza"),
	is_shared = false,
	min_ante = 0,
	on_add = function(self)
		local pool = G.P_CENTER_POOLS['Tag']
		if not pool or #pool == 0 then return end
		local tag_proto = pool[math.random(#pool)]
		add_tag(Tag(tag_proto.key))
	end,
}):inject()
