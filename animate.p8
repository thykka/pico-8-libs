pico-8 cartridge // http://www.pico-8.com
version 30
__lua__
#include debug.lua
#include animate.lua

function _init()
	cls()
	actors={
		{x=32,y=32,r=6,c=1},
		{x=32,y=32,s=1},
		{x=96,y=32,s=2},
		{x=32,y=96,s=3},
		{x=96,y=96,s=4}
	}
end

function _update60()
	for i,actor in pairs(actors) do
		if has_animations(actor) then
			animate(actor)
		end
	end
	if btnp(0) or btnp(1) then
		animate_key(
			actors[1],"x",
			btnp(0) and 32 or 96,
			0.5,ease_quad_out
		)
	end
	
	if btnp(2) or btnp(3) then
		animate_key(
			actors[1],"y",
			btnp(2) and 32 or 96,
			0.5,ease_quad_out
		)
	end
	if btn(5) then
		animate_key(
			actors[1],"r",6,0.75
		)
	else
		animate_key(
			actors[1],"r",16,0.25
		)
	end
end

function _draw()
	cls()
	for actor in all(actors) do
		draw_actor(actor)
	end
	local k=""
	if(btn(0))k..="⬅️"
	if(btn(1))k..="➡️"
	if(btn(2))k..="⬆️"
	if(btn(3))k..="⬇️"
	if(btn(4))k..="🅾️"
	if(btn(5))k..="❎"
	print(k,64-#k*4,62,6)
end

function draw_actor(actor)
	if actor.s then
		spr(actor.s,actor.x-3,actor.y-3)
	elseif actor.r then
		draw_ball(actor)
	end
end

function draw_ball(b)
	--current target
--	circfill(b._t.x,b._t.y,2,5)
	--ball
	circ(b.x,b.y,b.r,b.c)
	if(btn(5))then
		fillp(▒)
		circfill(b.x,b.y,b.r,b.c)
		fillp()
	end
end
__gfx__
000000000088800000bbb00000ccc000009990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888000bbbbb000ccccc00099999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070087787780b77b77b0c70c70c0907907900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700087087080b07b07b0c77c77c0977977900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700088888880bbbbbbb0ccccccc0999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070088888880bbbbbbb0ccccccc0999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000088888880bbbbbbb0ccccccc0999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080808000b0b0b000c0c0c00090909000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
