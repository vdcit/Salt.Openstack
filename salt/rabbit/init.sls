rabbitMQ_Server:
  pkg:
    - installed
    - name: rabbitmq-server
  service:
    - running
    - name: rabbitmq-server
    - enable: True
  cmd.run:
    - name: rabbitmqctl change_password guest {{ pillar['rabbit']['pass'] }}
    - require:
      - service: rabbitmq-server
