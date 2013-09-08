nginx:
    pkg:
        - installed
    service.running:
        - watch:
            - pkg: nginx
            - file: /etc/nginx/*

/etc/nginx/nginx.conf:
    file.managed:
        - source: salt://nginx/files/nginx.conf
        - require:
            - pkg: nginx

/etc/nginx/mime.types:
    file.managed:
        - source: salt://nginx/files/mime.types
        - require:
            - pkg: nginx

/etc/nginx/sites-enabled/:
    file.directory:
        - require:
            - pkg: nginx

/etc/nginx/sites-enabled/default:
    file.absent:
        - require:
            - pkg: nginx