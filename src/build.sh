#!/bin/sh -e
site=../site
content=content
headerA=../../inc/header-top.htm
headerB=../../inc/header-bottom.htm
sitenav=../../inc/nav.htm
meta=meta.htm
contentFile=content.htm
foottop=../../inc/footer-top.htm
foot=../../inc/footer.htm
footbot=../../inc/footer-bottom.htm
bottom=../../inc/html-bottom.htm
tally=0

rm -rf $site
mkdir -p $site

# List the index
setupindex() {
	echo "<h1>INDEX PAGE</h1>" > ../permanav/index/content.htm;
	for f in *; do #PREBERE MAPO PHOTOGRAPHY
		echo "<h2>${f}</h2><ul>" >> ../permanav/index/content.htm;
		cd $f;
		for f in *; do #ZDAJ PREBERE PODMAPO PHOTOGRAPHY
			echo "<li><a href='${site}/${f}.html'>{${f}}</a></li>" >> ../../permanav/index/content.htm; ##IN GENERIRA LINK PODMAPE
		done
		cd ..
		echo "</ul>" >> ../permanav/index/content.htm;
	done
	echo "Setup index -- DONE"
}

setupgungalarc() {
	for f in *; do
		categoryname=$f;
		mkdir -p ../permanav/index_${categoryname}
		echo "<ul>" > ../permanav/index_${categoryname}/content.htm
		cd $f;
		for f in *; do #ZDAJ GREV PODMAPO PHOTOGRAPHY
			echo "<li><a href='${site}/${f}.html'>${f}</a></li>" >> ../../permanav/index_${categoryname}/content.htm; ##IN GENERIRA LINK PODMAPE
		done
		cd ..
		echo "</ul>" >> ../permanav/index_${categoryname}/content.htm;
		#začasen metagen za index_F
		echo "<title>ganga95 - index of "${categoryname}"</title> <meta name='description' content='index of "${categoryname}"' />
" >../permanav/index_${categoryname}/meta.htm;
	echo "setup gungalarc -- DONE"
	done
}

sitenav() {
	echo "<header><a href="home.html"><img src="../assets/logosmoll.png"></a></header><nav class='sitenav'><ul>" > ../inc/nav.htm;
	#echo "<li><a href='home.html'>/PIARHIJA</a></li>" >> ../inc/nav.htm;
	for f in *; do
		if [ $f != 'index' ]; then
			echo "<li><a href='index_${f}.html'>${f}</a></li>" >>../inc/nav.htm;
		fi
	done
	echo "<li><a href='index.html'>index</a></li>" >> ../inc/nav.htm;
	echo "<li><a href='about.html'>about</a></li>" >> ../inc/nav.htm;
	echo "</ul></nav>" >> ../inc/nav.htm;
	echo "nav"
}


footy() {
	datum=$(date +%d-%m-%Y);
	letina=$(date +%Y);
	
	#echo "<footer><a>Ganga 95© ${letina} </a> <a>Gangad: ${datum}</a></footer></main>" >../inc/footer.htm;

	echo "<span><a href="about.html">Piarhija</a> &copy;${letina} <a><i> Last change: ${datum} </i></a></span>"  >../inc/footer.htm;

	

}

# Setup topics
cd $content
footy;
sitenav;
setupindex;
setupgungalarc;

for f in *; do
	cd $f;
	for f in *; do
		cd $f;
		markup=''
		topPart=$(cat ../$headerA $meta ../$headerB);
		nav=$(cat ../$sitenav);
		contentText=$(cat $contentFile);
		footer=$(cat ../$foottop ../$foot ../$footbot);
		closefile=$(cat ../$bottom);
		mainContent="<main>${contentText}</main>";
		sideBar="<aside>${markup}</aside>";
		echo ${topPart}${nav}"${mainContent}"${sideBar}${footer}${closefile} > ../../../$site/${f}.html
		cd ..
		tally=$((tally+1))
	done
	cd ..
done
cd ..
cd permanav
for f in *; do
	cd $f;
	markup=''
	topPart=$(cat $headerA $meta $headerB);
	nav=$(cat $sitenav);
	contentText=$(cat $contentFile);
	footer=$(cat $foottop $foot $footbot);
	closefile=$(cat $bottom);
	mainContent="<main>${contentText}</main>";
	sideBar="<aside>${markup}</aside>";
	echo ${topPart}${nav}"${mainContent}"${sideBar}${footer}${closefile} > ../../$site/${f}.html
	cd ..
done
echo "${tally} topics built"



