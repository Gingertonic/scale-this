// SCALE SHOW VIEW
// LOAD SCALE PAGE
function loadScaleShow(scaleName){
  loadScale(scaleName);
}
// lOAD SCALE
function loadScale(scaleName){
  $.get('/scales/' + scaleName, function(resp){
    $('.header').text(resp.name);
    var scale = new Scale(resp);
    console.log(scale);
    var playback = HandlebarsTemplates['scale_playback']({scale: scale, midi_notes: scale.patternInC()});
    var values = scale.patternInC();
    $('.primary_content').html(playback);
    loadProgress(scale);
  })
}
// EDIT SCALE FORM
function loadEditScaleForm(scale){
  $('.sb_nav').html('<button class="see_progress sidebar_link"><a href="/musicans/progress">See Progress</a></button>');
  $('.sb_header').html('<h1>Edit Scale</h1>');
  scaleForm = HandlebarsTemplates['scale_form']({scale: scale})
  $('.sb_content').html(scaleForm)
  $('.see_progress').on('click', function(e){
    e.preventDefault();
    loadProgress(scale);
  })
}
// SHOW USER PROGRESS
function loadProgress(scale){
  $('.sb_header').html('<h1>Practice Log</h1>');
  $('.sb_content').html('<p>This will state your progress</p>');
  $.get('/current_username', function(username){
    $.get('/' + username + '.json', function(user){
      debugger;
      if (scale.createdBy === parseInt(user.data.id)){
        $('.sb_nav').html('<button class="edit_scale sidebar_link"><a href="/scales/:id/edit">Edit Scale</a></button>');
        $('.edit_scale').on('click', function(e){
          e.preventDefault();
          loadEditScaleForm(scale);
        })
      }
    })
  })
}
