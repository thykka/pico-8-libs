pico-8 cartridge // http://www.pico-8.com
version 30
__lua__
#include debug.lua

--█▒🐱⬇️░✽●♥☉웃⌂⬅️😐♪
--🅾️◆…➡️★⧗⬆️ˇ∧❎▤▥

cls()
function nfo(v)
 print(v,6)
end

function is_even(v)
	return v&1==0
end

function fmt_kv(sep)
	local s=sep or "="
	return function(v,k)
		return k..s..v
	end
end

function sum_all(r,v)
	return r+v
end

function starts_with(l)
	return function(v)
		return sub(v,1,1)=="b"
	end
end

#include tables.lua

nfo('my_t=split("foo,bar,baz")')
my_t=split("foo,bar,baz")
debug(my_t)

nfo'map(my_t,fmt_kv":")'
my_t2=t_map(my_t,fmt_kv":")
debug(my_t2)

nfo'filter(my_t,starts_with"b")'
my_t3=t_filter(my_t,starts_with"b")
debug(my_t3)

nfo"reduce({3,3,4},sum_all,0)"
my_t4=t_reduce({3,3,4},sum_all,0)
debug(my_t4)

nfo"flat({1,2,{3,4}})"
my_t5=t_flat({1,2,{3,4}})
debug(my_t5)

nfo("find({1,1,2,3,5,8},is_even)")
my_t6=t_find({1,1,2,3,5,8},is_even)
debug(my_t6)

nfo'find_i(my_t,"baz")'
my_t7=t_find_i(my_t,"baz")
debug(my_t7)

nfo'vals='
my_t8={8,8,9,10}
debug(my_t8)
nfo'sort(vals)'
sort(my_t8)
debug(my_t8)

nfo'reverse(vals)'
t_reverse(my_t8)
debug(my_t8)
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
