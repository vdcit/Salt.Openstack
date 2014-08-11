icehouse-ppa:ppa:
  pkgrepo.absent:
    - ppa: webupd8team/tt-rss

update_ppa:
  cmd.run:
    - name: apt-get update
