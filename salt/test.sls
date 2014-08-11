cai_dat_ab:
  pkg.installed:
    - name: apache2-utils

  cmd.run:
    - name: ab -n 100 -c 10 http://google.com.vn/
