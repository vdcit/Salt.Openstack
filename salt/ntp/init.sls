NTP_Server:
  pkg:
    - name: ntp
    - installed
  service:
    - running
    - name: {{ pillar['service']['ntp'] }}


