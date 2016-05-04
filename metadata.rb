name 'cookbook-openshift3'
maintainer 'The Authors'
maintainer_email 'wburton@redhat.com'
license 'all_rights'
source_url 'https://github.com/IshentRas/cookbook-openshift3'
issues_url 'https://github.com/IshentRas/cookbook-openshift3/issues'
description 'Installs/Configures Openshift 3'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.10.2'
supports 'redhat', '>= 7.2'
supports 'centos', '>= 7.2'

depends 'iptables', '>= 2.0.0'
depends 'selinux_policy'
depends 'yum'

recipe 'cookbook-openshift3::default', 'Default recipe'
recipe 'cookbook-openshift3::common', 'Apply common logic'
recipe 'cookbook-openshift3::master', 'Configure basic master logic'
recipe 'cookbook-openshift3::master_standalone', 'Configure standalone master logic'
recipe 'cookbook-openshift3::master_cluster', 'Configure HA cluster master (PACEMAKER)'
recipe 'cookbook-openshift3::master_config_post', 'Configure Post actions for masters'
recipe 'cookbook-openshift3::node_config_post', 'Configure Post actions for nodes'
recipe 'cookbook-openshift3::nodes_certificates', 'Configure certificates for nodes'
recipe 'cookbook-openshift3::node', 'Configure node'
recipe 'cookbook-openshift3::etcd_cluster', 'Configure HA ETCD cluster'
recipe 'cookbook-openshift3::setup_cluster.rb', 'Configure PCS and COROSYNC cluster'
