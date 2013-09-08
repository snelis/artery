include:
    - python

python-pip:
    pkg.installed:
        - require:
            - pkg: python