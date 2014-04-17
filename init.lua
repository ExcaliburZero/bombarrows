modpath=minetest.get_modpath("bombarrows")

dofile(modpath.."/bomb_arrow.lua")

arrows = {
	{"throwing:arrow", "throwing:arrow_entity"},
	{"throwing:arrow_fire", "throwing:arrow_fire_entity"},
	{"throwing:arrow_teleport", "throwing:arrow_teleport_entity"},
	{"throwing:arrow_dig", "throwing:arrow_dig_entity"},
	{"throwing:arrow_build", "throwing:arrow_build_entity"},
	{"bombarrows:arrow_bomb", "bombarrows:arrow_bomb_entity"}
}
