-- ScreenOptionsGraphicsSound underlay

local t = Def.ActorFrame{
	-- GLOBAL screen text
	common_text("Graphics and Sound Options"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	slow_song
};

return t;