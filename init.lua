
------------------------------------
--FUNTIONS

local make_platform = function(target_coords)
	local target_below ={
		x = target_coords.x,
		y = target_coords.y - 2,
		z = target_coords.z
	}

	--at least one must be underplayer
	local target_b1 ={
		x = target_below.x,
		y = target_below.y + math.random(-2, 0),
		z = target_below.z
	}

	local target_b2 ={
		x = target_below.x + math.random(-1, 2),
		y = target_below.y + math.random(-2, 0),
		z = target_below.z + math.random(-2, 1)
	}

	local target_b3 ={
		x = target_below.x + math.random(-1, 2),
		y = target_below.y + math.random(-2, 0),
		z = target_below.z + math.random(-2, 1)
	}

	local target_b4 ={
		x = target_below.x + math.random(-2, 1),
		y = target_below.y + math.random(-2, 0),
		z = target_below.z + math.random(-1, 2)
	}


	local target_r1 ={
		x = target_b1.x + math.random(-2, 2),
		y = target_coords.y + math.random(1, 3),
		z = target_b1.z + math.random(-2, 2)
	}

	local target_r2 ={
		x = target_b2.x + math.random(-2, 2),
		y = target_coords.y + math.random(1, 3),
		z = target_b2.z + math.random(-2, 2)
	}

	local target_r3 ={
		x = target_b3.x + math.random(-2, 2),
		y = target_coords.y + math.random(1, 3),
		z = target_b3.z + math.random(-2, 2)
	}

	local target_r4 ={
		x = target_b4.x + math.random(-2, 2),
		y = target_coords.y + math.random(-4, 6),
		z = target_b4.z + math.random(-2, 2)
	}

	--set platforms and chaos, but don't destroy pre-existing rifts
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_below, {name = "default:obsidian"})
	end
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_b1, {name = "default:obsidian"})
	end
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_b2, {name = "default:obsidian"})
	end
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_b3, {name = "default:obsidian"})
	end
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_b4, {name = "default:obsidian"})
	end
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_r1, {name = "fire:basic_flame"})
	end
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_r2, {name = "fire:basic_flame"})
	end
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_r3, {name = "fire:basic_flame"})
	end
	if minetest.get_node(target_b1).name ~= "luckyportal:rift" then
		minetest.set_node(target_r4, {name = "fire:basic_flame"})
	end

end



--PARTICLE SPAWNER
local flash1 = function(pos)
	minetest.add_particlespawner({
		amount = 5,
		time = 0.5,
		minpos = {x = pos.x, y = pos.y, z = pos.z },
		maxpos = {x = pos.x, y = pos.y, z = pos.z },
		minvel = {x = -2, y = -0, z = -2},
		maxvel = {x = 2, y = 1, z = 2},
		minacc = {x = -1, y = -1, z = -1},
		maxacc = {x = 1, y = 1, z = 1},
		minexptime = 0.02,
		maxexptime = 0.1,
		minsize = 10,
		maxsize = 45,
		collisiondetection = false,
		vertical = false,
		texture = "luckyportal_lightning.png",
		glow = 14,
	})
end

local flash2 = function(pos)
	minetest.add_particlespawner({
		amount = 85,
		time = 2,
		minpos = {x = pos.x + math.random(-0.7, 0), y = pos.y + math.random(-0.7, 0), z = pos.z + math.random(-0.7, 0)},
		maxpos = {x = pos.x + math.random(-0, 0.7), y = pos.y + math.random(-0, 0.7), z = pos.z + math.random(-0, 0.7)},
		minvel = {x = -1, y = -1, z = -1},
		maxvel = {x = 1, y = 1, z = 1},
		minacc = {x = -5, y = -5, z = -5},
		maxacc = {x = 5, y = 5, z = 5},
		minexptime = 0.01,
		maxexptime = 0.07,
		minsize = 10,
		maxsize = 35,
		collisiondetection = false,
		vertical = false,
		texture = "luckyportal_lightning.png",
		glow = 14,
	})
end

