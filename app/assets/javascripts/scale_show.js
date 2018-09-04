// SCALE SHOW VIEW
// LOAD SCALE PAGE
function loadScaleShow(scaleName){
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
