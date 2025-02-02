#!/bin/sh -e
site=../site
content=content
headerA=../../inc/header-top.htm
headerB=../../inc/header-bottom.htm
sitenav=../../inc/nav.htm
meta=meta.htm
contentFile=content.htm
foot=../../inc/footer.htm
bottom=../../inc/html-bottom.htm
tally=0

rm -rf $site
mkdir -p $site

# List the index
function setupindex {
	echo "<h1>HEADING 1</h1>" > ./permanav/index/content.htm;
	for f in *; do #GRE V MAPO PHOTOGRAPHY
		echo "<h2>NAME OF FOLDER ${f}</h2>" >> ./permanav/index/content.htm;
		#categoryname=$f;setupindex;
		#for f in *; do #ZDAJ GREV PODMAPO PHOTOGRAPHY
		#	echo "<a href='${categoryname}/${f}.html'>{${f}}</a>" >> ../permanav/index/content.htm; ##IN GENERIRA LINK PODMAPE
		#done
	done
	echo "Index built"
}

# Setup topics
cd $content
setupindex;
for f in *; do
	cd $f;
	markup=''
	topPart=$(cat $headerA $meta $headerB);
	nav=$(cat $sitenav);
	contentText=$(cat $contentFile);
	footer=$(cat $foot);
	closefile=$(cat $bottom);
	mainContent="<main>${contentText}</main>";
	sideBar="<aside>${markup}</aside>";
	echo ${topPart}${nav}"${mainContent}"${sideBar}${footer}${closefile} > ../../$site/${f}.html
	cd ..
	tally=$((tally+1))
done
echo "${tally} topics built"



