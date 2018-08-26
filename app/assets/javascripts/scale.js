function Scale(attr){
  this.name = attr.name;
  this.scaleType = attr.scale_type;
  this.origin = attr.origin;
  this.melodyRules = attr.melody_rules;
  this.created_by = attr.created_by;
  this.private = attr.private;
  this.pattern = attr.pattern;
}

Scale.prototype.scaleTypeSlug = function(){
  return this.scaleType.replace(/\W/g, "_");
}

Scale.prototype.renderLiLink = function(){
  return `<li><a href="/scales/` + this.slugify() + `/do">` + this.name +`</a></li>`
}

Scale.prototype.slugify = function(){
  return this.name.replace(/\W/g, "-");
}

Scale.prototype.renderScaleTypeBlock = function(){
  return `<div class="scale_type" id="` + this.scaleTypeSlug() + `">
    <h4> ${this.scaleType} </h4>
  </div>`
}
