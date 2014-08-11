service:
  {% if grains['os_family'] == 'RedHat' %}
  apache: httpd
  ntp: ntpd
  mysql: mysqld
  {% elif grains['os_family'] == 'Debian' %}
  mysql: mysql
  ntp: ntp
  apache: apache2
  {% endif %}
