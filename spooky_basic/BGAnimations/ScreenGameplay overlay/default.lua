local t = Def.ActorFrame{
	-- dark gold header quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color(theme_dark_color));
	},
	-- dark gold footer quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_dark_color));
	},
	-- top border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+2;diffuse,color(theme_color));
	},
	-- bottom border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-2,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color));
	},
	-- left border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_LEFT+2,SCREEN_BOTTOM;diffuse,color(theme_color));
	},
	-- right border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-2,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color));
	},
	-- profile border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM-28;diffuse,color(theme_color));
	},
	-- screen border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP+28,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color(theme_color));
	},
	-- player border
	--Def.Quad{
	--	InitCommand=cmd(stretchto,SCREEN_CENTER_X-2,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM;diffuse,color(theme_color));
	--};
	-- back life meter p1
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- back life meter p2
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- front life meter p1
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+252,SCREEN_TOP+28;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("PALife");
		end;
		PALifeCommand=function(self)
			local playerstate = GAMESTATE:GetPlayerState('PlayerNumber_P1');
			local healthstate = playerstate:GetHealthState();
			if healthstate == 'HealthState_Hot' then
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28);
				self:diffuse(color("1,0.5,0.25,1"));
			elseif healthstate == 'HealthState_Alive' then
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+302,SCREEN_TOP+28);
				self:diffuse(color("1,0.25,0,1"));
			elseif healthstate == 'HealthState_Danger' then
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+202,SCREEN_TOP+28);
				self:diffuse(color("0.5,0.25,0,1"));
			elseif healthstate == 'HealthState_Dead' then
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+102,SCREEN_TOP+28);
				self:diffuse(color("0,0,0,1"));
			end;
		end;
		LifeMeterChangedP1MessageCommand=cmd(playcommand,"PALife");
	},
	-- front life meter p2
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-252,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("PBLife");
		end;
		PBLifeCommand=function(self)
			local playerstate = GAMESTATE:GetPlayerState('PlayerNumber_P2');
			local healthstate = playerstate:GetHealthState();
			if healthstate == 'HealthState_Hot' then
				self:stretchto(SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28);
				self:diffuse(color("0,0.75,1,1"));
			elseif healthstate == 'HealthState_Alive' then
				self:stretchto(SCREEN_RIGHT-302,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28);
				self:diffuse(color("0,0.5,1,1"));
			elseif healthstate == 'HealthState_Danger' then
				self:stretchto(SCREEN_RIGHT-202,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28);
				self:diffuse(color("0,0.25,0.5,1"));
			elseif healthstate == 'HealthState_Dead' then
				self:stretchto(SCREEN_RIGHT-102,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28);
				self:diffuse(color("0,0,0,1"));
			end;
		end;
		LifeMeterChangedP2MessageCommand=cmd(playcommand,"PBLife");
	}
};

return t;