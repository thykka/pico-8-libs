pico-8 cartridge // http://www.pico-8.com
version 30
__lua__
#include debug.lua
#include animate.lua

function _init()
	cls()
	actors={
		{x=32,y=32,r=16,c=1},
		{x=32,y=32,s=1,z=1},
		{x=96,y=32,s=2,z=1},
		{x=32,y=96,s=3,z=1},
		{x=96,y=96,s=4,z=1}
	}
	anim_fast={
		duration=0.1
	}
end

function _update60()
	for i,actor in pairs(actors) do
		if has_animations(actor) then
			animate(actor)
		end
	end
	local crs=actors[1]
	if btnp(0) or btnp(1) then
		tween(crs,{x=btnp(0) and 32 or 96})
	end
	if btnp(2) or btnp(3) then
		tween(crs,{y=btnp(2) and 32 or 96})
	end
	if btn(5) and not pressed_❎ then
		tween(crs,{r=6,c=7},anim_fast)
		pressed_❎=true
	elseif not btn(5) and pressed_❎ then
		pressed_❎=false
		tween(crs,{r=16,c=1})
	end
end

function _draw()
	cls()
	for actor in all(actors) do
		draw_actor(actor)
	end
	draw_buttons()
end

function draw_actor(actor)
	if actor.s then
		sspr(
			actor.s*8,0,
			8,8,
			actor.x-4,actor.y-4,
			8*(actor.z or 1),
			8*(actor.z or 1)
		)
	elseif actor.r then
		draw_ball(actor)
	end
end

function draw_ball(b)
	circ(b.x-1,b.y,b.r,b.c)
	if(not btn(5))then
		fillp(░)
		circfill(b.x,b.y,b.r,b.c)
		fillp()
	end
end

buttons=split("⬅️➡️⬆️⬇️🅾️❎","")
function draw_buttons()
	local k=""
	for i,v in ipairs(buttons) do
		if(btn(i-1))k..=v
	end
	print(k,64-#k*4,62,6)
	print("",0,0)
	local crs=actors[1]
	local twns=crs[animate_key]
	local twnc=0
	for k,v in pairs(twns) do
		twnc+=1
	end
end
__gfx__
000000000088800000bbb00000ccc000009990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888000bbbbb000ccccc00099999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070087787780b77b77b0c71c71c0987987900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700087187180b17b17b0c77c77c0977977900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700088888880bbbbbbb0ccccccc0999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070088888880bbbbbbb0ccccccc0999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000088888880bbbbbbb0ccccccc0999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080808000b0b0b000c0c0c00090909000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
