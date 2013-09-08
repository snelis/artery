include:
    - python

virtualenv:
    pkg.installed:
        - name: python-virtualenv
        - require:
            - pkg: python