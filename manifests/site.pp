node default {


  include stdlib

  class { 'apache':}
  class { 'apache::mod::ssl': }
                                                                                                                                                             
  apache::vhost { 'jenkins non-ssl':
    servername   => '127.0.0.1',
    port         => '80',
    rewrite_cond => '%{HTTPS} off',
    rewrite_rule => '(.*) https://%{HTTPS_HOST}%{REQUEST_URI}',
    docroot      => '/var/www/html',
  }             

  apache::vhost { 'jenkins ssl':
    servername => '127.0.0.1',
    port       => '443',
    ssl        => true,
    proxy_dest => 'http://localhost:8080/',
    docroot      => '/var/www/html',
  }                                                                                                                                                                                     

  include jenkins

#
# Install some jenkins plugins
#
  jenkins::plugin {
    'git': ;
    'github': ;
    'subversion': ;
    'chucknorris': ;
    'http_request': ;
    'jenkins-cloudformation-plugin': ;
    'ec2': ;
    's3': ;
    'batch-task': ;
    'ssh': ;
    'monitoring': ;
    'jabber' :
  }
  
}