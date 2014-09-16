-- ScreenEditMenu overlay

local t = Def.ActorFrame{
	-- GLOBAL screen text
	common_text("Edit Songs and Steps"),
	-- this is overlapping text... fix this... use quad_t
	grid_t,
	-- GLOBAL play music
	asian_song
};

return t;