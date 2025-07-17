local storage = {}

local record = require('model.record').model()

function storage.create_storage()
    local record_space = box.schema.space.create(record.SPACE_NAME, {
        if_not_exists = true
    })
    record_space:format(record.FORMAT)
    record_space:create_index(record.PRIMARY_INDEX, {
        type = 'hash',
        parts = { record.KEY, 'string' },
        if_not_exists = true
    })
end

return storage
