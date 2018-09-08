// USER PROGRESS
function loadProgress(scale, username){
  clearErrors();
  sbHeader("Practice Log");
    $.get('/current_username', function(username){
      $.get(`/${username}`, function(resp){
      }).done(function(resp){
        let user = resp["data"];
        loadScaleNavFor(scale, user);
        loadExperience(scale, user)
        addPractiseForm(scale, user);
        addPractiseListener();
      });
    });
};

function loadExperience(scale, user){
  let practises = user.relationships.practises.data;
  sbContent("Never practised!");
  practises.some(function(practise){
    if (practise["scale_id"] === scale.id){
      sbContent(`Practised ${practised(practise["experience"])}`);
    };
  });
};

function addPractiseForm(scale, user){
  const practiseForm = HandlebarsTemplates['new_practise']({scale: scale, musician: user});
  sbContentAdd(practiseForm);
}

function addPractiseListener(){
  $('form#new_practise').on('submit', function(e){
    e.preventDefault();
    let $form = $(this);
    createPractise($form);
  })
}

function createPractise($form){
  let action = $form.attr("action");
  let params = $form.serialize();
  $.post(action, params).done(function(resp){
    stopAudio();
    loadPracticeRoom();
  })
}

function practised(x){
  if (x === 1){
    return "just once...";
  } else if (x === 2){
    return "twice.";
  } else {
    return `${x} times!`;
  };
};
