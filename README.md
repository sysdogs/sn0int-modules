# sn0int-modules

## shodan-ports

- Scans shodan for open-ports.

```
sn0int-modules on  feature/add-security-trails via ·limakzi took 14s 503ms ⇣29% ➜ sn0int -w test run -f shodan-ports.lua
[*] "1.1.1.1"                                         : Adding port "udp/1.1.1.1:53"
[*] "1.1.1.1"                                         : Adding port "tcp/1.1.1.1:80"
[+] Finished anonymous/shodan-ports
(.venv)
sn0int-modules on 
```

## securitytrails-subdomains

- Scans subdomains in SecurityTrails

```
sn0int-modules on  feature/add-security-trails [✘!?] via ·limakzi took 7s 238ms ⇣77% ➜ sn0int -w sysdogs-com run -f securitytrails-subdomains.lua
[*] "sysdogs.com"                                     : Adding subdomain "autodiscover"
[*] "sysdogs.com"                                     : Adding subdomain "ssdgs-dev"
[*] "sysdogs.com"                                     : Adding subdomain "www"
[+] Finished anonymous/securitytrails-subdomains
(.venv)
sn0int-modules on 
```
