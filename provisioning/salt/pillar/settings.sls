users:
    artery:
        pub_key: salt://users/keys/artery.pub
        groups:
            - sudo

apps:

    vagrant:
        dir: /vagrant
        params:
            debug: True

    artery:
        debug: True

    nielslensink.com:
        debug: True
        aliases:
            - nielslensink.com
            - nielslensink.nl