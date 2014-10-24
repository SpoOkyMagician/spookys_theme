-- ScreenOptionsService underlay

local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("","bg_generic"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- GLOBAL theme color quad
	grid_u
};

return t;