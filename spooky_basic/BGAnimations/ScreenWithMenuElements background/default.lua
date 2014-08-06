local t = Def.ActorFrame{
	--[ black quad
	grid_a,
	--[ dark gold header quad
	grid_b,
	--[ dark gold footer quad
	grid_c,
	--[ top border
	grid_d,
	--[ bottom border
	grid_e,
	--[ left border
	grid_f,
	--[ right border
	grid_g,
	--[ profile border
	grid_h,
	--[ screen border
	grid_i
	--[ player border
	--[Def.Quad{
	--[	InitCommand=cmd(stretchto,SCREEN_CENTER_X-2,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM;diffuse,color(theme_color));
	--[};
};

return t;