package Jobeet::API;
use Mouse;

has errstr => (
    is  => 'rw',
    isa => 'Str',
);

no Mouse;

sub error {
    my ($self, $error) = @_;

    $self->_error($error);
    return;
}

1;

