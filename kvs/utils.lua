local utils = {}

function utils.is_string(str)
    return type(str) == 'string'
end

function utils.is_not_empty_string(str)
    return type(str) == 'string' and str ~= ''
end

return utils
