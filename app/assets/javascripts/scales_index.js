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

// SCALES INDEX VIEW
//LOAD SCALES INDEX
function loadScalesLibrary(){
  $('.header').text("SCALES LIBRARY");
  loadScales();
  loadRankings();
}
// GET SCALES
function loadScales(){
  $('.primary_content').html("")
  $.get('/scales.json', function(resp){
    resp["data"].forEach(function(scale){
      new_scale = new Scale(scale.attributes)
      console.log(new_scale)
      if ($('#' + new_scale.scaleTypeSlug()).length === 0) {
        $('.primary_content').append(new_scale.renderScaleTypeBlock());
      }
      $('#' + new_scale.scaleTypeSlug()).append(new_scale.renderLiLink());
      addGoToScaleListener($('#' + new_scale.slugify()));
    })
  })
}
// ADD LINKS
function addGoToScaleListener(link){
  link.on('click', function(e){
    e.preventDefault();
    loadScaleShow(link[0].id)
  })
}

//  GET RANKINGS
function loadRankings(){
  $('.sb_nav').html('<button class="add_scale sidebar_link"><a href="/scales/new">Add a New Scale</a></button>');
  $('.sb_header').html('<h1>Current Rankings!</h1>');
  $('.add_scale').on('click', function(e){
    e.preventDefault();
    loadNewScaleForm();
  })
  $.get('/musicians/rankings/total-practises', function(resp){
    console.log(resp);
    $('.sb_content').text(resp["data"]);
    var musicians = []
    resp["data"].forEach(function(muso){
      musicians.push(new Musician(muso))
    })
    let rankingsTable = HandlebarsTemplates['musician_rankings']({musicians: musicians});
    $('.sb_content').html(rankingsTable);
  })
}
// NEW SCALE FORM
function loadNewScaleForm(){
  $.get('/scales/new', function(resp){
    scaleForm = HandlebarsTemplates['scale_form']({scale: resp})
    $('.sb_content').html(scaleForm)
  })
  $('.sb_nav').html('<button class="see_rankings sidebar_link"><a href="/musicans/rankings">See rankings!</a></button>');
  $('.sb_header').html('<h1>New Scale</h1>');
  $('.see_rankings').on('click', function(e){
    e.preventDefault();
    loadRankings();
  })
}
// SHOW USER
function loadPracticeRoom(){
  $.get('/current_username', function(username){
    $.get('/' + username + '.json', function(resp){
      musician = new Musician(resp["data"]);
      $('.header').text(musician.name + "'s Practice Room");
      $.get('/musicians/' + musician.id + '/practise_log', function(resp){
        practiseLog = HandlebarsTemplates['practise_log']({log: resp})
        $('.primary_content').html(practiseLog);
        for (const period in resp){
          console.log(period.replace(" ","_").replace('!',''))
          for (var i = 0; i < resp[period].length; i++){
            console.log(resp[period][i]["scale_id"])
            $.get('/scales/' + resp[period][i]["scale_id"], function(scale){
              thisScale = new Scale(scale);
              $('.' + period.replace(" ","_").replace('!','')).append(thisScale.renderLiLink());
              addGoToScaleListener($('#' + thisScale.slugify()));
            })
          }
        }
      });
      loadMusicianInfo(musician);
    })
  })
}

function loadMusicianInfo(musician){
  $('.sb_nav').html("");
  $('.sb_header').text("");
  var musicianInfo = HandlebarsTemplates['musician_info']({musician: musician});
  $('.sb_content').html(musicianInfo);
}

Handlebars.registerHelper("slugifyPeriod", function(period) {
    return period.replace(" ","_").replace('!','');
});

Handlebars.registerHelper("consolelog", function(something) {
  console.log(something);
});

Handlebars.registerHelper("debug", function(what) {
  debugger;
});

/////////////////////////

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
  console.log(scale)
  $('.sb_header').html('<h1>Practice Log</h1>');
  $.get('/current_username', function(username){
    $.get('/' + username + '.json', function(user){
      if (scale.createdBy === parseInt(user.data.id)){
        $('.sb_nav').html('<button class="edit_scale sidebar_link"><a href="/scales/:id/edit">Edit Scale</a></button>');
        $('.edit_scale').on('click', function(e){
          e.preventDefault();
          loadEditScaleForm(scale);
        })
      } else { $('.sb_nav').html("") }
      for (var i = 0; i < user.data.relationships.practises.data.length; i++){
        if (user.data.relationships.practises.data[i]["scale_id"] === scale.id){
          $('.sb_content').text("Practised " + practised(user.data.relationships.practises.data[i]["experience"]));
          return true;
        } else {
          $('.sb_content').text("Never practised!");
        }
      }
    }).done(function(user){
      practiseForm = HandlebarsTemplates['new_practise']({scale: scale, musician: user["data"]})
      // debugger;
      $('.sb_content').append(practiseForm);
      $('form#new_practise').on('submit', function(e){
        e.preventDefault();
        console.log("stop right here, my man!")
        var $form = $(this)
        var action = $form.attr("action")
        var params = $form.serialize()
        $.post(action + '.json', params).done(function(resp){
          console.log("here's the response: " + resp )
          loadPracticeRoom();
        })
      })
    })
  })
}

function createPractise(scale){
  // debugger;
  // MAKE POST PRACTISE CREATE REQUEST HERE
}

function practised(x){
  if (x === 1){
    return "just once..."
  } else if (x === 2){
    return "twice."
  } else {
    return `${x} times!`
  }
}

///////////


$( document ).ready(function() {
    attachListeners();
    loadScalesLibrary();
  });
