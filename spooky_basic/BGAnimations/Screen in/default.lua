local t = Def.ActorFrame{
	Def.Quad{
		-- fades out of black
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color("0,0,0,1");sleep,0.1;diffuse,color("0,0,0,0.9");sleep,0.1;diffuse,color("0,0,0,0.8");sleep,0.1;diffuse,color("0,0,0,0.7");sleep,0.1;diffuse,color("0,0,0,0.6");sleep,0.1;diffuse,color("0,0,0,0.5");sleep,0.1;diffuse,color("0,0,0,0.4");sleep,0.1;diffuse,color("0,0,0,0.3");sleep,0.1;diffuse,color("0,0,0,0.2");sleep,0.1;diffuse,color("0,0,0,0.1");sleep,0.1;diffuse,color("0,0,0,0"));
	};
};

return t;