function attachListeners(){
  $('.to_library').on('click', function(e){
    e.preventDefault();
    stopAudio()
    loadScalesLibrary();
  })
  $('.to_practice_room').on('click', function(e){
    e.preventDefault();
    stopAudio()
    loadPracticeRoom();
  })
}

function stopAudio(){
  $('.audio_trigger').attr('checked', false);
  $('.audio_trigger').trigger("change");
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
  $('.sb_errors').removeClass('flash-error').text("");
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
  $('.sb_errors').removeClass('flash-error').text("");
  $.get('/current_username', function(user){
    // debugger;
    if (!user) {
      $('.sb_nav').html('');
    } else {
      $('.sb_nav').html('<button class="add_scale sidebar_link"><a href="/scales/new">Add a New Scale</a></button>');
      $('.add_scale').on('click', function(e){
        e.preventDefault();
        loadNewScaleForm();
      })
    }
  })
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
  $('.sb_errors').removeClass('flash-error').text("");
  $.get('/scales/new', function(resp){
    scale = new Scale(resp);
    $.get('/current_username', function(username){
      $.get('/' + username + '.json', function(user){
        scaleForm = HandlebarsTemplates['scale_form']({scale: scale, action: "/scales", midi_notes: [], submitTag: "Add", musician_id: user.data.id})
        $('.sb_content').html(scaleForm)
        // debugger
        $('form#scale').on('submit', function(e){
          e.preventDefault();
          $('.sb_errors').removeClass('flash-error').html("")
          console.log("stahhhp!")
          $form = $(this)
          console.log($form.serialize())
          action = $form.attr("action")
          params = ($form.serialize())
          $.post(action, params).done(function(resp){
            // debugger;
            if (resp["errors"]){
              $('.sb_errors').addClass('flash-error')
              resp["errors"].forEach(function(err){
                $('.sb_errors').append('<p>' + err + '</p>')
              })
            } else {
              new_scale = new Scale(resp)
              console.log(new_scale)
              if ($('#' + new_scale.scaleTypeSlug()).length === 0) {
                $('.primary_content').append(new_scale.renderScaleTypeBlock());
              }
              $('#' + new_scale.scaleTypeSlug()).append(new_scale.renderLiLink());
              addGoToScaleListener($('#' + new_scale.slugify()));
              loadNewScaleForm();
            }
          })
        })
      })
    })
  })
  $('.sb_nav').html('<button class="see_rankings sidebar_link"><a href="/musicans/rankings">See rankings!</a></button>');
  $('.sb_header').html('<h1>New Scale</h1>');
  $('.see_rankings').on('click', function(e){
    e.preventDefault();
    loadRankings();
  })
}

// POST NEW SCALE FORM


