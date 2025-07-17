local handlers = {}

local json = require('json')
local record = require('model.record').model()

function handlers.handle_index(req)
    local resp = req:render({})
    resp.status = 200
    return resp
end

function handlers.handle_get_record(req)
    local key = req:stash('key')
    local val = record.get(key)
    if val == nil then
        return {
            status = 404,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode({ error = 'not found' })
        }
    end

    return {
        status = 200,
        headers = { ['content-type'] = 'application/json; charset=utf8' },
        body = json.encode({ value = val[record.VALUE] })
    }
end

function handlers.handle_add_record(req)
    local body = req:json()
    local ok, inserted = pcall(record.create, body.key, body.value)
    if ok ~= true then
        return {
            status = 400,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode({ error = 'duplicate key' })
        }
    end
    if inserted == nil then
        return {
            status = 400,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode({ error = 'empty key' })
        }
    end

    return {
        status = 201,
        headers = { ['content-type'] = 'application/json; charset=utf8' },
        body = json.encode({ status = 'created' })
    }
end

function handlers.handle_update_record(req)
    local key = req:stash('key')
    local body = req:json()
    local updated = record.update(key, body.value)
    if updated == nil then
        return {
            status = 404,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode({ error = 'not found' })
        }
    end

    return {
        status = 200,
        headers = { ['content-type'] = 'application/json; charset=utf8' },
        body = json.encode({ status = 'updated' })
    }
end

function handlers.handle_put_record(req)
    local key = req:stash('key')
    local body = req:json()
    local put = record.put(key, body.value)
    if put == nil then
        return {
            status = 400,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode({ error = 'empty key' })
        }
    end

    return {
        status = 200,
        headers = { ['content-type'] = 'application/json; charset=utf8' },
        body = json.encode({ status = 'created/updated' })
    }
end

function handlers.handle_delete_record(req)
    local key = req:stash('key')
    local deleted = record.delete(key)
    if deleted == nil then
        return {
            status = 404,
            headers = { ['content-type'] = 'application/json; charset=utf8' },
            body = json.encode({ error = 'not found' })
        }
    end

    return {
        status = 200,
        headers = { ['content-type'] = 'application/json; charset=utf8' },
        body = json.encode({ status = 'deleted' })
    }
end

return handlers
