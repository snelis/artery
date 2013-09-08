base:

  '*':
    - data
    - settings

  'roles:web':
    - match: grain

  'roles:db':
    - match: grain

  'roles:postgresql':
    - match: grain
    - postgresql