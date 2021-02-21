-- math library
-- thykka::cfds


--[[ constants ]]--
pi=355/113
max_number=0x7fff.ffff--  32767.999...
min_number=0x8000.0000-- -32768


--[[ functions ]]--
log_10_table={
  0,0.3,0.475,0.6,0.7,
  0.775,0.8375,0.9,0.95,1
}
function log10(n)
  if (n<1) return nil
  local t=0
  while n>10 do n=n/10 t=t+1 end
  return log_10_table[flr(n)]+t
end

_min=min
function min(...)
  local m=max_number
  for i,v in ipairs({...}) do
    m=_min(m,v)
  end
  return m
end

_max=max
function max(...)
  local m=min_number
  for i,v in ipairs({...}) do
    m=_max(m,v)
  end
  return m
end

function lerp(a,b,t)
  return a+t*(b-a)
end

