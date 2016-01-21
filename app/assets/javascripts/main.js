$(document).ready(function(){
  $('.datetimepicker').datetimepicker();
  $('.datepicker').datepicker({
    format: 'yyyy-mm-dd'
  });
  $('.check_all').click(function(event){
    event.preventDefault();
    $( ":checkbox" ).attr('checked', 'true');
  });
});
