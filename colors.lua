colors={
 black=0,
 dkblue=1,
 dkpurple=2,
 dkgreen=3,
 brown=4,
 dkgray=5,
 ltgray=6,
 white=7,
 red=8,
 orange=9,
 yellow=10,
 green=11,
 blue=12,
 lavender=13,
 pink=14,
 ltpeach=15,
 ltblack=128,
 dkrblue=129,
 dkrpurple=130,
 turqoise=131,
 dkbrown=132,
 dkrgray=133,
 mdgray=134,
 ltyellow=135,
 dkred=136,
 dkorange=137,
 ltgreen=138,
 mdgreen=139,
 mdblue=140,
 mauve=141,
 dkpeach=142,
 peach=143
}
gradients={
 blue   ={"dkrblue","dkblue","mdblue","blue"},
 red    ={"dkrpurple","dkpurple","dkred","red"},
 green  ={"turqoise","dkgreen","mdgreen","green"},
 ltgreen={"dkgreen","mdgreen","green","ltgreen"},
 brown  ={"ltblack","dkbrown","brown","dkpeach"},
 dkgray ={"black","ltblack","dkrgray","dkgray"},
 ltgray ={"mdgray","ltgray","ltpeach","white"},
 yellow ={"dkorange","orange","yellow","ltyellow"}
}

function palette_from_gradients(grads)
 local p={}
 for grad_name in all(grads) do
  for color_name in all(gradients[grad_name]) do
   add(p, colors[color_name])
  end
 end
 return p
end

function palette_from_color_names(color_names)
 local p={}
 for name in all(color_names) do
  add(p,colors[name])
 end
 return p
end

function color_names(colors_in)
 local n={}
 for color_in in all(colors_in) do
  for color_name,color in pairs(colors) do
   if color == color_in then
    add(n,color_name)
    break
   end
  end
 end
 return n
end

function init_palette(palette)
 palette_current=palette or {}
 poke(0x5f2e,1) -- don't reset pal on exit
 set_palette(palette_current, 1)
end

function set_palette(palette, screen)
 local color_table = {}
 for i=0,15 do
   color_table[i]=palette[i+1]
 end
 pal(color_table, screen and 1 or 0)
end
