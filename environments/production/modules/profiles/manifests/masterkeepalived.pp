class profiles::masterkeepalived    {

include keepalived

  keepalived::vrrp::instance { 'VI_50':
    interface         => 'eth1',
    state             => 'MASTER',
    virtual_router_id => '50',
    priority          => '101',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => [ '10.90.15.109/29' ],
    track_interface   => ['eth1','tun0'], # optional, monitor these interfaces.
  }

}
