-- ScreenSelectGame underlay

local t = Def.ActorFrame{
	-- GLOBAL screen text
	common_text("Select Game Mode"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	slow_song
};

return t;