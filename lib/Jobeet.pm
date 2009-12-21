package Jobeet;
use Ark;

use Data::Page::Navigation;
use Digest::SHA1 ();

our $VERSION = '0.01';

use_model 'Jobeet::Models';

use_plugins qw{
    Session
    Session::State::Cookie
    Session::Store::Model
};

config 'Plugin::Session' => {
    expires => '+30d',
};

config 'Plugin::Session::State::Cookie' => {
    cookie_name => 'jobeet_session',
};

config 'Plugin::Session::Store::Model' => {
    model => 'cache',
};

config 'View::MT' => {
    macro => {
        sha1_hex => \&Digest::SHA1::sha1_hex,
    },
};

1;
