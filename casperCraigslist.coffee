casper = require('casper').create()

casper.start 'https://post.craigslist.org/c/nyc?lang=en', ->
  this.capture '01_mainpage.png'
  # click on For Sale by Owner
  this.click 'input[name="id"][value="fso"]'

casper.then ->
  console.log('clicked ok, new location is ' + this.getCurrentUrl())
  this.capture '02_fso.png'


casper.then ->

  # click on antiques by owner
  this.click 'input[name="id"][value="150"]'
  this.capture '03_category.png'

casper.then ->
    console.log('clicked ok, new location is ' + this.getCurrentUrl())


casper.then ->

  # click on location
  this.click 'input[name="n"][value="1"]'
  this.capture '04_location.png'

casper.then ->
  console.log('clicked ok, new location is ' + this.getCurrentUrl())

casper.then ->

  # click on sub location
  this.click 'input[name="n"][value="126"]'
  this.capture '05_sublocation.png'

casper.then ->
  console.log('clicked ok, new location is ' + this.getCurrentUrl())

#CRAIGSLIST FORM
casper.then ->
  @fill "form#postingForm",
    FromEMail: "tega.metmuseum@gmail.com"
    ConfirmEMail: "tega.metmuseum@gmail.com"
    contact_phone: "3472593073"
    contact_name: "Thomas"
    PostingTitle: casper.cli.get("title")
    postal: "10028"
    PostingBody: "Make an offer on this"+ casper.cli.get("title") + casper.cli.get("medium")+". A gorgeous examples of"+ casper.cli.get("department")+". This is a rare antique/collectors item
that I bought this years ago in "+ casper.cli.get("whereNarrow") +" "+ casper.cli.get("whereBroad")+". I think it was from" + casper.cli.get("provenance")+". This item is in excellent condition for its age - I'm pretty sure it is"+casper.cli.get("culture")+ " and would look fantastic in your New York City apartment.
Contact me to make me an offer!! All offers will be considered!!
This ad will be taken down immediately upon sale.
If you are responding to this ad please put the words serious buyer in the subject or I will assume you are a spam bot and will ignore you."
    sale_size: casper.cli.get("dimensions")
    xstreet0: "1000 5th Avenue"
    city: "New York"
    region: "NY"
    this.click 'input[name="contact_phone_ok"][value="1"]'
    this.capture '06_form.png'
  , true

casper.then ->
  this.click 'button[name="go"][value="Continue"]'
  console.log('clicked ok, new location is ' + this.getCurrentUrl())

casper.then ->
  this.capture '07_map.png'

casper.then ->
  this.clickLabel('continue', 'button')
  console.log('clicked ok, new location is ' + this.getCurrentUrl())

casper.then ->
  this.capture '08_photo.png'


casper.then ->
  this.page.uploadFile('input[type="file"]','/Users/tegabrain/Documents/METMUSEUM/MetMuseum/Posts/DT5363.jpg');

casper.then ->
  this.capture '09_upload.png'

casper.wait '5000', ->

casper.then ->
  this.click 'button[name="go"][value="Done with Images"]'
  console.log('clicked ok, new location is ' + this.getCurrentUrl())

casper.then ->
  this.capture '10_confirm.png'

casper.then ->
  this.click 'button[name="go"][value="Continue"]'
  console.log('clicked ok, new location is ' + this.getCurrentUrl())


casper.then ->
  this.capture '11_finish.png'

casper.run()
