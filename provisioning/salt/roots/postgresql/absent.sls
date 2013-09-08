{% set version = salt['pillar.get']('postgres:version', '9.1') %}

postgresql:
    package:
        - purged
        - require:
            - service: postgresql
    service.dead:
        - enabled: false

'/etc/postgresql/{{ version }}/':
    file:
        - absent
