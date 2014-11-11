-- ScreenEditMenu overlay

local t = Def.ActorFrame{
	Name="ScreenEditMenuOverlayActorFrame";
	-- GLOBAL screen text
	common_text("Edit Songs and Steps"),
	-- this is overlapping text... fix this... use quad_t
	grid_t,
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","options_theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- GLOBAL play music
	slow_song
};

return t;