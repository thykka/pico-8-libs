function t_map(tbl, map_fn)
 local nt={}
 for i,v in ipairs(tbl) do
  add(nt,map_fn(v,i,tbl))
 end
 return nt
end

function t_filter(tbl, filter_fn)
 local nt={}
 for i,v in ipairs(tbl) do
  if filter_fn(v,i,tbl) then
   add(nt,v)
  end
 end
 return nt
end

function t_reduce(tbl, reduce_fn, initial)
 local r=initial
 for i,v in ipairs(tbl) do
  r=reduce_fn(r,v,i,tbl)
 end
 return r
end

function t_flat(tbl)
 local nt={}
 for v in all(tbl) do
  if type(v)=="table" then
   for tv in all(v) do
    add(nt,tv)
   end
  else
   add(nt,v)
  end
 end
 return nt
end

function t_find(tbl, find_fn)
 local fn=type(find_fn)=="function"
  and find_fn
   or find_fn_equals(find_fn)
 local f
 for i,v in ipairs(tbl) do
  f=fn(v,i,tbl) and v or nil
  if f then
   break
  end
 end
 return f
end

function t_find_i(tbl, find_fn)
 local fn=type(find_fn)=="function"
  and find_fn
   or find_fn_equals(find_fn)
 local re
 for i,v in ipairs(tbl) do
  re=fn(v,i,tbl)
  if re then
   re=i
   break
  end
 end
 return re or -1
end

function find_fn_equals(n)
 return function(v,i,a)
  return v==n
 end
end

--samhocevar's fast sort
-- https://www.lexaloffle.com/bbs/?tid=38706
function sort(t, a, b)
 local a, b = a or 1, b or #t
 if (a >= b) return
 local m = (a + b) \ 2
 local j, k = a, m + 1
 sort(t, a, m)
 sort(t, k, b)
 local v = { unpack(t) }
 for i = a, b do
  if (k > b or j <= m and v[j] <= v[k]) t[i] = v[j] j += 1 else t[i] = v[k] k += 1
 end
end

function t_reverse(tbl)
 for i=0,#tbl/2-1 do
  t=tbl[#tbl-i]
  tbl[#tbl-i]=tbl[i+1]
  tbl[i+1]=t
 end
end

