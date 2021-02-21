
debug_width=1024--broken with control codes..
debug_config={
  colors={
    default=1,
    [""]=1,
    string="c",
    number="e",
    boolean="f",
    other="8",
    paren="5"
  }
}

function debug(val,c)
 local oc=peek(0x5f25)
 local co=c or debug_config.colors.default
 local serialized=debug_serialize(val)
 for i=1,#serialized,debug_width do
   print((i==1 and "…" or "")..sub(serialized,i,i+debug_width-1),co)
 end
 color(oc)
 return serialized
end

function debug_serialize(val,round)
  local c=debug_color
  if val==nil then return c"other".."nil"..c"" end
  local vtype=type(val)
  if vtype=="string"then
    return c(vtype).."\""..val.."\""..c""
  elseif vtype=="number"then
    if(round) return c(vtype)..tostr(val\1)..c""
    return c(vtype)..tostr(val)..c""
  elseif vtype=="boolean"then
    return c(vtype)..(val and "true" or "false")..c""
  elseif vtype=="table"then
    local out=""
    local i=1
    for k,v in pairs(val) do
      out=out..(type(k)=="string"and k.."=" or "")..debug_serialize(v,round)
      out=out..","
      i+=1
    end
    return c"paren".."{"..sub(out,0,-2)..c"paren".."}"..c""
  elseif vtype=="function"then
   return c"other".."[function]"..c""
  end
end

function debug_color(fg,bg)
 local fgc=fg and debug_config.colors[fg] or false
 local bgc=bg and debug_config.colors[bg] or false
 return (fgc and ("\f"..fgc) or "")..(bgc and ("\b"..bgc) or "")
end