# Create services
{% set OS_SERVICE_TOKEN="123" %}
{% set OS_SERVICE_ENDPOINT="http://controller:35357/v2.0" %}
{% set keystone="keystone --os-token=" ~ OS_SERVICE_TOKEN ~ " --os-endpoint=" ~ OS_SERVICE_ENDPOINT %}

create_user:
  cmd.run:
    - name: {{ keystone }} user-create --name=admin --pass=123 --email=hahungkk@gmail.com

create_admin_role:
  cmd.run:
    - name: {{ keystone }} role-create --name=admin

create_admin_tenant:
  cmd.run:
    - name: {{ keystone }} tenant-create --name=admin --description="Admin Tenant"

user_role_add:
  cmd.run:
    - name: {{ keystone }} user-role-add --user=admin --tenant=admin --role=admin

admin_role_add:
  cmd.run:
    - name: {{ keystone }} user-role-add --user=admin --role=_member_ --tenant=admin

create_demo_user:
  cmd.run:
    - name: {{ keystone }} user-create --name=demo --pass=123 --email=DEMO@example.com

create_demo_tenant:
  cmd.run:
    - name: {{ keystone }} tenant-create --name=demo --description="Demo Tenant"

link_demo_role:
  cmd.run:
    - name: {{ keystone }} user-role-add --user=demo --role=_member_ --tenant=demo

create_tenant_service:
  cmd.run:
    - name: {{ keystone }} tenant-create --name=service --description="Service Tenant"


create_identity_service:
  cmd.run:
    - name: {{ keystone }} service-create --name=keystone --type=identity --description="OpenStack Identity"

create_endpoint:
  cmd.run:
    - name: {{ keystone }} endpoint-create --service-id=$({{ keystone }} service-list | awk '/ identity / {print $2}') --publicurl=http://controller:5000/v2.0 --internalurl=http://controller:5000/v2.0 --adminurl=http://controller:35357/v2.0

auth_glance:
  cmd.run:
    - name: |
       {{ keystone }} user-create --name=glance --pass=123 --email=glance@example.com
       {{ keystone }} user-role-add --user=glance --tenant=service --role=admin
       {{ keystone }} service-create --name=glance --type=image --description="OpenStack Image Service"
       {{ keystone }} endpoint-create --service-id=$({{ keystone }} service-list | awk '/ image / {print $2}') --publicurl=http://controller:9292 --internalurl=http://controller:9292 --adminurl=http://controller:9292

Create_Nova_service:
  cmd.run:
    - name: |
       {{ keystone }} service-create --name=nova --type=compute --description="OpenStack Compute"
       {{ keystone }} endpoint-create --service-id=$({{ keystone }} service-list | awk '/ compute / {print $2}') --publicurl=http://controller:8774/v2/%\(tenant_id\)s --internalurl=http://controller:8774/v2/%\(tenant_id\)s --adminurl=http://controller:8774/v2/%\(tenant_id\)s


openrc:
  file.managed:
    - name: /root/openrc.sh
    - source: salt://keystone/openrc.sh