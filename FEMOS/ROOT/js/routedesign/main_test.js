$(document).ready(function() {
var addImage, layer, stage;
stage = new Kinetic.Stage("canvas", 1000, 700);
layer = new Kinetic.Layer();

addImage = function(src) {
  var image;
  image = new Image();
  image.onload = function() {
    var img;
    img = new Kinetic.Image({
      x: 10,
      y: 10,
      image: image,
      draggable: true
    });
    layer.add(img);
    stage.add(layer);
  };
  image.src = src;
};
$("#btn1").click(function() {
  addImage($("#btn1").data("src"));
});
$("#btn2").click(function() {
  addImage($("#btn2").data("src"));
});
$("#btn3").click(function() {
  addImage($("#btn3").data("src"));
});
$("#btn4").click(function() {
  addImage($("#btn4").data("src"));
});
$("#save").click(function() {
  stage.toDataURL(function(dataUrl) {
    return window.open(dataUrl);
  }, false);
});
});
