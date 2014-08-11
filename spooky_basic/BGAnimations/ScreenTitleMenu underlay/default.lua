local t = Def.ActorFrame{
	-- GLOBAL black quad
	grid_a,
--	LoadActor("iso_grid")..{
--		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
--		OnCommand=cmd(texcoordvelocity,0,0.1);
--	},
	-- GLOBAL dark gold header quad
	grid_b,
	-- GLOBAL dark gold footer quad
	grid_c,
	-- GLOBAL top border
	grid_d,
	-- GLOBAL bottom border
	grid_e,
	-- GLOBAL left border
	grid_f,
	-- GLOBAL right border
	grid_g,
	-- GLOBAL profile border
	grid_h,
	-- GLOBAL screen border
	grid_i,
	-- neat arrows
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-96;y,SCREEN_CENTER_Y;baserotationz,90;SetSize,32,32);
	},
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y;baserotationz,-90;SetSize,32,32);
	},
	-- screen text
	LoadFont("SpoOky")..{
		Text="Title Screen |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	-- logo extra text
	LoadFont("SpoOky")..{
		Text="STEPMANIA 5";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/3.75+4;diffuse,color(theme_color);diffusebottomedge,color("0,0,0,1");zoom,2.0;align,0.5,0.5);
	},
	-- logo text
	LoadFont("SpoOky")..{
		Text="STEPMANIA 5";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/3.75;diffuse,color(theme_color);zoom,2.0;align,0.5,0.5);
	},
	-- product version text
	LoadFont("SpoOky")..{
		Text=ProductVersion();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+32;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	-- build date text
	LoadFont("SpoOky")..{
		Text=VersionDate();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+48;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	-- build time text
	LoadFont("SpoOky")..{
		Text=VersionTime();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+64;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	-- server text
	LoadFont("SpoOky")..{
		Text=GetServerName();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+80;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	-- server text
	LoadFont("SpoOky")..{
		Text=tostring(IsNetConnected());
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+96;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	-- GLOBAL play music
	main_song
};

return t;