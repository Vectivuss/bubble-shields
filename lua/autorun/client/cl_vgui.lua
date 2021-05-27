concommand.Add( "p.shield.menu", function( p )

	if ( !DarkRP ) then return end

	local w, h = ScrWH()
	local l_open = true

	if IsValid( f ) then
		f:Hide()
	end

	local function isClosing( s ) -- I had enough having this in two places, good thing functions exists
		if s.CLOSING then return end
		s.CLOSING = true
		PlaySound( "close" )
		timer.Simple( 2, function() if IsValid( s ) then s:Remove() end end )
		s:AlphaTo( 0, .5, 0 )
		s:SizeTo( 0, 0, 1, 0, .1, function() s:Remove() end )
		s:SetMouseInputEnabled( false )
		s:SetKeyboardInputEnabled( false )
	end

	-- Might eventually make someone go insane hearing it 999 times, who knows...
	if ( vs.cfg.Menu.Sounds ) then PlaySound( "open_0" .. math.random( 1, 2 ) ) end

	local f = vgui.Create( "DFrame" )
	f:SetSize( w, h )
	f:MakePopup()
	f:SetTitle( "" ) 
	f.Close = function( s ) isClosing( s ) end
	f.Think = function( s )
		if input.IsKeyDown( KEY_TAB ) then 
			s:Close() 
		end
	end
	f.Paint = function( s, w, h )
		draw.BlurPanel( s )
	end
	f:SetAlpha( 0 )
	f:AlphaTo( 255, .2, 0 )

	local ff = vgui.Create( "DPanel", f )
	ff:SetSize( 0, 0 )
	ff:Center()
	ff:MakePopup()
	ff:SetText( "" )
	ff:SizeTo( w*.4, h*.42, 1.8, 0, .1, function()
		l_open = false
	end )
	ff.Paint = function( s, w, h )
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 255 ) )
		draw.RoundedBox( 6, 0, 0, w, h*.12, Color( 41, 41, 41, 255 ) )
		draw.SimpleText( vs.cfg.Menu.Title, "ui.40", w*.03, h*.014, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	end
	f.OnMousePressed = function( s, k )
		if k == MOUSE_LEFT or k == MOUSE_RIGHT then
			s:Close()
			ff:Close()
		end
	end
	ff.Close = function( s ) isClosing( s ) end
	ff.Think = function( s )
		s:Center()
		if input.IsKeyDown( KEY_TAB ) then 
			s:Close() 
		end
	end

	local c = vgui.Create( "DButton" , ff )
	c:SetSize( w*.025, h*.04 )
	c:SetPos( w*.372, h*.005 )
	c:SetText( "" )
	c.Paint = function( s, w, h )
		if s:IsHovered() then
            draw.RoundedBox( 6, 0, 0, w, h, Color( 255, 102, 102, 255 ) )
			draw.SimpleTextOutlined( "X", "ui.42", w/2, h/2, color_white, 1, 1, 1, color_black )
        else
			draw.RoundedBox( 6, 0, 0, w, h, Color( 197, 40, 40, 255 ) )
			draw.SimpleTextOutlined( "X", "ui.42", w/2, h/2, color_white, 1, 1, 1, color_black )
		end
	end
	c.DoClick = function()
		f:Close()
		ff:Close()
	end
	f:ShowCloseButton( false )

	local p = vgui.Create( "DPanel" , ff )
	p:Dock(FILL)
	p:DockMargin( 12, h*.062, 12, 12 )
	p:SetTall( h*.3 )
	p.Paint = function( s, w, h )
		draw.RoundedBox( 4, 0,0 , w, h, Color( 41, 41, 41, 255 ) )
	end

	local s = vgui.Create( "DScrollPanel", p )
	s:Dock( FILL )
	local sbar = s:GetVBar()
	function sbar:Paint( w, h ) end
	function sbar.btnUp:Paint( w, h ) end
	function sbar.btnDown:Paint( w, h ) end
	function sbar.btnGrip:Paint( w, h ) end

	for k, bData in pairs( vs.cfg.Shop ) do
		v = vgui.Create( "DPanel", s )
		v:Dock( TOP )
		v:DockMargin( 9, 9, 9, 9 )
		v:SetTall( h*.07 )
		v.Paint = function( s, w, h )
			draw.RoundedBox( 5, 0, 0, w, h, Color( 32, 32, 32, 255 ) )
			draw.SimpleText( bData.name, "ui.24", w*.015, h*.10, Color( 155, 155, 155, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			draw.SimpleText( DarkRP.formatMoney( bData.price ), "ui.24", w*.015, h*.48, vs.cfg.Menu.Money, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		end

		local b = vgui.Create( "DButton", v )
		b:Dock( RIGHT )
		b:DockMargin( 12, 12, 12, 12 )
		b:SetWide( w*.06 )
		b:SetText( "Purchase" )
		b:SetFont( "ui.28" )
		b:SetTextColor( vs.cfg.Menu.Purchase )
		b.Paint = function( s, w, h )
			if s:IsHovered() then
				draw.RoundedBox( 10, 0, 0, w, h, Color( 48, 48, 48, 255 ) )
			else
				draw.RoundedBox( 10, 0, 0, w, h, Color( 41, 41, 41, 255 ) )
			end
		end
		b.DoClick = function()
			for _, v in pairs( ents.FindByClass( "bubble_npc" ) ) do
				if ( LocalPlayer():GetPos():Distance( v:GetPos() ) > 140 ) then
					PlaySound( "error" )
				else
					PlaySound( "select" )
					net.Start( "vs.shield" )
					net.WriteInt( k, 32 )
					net.SendToServer()
				end
			end
		end
	end

end )