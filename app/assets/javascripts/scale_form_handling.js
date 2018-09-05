// GENERIC SCALE FORM HANDLER
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

// ERROR HANDLING
function renderErrors(resp){
  $('.sb_errors').addClass('flash-error')
  resp["errors"].forEach(err => $('.sb_errors').append(`<p>${err}</p>`))
}

function clearErrors(){
  $('.sb_errors').removeClass('flash-error').html("");
}

// DELTE SCALE
function deleteScale(scale){
  $.ajax({
    url: `/scales/${scale.id}`,
    method: "delete"
  }).done(function(resp){
    loadScalesLibrary();
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
      $.get(`/${username}.json`, function(user){
        scaleForm = HandlebarsTemplates['scale_form']({scale: scale, action: "/scales", midi_notes: [], submitTag: "Add", musician_id: user.data.id})
        sbContent(scaleForm)
      }).done(function(){
        addFormSubmitListener('form#scale', addScale, "post")
      })
    })
  })
}

function addScale(new_scale){
  addToIndex(new_scale);
  loadNewScaleForm();
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
