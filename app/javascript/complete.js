$(document).on('turbolinks:load', function() {
  const CLASSNAME = "-visible";
  const TIMEOUT = 1000;
  const $target = $(".bg");

  setInterval(() => {
    $target.addClass(CLASSNAME);

    setTimeout(() => {
      // $target.removeClass(CLASSNAME);
    }, TIMEOUT);
  }, TIMEOUT);
});