-- Description: Scans ports with Shodan
-- Version: 0.1.0
-- Source: ipaddrs
-- License: MIT
-- Keyring-Access: shodan


local shodan_throttle_req = 1
local shodan_throttle_time = 1000

local shodan_api_url = "https://api.shodan.io"
local shodan_api_port_uri = "/shodan/host/"




function run(arg)
    info('sn0int -- getting shodan api-key')
    creds = keyring('shodan')[1]['secret_key']
    if last_err() then return end
    debug(creds)

    debug('sn0ing -- shodan api-key ' .. creds)

    debug('shodan -- sending request to host ' .. arg['value'])
    session = http_mksession()
    req = http_request(session, 'GET',
                                shodan_api_url .. shodan_api_port_uri .. arg['value'] .. '?key=' .. creds, {})


    info('sn0int -- extract ports from host ' .. arg['value'])
    data = http_fetch_json(req)
    if last_err() then return end

    -- Shodan is limited to 1/rqps
    -- https://developer.shodan.io/api
    info('shodan -- waiting for shodan for rate limiting')
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
            info('sn0int -- adding port ' .. protocol .. '/' .. port)
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
