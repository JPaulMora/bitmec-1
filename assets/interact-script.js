function isTouchEnabled() {
  return (('ontouchstart' in window)
    || (navigator.MaxTouchPoints > 0)
    || (navigator.msMaxTouchPoints > 0));
}

$(document).ready(function () {
//  $('#bck_base').show().animate({ 'opacity': '0' }, 1000);

  for (let i = 1; i <= 42; i++) {
    addEventToBodyPart(`mal_${i}`, mal_config)

    if (i <= 6) {
      addEventToBodyPart(`bck_${i}`, bck_config)
    }
  }
});

function addEventToBodyPart(id, config) {
  let obj = $(`#${id}`)
  let configObj = config[id]

  obj.attr({
    'fill': configObj.upColor,
    'fill-opacity': configObj.upOpacity,
    'stroke': configObj.outlineUpColor,
    'stroke-opacity': configObj.outlineUpOpacity,
  })

  obj.attr({ cursor: 'default' })

  if (configObj.enable == true) {
    let organsTip = $('#organs-tip')

    if (isTouchEnabled()) {
      obj.on('touchstart', function (e) {
        let touch = e.originalEvent.touches[0]

        let x = touch.pageX + 10
        let y = touch.pageY + 15

        let tipw = organsTip.outerWidth()
        let tiph = organsTip.outerHeight()

        x = (x + tipw > $(document).scrollLeft() + $(window).width())
          ? x - tipw - (20 * 2)
          : x;

        y = (y + tiph > $(document).scrollTop() + $(window).height())
          ? $(document).scrollTop() - $(window).height() - tiph - 10
          : y;

        obj.css({
          'fill': configObj.overColor,
          'fill-opacity': configObj.downOpacity,
          'stroke': configObj.outlineDownColor,
          'stroke-opacity': configObj.outlineDownOpacity,
        })

        organsTip.show().html(configObj.hover)
        organsTip.css({ left: x, top: y })
      })

      obj.on('touchend', function () {
        obj.css({
          'fill': configObj.upColor,
          'fill-opacity': configObj.upOpacity,
          'stroke': configObj.outlineUpColor,
          'stroke-opacity': configObj.outlineUpOpacity,
        });

        window.flutter_inappwebview.callHandler('handleBodyPartSelected', configObj.id)
      })
    }

    obj.attr({ cursor: 'pointer' })
    obj.hover(function () {
      organsTip.show().html(configObj.hover)

      obj.css({
        'fill': configObj.overColor,
        'fill-opacity': configObj.overOpacity,
        'stroke': configObj.outlineOverColor,
        'stoke-opacity': configObj.outlineOverOpacity,
      })
    }, function () {
      organsTip.hide()
      obj.css({
        'fill': configObj.upColor,
        'fill-opacity': configObj.upOpacity,
        'stroke': configObj.outlineUpColor,
        'stroke-opacity': configObj.outlineUpOpacity,
      })
    })

    obj.mousedown(function () {
      obj.css({
        'fill': configObj.downColor,
        'fill-opacity': configObj.downOpacity,
        'stroke': configObj.outlineDownColor,
        'stroke-opacity': configObj.outlineDownOpacity,
      })
    })

    obj.mouseup(function () {
      obj.css({
        'fill': configObj.overColor,
        'fill-opacity': configObj.overOpacity,
        'stroke': configObj.outlineOverColor,
        'stroke-opacity': configObj.outlineOverOpacity,
      })
    })

    obj.mousemove(function (e) {
      let x = e.pageX + 10
      let y = e.pageY + 15

      let tipw = organsTip.outerWidth()
      let tiph = organsTip.outerHeight()

      x = (x + tipw > $(document).scrollLeft() + $(window).width())
        ? x - tipw - (20 * 2)
        : x

      y = (y + tiph > $(document).scrollTop() + $(window).height())
        ? $(document).scrollTop() + $(window).height() - tiph - 10
        : y;

      organsTip.css({ left: x, top: y })
    })
  }
}
