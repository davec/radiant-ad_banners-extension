document.observe("dom:loaded", function() {
  if ($('image-thumbnail')) {
    var box = $('image-thumbnail');
    if (!box.hasClassName('droppable')) {
      Droppables.add(box, {
        accept: 'asset',
        hoverclass: 'hover',
        onDrop: function(element) {
          AdBanner.attach(element, box);
        }
      });
      box.addClassName('droppable');
    }
    if (img = box.select('img')[0]) {
      box.style.width = img.getWidth() + 'px';
      box.style.height = img.getHeight() + 'px';
    }
    Asset.MakeDraggables();
  }
});

var AdBanner = {};

AdBanner.attach = function(element, box) {
  var img = element.select('a.bucket_link img')[0].cloneNode(true);
  var asset_id = element.id.split('_').last();
  $('ad_banner_asset_id').value = asset_id;
  box.update(img);
  box.style.width = img.getWidth() + 'px';
  box.style.height = img.getHeight() + 'px';
}
