// USER SHOW VIEW
// LOAD ALL PRACTISES
// function loadMusicianInfo(musician){
//   $('.sb_nav').html("");
//   $('.sb_header').html('<h1>' + musician.name '</h1>');
//   var musicianInfo = HandlebarsTemplates['musician_info']({scale: scale, midi_notes: scale.patternInC()});
//   $('.sb_content').html(musicianInfo);
// }
//
// function loadPracticeRoom(){
//   $.get('/current_username', function(username){
//     $.get('/' + username + '.json', function(resp){
//       console.log(resp);
//       musician = new Musician(resp["data"]);
//       $('.header').text(musician.name + "'s Practice Room");
//       $('.primary_content').text(musician);
//       loadMusicianInfo(musician);
//     })
//   })
// }
