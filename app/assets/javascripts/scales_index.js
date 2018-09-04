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
  primaryHeader("SCALES LIBRARY");
  loadScales();
  loadRankings();
}

// GET SCALES
function loadScales(){
  clearErrors();
  primaryContent("")
  $.get('/scales.json', function(resp){
  }).done(function(resp){
    sortScales(resp["data"])
  })
}

function sortScales(scales){
  scales.forEach(function(scale){
    new_scale = new Scale(scale.attributes)
    if ($('#' + new_scale.scaleTypeSlug()).length === 0) {
      primaryContentAdd(new_scale.renderScaleTypeBlock())
    }
    $('#' + new_scale.scaleTypeSlug()).append(new_scale.renderLiLink());
    addGoToScaleListener($('#' + new_scale.slugify()));
  })
}

function primaryContentAdd(content){
 $('.primary_content').append(content)
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
  clearErrors();
  $.get('/current_username', function(user){
    if (!user) {
      sbNavStart("")
    } else {
      sbNavStart(linkWithId("add_scale", "Add a New Scale"))
      $('#add_scale').on('click', function(e){
        e.preventDefault();
        loadNewScaleForm();
      })
    }
  })
  sbHeader("Current Rankings!")
  $('.add_scale').on('click', function(e){
    e.preventDefault();
    loadNewScaleForm();
  })
  $.get('/musicians/rankings/total-practises', function(resp){
    var musicians = []
    resp["data"].forEach(function(muso){
      musicians.push(new Musician(muso))
    })
    let rankingsTable = HandlebarsTemplates['musician_rankings']({musicians: musicians});
    sbContent(rankingsTable);
  })
}
// NEW SCALE FORM
function loadNewScaleForm(){
  clearErrors();
  sbNavStart(linkWithId("see_rankings", "See Rankings"))
  sbHeader("New Scale")
  addNavListener("see_rankings", loadRankings)
  $.get('/scales/new', function(resp){
  }).done(function(resp){
    scale = new Scale(resp);
    $.get('/current_username', function(username){
    }).done(function(username){
      $.get('/' + username + '.json', function(user){
        scaleForm = HandlebarsTemplates['scale_form']({scale: scale, action: "/scales", midi_notes: [], submitTag: "Add", musician_id: user.data.id})
        sbContent(scaleForm)
      }).done(function(){
        addFormSubmitListener('form#scale', addScale, "post")
      })
    })
  }) // get scales new done
}

function addScale(new_scale){
  debugger;
  if ($('#' + new_scale.scaleTypeSlug()).length === 0) {
    primaryContentAdd(new_scale.renderScaleTypeBlock())
    // $('.primary_content').append(new_scale.renderScaleTypeBlock());
  }
  $('#' + new_scale.scaleTypeSlug()).append(new_scale.renderLiLink());
  addGoToScaleListener($('#' + new_scale.slugify()));
  loadNewScaleForm();
}


// SHOW USER
function loadPracticeRoom(){
  clearErrors();
  $.get('/current_username', function(username){
    $.get('/' + username + '.json', function(resp){
      musician = new Musician(resp["data"]);
      primaryHeader(musician.name + "'s Practice Room")
      $.get('/musicians/' + musician.id + '/practise_log', function(pLog){
        practiseLog = HandlebarsTemplates['practise_log']({log: pLog})
        primaryContent(practiseLog)
        sortPractiseLog(pLog)
      });
      loadMusicianInfo(musician);
    })
  })
}

function sortPractiseLog(pLog){
  for (const period in pLog){
    for (var i = 0; i < pLog[period].length; i++){
      $.get('/scales/' + pLog[period][i]["scale_id"], function(scale){
        thisScale = new Scale(scale);
        $('.' + period.replace(" ","_").replace('!','')).append(thisScale.renderLiLink());
        addGoToScaleListener($('#' + thisScale.slugify()));
      })
    }
  }
}

function loadMusicianInfo(musician){
  clearErrors();
  sbNavStart("")
  sbHeader("")
  var musicianInfo = HandlebarsTemplates['musician_info']({musician: musician});
  sbContent(musicianInfo)
}

function sbContent(content){
  $('.sb_content').html(content);
}

