-- ScreenTestInput overlay

local t = Def.ActorFrame{
	-- menu items quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_TOP+30;diffuse,color("0,0,0,0.75"));
	},
	-- had to borrow this code to not overwrite fallback...
	Def.DeviceList{
		Font="Common Normal",
		InitCommand=cmd(x,SCREEN_LEFT+20;y,SCREEN_TOP+80;zoom,0.8;halign,0);
	},
	Def.InputList{
		Font="Common Normal",
		InitCommand=cmd(x,SCREEN_CENTER_X-250;y,SCREEN_CENTER_Y;zoom,1;halign,0;vertspacing,8);
	}
};

return t;