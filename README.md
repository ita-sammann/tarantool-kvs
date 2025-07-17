# Simple KV Storage

### Usage:
 * `GET /`: Read this help page.
 * `GET /records/<KEY>`: Get stored value. Will return error if not found.
 * `POST /records with JSON body {"key": "<KEY>", "value": "<VALUE>"}`: Add new record to storage. Will return error if key already exists.
 * `POST /records/<KEY> with JSON body {"value": "<VALUE>"}`: Update existing stored value. Will return error if not found.
 * `PUT /records/<KEY> with JSON body {"value": "<VALUE>"}`: Add record to storage. Will silently overwrite value if already exists.
 * `DELETE /records/<KEY>`: Delete stored value. Will return error if not found.
