-- Description: Search for build-metadata files
-- Version: 0.1.0
-- Source: urls
-- License: MIT

function run(arg)
    build_files = {'README.md',
                   'README',
                   'Jenkinsfile',
                   'bitbucket-pipelines.yml',
                   '.gitlab-ci.yml',
                   'Makefile',
                   'Dockerfile',
                   'docker-compose.yaml',
                   'docker-compose.yml'}

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
