local app_name = "kvs"

local log = require('log').new(app_name)
log.info('loaded')

local storage = require('storage')
storage.create_storage()

local handlers = require('handlers')

local httpd = require('http.server').new('127.0.0.1', 3380, {
    header_timeout = 30
})

httpd:route({ path = '/', method = 'GET', file = 'index.html' }, handlers.handle_index)
httpd:route({ path = '/records/:key', method = 'GET' }, handlers.handle_get_record)
httpd:route({ path = '/records', method = 'POST' }, handlers.handle_add_record)
httpd:route({ path = '/records/:key', method = 'POST' }, handlers.handle_update_record)
httpd:route({ path = '/records/:key', method = 'PUT' }, handlers.handle_put_record)
httpd:route({ path = '/records/:key', method = 'DELETE' }, handlers.handle_delete_record)

httpd:start()
log.info('started http server')

