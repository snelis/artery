base:

  '*':
    - common

  'roles:web':
    - match: grain
    - nginx
    - uwsgi
    - virtualenv

  'virtual:VirtualBox':
    - match: grain
    - vagrant

  'roles:db':
    - match: grain

  'roles:postgresql':
    - match: grain
    - postgresql