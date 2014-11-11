-- ScreenProfileLoad underlay

local t = Def.ActorFrame{
	Name="ScreenProfileLoadUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("Load Profile"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	fast_song
};

return t;