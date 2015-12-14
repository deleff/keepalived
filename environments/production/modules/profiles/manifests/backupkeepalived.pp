class profiles::backupkeepalived    {

include keepalived

  keepalived::vrrp::instance { 'VI_50':
    interface         => 'eth1',
    state             => 'BACKUP',
    virtual_router_id => '50',
    priority          => '100',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => [ '10.10.15.109/29' ],
    track_interface   => ['eth1','tun0'], # optional, monitor these interfaces.
  }

}

