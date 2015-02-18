local gc = Var("GameCommand");

return Def.ActorFrame{
	LoadFont("Common Normal") .. {
	Text=THEME:GetString("ScreenTitleMenu",gc:GetText());
	OnCommand=cmd(shadowlength,1);
	GainFocusCommand=cmd(stoptweening;linear,0.1;diffuse,color(theme_color);shadowlength,1;visible,true);
	LoseFocusCommand=cmd(stoptweening;linear,0.1;diffuse,color(theme_color);shadowlength,1;visible,false);
	};
};