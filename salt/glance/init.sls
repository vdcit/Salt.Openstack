glance_install:
  pkg.installed:
    - refresh: False
    - pkgs:
      - glance
      - python-glanceclient

glance-api.conf:
  file.managed:
    - name: /etc/glance/glance-api.conf
    - source: salt://glance/files/glance-api.conf
    - mode: 644
    - user: glance
    - group: glance
    - require:
      - pkg: glance_install

glance-registry.conf:
  file.managed:
    - name: /etc/glance/glance-registry.conf
    - source: salt://glance/files/glance-registry.conf
    - mode: 644
    - user: glance
    - group: glance
    - require:
      - pkg: glance_install

glance.sqlite:
  file.absent:
    - name: /var/lib/glance/glance.sqlite
    - require:
      - pkg: glance_install

syncDB_glance:
  cmd.run:
    - name: |
       su -s /bin/sh -c "glance-manage db_sync" glance


restart_glance_service:
  cmd.run:
    - name: |
       service glance-registry restart
       service glance-api restart