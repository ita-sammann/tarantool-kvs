local record = {}

local utils = require('utils')

function record.model()
    local model = {}

    model.SPACE_NAME = 'kvs_record'
    model.PRIMARY_INDEX = 'primary'

    model.KEY = 1
    model.VALUE = 2

    model.FORMAT = {
        { name = 'key', type = 'string' },
        { name = 'value', type = 'string' }
    }

    function model.get_space()
        return box.space[model.SPACE_NAME]
    end

    function model.get(key)
        if utils.is_not_empty_string(key) then
            return model.get_space().index[model.PRIMARY_INDEX]:select(key)[1]
        end
    end

    function model.create(key, value)
        if utils.is_not_empty_string(key) then
            return model.get_space():insert{key, value}
        end
    end

    function model.update(key, value)
        if utils.is_not_empty_string(key) then
            return model.get_space():update(key, {{'=', model.VALUE, value}})
        end
    end

    function model.put(key, value)
        if utils.is_not_empty_string(key) then
            return model.get_space():put{key, value}
        end
    end

    function model.delete(key)
        if utils.is_not_empty_string(key) then
            return model.get_space():delete(key)
        end
    end

    return model
end

return record
