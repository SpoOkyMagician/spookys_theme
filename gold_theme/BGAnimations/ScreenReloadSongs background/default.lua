-- ScreenReloadSongs background

local t = Def.ActorFrame{
	-- GLOBAL black quad
	grid_a,
	LoadActor(THEME:GetPathG("","bg_gold"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
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
	--[ screen text
	LoadFont("SpoOky")..{
		Text="Reload Songs";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- menu items quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_TOP+30;diffuse,color("0,0,0,0.75"));
	},
	-- GLOBAL play music
	asian_song
};

return t;