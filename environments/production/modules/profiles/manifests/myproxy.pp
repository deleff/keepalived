class profiles::myproxy ( $portnum = hiera('apacheport') ) {


class { 'haproxy': }
  haproxy::listen { 'puppet00':
    collect_exported => false,
    ipaddress        => '10.90.15.100',
    ports            => '80',
    mode             => 'http',
    options          => {
      'option'       => ['httplog'],
      'balance'      => 'roundrobin',
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

}
