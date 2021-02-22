animate_key="__a"
animate_default_duration=0.4
animate_default_easing=3

ease_linear=1
ease_quad_in=2
ease_quad_out=3
ease_quad_in_out=4

animate_easings={
--linear
  function(t) return t end,
--quad_in
  function(t) return t*t end,
--quad_out
  function(t) t-=1 return 1-t*t end,
--quad_in_out
  function(t)
    if(t<0.5)return t*t*2
    t-=1 return 1-t*t*2
  end
}

-- linear interpolation
function lerp(a,b,t)
 return a+t*(b-a)
end

-- inverse linear interpolation
function ilerp(a,b,v)
 return (v-a)/(b-a)
end

-- update node with each of it's animations
function animate(node,t)
 for key,a in pairs(node[animate_key]) do
  node[animate_key][key]:animate(t or time())
 end
end

-- check if a node has any active animations
function has_animations(node)
 local a=node[animate_key]
 if a then
  for key,anim_fn in pairs(a) do
   return true
  end
  return false
 end
end

-- creates and attaches a tweening animation to the object
-- options:
--   duration - tween duration (default: in seconds)
--   easing - override easing function (expects an index)
--   custom_time - starting time for tween
function tween_value(node,key,value,options)
 if type(node[animate_key])!="table" then
  node[animate_key]={}
 end
 local o=options or {}
 node[animate_key][key]={
  start=node[key],
  stop=value,
  duration=o.duration or animate_default_duration,
  start_time=o.custom_time or time(),
  easing=type(o.easing)=="number" and o.easing or animate_default_easing,
  animate=_tween_function(node,key)
 }
end

-- (internal) creates an animate function for a tween
function _tween_function(node,key)
 return function(self,t)
  -- _t is the eased tween time from 0 to 1
  local _t=animate_easings[self.easing]((t-self.start_time)/self.duration)
   if _t>=1 then
    -- clamp to final value
    node[key]=self.stop
    animate_clear(node,key)
    return
   end
   -- apply current animation value
   node[key]=lerp(self.start,self.stop,_t)
 end
end

-- cleans up the given key's animation
function animate_clear(node,key)
 node[animate_key][key]=nil
 --remove animate_key, if no animations left
 for k,v in pairs(node[animate_key]) do return end
 node[animate_key]=nil
end

function tween(node,target,options)
 for k,v in pairs(target) do
  tween_value(node,k,v,options)
 end
end