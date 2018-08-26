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
  $('.sb_header').html('<h1>Current Rankings!</h1>');
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
  $('.sb_header').html('<h1>New Scale</h1>');
  scaleForm = HandlebarsTemplates['scale_form']
  $('.sb_content').html('<p>This will be the New Scale Form</p>');
  $('.sb_content').append(scaleForm)
  $('.see_rankings').on('click', function(e){
    e.preventDefault();
    loadRankings();
  })
}

function loadEditScaleForm(){
  $('.sb_nav').html('<button class="see_progress sidebar_link"><a href="/musicans/progress">See Progress</a></button>');
  $('.sb_header').html('<h1>Edit Scale</h1>');
  scaleForm = HandlebarsTemplates['scale_form']
  $('.sb_content').html('<p>This will be the Edit Scale Form</p>');
  $('.sb_content').append(scaleForm)
  $('.see_progress').on('click', function(e){
    e.preventDefault();
    loadProgress();
  })
}

function loadProgress(){
  $('.sb_nav').html('<button class="edit_scale sidebar_link"><a href="/scales/:id/edit">Edit Scale</a></button>');
  $('.sb_header').html('<h1>Practice Log</h1>');
  $('.sb_content').html('<p>This will state your progress</p>');
  $('.edit_scale').on('click', function(e){
    e.preventDefault();
    loadEditScaleForm();
  })
}

function loadPracticeDiary(practises){
  $('.sb_nav').hide();
  $('.sb_header').html('<h1>Practice Diary</h1>');
  $('.sb_content').text(practises);
}


function loadScalesLibrary(){
  $('.header').text("SCALES LIBRARY");
  loadScales();
  loadRankings();
}

function loadPracticeRoom(){
  $('.header').text("YOUR PRACTICE ROOM");
  $.get('/current_username', function(username){
    $.get('/' + username + '.json', function(resp){
      console.log(resp);
      $('.primary_content').text(resp["data"]);
      practises = resp["data"]["relationships"]["practises"]["data"]
      loadPracticeDiary(practises);
    })
  })
}

function loadScales(){
  $.get('/scales.json', function(resp){
    resp["data"].forEach(function(scale){
      console.log(scale.attributes)
    })
    $('.primary_content').text(resp["data"])
  })
}



$( document ).ready(function() {
    console.log( "ready!" );
    attachListeners();
    init();
  });
