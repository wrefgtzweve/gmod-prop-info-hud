surface.CreateFont( "HudInfoFont", {
    font = "Verdana",
    size = 18,
    weight = 500,
    outline = false
} )

CreateClientConVar( "hudinfo_enable", "0", true, false, "Enables/Disables hud info.", 0, 1 )

local y = ScrH()
local convar = GetConVar( "hudinfo_enable" )

hook.Add( "HUDPaint", "HudInfoAddon", function()
    if convar:GetInt() == 0 then return end
    local eyeTrace = LocalPlayer():GetEyeTrace()

    if eyeTrace.HitWorld then return end

    local owner
    local ownerColor = Color( 255, 255, 255 )
    local ent = eyeTrace.Entity
    local ownerEnt
    if CPPI then
        ownerEnt = ent:CPPIGetOwner()
    else
        ownerEnt = ent:GetOwner()
    end

    if ownerEnt:IsPlayer() then
        owner = ownerEnt:GetName()
        ownerColor = team.GetColor( ownerEnt:Team() )
    else
        owner = "World"
    end

    surface.SetFont( "HudInfoFont" )

    local angles = ent:GetAngles()
    local angleText = "Angle: " .. math.Round( angles.p, 2 ) .. ", " .. math.Round( angles.y, 2 ) .. ", " .. math.Round( angles.r, 2 )
    local modelText = "Model: " .. ent:GetModel()
    local classText = "Class: " .. ent:GetClass()
    local ownerText = "Owner: " .. owner
    local size = math.max( surface.GetTextSize( angleText ), surface.GetTextSize( modelText ), surface.GetTextSize( classText ), surface.GetTextSize( ownerText ) )

    surface.SetDrawColor( 52, 52, 52, 180 )
    surface.DrawRect( 0, y / 2, size + 15, 125 )

    surface.SetTextPos( 5, y / 2 + 5 )
    surface.SetTextColor( ownerColor )
    surface.DrawText( ownerText )
    surface.SetTextColor( 255, 255, 255 )
    surface.SetTextPos( 5, y / 2 + 25 )
    surface.DrawText( classText )
    surface.SetTextPos( 5, y / 2 + 45 )
    surface.SetTextColor( ent:GetColor() )
    surface.DrawText( "Color: " .. string.FromColor( ent:GetColor() ) )
    surface.SetTextColor( 255, 255, 255 )
    surface.SetTextPos( 5, y / 2 + 65 )
    surface.DrawText( "Material: " .. ( ent:GetMaterial() and "default" ) )
    surface.SetTextPos( 5, y / 2 + 85 )
    surface.DrawText( modelText )
    surface.SetTextPos( 5, y / 2 + 105 )
    surface.DrawText( angleText )

    surface.SetDrawColor( 255, 0, 0 )
    local forwardVec1 = ent:WorldSpaceCenter():ToScreen()
    local forwardVec2 = ( ent:WorldSpaceCenter() + 10 * ent:GetForward() ):ToScreen()
    surface.DrawLine( forwardVec1.x, forwardVec1.y, forwardVec2.x, forwardVec2.y )

    surface.SetDrawColor( 0, 0, 255 )
    local rightVec1 = ent:WorldSpaceCenter():ToScreen()
    local rightVec2 = ( ent:WorldSpaceCenter() + 10 * ent:GetRight() ):ToScreen()
    surface.DrawLine( rightVec1.x, rightVec1.y, rightVec2.x, rightVec2.y )

    surface.SetDrawColor( 0, 255, 0 )
    local upVec1 = ent:WorldSpaceCenter():ToScreen()
    local upVec2 = ( ent:WorldSpaceCenter() + 10 * ent:GetUp() ):ToScreen()
    surface.DrawLine( upVec1.x, upVec1.y, upVec2.x, upVec2.y )
end)
