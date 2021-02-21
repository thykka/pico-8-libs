
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

function animate_keys(node,target,keys,duration,easing,custom_time)
 local n=node
 n._t=target
 local e=easing or ease_linear
 local d=duration or 1
 local iv={}
 for key in all(keys) do
  iv[key..1]=n[key]
  iv[key..2]=n._t[key]
 end
 local st=custom_time or time()
 n._a=function(t)
  local tm=e((t-st)/d)
  if tm>=1 then
   for key in all(keys) do
    n[key]=iv[key..2]
   end
   n._a=nil
   return
  end
  for key in all(keys) do
   n[key]=lerp(iv[key..1],iv[key..2],tm)
  end
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