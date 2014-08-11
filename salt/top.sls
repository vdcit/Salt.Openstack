base:
  '*':
    - ntp
    - mysql_python
    - rabbit
  'controller':
    - mysql
    - keystone
    - keystone.create-user-tenant
