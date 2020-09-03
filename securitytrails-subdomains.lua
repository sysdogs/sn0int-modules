-- Description: Searches for subdomains in SecurityTrails.com
-- Version: 0.1.0
-- Source: domains
-- License: MIT
-- Keyring-Access: securitytrails


local security_trails_throttle_req = 1
local security_trails_throttle_time = 1000
local security_trails_api_url = "https://api.securitytrails.com/v1/domain/"


function run(arg)
    debug('Getting security-trails credentials')
    creds = keyring('securitytrails')[1]['secret_key']

    if last_err() then return end
    debug('SecurityTrails APIKEY ' .. creds)

    security_trails_request_uri = security_trails_api_url .. arg['value'] .. "/subdomains"
    debug('Sending request to host ' .. security_trails_request_uri)
    session = http_mksession()
    req = http_request(session, 'GET',
                                security_trails_request_uri,
                                {query={apikey=creds,children_only="false"},
                                 headers={accept="application/json"}})


    debug('Extracting subdomains for domain ' .. arg['value'])
    data = http_fetch_json(req)
    if last_err() then return end

    debug('SecurityTrails - waiting for rate limiting')
    ratelimit_throttle('sectrails', security_trails_throttle_req, security_trails_throttle_time)
    if last_err() then return end

    subdomains = data["subdomains"]

    for i=1,#subdomains do
      db_add('subdomain', {
        value = subdomains[i],
        domain_id = arg['id'],
        resolvable = nil,
      })
    end

end
