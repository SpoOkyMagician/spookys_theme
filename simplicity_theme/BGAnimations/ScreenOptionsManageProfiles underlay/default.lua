-- ScreenOptionsManageProfiles underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsManageProfilesUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("Manage Profiles"),
	-- GLOBAL dark quad
	grid_t,
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","options_theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- GLOBAL play music
	slow_song
};

return t;