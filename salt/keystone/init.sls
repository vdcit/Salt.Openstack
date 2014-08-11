Keystone_install:
  pkg.installed:
    - name: keystone
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://keystone/keystone.conf
    - user: root
    - group: root
    - mode: 644

/usr/bin/keystone-manage token_flush >/var/log/keystone/keystone-tokenflush.log 2>&1:
  cron.present:
    - user: root
    - minute: 1

Runing_command:
  cmd.run:
    - name: su -s /bin/sh -c "keystone-manage db_sync" keystone
    - require:
      - file: /etc/keystone/keystone.conf

/var/lib/keystone/keystone.db:
 file:
  - absent

Reload_service:
  cmd.run:
    - name : service keystone restart