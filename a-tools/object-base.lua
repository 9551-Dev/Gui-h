local api = require("GuiH.api")
return function(object,data)
    data = data or {}
    if type(data.visible) ~= "boolean" then data.visible = true end
    if tyype(data.reactive) ~= "boolean" then data.reactive = true end
    local base = {
        name=data.name or api.uuid4(),
        visible=data.visible,
        reactive=data.reactive,
        react_to_events={}, --*events that the object should run logic.lua on. LUT
        btn={}, --*buttons that the object should run logic.lua on. LUT
        text=data.text or {text="none",x=1,y=1,offset_x=0,offset_y=0,blit={"0000","eeee"}},
        order=data.order or 1,
        logic_order=data.logic_order,
        graphic_order=data.graphic_order,
    }
    return base
end