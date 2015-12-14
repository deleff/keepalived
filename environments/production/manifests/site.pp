
node 	'http1.example.haproxy',
	'http2.example.haproxy' {
include roles::apacheproject
}

node 'lb1.example.haproxy' {
include roles::masterproxy
}


node 'lb2.example.haproxy' {
include roles::backupproxy
}


node default {

}
