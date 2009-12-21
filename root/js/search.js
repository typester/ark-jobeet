$(document).ready(function()
{
  $('.search input[type="submit"]').hide();
 
  $('#search_keywords').keyup(function(key)
  {
    if (this.value.length >= 3 || this.value == '')
    {
      $('#loader').show();
      $('#jobs').load(
        $(this).parents('form').attr('action'),
        { q: this.value + '*' },
        function() { $('#loader').hide(); }
      );
    }
  });
});