--TELEPORT TO RANDOM
local teleport = function(player, pos, x, y, z)

		--find a new location
		local target_coords ={
			x = math.random(-x, x),
			y = math.random(-y, y),
			z = math.random(-z, z)
		}

		--positions for create platform etc
		local riftpos ={
			x = target_coords.x + math.random(-2, 2),
			y = target_coords.y + math.random(-1, 1),
			z = target_coords.z + math.random(-2, 2)
		}


		--do the full routine...
		--blow out, create structures
		--(boom only seems to work if called twice... not sure why)
		tnt.boom(target_coords, {
						radius = 2,
						damage_radius = 2,
					})
		tnt.boom(target_coords, {
						radius = 3,
						damage_radius = 3,
					})
		make_platform(target_coords)

		minetest.set_node(riftpos, {name = "luckyportal:rift"})
		--set return target for rift
		local meta = minetest.get_meta(riftpos)
		meta:set_int("x", pos.x)
		meta:set_int("y", pos.y)
		meta:set_int("z", pos.z)

		--replace the origin portal with a linked rift
		minetest.set_node(pos, {name = "luckyportal:rift"})
		--set return target for rift
		local meta = minetest.get_meta(pos)
		meta:set_int("x", riftpos.x)
		meta:set_int("y", riftpos.y)
		meta:set_int("z", riftpos.z)

		player:moveto(target_coords, true)


		--flash effects at source
		minetest.sound_play("luckyportal_bell", {pos = pos, gain = 1.0, max_hear_distance = 10,})
		flash1(pos)

		--flash effects at destination
		minetest.sound_play("luckyportal", {pos = target_coords, gain = 3.5, max_hear_distance = 100,})
		flash1(target_coords)
end




