WOF.Effect({
	key = "random_tag",
	message = "Get a random tag",
	is_shared = false,
	min_ante = 0,
	calculate = function(self)
		local pool = G.P_CENTER_POOLS['Tag']
		if not pool or #pool == 0 then return end
		local tag_proto = pool[math.random(#pool)]
		add_tag(Tag(tag_proto.key))
	end,
}):inject()
