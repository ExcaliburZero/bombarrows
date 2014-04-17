-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- Bomb Arrow        --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --

minetest.register_craftitem("bombarrows:arrow_bomb", {
	description = "Bomb Arrow",
	inventory_image = "bombarrows_arrow_bomb.png",
})

minetest.register_node("bombarrows:arrow_bomb_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},
			
			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"bombarrows_arrow_bomb.png", "bombarrows_arrow_bomb.png", "bombarrows_arrow_bomb_back.png", "bombarrows_arrow_bomb_front.png", "bombarrows_arrow_bomb_2.png", "bombarrows_arrow_bomb.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"bombarrows:arrow_bomb_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
	node = "",
}

THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "bombarrows:arrow_bomb_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					if self.node ~= "" then
						for dx=-1,1 do
							for dy=-2,1 do
								for dz=-1,1 do
									local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
									local n = minetest.env:get_node(pos).name
									if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 30 then
										minetest.env:set_node(p, {name="fire:basic_flame"})
									else
										minetest.env:remove_node(p)
									end
								end
							end
						end
					end
					self.object:remove()
				end
			else
				if self.node ~= "" then
					for dx=-1,1 do
						for dy=-2,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(pos).name
								if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 30 then
									minetest.env:set_node(p, {name="fire:basic_flame"})
								else
									minetest.env:remove_node(p)
								end
							end
						end
					end
				end
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= "air" then
			if self.node ~= "" then
				for dx=-1,1 do
					for dy=-2,1 do
						for dz=-1,1 do
							local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
							local n = minetest.env:get_node(pos).name
							if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 30 then
								minetest.env:set_node(p, {name="fire:basic_flame"})
							else
								minetest.env:remove_node(p)
							end
						end
					end
				end
			end
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity("bombarrows:arrow_bomb_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
output = "bombarrows:arrow_bomb",
recipe = {
{'', '', ''},
{'', '', ''},
{'', '', ''},
}
})