function sbContentAdd(content){
  $('.sb_content').append(content);
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
  debugger;
  if ((typeof scaleName) === "object"){
    scale = scaleName.slugify()
    loadScale(scale)
  }
  loadScale(scaleName);
}
// lOAD SCALE
function loadScale(scaleName){
  clearErrors();
  $.get('/scales/' + scaleName, function(resp){
    primaryHeader(resp.name)
    var scale = new Scale(resp);
    var playback = HandlebarsTemplates['scale_show']({scale: scale, root: 60, midi_notes: scale.patternFrom(60)});
    primaryContent(playback)
    var values = scale.patternFrom(60);
    loadPlayback(values)
    $.get('/current_username', function(user){
      if (!user) {
        sbNavStart("")
      } else {
        loadProgress(scale, user);
      }
    })
    addRootListener(scale);
  })
}

function primaryContent(content){
  $('.primary_content').html(content);
}

function primaryHeader(headerText){
  $('.header').text(headerText);
}

function changeRoot(scale, root){
  stopAudio();
  var playback = HandlebarsTemplates['scale_show']({scale: scale, root: root, midi_notes: scale.patternFrom(root)});
  primaryContent(playback)
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
  clearErrors();
  sbNavStart(linkWithId("see_progress", "See Progress"))
  sbHeader("Edit Scale")
  scaleForm = HandlebarsTemplates['scale_form']({scale: scale, action: `/scales/${scale.id}`, midi_notes: scale.patternFrom(60), submitTag: "Update"})
  sbContent(scaleForm);
  addNavListener("see_progress", loadProgress, [scale])
  addFormSubmitListener('form#scale', loadScaleShow, "patch")
}

function addFormSubmitListener(identifier, func, method){
  $(identifier).on('submit', function(e){
    e.preventDefault();
    clearErrors()
    $form = $(this);
    action = $form.attr("action");
    params = $form.serialize();
    $.ajax({
      url: action,
      data: params,
      method: method
    }).done(function(resp){
      if (resp["errors"]){
        renderErrors(resp)
      } else {
        thisScale = new Scale(resp)
        func.call(this, thisScale)
      }
    })
  })
}

function updateScale(){

}

function addNavListener(id, func, args){
  // debugger;
  $('#' + id).on('click', function(e){
    e.preventDefault();
    func.apply(this, args)
  })
}

function sbNavStart(content){
  $('.sb_nav').html(content)
}

function sbNavAdd(content){
  $('.sb_nav').append(content)
}

function sbHeader(headerText){
  $('.sb_header').html('<h1>' + headerText + '</h1>');
}

function renderErrors(resp){
  $('.sb_errors').addClass('flash-error')
  resp["errors"].forEach(function(err){
    $('.sb_errors').append('<p>' + err + '</p>')
  })
}



function clearErrors(){
  $('.sb_errors').removeClass('flash-error').html("");
}


// SHOW USER PROGRESS
function loadProgress(scale, username){
  clearErrors();
  sbHeader("Practice Log")
    $.get('/current_username', function(username){
      $.get('/' + username + '.json', function(resp){
      }).done(function(resp){
        user = resp["data"]
        loadScaleNavFor(scale, user);
        loadExperience(scale, user)
        addPractiseForm(scale, user);
        addPractiseListener();
      })
    })
}

function loadExperience(scale, user){
  practises = user.relationships.practises.data;
  for (var i = 0; i < practises.length; i++){
    if (practises[i]["scale_id"] === scale.id){
      sbContent("Practised " + practised(practises[i]["experience"]))
      break;
    } else {
      sbContent("Never practised!");
    }
  }
}

function loadScaleNavFor(scale, user){
  if (scale.createdBy === parseInt(user.id)){
    sbNavStart(linkWithId("edit_scale", "Edit Scale"))
    $('#edit_scale').on('click', function(e){
      e.preventDefault();
      loadEditScaleForm(scale);
    })
    sbNavAdd(linkWithId("delete_scale", "Delete Scale"))
    $('#delete_scale').on('click', function(e){
      e.preventDefault();
      deleteScale(scale);
    })
  } else {
    sbNavStart("")
  }
}

function linkWithId(id, text){
  return '<a id="' + id + '" href="#">' + text + '</a>'
}

function deleteScale(scale){
  $.ajax({
    url: '/scales/' + scale.id,
    method: "delete"
  }).done(function(resp){
    loadScalesLibrary();
  })
}

function createPractise($form){
  var action = $form.attr("action")
  var params = $form.serialize()
  $.post(action + '.json', params).done(function(resp){
    loadPracticeRoom();
  })
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


////

function addPractiseForm(scale, user){
  practiseForm = HandlebarsTemplates['new_practise']({scale: scale, musician: user["data"]})
  sbContentAdd(practiseForm);
}

function addPractiseListener(){
  $('form#new_practise').on('submit', function(e){
    e.preventDefault();
    var $form = $(this)
    createPractise($form)
  })
}

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
