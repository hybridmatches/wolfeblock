#!/bin/sh -e
site=../site
content=content
headerA=../../../inc/header-top.htm
headerB=../../../inc/header-bottom.htm
sitenav=../../../inc/nav.htm
meta=meta.htm
contentFile=content.htm
foot=../../../inc/footer.htm
bottom=../../../inc/html-bottom.htm
tally=0

rm -rf $site
mkdir -p $site

# List the index
setupindex() {
	echo "<h1>INDEX PAGE</h1>" > ../permanav/index/content.htm;
	for f in *; do #GRE V MAPO PHOTOGRAPHY
		echo "<h2>${f}</h2><ul>" >> ../permanav/index/content.htm;
		categoryname=$f;
		cd $f;
		for f in *; do #ZDAJ GREV PODMAPO PHOTOGRAPHY
			echo "<li><a href='${categoryname}/${f}.html'>{${f}}</a></li>" >> ../../permanav/index/content.htm; ##IN GENERIRA LINK PODMAPE
		done
		cd ..
		echo "</ul>" >> ../permanav/index/content.htm;
	done
	echo "Index built"
}

sitenav() {
	echo "<nav class='sitenav'>" > ../inc/nav.htm;
	for f in *; do
		if [ $f != 'index' ]; then
			echo "<a href='${f}.html'>{${f}}</a>" >>../inc/nav.htm;
		fi
	done
	echo "</nav>" > ../inc/nav.htm;
	echo "nav"
}

# Setup topics
cd $content
sitenav;
setupindex;
for f in *; do
	cd $f;
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
		echo ${topPart}${nav}"${mainContent}"${sideBar}${footer}${closefile} > ../../../$site/${f}.html
		cd ..
		tally=$((tally+1))
	done
	cd ..
done
echo "${tally} topics built"



