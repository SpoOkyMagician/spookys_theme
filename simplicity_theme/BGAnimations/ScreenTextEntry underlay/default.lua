-- ScreenTextInput underlay

local t = Def.ActorFrame{
	-- GLOBAL black quad
	grid_a,
	LoadActor(THEME:GetPathG("","bg_generic"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- GLOBAL theme color quad
	grid_u,
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
	-- GLOBAL profile divider
	grid_s,
	-- GLOBAL screen text
	common_text("Text Input"),
	-- GLOBAL dark quad
	grid_t,
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	}
	-- don't play music here...
};

return t;