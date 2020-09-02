# sn0int-modules

## shodan-ports

- Scans shodan for open-ports.

```
sn0int-modules on  feature/add-shodan-ports [!] via ·limakzi took 46s 558ms ⇣24% ➜ sn0int -w test run -f shodan-ports.lua
[*] "1.1.1.1"                                         : "Getting shodan api-key"
[*] "1.1.1.1"                                         : "Extracting ports from host 1.1.1.1"
[*] "1.1.1.1"                                         : "Shodan - waiting for rate limiting"
[*] "1.1.1.1"                                         : "sn0int -- adding port udp/53"
[+] Finished anonymous/shodan-ports
(.venv)
sn0int-modules on 
```

## securitytrails-subdomains
:q

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
