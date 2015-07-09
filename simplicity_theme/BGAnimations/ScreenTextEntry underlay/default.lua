-- ScreenTextInput underlay

local t = Def.ActorFrame{
	Name="ScreenTextInputUnderlayActorFrame";
	-- Actor (Generic BG)
	LoadActor(THEME:GetPathG("","bg_generic"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- Actor/Function (scripts)
	grid_d(),
	-- Actor/Function (scripts)
	grid_a(),
	-- Actor/Function (scripts)
	grid_b(),
	-- Actor/Function (scripts)
	common_text("Text Input"),
	-- Actor (scripts)
	grid_c(),
	-- Actor/Function (scripts)
	theme_skin("theme_skin")
};

return t;