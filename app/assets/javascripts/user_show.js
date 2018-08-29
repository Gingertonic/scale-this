// USER SHOW VIEW
// LOAD ALL PRACTISES
function loadPracticeDiary(practises){
  $('.sb_nav').html("");
  $('.sb_header').html('<h1>Practice Diary</h1>');
  $('.sb_content').text(practises);
}

function loadPracticeRoom(){
  $.get('/current_username', function(username){
    $.get('/' + username + '.json', function(resp){
      console.log(resp);
      musician = new Musician(resp["data"]);
      $('.header').text(musician.name + "'s Practice Room");
      $('.primary_content').text(musician);
      loadPracticeDiary(musician.practises);
    })
  })
}
