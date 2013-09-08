/home/vagrant/venv_production:
  virtualenv.managed:
    - system_site_packages: False
    - requirements: /vagrant/requirements.txt
    - require:
        - pkg: virtualenv