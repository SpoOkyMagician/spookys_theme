-- ScreenTestInput underlay

local t = Def.ActorFrame{
	Name="ScreenTestInputUnderlayActorFrame";
	-- Actor/Function (scripts)
	grid_c(),
	-- Actor (had to borrow this code to not overwrite fallback... i need to change the color anyway...)
	Def.DeviceList{
		Font="Common Normal",
		InitCommand=cmd(x,SCREEN_LEFT+20;y,SCREEN_TOP+80;zoom,0.8;halign,0;diffuse,color(theme_color));
	},
	Def.InputList{
		Font="Common Normal",
		InitCommand=cmd(x,SCREEN_CENTER_X-250;y,SCREEN_CENTER_Y;zoom,1;halign,0;vertspacing,8;diffuse,color(theme_color));
	}
};

return t;