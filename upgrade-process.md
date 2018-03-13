# Upgrade Process

### Overview

You can use the upgrade cookbook to automate the OpenShift cluster upgrade process.

Once the upgrade is done, any future CHEF runs will skip the default installation/run so as to avoid any clashes with previous variables such as:

* `ose_major_version`
* `ose_version`
* `docker_version`
* `etcd_version`
* `openshift_docker_image_version`

It gives you the time/opportunity to update any references from the previous list accordingly with the new environment.

Example from an upgrade from 1.5 to 3.6

```json
  "override_attributes": {
    "cookbook-openshift3": {
      "ose_major_version": "1.5",
      "ose_version": "1.5.1-1.0.008f2d5",
      "openshift_docker_image_version": "v1.5.1",
      "docker_version": "1.12.6.x"
    }
  }
```

**The automated upgrade performs the following steps for you:**

- Applies the latest configuration.

- Upgrades master and etcd components and restarts services. (Control plane servers)

- Upgrade docker components.

- Upgrades node components and restarts services. (Node servers)

- Applies the latest cluster policies.

- Updates the default router if one exists.

- Updates the default registry if one exists.

*Make sure your servers are assigned to the right groups*

###### Limitation

**The automated upgrade does not perform the following steps for you:**

- Drain node servers.

- Mark drained node servers as unschedulable.

- Reboot servers after upgrade.

- Upgrade metrics or logging components (Coming soon)

#### Control upgrade

When upgrading in separate phases, the control plane phase includes upgrading:

* Master components (master_servers group)
* Etcd components (etcd_servers group)
* Node services running on masters (node_servers group)
* Docker running on masters
* Docker running on any stand-alone etcd hosts

When upgrading only the nodes, **the control plane must already be upgraded**. 

The node phase includes upgrading:

* Node services running on stand-alone nodes (node_servers group)
* Docker running on stand-alone nodes

#### Supported version

[x] 1.3 to 1.4

[x] 1.4 to 1.5

[x] 1.5 to 3.6

[x] 3.6 to 3.7

*Cluster upgrades cannot span more than one minor version at a time, so if your cluster is at a version earlier than the targeted one, you must first upgrade incrementally (e.g., 1.4 to 1.5, then 1.5 to 3.6...)*

### Running control upgrade

Before upgrading the cluster, some variables need to be declared:

| NAME | PURPOSE | Default value | Mandatory |
| ---------------- | ------------------------------- | ------------------ | ---------- |
| control_upgrade | Execute an upgrade     | `false`    | `YES` |
| control_upgrade_version | Target version (13,14,15,36,37)        |`""` |`YES`|
| control_upgrade_flag | Location of the control upgrade flag | `"/to_be_replaced"`  | `YES` |
| upgrade_repos | Target YUM repo | `""` | `NO` |


```json
  "override_attributes": {
    "cookbook-openshift3": {
      "control_upgrade": true,
      "control_upgrade_version": "37",
      "control_upgrade_flag": "/tmp/ready",
      "upgrade_repos": [
        {
          "name": "centos-openshift-origin37",
          "baseurl": "http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin37/",
          "gpgcheck": false
        }
      ]
    }
  }
```
##### Please be aware

* **The upgrade will not run unless it finds the file designated by the `control_upgrade_flag`**
* **The upgrade will not run unless the `control_upgrade` is set to `true`**
* **The upgrade will not run unless it finds a valid version to upgrade to via `control_upgrade_version`**