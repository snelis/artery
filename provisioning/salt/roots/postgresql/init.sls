{% set version = salt['pillar.get']('postgres:version', '9.1') %}
{% set listen = salt['pillar.get']('postgres:listen', 'localhost') %}
{% set port = salt['pillar.get']('postgres:port', 5432) %}

postgresql:
    package.installed:
        - name: postgresql-{{ version }}
    service.running:
        - enable: true
        - watch:
            - package: postgresql
            - file: '/etc/postgresql/{{ version }}/main/*'
        - require:
            - user: postgresql
            - group: postgresql
    user.present:
        - name: postgres
        - gid_from_name: True
        - require:
            - group: postgresql
            - package: postgresql
    group.present:
        - name: postgres
        - require:
            - package: postgresql

'/etc/postgresql/{{ version }}/main/':
    file.recurse:
        - source: salt://postgresql/files/conf
        - user: {{ salt['pillar.get']('root:user', 'root') }}
        - group: {{ salt['pillar.get']('root:group', 'root') }}
        - require:
            - package: postgresql
