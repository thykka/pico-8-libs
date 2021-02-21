
function lerp(a,b,t)
 return a+t*(b-a)
end

function ilerp(a,b,v)
 return (v-a)/(b-a)
end

function ease_linear(t) return t end
function ease_quad_in(t) return t*t end
function ease_quad_out(t)
 t-=1
 return 1-t*t
end
function ease_quad_inout(t)
 if(t<0.5) return t*t*2
 t-=1
 return 1-t*t*2
end

function animate(node,t)
 for key,a in pairs(node._animations) do
  node._animations[key]:animate(t or time())
 end
end

function has_animations(node)
 local a=node._animations
 if a then
  for key,anim_fn in pairs(a) do
   return true
  end
  return false
 end
end

function animate_key(node,key,value,duration,easing,custom_time)
 if type(node._animations)!="table" then
  node._animations={}
 end
 node._animations[key]={
  start=node[key],
  stop=value,
  duration=duration or 1,
  start_time=custom_time or time(),
  easing=type(easing)=="function" and easing or ease_linear,
  animate=function(self,t)
   local _t=self.easing((t-self.start_time)/self.duration)
   if _t>=1 then
    node[key]=self.stop
    node._animations[key]=nil
    return
   end
   node[key]=lerp(self.start,self.stop,_t)
  end
 }
end