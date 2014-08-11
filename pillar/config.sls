{% set controller_private_ip = '10.10.10.81' %}
{% set private_ip = grains['ip_interfaces']['eth0'][0] %}
{% set TUNNEL_IP = grains['ip_interfaces']['eth1'][0] %}
{% set EXTERNAL_INTERFACE = 'eth2' %}

{% set MYSQL_ROOT = '123' %}
{% set ADMIN_TOKEN = '123' %}
{% set RABBIT_PASS = '123' %}
{% set KEYSTONE_DBPASS = '123' %}
{% set USER_DEMO_PASS = '123' %}
{% set USER_ADMIN_PASS = '123' %}
{% set GLANCE_DBPASS = '123' %}
{% set GLANCE_PASS = '123' %}
{% set NOVA_DBPASS = '123' %}
{% set NOVA_PASS = '123' %}
{% set DASH_DBPASS = '123' %}
{% set CINDER_DBPASS = '123' %}
{% set CINDER_PASS = '123' %}
{% set NEUTRON_DBPASS = '123' %}
{% set NEUTRON_PASS = '123' %}
{% set METADATA_SHARED_SECRET = '123' %}

{% set KEYSTONE_SERVER = controller_private_ip %}
{% set MYSQL_SERVER_IP = controller_private_ip %}
{% set NOVA_API_SERVER = controller_private_ip %}
{% set RABBITMQ_SERVER = controller_private_ip %}
{% set GLANCE_API_SERVER = controller_private_ip %}
{% set CINDER_API_SERVER = controller_private_ip %}
{% set METADATA_SERVER = controller_private_ip %}
{% set NEUTRON_API_SERVER = controller_private_ip %}
{% set NTP_UPDATE_SERVER = controller_private_ip %}


mysql:
  server:
    config_file: salt://mysql/files/my-{{ grains['os']}}.cnf
    root_password: {{ MYSQL_ROOT }}
    bind-address: {{ MYSQL_SERVER_IP }}
    port: 3306

rabbit:
  pass: {{ RABBIT_PASS }}

#Keystone
keystone:
 pkgs:
  - keystone
 admin_token: {{ ADMIN_TOKEN }}
 admin_password: {{ USER_ADMIN_PASS }}
 dbname: 'keystone'
 dbuser: 'keystone'
 dbpass: {{ KEYSTONE_DBPASS }}
 bind-address: {{ KEYSTONE_SERVER }}

nova-api:
  pkgs:
    - nova-api
    - nova-cert
    - nova-conductor
    - nova-consoleauth
    - nova-novncproxy
    - nova-scheduler
    - python-novaclient
  services:
    - nova-api
    - nova-cert
    - nova-consoleauth
    - nova-scheduler
    - nova-conductor
    - nova-novncproxy

nova-compute:
  pkgs:
    - nova-compute-kvm
    - python-guestfs


