-- ScreenEditCourseModsMenu overlay

local t = Def.ActorFrame{
	Name="ScreenEditCourseModsMenuOverlayActorFrame";
	-- GLOBAL screen text
	common_text("Edit Courses and Mods"),
	-- this is overlapping text... fix this... use grid_t
	grid_t,
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","options_theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- GLOBAL play music
	slow_song
};

return t;