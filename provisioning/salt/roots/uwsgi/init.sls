include:
  - python
  - pip

uwsgi:
  pip.installed:
    - require:
      - pkg: python-packages

uwsgi:
  pip.installed:
    - require:
      - pkg: python-dev
      - pkg: python-pip
  service:
    - running
    - enable: True
    - name: uwsgi
    - watch:
      - file: /etc/init/uwsgi.conf
    - require:
      - file: /etc/init/uwsgi.conf

/etc/init/uwsgi.conf:
  file.managed:
    - source: salt://uwsgi/upstart/uwsgi.conf
    - require:
      - pip: uwsgi

/var/log/uwsgi:
  file.directory:
  - user: www-data
  - group: www-data
  - makedirs: true
  - require:
    - pip: uwsgi
    - pkg: nginx

/var/log/uwsgi/emperor.log:
  file.managed:
  - user: www-data
  - group: www-data
  - require:
    - pip: uwsgi
    - pkg: nginx