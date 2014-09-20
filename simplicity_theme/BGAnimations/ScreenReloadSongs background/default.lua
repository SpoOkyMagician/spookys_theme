-- ScreenReloadSongs background

local t = Def.ActorFrame{
	-- GLOBAL black quad
	grid_a,
	LoadActor(THEME:GetPathG("","bg_generic"))..{
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
	-- GLOBAL screen text
	common_text("Reload Songs"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	asian_song
};

return t;