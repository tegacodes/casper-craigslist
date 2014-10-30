# Make dir with timestamp and go there
folder=$(date +%H%M%S)
mkdir $folder && pushd $folder

# grab some random artwork metadata from scrapi
artwork=$(curl scrapi.org/random?images=true)



hasDescription=$(echo $artwork | jq '.hasDescription')
echo $hasDescription




# filter out the title
title=$(echo $artwork |jq -r '.title' )

# filter out the description
description=$(echo $artwork |jq -r '.description')

# filter out the dimensions
dimensions=$(echo $artwork |jq -r '.dimensions')


whereBroad=$(echo $artwork |jq -r '.whereList[0].name')
whereNarrow=$(echo $artwork |jq -r '.whereList[1].name')
medium=$(echo $artwork |jq -r '.medium')
provenance=$(echo $artwork |jq -r '.provenance')
department=$(echo $artwork |jq -r '.department')
culture=$(echo $artwork |jq -r '.culture')

#get image
imageUrl=$(echo $artwork | jq -r '.currentImage.imageUrl')  #-r means that we get the raw url
imageName=$(echo $artwork | jq -r '.currentImage.imageFileName')  #-r means that we get the raw url
imageLocation=$(pwd)/$imageName



curl -OL $imageUrl # O is download whats at the apir and L means follow redirect



popd

# run the script with variables
casperjs casperCraigslist.coffee --title="$title" --description="$description" --dimensions="$dimensions" --imageLocation="$imageLocation"

#casperjs casper5.coffee ${title} ${description} ${dimensions} --foo=bar

#if (casper.cli.args.length === 0 && Object.keys(casper.cli.options).length === 0) {
  #  casper.echo("No arg nor option passed").exit();
#}
