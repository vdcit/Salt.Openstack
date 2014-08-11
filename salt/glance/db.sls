glance_db:
  cmd.run:
    - name: mysql -p123 -e 'CREATE DATABASE glance;'

glance_user:
  cmd.run:
    - name: mysql -p123 -e "GRANT ALL PRIVILEGES ON keystone.* TO 'glance'@'localhost' IDENTIFIED BY '123';"

glance_grant:
  cmd.run:
    - name: |
       mysql -p123 -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' IDENTIFIED BY '123';"
       mysql -p123 -e 'FLUSH PRIVILEGES;'

Create_DB:
  mysql_database.present:
    - name: glance
    - require:
      - service: mysql

Create_user:
  mysql_user.present:
    - name: keystone
    - host: localhost
    - password: '123'

  mysql_grants.present:
    - grant: all privileges
    - database: keystone.*
    - user: keystone
    - host: localhost

