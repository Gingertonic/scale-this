// SCALE SHOW VIEW
// LOAD SCALE PAGE
function loadScaleShow(scaleName){
  if ((typeof scaleName) === "object"){
    let scale = scaleName.slugify();
    loadScale(scale);
  };
  loadScale(scaleName);
};
// lOAD SCALE
function loadScale(scaleName){
  clearErrors();
  hideSearchBar();
  $.get(`/scales/${scaleName}`, function(resp){
    let scale = new Scale(resp);
    primaryHeader(scale.name);
    const playback = HandlebarsTemplates['scale_show']({scale: scale, root: 60, midi_notes: scale.patternFrom(60)});
    primaryContent(playback);
    let values = scale.patternFrom(60);
    loadPlayback(values);
    $.get('/current_username', function(user){
      if (!user) {
        sbNavStart("");
      } else {
        loadProgress(scale, user);
      };
    });
    addRootListener(scale);
  });
};

function changeRoot(scale, root){
  stopAudio();
  const playback = HandlebarsTemplates['scale_show']({scale: scale, root: root, midi_notes: scale.patternFrom(root)});
  primaryContent(playback);
  let values = scale.patternFrom(root);
  loadPlayback(values);
  addRootListener(scale);
};

function addRootListener(scale){
  $('form#change_root').on('change', function(e){
    e.preventDefault();
    let newRoot = parseInt($('select#root')[0].selectedOptions[0].value);
    changeRoot(scale, newRoot);
  });
};

function loadScaleNavFor(scale, user){
  if (scale.createdBy === parseInt(user.id)){
    sbNavStart(linkWithId("edit_scale", "Edit Scale"));
    $('#edit_scale').on('click', function(e){
      e.preventDefault();
      loadEditScaleForm(scale);
    });
    sbNavAdd(linkWithId("delete_scale", "Delete Scale"));
    $('#delete_scale').on('click', function(e){
      e.preventDefault();
      deleteScale(scale);
    });
  } else {
    sbNavStart("");
  };
};
