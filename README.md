# Docker OpenStack Swift

Dockerfile for OpenStack Swift.

## Usage

```bash
docker run -itd --net=host --name openstack-swift \
    -v /srv/node:/srv/node \
    -e KEYSTONE_HOST=KEYSTONE_IP \
    openstack-swift
```

```bash
docker run -itd --net=host --name openstack-swift \
    -v /srv/node:/srv/node \
    -v /etc/swift:/etc/swift \
    -e NO_SWIFT_INIT=1 \
    openstack-swift
```

```bash
openstack project create --domain default --description "Service Project" service

openstack user create --domain default --password SWIFT_PASS swift
openstack role add --project service --user swift admin
openstack service create --name swift --description "OpenStack Object Storage" object-store
openstack endpoint create --region RegionOne object-store public http://controller:8080/v1/AUTH_%\(project_id\)s
openstack endpoint create --region RegionOne object-store internal http://controller:8080/v1/AUTH_%\(project_id\)s
openstack endpoint create --region RegionOne object-store admin http://controller:8080/v1
```
