pkgs:
  {% if grains['os_family'] == 'RedHat' %}
  apache: httpd
  php: php
  python_mysql: MySQL-python
  php_mysql: php-mysql
  vim: vim-enhanced
  git: git
  {% elif grains['os_family'] == 'Debian' %}
  python_mysql: python-mysqldb
  php: php5
  apache: apache2
  php_mysql: php5-mysql
  vim: vim
  git: git-core
  {% elif grains['os'] == 'Arch' %}
  apache: apache
  vim: vim
  {% endif %}
