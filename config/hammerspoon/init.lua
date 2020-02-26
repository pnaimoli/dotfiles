eventtapFnLeftClick = hs.eventtap.new({ hs.eventtap.event.types.leftMouseDown, hs.eventtap.event.types.leftMouseUp }, function(event)
    if (not event:getFlags().fn) then
        return false -- don't delete the event
    end
    if (event:getType() == hs.eventtap.event.types.leftMouseDown) then
        return true, { hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.rightMouseDown, event:location()) }
    else
        return true, { hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.rightMouseUp, event:location()) }
    end
    return false -- shouldn't ever reach here, but just in case
end):start()