// SHOW USER
function loadPracticeRoom(){
  $('.sb_errors').removeClass('flash-error').text("");
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
  $('.sb_errors').removeClass('flash-error').text("");
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

Handlebars.registerHelper("checkedIf", function (pattern, note) {
    return (pattern.includes(note)) ? "checked" : "";
});

Handlebars.registerHelper("selectedIf", function (root, value) {
    return (root === value) ? "selected" : "";
});

Handlebars.registerHelper("gColour", function (value, index) {
    return (255 - (index*10) - value);
});

Handlebars.registerHelper("bColour", function (value, index) {
    return (value + (index*10));
});

Handlebars.registerHelper("getNoteName", function (midi) {
    notes = {55: "G", 56: "G#/Ab", 57: "A", 58: "A#/Bb", 59: "B", 60: "C", 61: "C#/Db", 62: "D", 63: "D#/Eb", 64: "E", 65: "F", 66: "F#/Gb", 67: "G", 68: "G#/Ab", 69: "A", 70: "A#/Bb", 71: "B", 72: "C", 73: "C#/Db", 74: "D", 75: "D#/Eb", 76: "E", 77: "F", 78: "F#/Gb"}
    return notes[midi]
});



/////////////////////////

// SCALE SHOW VIEW
// LOAD SCALE PAGE
function loadScaleShow(scaleName){
  loadScale(scaleName);
}
// lOAD SCALE
function loadScale(scaleName){
  $('.sb_errors').removeClass('flash-error').text("");
  $.get('/scales/' + scaleName, function(resp){
    $('.header').text(resp.name);
    var scale = new Scale(resp);
    console.log(scale);
    var playback = HandlebarsTemplates['scale_show']({scale: scale, root: 60, midi_notes: scale.patternFrom(60)});
    $('.primary_content').html(playback);
    var values = scale.patternFrom(60);
    loadPlayback(values)
    $.get('/current_username', function(user){
      if (!user) {
        $('.sb_nav').html('');
      } else {
        loadProgress(scale, user);
      }
    })
    addRootListener(scale);
  })
}

function changeRoot(scale, root){
  stopAudio();
  var playback = HandlebarsTemplates['scale_show']({scale: scale, root: root, midi_notes: scale.patternFrom(root)});
  $('.primary_content').html(playback);
  var values = scale.patternFrom(root);
  loadPlayback(values)
  addRootListener(scale);
}

function addRootListener(scale){
  $('form#change_root').on('change', function(e){
    e.preventDefault();
    newRoot = parseInt($('select#root')[0].selectedOptions[0].value)
    changeRoot(scale, newRoot);
  })
}

// EDIT SCALE FORM
function loadEditScaleForm(scale){
  $('.sb_errors').removeClass('flash-error').text("");
  $('.sb_nav').html('<button class="see_progress sidebar_link"><a href="/musicans/progress">See Progress</a></button>');
  $('.sb_header').html('<h1>Edit Scale</h1>');
  debugger
  scaleForm = HandlebarsTemplates['scale_form']({scale: scale, action: `/scales/${scale.id}`, midi_notes: scale.patternFrom(60), submitTag: "Update"})
  $('.sb_content').html(scaleForm)
  $('.see_progress').on('click', function(e){
    e.preventDefault();
    loadProgress(scale);
  })
  $('form#scale').on('submit', function(e){
    e.preventDefault();
    $('.sb_errors').removeClass('flash-error').html("");
    $form = $(this);
    action = $form.attr("action");
    params = $form.serialize();
    $.ajax({
      url: action,
      data: params,
      method: "patch"
    }).done(function(resp){
      if (resp["errors"]){
        $('.sb_errors').addClass('flash-error')
        resp["errors"].forEach(function(err){
          $('.sb_errors').append('<p>' + err + '</p>')
        })
      } else {
        thisScale = new Scale(resp)
        loadScaleShow(thisScale.slugify());
      }
    })
  })
}


// SHOW USER PROGRESS
function loadProgress(scale, username){
  // debugger;
  $('.sb_errors').removeClass('flash-error').text("");
  console.log("This is scale" + scale)
  console.log("current user is " + username)
  $('.sb_header').html('<h1>Practice Log</h1>');
  // $.get('/current_username', function(username){
    $.get('/' + username + '.json', function(user){
      debugger;
      if (scale.createdBy === parseInt(user.data.id)){
        $('.sb_nav').html('<button class="edit_scale sidebar_link"><a href="/scales/:id/edit">Edit Scale</a></button>');
        $('.edit_scale').on('click', function(e){
          e.preventDefault();
          loadEditScaleForm(scale);
        })
        $('.sb_nav').append('<button class="delete_scale sidebar_link"><a href="/scales/:id/destroy">Delete Scale</a></button>');
        $('.delete_scale').on('click', function(e){
          e.preventDefault();
          deleteScale(scale);
        })
      } else {
        $('.sb_nav').html("")
      }
      for (var i = 0; i < user.data.relationships.practises.data.length; i++){
        if (user.data.relationships.practises.data[i]["scale_id"] === scale.id){
          $('.sb_content').text("Practised " + practised(user.data.relationships.practises.data[i]["experience"]));
          break;
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
  // })
}

function deleteScale(scale){
  console.log(scale)
  console.log(scale.id)
  $.ajax({
    url: '/scales/' + scale.id,
    method: "delete"
  }).done(function(resp){
    loadScalesLibrary();
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


////////


$( document ).ready(function() {
  if (window.location.pathname === '/scales') {
    attachListeners();
    loadScalesLibrary();
  }
  if (window.location.hash === '#practise_room') {
    attachListeners();
    loadPracticeRoom();
  }
});
