-- Description: Scans ports with Shodan
-- Version: 0.1.0
-- Source: ipaddrs
-- License: MIT
-- Keyring-Access: shodan


local shodan_throttle_req = 1
local shodan_throttle_time = 1000

local shodan_api_url = "https://api.shodan.io/shodan/host/"


function run(arg)
    debug('Getting shodan api-key')
    creds = keyring('shodan')[1]['secret_key']
    if last_err() then return end
    debug('Shodan api-key ' .. creds)

    shodan_request_uri = shodan_api_url .. arg['value']
    debug('Sending request to host ' .. shodan_request_uri)
    session = http_mksession()
    req = http_request(session, 'GET',
                                shodan_request_uri, {query={key=creds}})


    debug('Extracting ports from host ' .. arg['value'])
    data = http_fetch_json(req)
    if last_err() then return end

    -- Shodan is limited to 1/rqps
    -- https://developer.shodan.io/api
    debug('Shodan - waiting for rate limiting')
    ratelimit_throttle('shoo', shodan_throttle_req, shodan_throttle_time)

    metadata = data['data']
    if last_err() then return end

    for i=1,#metadata do
      ip_addr_id = arg['id']
      ip_addr = arg['value']
      port = metadata[i]['port']
      protocol = metadata[i]['transport']

      if metadata[i]['ip_str'] == arg['value'] then
        if metadata[i]['transport'] ~= nil then
          if metadata[i]['port'] ~= nil then
            db_add('port', {
              ip_addr_id = ip_addr_id,
              ip_addr = ip_addr,
              protocol = protocol,
              port = port,
              status = 'open'
            })
          end
        end
      end
    end

end
