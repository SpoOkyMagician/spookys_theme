-- ScreenTitleMenu underlay

local t = Def.ActorFrame{
	-- GLOBAL black quad
	grid_a,
	LoadActor(THEME:GetPathG("","bg_gold"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- GLOBAL dark gold header quad
	grid_b,
	-- GLOBAL dark gold footer quad
	grid_c,
	-- GLOBAL top border
	grid_d,
	-- GLOBAL bottom border
	grid_e,
	-- GLOBAL left border
	grid_f,
	-- GLOBAL right border
	grid_g,
	-- GLOBAL profile border
	grid_h,
	-- GLOBAL screen border
	grid_i,
	-- GLOBAL profile divider
	grid_s,
	-- menu items quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+314,SCREEN_BOTTOM/2-18,SCREEN_RIGHT-314,SCREEN_BOTTOM/2+18;diffuse,color("0,0,0,0.5"));
	},
	-- menu info quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-115,SCREEN_RIGHT-2,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- neat arrows
	LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-96;y,SCREEN_CENTER_Y;baserotationz,90;SetSize,32,32;bob;effectmagnitude,2,0,0;effecttiming,0.25,0.25,0.25,0.25);
	},
	LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y;baserotationz,-90;SetSize,32,32;bob;effectmagnitude,2,0,0;effecttiming,0.25,0.25,0.25,0.25);
	},
	-- screen text
	LoadFont("SpoOky")..{
		Text="Title Screen";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- logo text
	LoadFont("SpoOky")..{
		Text="STEPMANIA 5";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/3.75;diffuse,color(theme_color);zoom,2.0;align,0.5,0.5;shadowlength,1;shadowcolor,color("0,0,0,1"));
	},
	-- product version text
	LoadFont("SpoOky")..{
		Text=ProductVersion();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+32;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- build date text
	LoadFont("SpoOky")..{
		Text=VersionDate();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+48;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- build time text
	LoadFont("SpoOky")..{
		Text=VersionTime();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+64;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- server text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+80;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
		OnCommand=function(self)
			if GetServerName() == "" then
				self:settext("No Server Name");
			else
				self:settext(GetServerName());
			end;
		end;
	},
	-- server text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+96;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
		OnCommand=function(self)
			if IsNetConnected() == true then
				self:settext("Connected");
			else
				self:settext("Disconnected");
			end;
		end;
	},
	-- GLOBAL play music
	main_song
};

return t;