--rift return
local rift_return = function(player, pos)

	--read target from metadata
	local meta = minetest.get_meta(pos)
	local tx = meta:get_int("x")
	local ty = meta:get_int("y")
	local tz = meta:get_int("z")

	--find a new location
	if tx ~= nil and ty ~=nil and tz ~= nil then
		local target_coords ={
			x = tx,
			y = ty,
			z = tz
		}

		--chance of the pair of rifts collapsing violently
		local blow_chance = math.random(1, 5000)

		--zap on use
		flash1(pos)
		minetest.sound_play("luckyportal", {pos = target_coords, gain = 6.0, max_hear_distance = 100,})


		--rare blow up of origin rift..before arrival so don't kill
		if blow_chance <= 1 then
			minetest.set_node(target_coords, {name = "air"})
			--(boom only seems to work if called twice... not sure why)
			tnt.boom(target_coords, {
				radius = 2,
				damage_radius = 2,
			})
			tnt.boom(target_coords, {
				radius = 5,
				damage_radius = 5,
			})
		end


		--player is returned to origin rift
		make_platform(target_coords)
		player:moveto(target_coords, true)
		minetest.sound_play("luckyportal", {pos = target_coords, gain = 3.5, max_hear_distance = 100,})
		flash1(target_coords)

		--rare blow up rift (after leave so don't kill player)
		--(boom only seems to work if called twice... not sure why)
		if blow_chance <= 1 then
			tnt.boom(target_coords, {
				radius = 2,
				damage_radius = 2,
			})
			tnt.boom(pos, {
				radius = 10,
				damage_radius = 10,
			})
			minetest.set_node(pos, {name = "air"})
		end
	end
end


---------------------------------------------
--NODES

--luckyportal node

minetest.register_node('luckyportal:luckyportal', {
	description = 'Unstable Wormhole',
	drawtype = "mesh",
	mesh = "luckyportal_sphere.obj",
	visual_scale = 2,
	selection_box = {
		type = "fixed",
		fixed = {-0.56, -0.56, -0.56, 0.56, 0.56, 0.56},
	},
	light_source = 3,
	walkable = false,
	diggable = false,
	tiles = {
		{name="luckyportal_swirl.png",
		animation = {type="vertical_frames", length=80.0}}
	},
	groups = {cracky = 3, oddly_breakable_by_hand=1, igniter = 2},
	use_texture_alpha = true,
	post_effect_color = {a = 180, r = 255, g = 255, b = 255},
	on_punch = function(pos, node, puncher)
		teleport(puncher, pos, 30000, 30000, 30000)
	end,
	on_blast = function(pos)
		minetest.sound_play("luckyportal_thunder", {pos = target_coords, gain = 7, max_hear_distance = 60,})
		flash2(pos)
	end,
	})


-- Rift
minetest.register_node('luckyportal:rift', {
	description = 'Unstable Spacetime Rift',
	drawtype = "mesh",
	mesh = "luckyportal_sphere.obj",
	visual_scale = 2,
	light_source = 3,
	selection_box = {
		type = "fixed",
		fixed = {-0.56, -0.56, -0.56, 0.56, 0.56, 0.56},
	},
	walkable = false,
	diggable = false,
	tiles = {
		{name="luckyportal_swirl.png",
		animation = {type="vertical_frames", length=80.0}}
	},
	groups = {cracky = 3, oddly_breakable_by_hand=1, not_in_creative_inventory = 1, igniter = 2},
	use_texture_alpha = true,
	post_effect_color = {a = 180, r = 255, g = 255, b = 255},
	on_construct = function(pos)
		--set nil target
		local meta = minetest.get_meta(pos)
    meta:set_string("x", nil)
		meta:set_string("y", nil)
		meta:set_string("z", nil)
    end,

	on_punch = function(pos, node, puncher)
		--chance of sending other than where intended
		if math.random(1,5000) > 1 then
			rift_return(puncher, pos)
		else
			teleport(puncher, pos, 30000, 30000, 30000)
		end
	end,
	on_blast = function(pos)
		minetest.sound_play("luckyportal_thunder", {pos = target_coords, gain = 7, max_hear_distance = 60,})
		flash2(pos)
	end,
	drop = "luckyportal:luckyportal"
	})








-------------------------------------------------
--ABMS

-- teleport random
minetest.register_abm{
    nodenames = {"luckyportal:luckyportal"},
    interval = 5,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
			--is player in radius?
			local objs = minetest.env:get_objects_inside_radius(pos, 1.6)
			for k, player in pairs(objs) do
				if player:get_player_name()~=nil then
					teleport(player, pos, 30000, 30000, 30000)
				end
			end
end,
}

-- teleport back from rift
minetest.register_abm{
  nodenames = {"luckyportal:rift"},
  interval = 5,
  chance = 25,
  action = function(pos, node, active_object_count, active_object_count_wider)
		--is player in radius?
		local objs = minetest.env:get_objects_inside_radius(pos, 1.6)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then
				if math.random(1,5000) > 1 then
					--return where you intended
					rift_return(player, pos)
				else
					--get lost in space, detaches from original, forms a new one
					teleport(player, pos, 30000, 30000, 30000)
				end
			end
		end
end,
}

--Ambience
minetest.register_abm{
  nodenames = {"luckyportal:rift", "luckyportal:luckyportal"},
  interval = 3,
  chance = 2,
  action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.sound_play("luckyportal_noise", {pos = target_coords, gain = 5, max_hear_distance = 20,})
		minetest.sound_play("luckyportal_thunder", {pos = target_coords, gain = 7, max_hear_distance = 50,})
		flash2(pos)
end,
}


--Portal Explodes spontaneously in an enormous bang
minetest.register_abm{
  nodenames = {"luckyportal:rift", "luckyportal:luckyportal"},
  interval = 60,
  chance = 5000,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.sound_play("luckyportal_thunder", {pos = target_coords, gain = 20, max_hear_distance = 200,})
		minetest.sound_play("luckyportal", {pos = target_coords, gain = 4.0, max_hear_distance = 100,})
		tnt.boom(pos, {
						radius = 10,
						damage_radius = 10,
					})
		flash2(pos)
		minetest.set_node(pos, {name = "air"})
end,
}


--Crafting

minetest.register_craft({
	output = "luckyportal:luckyportal 1",
	recipe = {
		{"default:coal_lump", "", "default:coal_lump"},
		{"", "default:mese_crystal_fragment", ""},
		{"default:mese_crystal_fragment", "default:coal_lump", "default:mese_crystal_fragment"}
	}
})
