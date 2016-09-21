var page = require('webpage').create();
var system = require('system');

page.viewportSize = { width: 1024, height: 128 };

page.open('index.html', function(status) {
  if(status !== "success") {
    return;
  }
  var data = system.args[1];
  var count = system.args[2];
  page.evaluate(function(data) {
    mdc.init(data, false);
  }, data);
  setTimeout(function(){
    page.render('static/test_' + count + '.png');
    phantom.exit();
  }, 1000);
});
