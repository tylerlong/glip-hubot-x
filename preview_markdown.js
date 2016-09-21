var page = require('webpage').create();
page.open('index.html', function(status) {
  console.log("Status: " + status);
  if(status !== "success") {
    return
  }
  page.evaluate(function() {
    var data = '```js\nfunction test() {\n    console.log("hello world");\n}\n```';
    mdc.init(data, false);
  });
  page.render('static/test.png');
  phantom.exit();
});
