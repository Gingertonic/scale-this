function attachListeners(){
  $('.add_scale').on('click', function(e){
    e.preventDefault();
    loadNewScaleForm();
  })
  $('.to_library').on('click', function(e){
    e.preventDefault();
    loadScalesLibrary();
  })
  $('.to_practice_room').on('click', function(e){
    e.preventDefault();
    loadPracticeRoom();
  })
}

function loadRankings(){
  $('.sb_nav').html('<button class="add_scale sidebar_link"><a href="/scales/new">Add a New Scale</a></button>');
  $('.sb_content').html('<h1>Current Rankings!</h1>');
  $('.add_scale').on('click', function(e){
    e.preventDefault();
    loadNewScaleForm();
  })
  $.get('/musicians/rankings/name.json', function(resp){
    console.log(resp);
    $('.sb_content').text(resp["data"]);
  })
}

function loadNewScaleForm(){
  $('.sb_nav').html('<button class="see_rankings sidebar_link"><a href="/musicans/rankings">See rankings!</a></button>');
  $('.sb_content').html('<h1>New Scale Form</h1>');
  $('.see_rankings').on('click', function(e){
    e.preventDefault();
    loadRankings();
  })
}

function loadEditScaleForm(){
  $('.sb_nav').html('<button class="see_progress sidebar_link"><a href="/musicans/progress">See Progress</a></button>');
  $('.sb_content').html('<h1>Edit Scale Form</h1>');
  $('.see_progress').on('click', function(e){
    e.preventDefault();
    loadProgress();
  })
}

function loadProgress(){
  $('.sb_nav').html('<button class="edit_scale sidebar_link"><a href="/scales/:id/edit">Edit Scale</a></button>');
  $('.sb_content').html('<h1>Practice Diary</h1>');
  $('.edit_scale').on('click', function(e){
    e.preventDefault();
    loadEditScaleForm();
  })
}

function loadPracticeDiary(){
  $('.header').text("YOUR PRACTICE ROOM");
  $('.sb_nav').hide();
  $('.sb_content').html('<h1>Practice Diary</h1>');
}


function loadScalesLibrary(){
  $('.header').text("SCALES LIBRARY");
  loadScales();
  loadRankings();
}

function loadPracticeRoom(){
  $('.primary_content').html('<h1>Your Practice Room</h1>')
  loadPracticeDiary();
}

function loadScales(){
  $.get('/scales.json', function(resp){
    console.log(resp)
    $('.primary_content').text(resp["data"])
  })
}

$( document ).ready(function() {
    console.log( "ready!" );
    attachListeners();
  });
