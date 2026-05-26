require("hook")

local PANEL = {}

function PANEL:PostChildPaint()

    if SetPostChildPaintEnabled then
       self:SetPostChildPaintEnabled(true)
    end

    hook.Run("PostChildPaint", nil, self)

end