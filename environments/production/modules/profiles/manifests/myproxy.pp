class profiles::myproxy ( $portnum = hiera('apacheport') ) {


class { 'haproxy': }
 haproxy::listen { 'puppet00':
    collect_exported => false,
    ipaddress        => '10.90.15.109',
     ports            => "${portnum}",
     options         => {
        'mode'       => 'http',
            },
          }


  haproxy::balancermember { 'http1':
    listening_service => 'puppet00',
    server_names      => 'http1.example.haproxy',
    ipaddresses       => '10.90.15.102',
    ports             => $portnum,
    options           => 'check',
  }
  haproxy::balancermember { 'http2':
    listening_service => 'puppet00',
    server_names      => 'http2.example.haproxy',
    ipaddresses       => '10.90.15.103',
    ports             =>  $portnum,
    options           => 'check',
  }

 # disable the appropriate firewalls
   firewall { '100 allow http and https access':
    dport   => [80, 443, 61613, 8140, $portnum],
    proto  => tcp,
    action => accept,
  }

 # enable forwarding
   sysctl::value { "net.ipv4.ip_forward": value => "1" }

   sysctl::value { "net.ipv4.ip_nonlocal_bind": value => "1" }



}
