Mysql:
  pkg:
    - installed
    - name: mysql-server
  file.managed:
    - name: /etc/mysql/my.cnf
    - source: salt://mysql/my.cnf
    - mode: 644
    - user: root
    - template: jinja
    - group: root
  service:
    - running
    - reload: True
    - name: {{ pillar['service']['mysql'] }}
    - enable: True

Create_DB:
  mysql_database.present:
    - name: keystone
    - require:
      - service: mysql

Create_user:
  mysql_user.present:
    - name: keystone
    - host: localhost
    - password: '123'
    - require:
      - service: mysql

  mysql_grants.present:
    - grant: all privileges
    - database: keystone.*
    - user: keystone
    - host: localhost
