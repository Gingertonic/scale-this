function Musician(attr){
  this.id = attr.id
  this.name = attr.attributes.name;
  this.admin = attr.attributes.admin;
  this.practises = attr.relationships.practises.data;
  this.imageUrl = attr.attributes.image_url;
}

Musician.prototype.totalPractises = function(){
  var totalExperience = 0
  this.practises.forEach(function(practise){
     totalExperience += practise.experience;
   })
   return totalExperience
}
