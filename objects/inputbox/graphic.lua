local graphic = require("GuiH.texture-wrapper").code

return function(object)
    local term = object.canvas.term_object
    local text,mv = object.input,0
    if #object.input >= object.positioning.width-1 then
        text = object.input:sub(#object.input-object.positioning.width+1-object.shift,#object.input-object.shift)
        mv = #object.input-#text
    end
    local cursor_x = (object.positioning.x+object.cursor_pos)-mv
    term.setCursorPos(object.positioning.x,object.positioning.y)
    text = text..object.background_symbol:rep(object.positioning.width-#text+1)
    term.blit(
        text,
        graphic.to_blit[object.text_color]:rep(#text),
        graphic.to_blit[object.background_color]:rep(#text)
    )
    if object.selected and (object.char_limit > object.cursor_pos) then
        term.setCursorPos(cursor_x+object.shift,object.positioning.y)
        if cursor_x+object.shift < object.positioning.x then
            object.shift = object.shift + 1
        end
        if cursor_x+object.shift > object.positioning.x+object.positioning.width then
            object.shift = object.shift - 1
        end
        local cursor
        if object.cursor_pos < object.positioning.width then
            cursor = object.input:sub(object.cursor_pos+1,object.cursor_pos+1)
            object.cursor_x = object.cursor_pos+1
        else
            cursor = object.input:sub(object.cursor_pos+1,object.cursor_pos+1)
            term.setCursorPos(cursor_x+object.shift,object.positioning.y)
        end
        object.cursor_x = cursor_x+object.shift
        term.blit(
            cursor ~= "" and cursor or "_",
            cursor ~= "" and graphic.to_blit[object.background_color] or graphic.to_blit[object.text_color],
            cursor ~= "" and graphic.to_blit[object.text_color] or graphic.to_blit[object.background_color]
        )
    else
        term.setCursorPos(object.positioning.x+object.positioning.width,object.positioning.y)
        term.blit(
            "\127",
            graphic.to_blit[object.text_color],
            graphic.to_blit[object.background_color]
        )
    end
end