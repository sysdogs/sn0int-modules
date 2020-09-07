-- Description: Search for build-metadata files
-- Version: 0.1.0
-- Source: urls
-- License: MIT

function run(arg)
    build_files = {'README',
                   'README.md',
                   '.ci.env',
                   '.travis.yml',
                   '.gitlab-ci.yml',
                   'Jenkinsfile',
                   'bitbucket-pipelines.yml',
                   'Makefile',
                   'Dockerfile',
                   'docker-compose.yml',
                   'docker-compose.yaml'}

    for i=1, #build_files do
      url = url_join(arg['value'], build_files[i])
      info("Scanning " .. url)

      session = http_mksession()
      req = http_request(session, 'GET', url, {})
      reply = http_send(req)
      if last_err() then return end

      if reply['status'] == 200 then
        db_add('url', {
            subdomain_id=arg['subdomain_id'],
            value=url,
            status=reply['status'],
            body=reply['text'],
        })
      end
    end
end
