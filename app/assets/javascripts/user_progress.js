// USER PROGRESS
function loadProgress(scale, username){
  clearErrors();
  sbHeader("Practice Log")
    $.get('/current_username', function(username){
      $.get(`/${username}`, function(resp){
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
  for (let i = 0; i < practises.length; i++){
    if (practises[i]["scale_id"] === scale.id){
      sbContent(`Practised ${practised(practises[i]["experience"])}`)
      break;
    } else {
      sbContent("Never practised!");
    }
  }
}

function addPractiseForm(scale, user){
  practiseForm = HandlebarsTemplates['new_practise']({scale: scale, musician: user})
  sbContentAdd(practiseForm);
}

function addPractiseListener(){
  $('form#new_practise').on('submit', function(e){
    e.preventDefault();
    let $form = $(this)
    createPractise($form)
  })
}

function createPractise($form){
  let action = $form.attr("action")
  let params = $form.serialize()
  $.post(action, params).done(function(resp){
    stopAudio();
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
